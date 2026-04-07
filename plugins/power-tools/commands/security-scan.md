---
description: "Run a full security scan: OWASP Top 10 + STRIDE + dependency audit."
---

Comprehensive security scan combining multiple checks:

1. /cso - OWASP Top 10 + STRIDE threat model on the codebase
2. Dependency audit: check for known CVEs in package dependencies
3. Secrets scan: grep for API keys, tokens, passwords in code and config
4. Permission audit: check file permissions, .env handling, gitignore coverage

Deliverable: Security report with findings rated by severity and exploitability.
Only report findings with confidence >= 8/10.
