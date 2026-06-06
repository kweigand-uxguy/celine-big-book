# ChatGPT Action Package Reference

The install-ready sanitized Celine Server ChatGPT Action package is stored here in the public Big Book repo:

```text
actions/chatgpt/
```

The live local Celine Server copy lives on Ken's Mac at:

```text
~/Celine/celine-server/actions/chatgpt/
```

## Action Base URL

```text
https://action-celine.thecreatorsmark.org
```

## Purpose

This package gives ChatGPT/Celine/Codex sessions a stable, public, sanitized reference for the Celine Server Action contract.

It stores API maps and OpenAPI specs, not keys.

## Recommended Install

- `actions/chatgpt/openapi.celine-server.private.yaml`

This is the current Custom GPT install schema.

## Public Connectivity Spec

- `actions/chatgpt/openapi.celine-server.public.yaml`

Use this for secret-free connectivity testing only.

## Legacy Specs

- `actions/chatgpt/openapi.celine-server.yaml`
- `actions/chatgpt/openapi.celine-server.readonly.yaml`
- `actions/chatgpt/openapi.celine-jira.yaml`

These older read-only/dry-run schemas remain for reference.

## Future Spec

- `actions/chatgpt/openapi.celine-server.write-capable.future.yaml`

This is not for installation yet.

## Setup

Follow:

```text
actions/chatgpt/setup-checklist.md
```

## Security Notes

- Do not put secrets in this repo.
- Do not paste tokens into chat.
- Use placeholders only.
- Real Action credentials must live in Celine Server `.env` and Custom GPT Action auth configuration.
- Use `CELINE_ACTION_TOKEN`, not `CELINE_API_TOKEN`, for ChatGPT Actions.
