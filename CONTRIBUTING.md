# Contributing to Solo Squad

Thanks for considering a contribution. Solo Squad is built to be extended by anyone who runs an agency or ships solo and wants their workflows captured as Claude Code skills.

## What's most useful

The highest-value contributions, in order:

1. **New skills in your domain of expertise.** If you have a workflow you run weekly that isn't in Solo Squad, that's the best thing you can add. Real workflows beat theoretical ones.
2. **Improvements to existing skills.** Sharper rules, better deliverable formats, more concrete process steps.
3. **New commands** that chain existing skills into multi-step workflows.
4. **Bug fixes** in plugin manifests, hooks, or skill structures.
5. **Better docs** with real-world examples of using a skill on actual work.

## How to add a new skill

A skill is a `SKILL.md` file inside `plugins/<squad>/skills/<skill-name>/`.

Required structure:

```
---
description: "One sentence describing what this skill does and when to use it."
---

# Skill Name

You are a [role]. [One sentence about what you do.]

## Process

1. Step one.
2. Step two.
3. Step three.

## Rules

- Rule one.
- Rule two.
```

Required elements:
- Frontmatter with a `description` field. This is what Claude uses to know when to invoke the skill.
- A clear role definition (you are a senior X who does Y).
- A numbered process the skill follows.
- Explicit rules that constrain behavior.
- A defined deliverable format.

Match the format of any existing skill in the same squad. Look at `plugins/engineering-squad/skills/brainstorm/SKILL.md` for a strong reference.

## How to add a new command

Commands chain multiple skills into one workflow. They live in `plugins/<squad>/commands/`.

```
---
description: "What this command accomplishes in one sentence."
---

[The instructions Claude follows when the command is invoked]
```

Commands should make sense as user-facing slash commands. If the workflow is short, just add it as a skill instead.

## How to add a new plugin (squad)

If you want to add a whole new squad, you'll need:

1. A new directory: `plugins/your-squad-name/`
2. A plugin manifest: `plugins/your-squad-name/.claude-plugin/plugin.json`
3. At least 3 skills in `plugins/your-squad-name/skills/`
4. An entry in the marketplace catalog at `.claude-plugin/marketplace.json`
5. A docs file at `docs/squads/your-squad-name.md`

Open an issue first to discuss whether the squad fits Solo Squad's scope. Solo Squad is opinionated about staying focused on solo operators running multi-functional businesses. Specialty squads (game dev, blockchain, embedded) are better as separate plugins.

## PR process

1. Fork the repo
2. Create a branch: `git checkout -b add-skill-name` or `fix-issue-123`
3. Make your changes
4. Test locally: `/plugin marketplace add ./solo-squad` then install your plugin
5. Verify the skill triggers correctly with realistic input
6. Open a PR with a clear description of what you changed and why

## What I won't accept

- Skills that just rephrase what Claude already does well without added structure
- Commands that don't actually save the user time vs invoking skills directly
- Marketing copy or "personality" that doesn't translate to better outputs
- Anything that requires external paid services without a clear note saying so
- Hooks that fire too aggressively and add noise

## Code of conduct

Be useful. Be honest about what works and what doesn't. Disagree directly when you think something is wrong. Don't waste anyone's time.

That's it. Ship something good.
