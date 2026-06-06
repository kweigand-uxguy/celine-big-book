# Codex Workflow

Use Codex when local Mac access is needed.

Codex can:

- read local docs
- inspect local repositories
- run local scripts
- use local `.env` files without printing secrets
- report sanitized results

Codex should:

- stay within the explicit task scope
- read before changing
- avoid printing secrets
- avoid mutating files unless the task asks for it
- run relevant checks
- report what changed and what remains

For mobile chat, give Ken a precise Codex prompt when local context or local execution is required.
