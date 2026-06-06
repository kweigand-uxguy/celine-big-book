#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/../.."

required_files=(
  "docs/chatgpt-action-research-notes.md"
  "actions/chatgpt/README.md"
  "actions/chatgpt/openapi.celine-server.yaml"
  "actions/chatgpt/openapi.celine-server.readonly.yaml"
  "actions/chatgpt/openapi.celine-jira.yaml"
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
  "actions/chatgpt/openapi.celine-server.yaml"
  "actions/chatgpt/openapi.celine-server.readonly.yaml"
  "actions/chatgpt/openapi.celine-jira.yaml"
)

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

for spec in "${install_ready_specs[@]}"; do
  for term in "${dangerous_terms[@]}"; do
    if grep -Fq "$term" "$spec"; then
      echo "FAIL dangerous term in install-ready spec: $spec"
      exit 1
    fi
  done
done

for spec in "${install_ready_specs[@]}"; do
  if grep -Eq '^[[:space:]]*/launcher/open-any:[[:space:]]*$' "$spec"; then
    echo "FAIL open-any launch path in install-ready spec: $spec"
    exit 1
  fi
done
echo "PASS dangerous route scan"

if grep -RIE '(CELINE_API_TOKEN=|CELINE_ACTION_TOKEN=|CF_ACCESS_CLIENT_SECRET=|CF_ACCESS_CLIENT_ID=|PUSHOVER_[A-Z_]*=|GITHUB_TOKEN=|VERCEL_TOKEN=|CLOUDFLARE.*TOKEN=|JIRA.*(TOKEN|SECRET|PASSWORD)=)' actions/chatgpt docs/chatgpt-action-research-notes.md --exclude=test-action-spec.sh >/tmp/celine-action-secret-scan.txt; then
  echo "FAIL secret-like assignment found"
  exit 1
fi

if grep -RIE 'Bearer[[:space:]]+[A-Za-z0-9._~+/-]{16,}' actions/chatgpt docs/chatgpt-action-research-notes.md >/tmp/celine-action-bearer-scan.txt; then
  echo "FAIL real-looking bearer token found"
  exit 1
fi

echo "PASS secret placeholder scan"
echo "Action spec test passed"
