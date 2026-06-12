# ChatGPT Action Setup Checklist

ChatGPT allows a maximum of **30 operations per Action**. Celine uses one public Action plus four private Actions.

## 1. Confirm hostnames

Protected Celine control plane:

```text
https://celine.thecreatorsmark.org
```

ChatGPT Action gateway:

```text
https://action-celine.thecreatorsmark.org
```

## 2. Set the Action token

Add a separate token to `~/Celine/celine-server/.env`:

```text
CELINE_ACTION_TOKEN=replace-me-with-a-long-random-secret
```

Do not reuse `CELINE_API_TOKEN`.

Restart Celine Server after changing the token.

## 3. Add five Actions to one Custom GPT

### Action 1 — Public (no auth, 4 operations)

```text
https://raw.githubusercontent.com/kweigand-uxguy/celine-big-book/main/actions/chatgpt/openapi.celine-server.public.yaml
```

Authentication: **None**

### Action 2 — Private Core (Bearer token, 28 operations)

```text
https://raw.githubusercontent.com/kweigand-uxguy/celine-big-book/main/actions/chatgpt/openapi.celine-server.private.core.yaml
```

Status, projects, tools, apps, workspace, notifications, assistant, launcher, Forge Key, audit, Obsidian read, Scrivener read.

### Action 3 — Private Jira (Bearer token, 11 operations)

```text
https://raw.githubusercontent.com/kweigand-uxguy/celine-big-book/main/actions/chatgpt/openapi.celine-server.private.jira.yaml
```

### Action 4 — Private GitHub (Bearer token, 13 operations)

```text
https://raw.githubusercontent.com/kweigand-uxguy/celine-big-book/main/actions/chatgpt/openapi.celine-server.private.github.yaml
```

### Action 5 — Private Keyboard Maestro (Bearer token, 4 operations)

```text
https://raw.githubusercontent.com/kweigand-uxguy/celine-big-book/main/actions/chatgpt/openapi.celine-server.private.keyboard-maestro.yaml
```

For Actions 2–5:

- Authentication: **API Key → Bearer**
- Token: `CELINE_ACTION_TOKEN`

Do **not** install `openapi.celine-server.private.yaml`. That combined reference file has 54 operations and exceeds ChatGPT's 30-operation limit.

## 4. Configure the Custom GPT

1. Paste `custom-gpt-instructions.md` into the GPT instructions.
2. Add all five Actions above.
3. Use public Action 1 for connectivity and sanitized reads.
4. Use private Actions 2–5 only when Ken needs local bridge access.
5. Do not paste tokens into chat.

## 5. Local test

```bash
cd ~/Celine/celine-server
bash actions/chatgpt/test-action-spec.sh
scripts/test-private-gpt-action-gateway.sh
```

## 6. Remote test order

1. `getPublicGatewayHealth`
2. `getPrivateGatewayHealth`
3. `getPrivateGatewayStatus`
4. `getPrivateProjects`
5. `dryRunPrivateAssistantJob`
6. `dryRunPrivateJiraSubtasks` or `dryRunPrivateCreateGitHubIssue` as needed

## 7. Write approval texts

| Service | Exact `approvalText` |
|---|---|
| Jira | `Ken approved this Jira write` |
| GitHub | `Ken approved this GitHub write` |
| Keyboard Maestro | `Ken approved this Keyboard Maestro macro` |

## 8. Still excluded from ChatGPT

- App launching
- Open-any app launching
- Forge Key enable or disable
- Shell or arbitrary command execution
- Obsidian write/append/patch/import
- Scrivener write/create/delete
