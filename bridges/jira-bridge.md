# Jira Bridge

Base URL:

```text
https://celine.thecreatorsmark.org
```

## Routes

```text
GET /health
GET /jira/issues/:key
GET /jira/issues/:key/children
POST /jira/subtasks/dry-run
POST /jira/subtasks/create
```

## Rules

- Always dry-run before create.
- Never create subtasks unless Ken explicitly approves.
- Treat `POST /jira/subtasks/create` as a write action.
- Store only token patterns and header names here.
- Do not store actual secrets, Jira credentials, bearer tokens, or Cloudflare Access secrets.

## Token Pattern

Use placeholder names only:

```text
Authorization: Bearer <CELINE_API_TOKEN>
CF-Access-Client-Id: <CF_ACCESS_CLIENT_ID>
CF-Access-Client-Secret: <CF_ACCESS_CLIENT_SECRET>
```

Actual values expand locally on Ken's Mac from `.env`.
