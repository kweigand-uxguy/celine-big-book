# Celine Server ChatGPT Action Package

This directory contains the Custom GPT / ChatGPT Action package for calling a safe, documented subset of Celine Server.

This package stores maps, not keys.

No real secrets belong here.

## Files

- `openapi.celine-server.public.yaml` - public Action schema (4 operations).
- `openapi.celine-server.private.core.yaml` - private core Action schema (28 operations).
- `openapi.celine-server.private.jira.yaml` - private Jira Action schema (11 operations).
- `openapi.celine-server.private.github.yaml` - private GitHub Action schema (13 operations).
- `openapi.celine-server.private.keyboard-maestro.yaml` - private Keyboard Maestro Action schema (4 operations).
- `openapi.celine-server.private.yaml` - combined reference only. Too large for ChatGPT install.
- `openapi.celine-server.readonly.yaml` - legacy read-only schema.
- `openapi.celine-jira.yaml` - legacy Jira read and dry-run schema.
- `openapi.celine-server.yaml` - legacy combined read/dry-run schema.
- `openapi.celine-server.write-capable.future.yaml` - future-only placeholder, not for installation.
- `custom-gpt-instructions.md` - Custom GPT instruction block.
- `setup-checklist.md` - setup checklist for the Custom GPT Action.
- `security-model.md` - security model and token handling.
- `action-gateway-design.md` - gateway design notes.
- `test-action-spec.sh` - local static validation for specs/docs.

## Action Base URL

```text
https://action-celine.thecreatorsmark.org
```

Protected Celine control plane:

```text
https://celine.thecreatorsmark.org
```

## Recommended Auth Model

Use a separate Action token:

```text
CELINE_ACTION_TOKEN
```

Do not reuse `CELINE_API_TOKEN` as the ChatGPT Action token.

The Action token should be stored in Celine Server `.env` and configured in the Custom GPT Action auth UI, not pasted into chat or committed to docs.

## Install-Ready Scope

Recommended install:

```text
openapi.celine-server.private.yaml
```

The private gateway includes:

- read routes for projects, tools, apps, workspace, notifications, launcher, Forge Key, Obsidian, and Scrivener
- Assistant Bridge catalog, dry-run, queued placeholders, and audit logs
- Jira and GitHub reads, previews, and approved writes
- allowlisted Keyboard Maestro macro preview/run with approval text

It intentionally excludes:

- app launching
- open-any app launching
- Forge Key disable or enable
- workspace launching
- shell or command execution
- Obsidian write/append/patch/import
- Scrivener write/create/delete

## Local Tests

```bash
bash actions/chatgpt/test-action-spec.sh
scripts/test-private-gpt-action-gateway.sh
```

## Docs

- `docs/public-gpt-action-gateway.md`
- `docs/private-gpt-action-gateway.md`
- `docs/cloudflare-tunnel.md`

Public sanitized mirror:

```text
~/Celine/Projects/celine-big-book/actions/chatgpt/
```
