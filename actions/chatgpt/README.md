# Celine Server ChatGPT Action Package

This directory contains the foundation for a future Custom GPT / ChatGPT Action that can call a safe, documented subset of Celine Server.

This package stores maps, not keys.

No real secrets belong here.

## Files

- `openapi.celine-server.readonly.yaml` - install-ready read-only Celine Server Action schema.
- `openapi.celine-jira.yaml` - install-ready Jira read and dry-run Action schema.
- `openapi.celine-server.yaml` - combined install-ready read/dry-run Action schema.
- `openapi.celine-server.write-capable.future.yaml` - future-only placeholder, not for installation.
- `custom-gpt-instructions.md` - Custom GPT instruction block.
- `setup-checklist.md` - setup checklist for a future GPT Action.
- `security-model.md` - security model and token handling.
- `action-gateway-design.md` - future gateway design notes.
- `test-action-spec.sh` - local static validation for specs/docs.

## Base URL

```text
https://celine.thecreatorsmark.org
```

## Recommended Auth Model

Use a separate future token:

```text
CELINE_ACTION_TOKEN
```

Do not reuse `CELINE_API_TOKEN` as the recommended ChatGPT Action token.

The Action token should be stored in Celine Server `.env` and configured in the Custom GPT Action auth UI, not pasted into chat or committed to docs.

## Install-Ready Scope

The install-ready specs are read-only/dry-run only.

They intentionally exclude:

- Jira create
- app launching
- open-any app launching
- Forge Key disable or enable
- workspace launching
- shell or command execution
- deploy/write/mutation routes
