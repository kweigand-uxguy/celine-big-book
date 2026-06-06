# App Launcher Bridge

Celine Server has a controlled app launcher concept for opening approved local Mac applications and workspaces.

## Safety Model

- Controlled app launching is a write-capable action.
- Open-any mode requires Forge Key.
- Forge Key is time-limited and local-first.
- App launching must not become arbitrary command execution.
- Do not run arbitrary shell commands.
- Do not create command execution endpoints.
- Do not expose secrets.

## Workflow

Use the write-action policy:

```text
Read/inspect -> propose -> dry-run if available -> Ken approves -> execute.
```
