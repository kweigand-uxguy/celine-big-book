# ChatGPT Action Setup Checklist

## 1. Confirm hostnames

Protected Celine control plane:

```text
https://celine.thecreatorsmark.org
```

ChatGPT Action gateway:

```text
https://action-celine.thecreatorsmark.org
```

Both hostnames route to the same local Celine Server process through Cloudflare Tunnel.

## 2. Confirm tunnel and DNS

Verify `~/.cloudflared/config.yml` includes both hostnames and that DNS routes exist for:

```text
celine.thecreatorsmark.org
action-celine.thecreatorsmark.org
```

See `docs/cloudflare-tunnel.md`.

## 3. Set the Action token

Add a separate token to `~/Celine/celine-server/.env`:

```text
CELINE_ACTION_TOKEN=replace-me-with-a-long-random-secret
```

Do not reuse `CELINE_API_TOKEN`.

Restart Celine Server after changing the token.

## 4. Choose the OpenAPI schema

Public connectivity test only:

```text
https://raw.githubusercontent.com/kweigand-uxguy/celine-big-book/main/actions/chatgpt/openapi.celine-server.public.yaml
```

Recommended Custom GPT install:

```text
https://raw.githubusercontent.com/kweigand-uxguy/celine-big-book/main/actions/chatgpt/openapi.celine-server.private.yaml
```

Do not install `openapi.celine-server.write-capable.future.yaml`.

## 5. Configure the Custom GPT

1. Paste `custom-gpt-instructions.md` into the GPT instructions.
2. Add the private OpenAPI schema as an Action.
3. Set Action authentication to Bearer token.
4. Store `CELINE_ACTION_TOKEN` in the Action auth UI only.
5. Do not paste tokens into chat.

## 6. Local test before remote test

```bash
cd ~/Celine/celine-server
scripts/test-private-gpt-action-gateway.sh
```

## 7. Remote test order

1. `GET /gpt-action/health`
2. `GET /gpt-action/status`
3. `getPrivateGatewayHealth`
4. `getPrivateGatewayStatus`
5. `getPrivateProjects`
6. `getPrivateAssistantJobCatalog`
7. `dryRunPrivateAssistantJob`
8. `getPrivateLauncherStatus`
9. `getPrivateForgeKeyStatus`

## 8. Write-capable routes

The private gateway includes approved Jira, GitHub, and Keyboard Maestro write routes.

For every write:

1. Call the matching dry-run or preview route first.
2. Show Ken the exact planned payload.
3. Only call the write route if Ken explicitly approves.
4. Include the exact approval text required by the route.

Do not skip dry-run.

## 9. Still excluded from ChatGPT

- App launching
- Open-any app launching
- Forge Key enable or disable
- Shell or arbitrary command execution
- Obsidian write/append/patch/import
- Scrivener write/create/delete

## 10. If Cloudflare Access blocks calls

- Do not remove security from the protected hostname.
- Use `action-celine.thecreatorsmark.org` for ChatGPT Actions.
- Allow only `/gpt-action/*` on the action hostname.
- Keep private routes protected by `CELINE_ACTION_TOKEN`.
