/**
 * Solo Squad — OpenCode Plugin
 *
 * Registers Solo Squad skills, workflow commands, and specialist subagents,
 * then injects a bootstrap context into the first user turn of each session.
 *
 * Zero dependencies. Pure ESM.
 */

import { readFileSync, readdirSync } from "node:fs";
import { basename, dirname, extname, join } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const PLUGIN_ROOT = join(__dirname, "..", "..");
const SKILLS_DIR = join(PLUGIN_ROOT, "skills");
const COMMANDS_DIR = join(PLUGIN_ROOT, "commands");
const AGENTS_DIR = join(PLUGIN_ROOT, "agents");
const READ_ONLY_AGENT_TOOLS = new Set(["Read", "Bash", "Glob", "Grep", "WebFetch", "WebSearch"]);

function stripQuotes(value) {
  return value.replace(/^["']|["']$/g, "");
}

function parseMarkdown(filePath) {
  const raw = readFileSync(filePath, "utf-8");
  const match = raw.match(/^---\n([\s\S]*?)\n---\n([\s\S]*)$/);
  if (!match) return { frontmatter: {}, content: raw.trim() };

  const frontmatter = {};
  let currentKey = null;

  for (const line of match[1].split("\n")) {
    const keyMatch = line.match(/^([A-Za-z0-9_-]+):\s*(.*)$/);
    if (keyMatch) {
      currentKey = keyMatch[1];
      const value = keyMatch[2].trim();
      frontmatter[currentKey] = value ? stripQuotes(value) : [];
      continue;
    }

    const itemMatch = line.match(/^\s*-\s+(.*)$/);
    if (itemMatch && currentKey) {
      if (!Array.isArray(frontmatter[currentKey])) {
        frontmatter[currentKey] = [];
      }
      frontmatter[currentKey].push(stripQuotes(itemMatch[1].trim()));
      continue;
    }

    currentKey = null;
  }

  return { frontmatter, content: match[2].trim() };
}

function listMarkdownFiles(root) {
  const result = [];

  for (const entry of readdirSync(root, { withFileTypes: true })) {
    const fullPath = join(root, entry.name);
    if (entry.isDirectory()) {
      result.push(...listMarkdownFiles(fullPath));
      continue;
    }

    if (entry.isFile() && extname(entry.name) === ".md") {
      result.push(fullPath);
    }
  }

  return result.sort();
}

function registerSkills(cfg) {
  cfg.skills ??= {};
  cfg.skills.paths ??= [];

  if (!cfg.skills.paths.includes(SKILLS_DIR)) {
    cfg.skills.paths.push(SKILLS_DIR);
  }
}

function registerCommands(cfg) {
  cfg.command ??= {};

  for (const filePath of listMarkdownFiles(COMMANDS_DIR)) {
    const name = basename(filePath, extname(filePath));
    if (cfg.command[name]) continue;

    const { frontmatter, content } = parseMarkdown(filePath);
    cfg.command[name] = {
      description: frontmatter.description,
      template: content,
    };
  }
}

function registerAgents(cfg) {
  cfg.agent ??= {};

  for (const filePath of listMarkdownFiles(AGENTS_DIR)) {
    const name = basename(filePath, extname(filePath));
    if (cfg.agent[name]) continue;

    const { frontmatter, content } = parseMarkdown(filePath);
    const tools = new Set(Array.isArray(frontmatter.tools) ? frontmatter.tools : []);
    const isReadOnly = tools.size > 0 && Array.from(tools).every((tool) => READ_ONLY_AGENT_TOOLS.has(tool));

    cfg.agent[name] = {
      description: frontmatter.description,
      prompt: content,
      mode: "subagent",
      ...(frontmatter.model && frontmatter.model !== "inherit" ? { model: frontmatter.model } : {}),
      ...(isReadOnly ? { permission: { edit: "deny" } } : {}),
    };
  }
}

function buildSessionContext() {
  const sections = [];

  try {
    const { content } = parseMarkdown(join(SKILLS_DIR, "using-solo-squad", "SKILL.md"));
    if (content) sections.push(content);
  } catch {
    // Continue without the bootstrap skill.
  }

  try {
    const toolMapping = readFileSync(join(SKILLS_DIR, "using-solo-squad", "references", "opencode-tools.md"), "utf-8").trim();
    if (toolMapping) sections.push(toolMapping);
  } catch {
    // Continue without the OpenCode tool reference.
  }

  return sections.join("\n\n---\n\n");
}

function injectSessionContext(output, sessionContext) {
  const prefix = `[Solo Squad Context]\n${sessionContext}\n\n---\n\n`;

  output.messages = output.messages.map((message, index) => {
    if (index !== 0 || message.info.role !== "user") {
      return message;
    }

    let injected = false;
    const parts = message.parts.map((part) => {
      if (!injected && part.type === "text") {
        injected = true;
        return {
          ...part,
          text: prefix + part.text,
        };
      }

      return part;
    });

    if (!injected) {
      parts.unshift({ type: "text", text: prefix });
    }

    return {
      ...message,
      parts,
    };
  });
}

export default {
  id: "solo-squad",
  server: async () => {
    const sessionContext = buildSessionContext();
    let didInjectSessionContext = false;

    return {
      async config(cfg) {
        registerSkills(cfg);
        registerCommands(cfg);
        registerAgents(cfg);
      },

      async "experimental.chat.messages.transform"(_input, output) {
        if (didInjectSessionContext || !sessionContext || output.messages.length === 0) {
          return;
        }

        didInjectSessionContext = true;
        injectSessionContext(output, sessionContext);
      },
    };
  },
};
