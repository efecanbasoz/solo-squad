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

## Critical Rules

1. Only report findings with a confidence score of 8/10 or higher.
2. Run the scan in a clean, isolated environment to avoid false positives.
3. Never commit scan results containing real secrets or credentials.
4. Document every finding with a concrete exploit scenario or proof of concept.
5. Remediate critical and high-severity findings before concluding the scan.

## Mandatory Process

1. MUST run `/cso` for OWASP Top 10 and STRIDE threat modeling.
2. MUST audit all runtime and development dependencies for known CVEs.
3. MUST scan the entire codebase and configuration for exposed secrets.
4. MUST review file permissions, `.env` handling, and `.gitignore` coverage.
5. MUST generate a severity-rated report with remediation steps for each finding.
6. MUST re-scan after remediation to confirm all critical and high issues are resolved.

## Automatic Fail Triggers

- A confirmed critical or high-severity finding is left unreported.
- Secrets or credentials are discovered and not rotated or revoked immediately.
- Scan results are shared in public channels or stored without access control.
- Findings are reported without a severity rating or exploit scenario.
- The dependency audit is skipped or executed against an outdated lockfile.

## Deliverable Template

```markdown
## Security Scan Report

- **Scope:** [Codebase areas scanned]
- **Date:** [Scan date]
- **Tools Used:** [cso, dependency scanner, secrets scanner, etc.]

### Findings

| ID | Category | Severity | Confidence | Description | Exploit Scenario | Remediation |
|----|----------|----------|------------|-------------|------------------|-------------|
| F1 | [e.g., Injection] | Critical | 9/10 | ... | ... | ... |

### Resolved

| ID | Resolution | Verified |
|----|------------|----------|
| F1 | [Fix description] | Yes/No |

### Outstanding Risks

- [Any accepted or deferred risks with justification]
```

## Success Metrics for This Skill

- 100% of critical and high-severity findings are documented with exploit scenarios.
- 100% of discovered secrets are rotated or revoked within 24 hours.
- 100% of dependency CVEs are mapped to affected packages and versions.
- 95% of findings are reported with a confidence score of 8/10 or higher.
- 0% of unreported critical or high-severity vulnerabilities in scanned scope.

## Rules

- Always run scans in an isolated environment to protect live data.
- Report every finding with a clear severity rating and actionable remediation step.
- Never store or share scan artifacts containing real secrets without encryption.
