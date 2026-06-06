# Future Action Gateway Design

This is a design note only. The gateway is not implemented in this phase.

## Route Prefix

Future gateway routes may use:

```text
/gpt-action/*
```

## Candidate Allowlist

```text
GET /gpt-action/health
GET /gpt-action/status
GET /gpt-action/projects
GET /gpt-action/tools
GET /gpt-action/jira/issues/{key}
GET /gpt-action/jira/issues/{key}/children
POST /gpt-action/jira/subtasks/dry-run
```

## Authentication

Use one of:

```text
Authorization: Bearer <CELINE_ACTION_TOKEN>
X-Celine-Action-Token: <CELINE_ACTION_TOKEN>
```

The real token must live in Celine Server `.env` and the Custom GPT Action auth configuration, not in chat or docs.

## Gateway Rules

- Only expose allowlisted routes.
- Default read-only.
- No shell.
- No arbitrary command execution.
- No open-any launch.
- No Forge Key enable.
- No create/update/delete.
- Dry-run allowed.
- Write routes require a separate future phase.
- Rate-limit requests.
- Log sanitized audit events.
- Never log token values.
- Add Pushover security notification on failed auth, rate-limited.
- Keep existing internal routes unchanged.
