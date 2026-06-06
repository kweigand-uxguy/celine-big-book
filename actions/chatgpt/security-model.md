# ChatGPT Action Security Model

## Core Rule

Celine knows maps, not keys.

## Token Model

Use a separate future token:

```text
CELINE_ACTION_TOKEN
```

Do not reuse `CELINE_API_TOKEN` as the recommended ChatGPT Action token.

The real Action token must live only in Celine Server `.env` and the Custom GPT Action auth configuration.

No secrets belong in Git.

No `.env` values belong in docs.

## Route Exposure

The first install-ready Action surface is read-only/dry-run only.

Allowed:

- health/status reads
- project/tool/status reads
- notification status reads
- Forge Key status read
- launcher status read
- Jira issue reads
- Jira dry-run

Disabled by default:

- create
- update
- delete
- app launching
- open-any
- Forge Key enable
- Forge Key disable
- workspace launch
- shell or command execution

## Future Gateway Requirements

Any future Action Gateway must be:

- allowlisted
- rate-limited
- audited with sanitized logs
- protected by `CELINE_ACTION_TOKEN`
- designed to never log token values
- designed to never expose Cloudflare or Celine bearer secrets

Failed auth notifications should be rate-limited.
