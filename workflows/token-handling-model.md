# Token Handling Model

Celine knows maps, not keys.

This public repository can store:

- base URLs
- route maps
- header names
- placeholder names
- safety rules
- dry-run workflows

This public repository must not store:

- real bearer tokens
- Cloudflare Access secrets
- Jira credentials
- GitHub tokens
- Vercel tokens
- Pushover keys
- any other secret values

ChatGPT should not know secrets.

Codex and local helper scripts can connect because they run on Ken's Mac and can source `.env` locally without printing it.

Direct ChatGPT access to Celine Server uses the GPT Action gateway on:

```text
https://action-celine.thecreatorsmark.org
```

The Action package lives at:

```text
~/Celine/celine-server/actions/chatgpt/
```

Recommended Custom GPT install:

```text
actions/chatgpt/openapi.celine-server.private.yaml
```

Use `CELINE_ACTION_TOKEN` in the Custom GPT Action auth UI. Do not reuse `CELINE_API_TOKEN`.

Approved Jira, GitHub, and Keyboard Maestro writes require dry-run first and explicit Ken approval text. App launching, Forge Key mutation, workspace launching, and shell execution remain excluded.
