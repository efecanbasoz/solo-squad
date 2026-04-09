---
description: "Persistent client context management. Initialize, load, save, and list client profiles that carry intelligence across sessions."
---

# Client Context

You manage persistent client context files that carry intelligence across sessions. When loaded, all subsequent skills benefit from knowing the client's industry, history, preferences, and current project state.

## Process

1. **Initialize.** When starting with a new client:
   - Create directory: `clients/{client-slug}/`
   - Create 4 context files from template
   - Gather initial information through conversation
   - Save to the appropriate files

2. **Load.** At the start of any client session:
   - Read all 4 context files from `clients/{client-slug}/`
   - Inject a summary into the session context
   - Report: client name, active projects, key preferences, last engagement date

3. **Save.** After significant work (audit, sprint, campaign):
   - Prompt the user: "Should I update the client context with what we learned?"
   - Update the relevant files with new information
   - Add dated entry to history.md

4. **List.** Show all client contexts:
   - List directories under `clients/`
   - For each: client name, last modified date, active project count

## Client Context Files

### `context.md` — Company Profile (rarely changes)
```
# {Client Name}

## Company
- Industry: {industry}
- Size: {employee count, revenue range}
- Website: {url}
- Tech stack: {key technologies}

## Key Contacts
| Name | Role | Email | Notes |
|------|------|-------|-------|
| {name} | {role} | {email} | {communication preferences} |

## Preferences
- Communication: {channel, frequency, format preferences}
- Reporting: {KPIs they care about, format preferences}
- Decision style: {consensus, executive decree, data-driven}
```

### `brand.md` — Brand Guidelines Reference
```
# {Client Name} Brand

## Visual Identity
- Primary colors: {hex values}
- Secondary colors: {hex values}
- Fonts: {heading font, body font}
- Logo: {location, usage rules}

## Voice & Tone
- Attributes: {3-5 adjectives}
- Audience: {who they talk to}
- Avoid: {words, topics, styles to avoid}
```

### `history.md` — Engagement Log (append-only)
```
# {Client Name} History

## {YYYY-MM-DD}: {engagement description}
- What we did: {summary}
- Key decisions: {decisions made}
- Learnings: {what we learned about the client/project}
- Deliverables: {what was produced}
```

### `active.md` — Current State (frequently updated)
```
# {Client Name} Active Projects

## {Project Name}
- Status: {in progress / paused / complete}
- Started: {date}
- Goal: {one sentence}
- Current blockers: {if any}
- Next steps: {immediate actions}
```

## Rules

- Client data is local — never push to git repositories. The `clients/` directory should be in `.gitignore`.
- Context files are living documents. Update them, don't let them go stale.
- When loading context, summarize — don't dump the entire file contents into the conversation.
- If a client context is older than 90 days without updates, flag it as potentially stale.

## Deliverables

- Initialized client context directory with 4 template files
- Session context summary (on load)
- Updated context files (on save)
- Client context list with metadata
