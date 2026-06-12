#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/../.."

required_files=(
  "docs/chatgpt-action-research-notes.md"
  "actions/chatgpt/README.md"
  "actions/chatgpt/openapi.celine-server.yaml"
  "actions/chatgpt/openapi.celine-server.readonly.yaml"
  "actions/chatgpt/openapi.celine-jira.yaml"
  "actions/chatgpt/openapi.celine-server.public.yaml"
  "actions/chatgpt/openapi.celine-server.private.core.yaml"
  "actions/chatgpt/openapi.celine-server.private.jira.yaml"
  "actions/chatgpt/openapi.celine-server.private.github.yaml"
  "actions/chatgpt/openapi.celine-server.private.keyboard-maestro.yaml"
  "actions/chatgpt/openapi.celine-server.private.yaml"
  "actions/chatgpt/custom-gpt-instructions.md"
  "actions/chatgpt/setup-checklist.md"
  "actions/chatgpt/security-model.md"
  "actions/chatgpt/action-gateway-design.md"
  "actions/chatgpt/test-action-spec.sh"
)

for file in "${required_files[@]}"; do
  if [[ ! -s "$file" ]]; then
    echo "FAIL missing or empty: $file"
    exit 1
  fi
  echo "PASS exists: $file"
done

install_ready_specs=(
  "actions/chatgpt/openapi.celine-server.public.yaml"
  "actions/chatgpt/openapi.celine-server.private.core.yaml"
  "actions/chatgpt/openapi.celine-server.private.jira.yaml"
  "actions/chatgpt/openapi.celine-server.private.github.yaml"
  "actions/chatgpt/openapi.celine-server.private.keyboard-maestro.yaml"
  "actions/chatgpt/openapi.celine-server.yaml"
  "actions/chatgpt/openapi.celine-server.readonly.yaml"
  "actions/chatgpt/openapi.celine-jira.yaml"
)

chatgpt_install_specs=(
  "actions/chatgpt/openapi.celine-server.public.yaml"
  "actions/chatgpt/openapi.celine-server.private.core.yaml"
  "actions/chatgpt/openapi.celine-server.private.jira.yaml"
  "actions/chatgpt/openapi.celine-server.private.github.yaml"
  "actions/chatgpt/openapi.celine-server.private.keyboard-maestro.yaml"
)

max_chatgpt_operations=30

for spec in "${chatgpt_install_specs[@]}"; do
  if [[ ! -s "$spec" ]]; then
    echo "FAIL missing or empty ChatGPT install spec: $spec"
    exit 1
  fi
  op_count="$(grep -c 'operationId:' "$spec" || true)"
  if [[ "$op_count" -gt "$max_chatgpt_operations" ]]; then
    echo "FAIL ChatGPT operation limit exceeded in $spec ($op_count > $max_chatgpt_operations)"
    exit 1
  fi
  echo "PASS ChatGPT operation count: $spec ($op_count)"
done

combined_private_spec="actions/chatgpt/openapi.celine-server.private.yaml"
if [[ -s "$combined_private_spec" ]]; then
  combined_ops="$(grep -c 'operationId:' "$combined_private_spec" || true)"
  if [[ "$combined_ops" -le "$max_chatgpt_operations" ]]; then
    echo "WARN combined private spec fits ChatGPT limit; split specs may no longer be required"
  else
    echo "PASS combined private spec kept as reference only ($combined_ops operations)"
  fi
fi

if command -v yq >/dev/null 2>&1; then
  for spec in "${install_ready_specs[@]}"; do
    yq '.' "$spec" >/dev/null
    echo "PASS yaml parse: $spec"
  done
elif python3 - <<'PY' >/dev/null 2>&1
import yaml
PY
then
  for spec in "${install_ready_specs[@]}"; do
    python3 - "$spec" <<'PY'
import sys, yaml
with open(sys.argv[1], "r", encoding="utf-8") as handle:
    yaml.safe_load(handle)
PY
    echo "PASS yaml parse: $spec"
  done
else
  for spec in "${install_ready_specs[@]}"; do
    python3 - "$spec" <<'PY'
import sys
text = open(sys.argv[1], "r", encoding="utf-8").read()
if "openapi:" not in text or "paths:" not in text:
    raise SystemExit(1)
PY
    echo "PASS yaml shape: $spec"
  done
fi

dangerous_terms=(
  "createJiraSubtasks"
  "openAnyApp"
  "disableForgeKey"
  "launchWorkspace"
  "executeCommand"
  "runShell"
  "/jira/subtasks/create"
  "/launcher/workspace/moth-market/open"
  "/forge-key/disable"
)

legacy_readonly_specs=(
  "actions/chatgpt/openapi.celine-server.yaml"
  "actions/chatgpt/openapi.celine-server.readonly.yaml"
  "actions/chatgpt/openapi.celine-jira.yaml"
  "actions/chatgpt/openapi.celine-server.public.yaml"
)

for spec in "${legacy_readonly_specs[@]}"; do
  for term in "${dangerous_terms[@]}"; do
    if grep -Fq "$term" "$spec"; then
      echo "FAIL dangerous term in legacy readonly spec: $spec"
      exit 1
    fi
  done
done

for spec in "${legacy_readonly_specs[@]}" "${chatgpt_install_specs[0]}" "${chatgpt_install_specs[1]}"; do
  if grep -Eq '^[[:space:]]*/launcher/open-any:[[:space:]]*$' "$spec"; then
    echo "FAIL open-any launch path in spec: $spec"
    exit 1
  fi
done
echo "PASS dangerous route scan"

if grep -RIE '(CELINE_API_TOKEN=|CELINE_ACTION_TOKEN=|CF_ACCESS_CLIENT_SECRET=|CF_ACCESS_CLIENT_ID=|PUSHOVER_[A-Z_]*=|GITHUB_TOKEN=|VERCEL_TOKEN=|CLOUDFLARE.*TOKEN=|JIRA.*(TOKEN|SECRET|PASSWORD)=)' actions/chatgpt docs/chatgpt-action-research-notes.md --exclude=test-action-spec.sh --exclude=setup-checklist.md >/tmp/celine-action-secret-scan.txt; then
  echo "FAIL secret-like assignment found"
  exit 1
fi

if grep -RIE 'Bearer[[:space:]]+[A-Za-z0-9._~+/-]{16,}' actions/chatgpt docs/chatgpt-action-research-notes.md >/tmp/celine-action-bearer-scan.txt; then
  echo "FAIL real-looking bearer token found"
  exit 1
fi

echo "PASS secret placeholder scan"
echo "Action spec test passed"
