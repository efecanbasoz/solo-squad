# Solo Squad

> A squad of specialists for the solo operator.

You're alone. You're not.

Solo Squad is a Claude Code plugin marketplace built for one person doing the work of a small agency. Engineering, marketing, sales, design, project management, and security - six squads, each with specialists who do one job well.

I'm [Efecan](https://github.com/efecanbasoz). I run a digital marketing agency. I built Solo Squad because I was tired of switching between engineering tools, ad platform dashboards, sales spreadsheets, and design files all day. Now I run my whole agency through Claude Code. Solo Squad is what I use every day on real client work.

## See it work

Here's what a `/client-audit` run looks like for an e-commerce client. One command, five squads, one report.

```
You: /client-audit https://acmewidgets.com

Solo Squad: Running full marketing audit. This dispatches:
  /seo-audit + /tracking-audit + /paid-audit + /social-strategy + /ai-citation
  Estimated time: 15-20 min. Estimated tokens: ~$2-4.
  Continue? [y/N]

You: y

[14 minutes later]

Solo Squad:

SEO Audit: 6.2/10
  - Sitemap missing 47% of product pages
  - 12 broken redirect chains
  - LCP at 4.8s (target: under 2.5s)
  - Quick wins: regenerate sitemap, fix redirects, compress hero images

Tracking Audit:
  - GA4 properly configured
  - Google Ads conversion firing 2x on thank-you page (double-counting)
  - Meta Pixel missing on checkout step
  - No CAPI for Meta - losing iOS attribution

Paid Audit: 142/200 (Grade C)
  - Branded and non-branded mixed in same campaign
  - Zero negative keyword lists
  - Wasted spend estimate: $1,840/month on irrelevant search terms
  - Quick wins: restructure into branded/non-branded, add 200+ negatives

Social Strategy:
  - LinkedIn: 0 posts in 90 days
  - Instagram: 0.4% engagement rate (benchmark: 1%+)
  - Twitter/X: dormant, recommend deletion

AI Citation:
  - Brand appears in 2/30 test queries on ChatGPT (competitors: 18/30)
  - No Wikipedia entry, no Organization schema markup

Top 3 quick wins (impact > effort):
  1. Fix Meta CAPI + remove duplicate Google conversion
  2. Restructure paid campaigns + add negatives (~$1,800/mo recovered)
  3. Fix sitemap + redirects (unblocks indexing)

Full report saved: ./reports/acmewidgets-audit.md
Want me to draft the client-facing version of this report? [y/N]
```

That's the demo. If pulling that report by hand would take you most of a day, Solo Squad is for you.

## Install

Add the marketplace, then install whichever squads you need.

```
/plugin marketplace add efecanbasoz/solo-squad
/plugin install engineering-sprint@solo-squad
/plugin install campaign-ops@solo-squad
/plugin install sales-pipeline@solo-squad
/plugin install design-studio@solo-squad
/plugin install project-command@solo-squad
/plugin install power-tools@solo-squad
```

The squads are independent. Install only what you need today, add the rest later. Skipping a squad means fewer tokens consumed in the background.

## The six squads

Each squad is a Claude Code plugin with skills, commands, agents, and hooks. Click into any squad for the full skill list and usage examples.

| Squad | What they do |
|-------|--------------|
| [Engineering Squad](docs/squads/engineering.md) | Brainstorm, plan, build with TDD, review, QA in a real browser, ship a PR, capture learnings |
| [Campaign Squad](docs/squads/campaign.md) | SEO audits, PPC strategy, social planning, content calendars, ad creative, tracking audits, paid media audits, AI citation |
| [Sales Squad](docs/squads/sales.md) | Outbound prospecting, discovery prep, MEDDPICC qualification, proposal writing, pipeline review, account expansion |
| [Design Squad](docs/squads/design.md) | Design systems, AI slop detection, UX research, brand consistency checks, AI image prompts |
| [Project Squad](docs/squads/project.md) | Client kickoffs, sprint planning, status reports, A/B test tracking, feedback synthesis, weekly retros |
| [Security Squad](docs/squads/security.md) | OWASP + STRIDE audits, performance benchmarks, browser automation, safety guardrails, cross-AI code review |

## Why Solo Squad and not the alternatives

Three projects already do parts of this well, and you should know about them.

[Superpowers](https://github.com/obra/superpowers) is the most disciplined engineering methodology in the ecosystem. If you only build software, install it and stop reading this. [gstack](https://github.com/garrytan/gstack) is the most feature-complete set of dev tools, with the best browser automation around. If you're shipping product full-time, install gstack. [Compound Engineering](https://github.com/EveryInc/compound-engineering-plugin) has the best knowledge-capture philosophy and the most cross-platform converters.

Solo Squad exists because none of those help me when I need to audit a client's Google Ads account, prep for a discovery call at 2pm, score a new deal with MEDDPICC, or write next month's content calendar. Solo Squad covers engineering, marketing, sales, design, and project management in one place because that's what running an agency actually looks like. If you only need engineering, the older projects are better. If you need all of it, that's what this is for.

## What's solid in v1, what's rough

This is v1. Honest assessment of where you are.

**Solid:** The engineering-sprint, sales-pipeline, and power-tools squads are based on workflows I use daily. The skill structures, the rules, and the deliverable formats are battle-tested. The marketplace catalog and plugin manifests follow Anthropic's official spec and validate cleanly.

**Rough:** The campaign-ops skills cover the right ground but deliverable formats will evolve as I run more real client audits through them. Hooks are minimal and will get smarter. The browser automation in `/browse` needs work to match what gstack offers. The agents currently use generic tool permissions and need tightening per role. There are no unit tests on the skill structures yet.

If you find issues or have ideas, file them. I read every issue.

## Cost warning

Solo Squad runs subagent-driven workflows that consume Claude tokens faster than typical Claude Code usage.

A full `/sprint` run can cost $5-15 in API tokens depending on project size. A `/client-audit` runs five specialized skills and typically costs $2-4. Single-skill runs are usually under $1. Disable any squad you don't actively use to reduce background token consumption.

If you're on a Claude Pro or Max plan with included usage, this rarely matters. If you're on the API directly, watch your bill the first week.

## Roadmap

**v1.1 (next):** Expanded campaign-ops with keyword research and SERP analysis, MEDDPICC scoring as a standalone command, design system templates for design-studio, smarter hooks across all squads.

**v1.2:** Cross-squad orchestration (one client, all squads coordinated), per-command cost reporting, persistent client context across sessions.

**v2.0:** Optional team mode for studios with 2-5 people sharing the same Solo Squad install.

## Contributing

Solo Squad accepts PRs for new skills, command improvements, agent refinements, and bug fixes. The fastest way to contribute is to add a skill in your domain of expertise. Each new skill needs a `SKILL.md` file with frontmatter (`description`), a clear process, concrete deliverables, and explicit rules. Match the format of any existing skill in the same squad.

## Built on the shoulders of giants

Solo Squad would not exist without:

- [obra/superpowers](https://github.com/obra/superpowers) by Jesse Vincent - TDD methodology, subagent-driven development, systematic debugging
- [garrytan/gstack](https://github.com/garrytan/gstack) by Garry Tan - Browser automation, security audits, deploy pipelines, design tools, safety guardrails
- [EveryInc/compound-engineering-plugin](https://github.com/EveryInc/compound-engineering-plugin) by Every - Knowledge compounding philosophy, cross-platform plugin conversion
- [msitarzewski/agency-agents](https://github.com/msitarzewski/agency-agents) by Mike Sitarzewski - 144 specialist agent personas across 12 divisions

Solo Squad's contribution is the synthesis: a curated, deduplicated, agency-focused subset of these ideas, structured around the workflows of a solo operator running an entire business.

## License

MIT. Use it, fork it, sell services on top of it. Attribution appreciated, not required.
