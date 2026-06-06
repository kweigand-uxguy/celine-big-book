# ChatGPT Action Package Reference

The install-ready sanitized Celine Server ChatGPT Action package is stored here in the public Big Book repo:

```text
actions/chatgpt/
```

The live local Celine Server copy lives on Ken's Mac at:

```text
~/Celine/celine-server/actions/chatgpt/
```

## Purpose

This package gives future ChatGPT/Celine/Codex sessions a stable, public, sanitized reference for the Celine Server Action contract.

It stores API maps and OpenAPI specs, not keys.

## Install-Ready Specs

- `actions/chatgpt/openapi.celine-server.yaml`
- `actions/chatgpt/openapi.celine-server.readonly.yaml`
- `actions/chatgpt/openapi.celine-jira.yaml`

These are read-only/dry-run only.

## Future Spec

- `actions/chatgpt/openapi.celine-server.write-capable.future.yaml`

This is not for installation yet. Write-capable Actions require a future explicit phase and Ken approval.

## Security Notes

- Do not put secrets in this repo.
- Do not paste tokens into chat.
- Use placeholders only.
- Real Action credentials must live in Celine Server `.env` and Custom GPT Action auth configuration.
