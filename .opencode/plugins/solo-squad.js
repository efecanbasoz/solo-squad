/**
 * Solo Squad — OpenCode Plugin
 *
 * Registers Solo Squad skills directory and injects bootstrap context
 * into the first user message of each session.
 *
 * Zero dependencies. Pure ESM.
 */

import { readFileSync } from "node:fs";
import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const PLUGIN_ROOT = join(__dirname, "..", "..");

/**
 * Parse YAML frontmatter from a SKILL.md file.
 * Returns { frontmatter: {}, content: string }
 */
function parseSkillMd(filePath) {
  const raw = readFileSync(filePath, "utf-8");
  const match = raw.match(/^---\n([\s\S]*?)\n---\n([\s\S]*)$/);
  if (!match) return { frontmatter: {}, content: raw };

  const frontmatter = {};
  for (const line of match[1].split("\n")) {
    const idx = line.indexOf(":");
    if (idx > 0) {
      const key = line.slice(0, idx).trim();
      const val = line.slice(idx + 1).trim().replace(/^["']|["']$/g, "");
      frontmatter[key] = val;
    }
  }
  return { frontmatter, content: match[2] };
}

export default async function ({ project, directory }) {
  const skillsDir = join(PLUGIN_ROOT, "skills");

  // Read bootstrap skill content
  let bootstrapContent = "";
  try {
    const { content } = parseSkillMd(
      join(skillsDir, "using-solo-squad", "SKILL.md")
    );
    bootstrapContent = content.trim();
  } catch {
    // Bootstrap skill not found — continue without it
  }

  // Read tool mapping for OpenCode
  let toolMapping = "";
  try {
    toolMapping = readFileSync(
      join(skillsDir, "using-solo-squad", "references", "opencode-tools.md"),
      "utf-8"
    ).trim();
  } catch {
    // Tool mapping not found — continue without it
  }

  const sessionContext = [bootstrapContent, toolMapping]
    .filter(Boolean)
    .join("\n\n---\n\n");

  let injected = false;

  return {
    // Register skills directory so OpenCode discovers SKILL.md files
    config: {
      skills: [{ path: skillsDir }],
    },

    hooks: {
      // Inject bootstrap context into the first user message
      "experimental.chat.messages.transform": async ({ messages }) => {
        if (injected || !sessionContext || messages.length === 0) {
          return { messages };
        }

        injected = true;

        // Find the first user message and prepend context
        const transformed = messages.map((msg, i) => {
          if (i === 0 && msg.role === "user") {
            const prefix = `[Solo Squad Context]\n${sessionContext}\n\n---\n\n`;
            if (typeof msg.content === "string") {
              return { ...msg, content: prefix + msg.content };
            }
          }
          return msg;
        });

        return { messages: transformed };
      },
    },
  };
}
