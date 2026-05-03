---
description: "Start a TDD session: write tests first, then implement. Enforces red/green/refactor."
---

Start a strict TDD session for the current task.

Process:
1. Ask what behavior to implement
2. Write the test (RED - must fail)
3. Run it, confirm failure, show the failure output
4. Write minimal implementation (GREEN - must pass)
5. Run it, confirm pass
6. Refactor if needed, run tests again
7. Commit with descriptive message
8. Ask: "Next behavior, or done?"

## Critical Rules

1. Write the test before the implementation. If code exists before a test, delete the code and start with the test.
2. The RED phase must produce a genuine, visible test failure — a passing "RED" test is an automatic failure.
3. Write the minimal implementation required to make the test pass. No speculative features, no future-proofing.
4. The GREEN phase must confirm the test passes before any refactoring begins.
5. Commit after every complete red/green/refactor cycle with a descriptive message.

## Mandatory Process

1. MUST ask what behavior to implement before writing any code.
2. MUST write a failing test (RED) and run it to confirm the failure output is visible.
3. MUST write the minimal implementation needed to make the test pass (GREEN).
4. MUST run the test again to confirm it passes before proceeding.
5. MUST refactor only when tests are green, then run tests again to confirm no regressions.
6. MUST commit with a descriptive message after the cycle completes.
7. MUST ask "Next behavior, or done?" before starting the next cycle.

## Automatic Fail Triggers

- Writing implementation code before a failing test exists.
- A "RED" test that passes on its first run (false positive, missing assertion, or testing the wrong thing).
- Skipping the RED phase and writing implementation directly.
- Skipping the GREEN confirmation and proceeding to refactor on unverified code.
- Adding speculative features or code not required by the current failing test.
- Committing implementation changes without a corresponding passing test.

## Deliverable Template

```markdown
## TDD Cycle Log

### Cycle #[N]
- **Behavior:** [What is being implemented]
- **RED:** [Test name] — [Failure output confirmed]
- **GREEN:** [Implementation] — [Pass confirmed]
- **Refactor:** [Changes made] — [Tests still pass]
- **Commit:** [Descriptive message]

### Session Summary
- Total cycles: [N]
- Behaviors implemented: [N]
- Final status: [Done / Next behavior pending]
```

## Success Metrics for This Skill

- 100% of implementation code is preceded by a failing test (RED phase verified).
- 100% of RED-phase tests show genuine, visible failure output before implementation.
- 100% of GREEN-phase tests pass before refactoring begins.
- 100% of commits include a corresponding passing test.
- Average cycle time (RED → GREEN → Refactor → Commit) is under 10 minutes.

## Rules

- If the user writes code before a test, DELETE the code and write the test first. This is not optional.
- A test must fail (RED) with visible output before any implementation is written.
- Refactor only after GREEN is confirmed. Run tests after every refactor.
