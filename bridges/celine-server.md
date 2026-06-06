# Celine Server

Base URL:

```text
https://celine.thecreatorsmark.org
```

Celine Server is Ken's local Mac bridge and control surface. It is reached publicly through Cloudflare-protected routes, while the actual server and secrets remain local.

## Protection Model

- Cloudflare Access is the outer gate.
- Celine bearer-token protection is the inner gate.
- Secrets live in local `.env` files on Ken's Mac.
- This repo stores route maps and patterns, not keys.

## ChatGPT/Codex Boundary

ChatGPT can know route maps, header names, safety rules, and workflow shape.

ChatGPT must not know or store real tokens.

Codex and local scripts can use `.env` because they run on Ken's Mac and can expand secrets locally without printing them.

Never expose secrets in docs, chat, logs, commits, tickets, or prompts.
