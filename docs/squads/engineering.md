# Engineering Squad

The full development lifecycle from idea to shipped PR, with TDD enforcement and multi-agent code review.

**Plugin name:** `engineering-squad`

## The workflow

```
brainstorm -> plan -> build -> review -> qa -> ship -> compound
```

Each phase feeds the next. Brainstorming produces a design doc that planning reads. Planning produces a task list that build executes. Build produces commits that review audits. Review hands off to QA, which hands off to ship, which triggers compound.

You can run the whole thing as `/sprint`, or invoke each skill independently.

## Skills

| Skill | What it does |
|-------|--------------|
| `/brainstorm` | Refine rough ideas through Socratic questioning. Challenges premises, generates alternatives, produces a design doc. |
| `/plan` | Turn a design doc into a step-by-step implementation plan with exact file paths, test requirements, and verification steps. |
| `/build` | Execute the plan using subagent-driven development. TDD red/green/refactor. Git worktree isolation. Two-stage review per task. |
| `/review` | Multi-lens code review: correctness, security, performance, maintainability, test coverage. Auto-fixes obvious issues. |
| `/qa` | Open a real browser, click through user flows, find bugs, fix them with atomic commits, generate regression tests. |
| `/ship` | Sync main, run tests, audit coverage, update docs, push, and open a PR with a structured description. |
| `/compound` | Capture learnings from the cycle. Codify patterns into templates, lint rules, and project knowledge. |
| `/investigate` | Systematic debugging. No fixes without root cause analysis. Auto-freezes to the investigated module. |
| `/technical-writing` | Technical documentation: API docs, architecture decision records, runbooks, and onboarding guides. |
| `/devops-pipeline` | CI/CD pipeline design: GitHub Actions, deployment strategies, environment promotion, and rollback plans. |
| `/database-optimization` | Database performance: query analysis, index strategy, schema design, migration planning, and capacity forecasting. |
| `/workflow-mapping` | Map and optimize development workflows: identify bottlenecks, automate repetitive steps, and design efficient pipelines. |
| `/developer-advocacy` | Developer advocacy content: tutorials, conference talks, demo apps, and developer experience improvements. |

## Commands (multi-skill workflows)

| Command | What it does |
|---------|-------------|
| `/sprint` | Full lifecycle, pausing for human approval between major phases |
| `/hotfix` | Emergency fix workflow: investigate -> test -> fix -> review -> ship. Skips planning ceremony. |
| `/tdd` | Strict TDD session. Deletes any code written before its test. |

## Agents

| Agent | Role |
|-------|------|
| Architect | System design and tradeoff analysis. Draws diagrams, doesn't write code. |
| Tester | Edge cases, boundary values, test quality. Catches bugs others miss. |
| Debugger | Read-only investigator. Follows evidence chains, never guesses. |

## Hooks

Context-aware shell script that checks file type, path, and content before firing. Reminds you to write the test before the code if you haven't. TDD is non-negotiable in this squad.
