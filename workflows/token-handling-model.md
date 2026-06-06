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

Direct ChatGPT access to protected systems would require a future secured connector, ChatGPT Action, or MCP tool where credentials are stored in connector/tool configuration, not in chat text or memory.

Never paste tokens into chat.
