---
description: "Maximum safety mode for production work: guard + careful + freeze combined."
---

Activate full lockdown for production-critical work.

1. Ask which directory to freeze edits to
2. Activate /guard (which enables both /careful and /freeze)
3. Display active protections:
   ```
   LOCKDOWN ACTIVE
   Edit scope: [directory]
   Destructive commands: WARNED
   Production deploys: REQUIRE CONFIRMATION
   ```
4. Remind the user to say "stand down" when finished

Use this before touching production databases, deploying critical changes, or debugging live systems.
