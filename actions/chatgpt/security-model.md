# ChatGPT Action Security Model

## Core Rule

Celine knows maps, not keys.

## Token Model

Use a separate Action token:

```text
CELINE_ACTION_TOKEN
```

Do not reuse `CELINE_API_TOKEN` as the ChatGPT Action token.

Token placement:

- `CELINE_ACTION_TOKEN` lives in Celine Server `.env`
- The same value is configured in the Custom GPT Action auth UI
- ChatGPT must never be given `CELINE_API_TOKEN`, Cloudflare Access secrets, or provider credentials

No secrets belong in Git.

No `.env` values belong in docs.

## Hostname Model

Two public hostnames serve different roles:

| Hostname | Purpose |
|---|---|
| `celine.thecreatorsmark.org` | Protected control plane for Ken/Codex |
| `action-celine.thecreatorsmark.org` | ChatGPT Action gateway |

Both route to the same local server, but Cloudflare Access policies should differ.

## Public Gateway

Routes under `/gpt-action/*` on the action hostname are sanitized and secret-free.

Allowed:

- health/status reads
- public project metadata
- connectivity testing

The public gateway does not expose tokens, local file contents, app launching, Forge Key mutation, or shell execution.

## Private Gateway

Routes under `/gpt-action/private/*` require:

```text
Authorization: Bearer <CELINE_ACTION_TOKEN>
```

Allowed:

- health/status reads
- project/tool/system/app/workspace reads
- notification status and explicit test notifications
- Assistant Bridge catalog, dry-run, queued placeholders, and audit logs
- launcher, Forge Key, and audit status reads
- Obsidian list/read/search and Scrivener list/read
- Jira reads and dry-run previews through local `acli`
- approved Jira writes with explicit approval text
- GitHub reads and dry-run previews through local `gh`
- approved GitHub writes with explicit approval text
- allowlisted Keyboard Maestro macro preview/run with explicit approval text

Still excluded:

- app launching
- open-any app launching
- Forge Key enable or disable
- workspace launching
- shell or arbitrary command execution
- Obsidian write/append/patch/import
- Scrivener write/create/delete
- Jira delete, bulk edit, or transition
- GitHub delete, close, merge, push, checkout, or repo settings
- arbitrary Keyboard Maestro macro names or XML actions

## Write Workflow

Every write-capable private route follows the same pattern:

1. Preview or dry-run first.
2. Show Ken the exact payload.
3. Execute only after explicit approval.
4. Include the route-specific exact approval text.

If approval text is missing or wrong, Celine Server rejects the write with `403`.

## Gateway Requirements

The Action gateway is:

- allowlisted
- rate-limited
- audited with sanitized logs
- protected by `CELINE_ACTION_TOKEN`
- designed to never log token values
- designed to never expose Cloudflare or Celine bearer secrets

Failed auth notifications should be rate-limited.
