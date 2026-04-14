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

If the user writes code before a test, DELETE the code and write the test first. This is not optional.
