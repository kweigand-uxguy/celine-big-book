# Mobile Chat Workflow

Mobile ChatGPT cannot directly read Ken's Mac filesystem.

Mobile chat can:

- reference Celine's Big Book remote prompt
- reason from public/sanitized context
- draft Codex prompts
- prepare payloads and plans
- ask Ken whether to use Codex or normal chat reasoning

When exact local docs or files are needed:

1. Generate a Codex prompt.
2. Tell Codex which local path to read.
3. Tell Codex not to print secrets.
4. Have Codex report back with sanitized findings.

Secrets stay local.
