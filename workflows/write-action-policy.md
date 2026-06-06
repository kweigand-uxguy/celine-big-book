# Write Action Policy

This policy applies to anything that creates, updates, deletes, deploys, sends, launches, archives, mutates, or causes an external side effect.

Examples:

- Jira creates or updates
- app launching
- notifications
- deployments
- file modifications
- API writes
- email/calendar sends if added later
- destructive or irreversible operations

## Required Workflow

```text
Read/inspect -> propose -> dry-run if available -> explicit Ken approval -> execute.
```

## Rules

- Treat write-capable routes and tools with care.
- Never create subtasks, deploy, send, launch, or mutate without explicit task scope or approval.
- Prefer dry-runs where available.
- Never expose secrets.
- Report sanitized results.
