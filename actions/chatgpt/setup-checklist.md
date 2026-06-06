# ChatGPT Action Setup Checklist

1. Confirm Celine Server production URL:

   ```text
   https://celine.thecreatorsmark.org
   ```

2. Decide auth model.

   Preferred future token:

   ```text
   CELINE_ACTION_TOKEN
   ```

3. Add `CELINE_ACTION_TOKEN` to Celine Server `.env` only if/when an Action Gateway is implemented.

4. Configure Custom GPT Action:

   - import OpenAPI schema
   - configure auth
   - test `GET /health`
   - test `GET /status`
   - test Jira read route
   - test Jira dry-run only

5. Do not install write-capable spec yet.

6. If Cloudflare Access blocks calls:

   - do not remove security
   - return to Action Gateway design
   - implement `/gpt-action/*` in a separate, explicit phase
