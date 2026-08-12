#!/usr/bin/env bash
set -euo pipefail

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$root_dir"

test -f .github/workflows/check.yml
echo "ok GitHub Actions workflow"

echo "Shell syntax:"
for script in examples/curl/*.sh scripts/*.sh; do
  bash -n "$script"
  echo "ok $script"
done

echo
echo "Python syntax:"
python3 - <<'PY'
import ast
from pathlib import Path

for path in sorted(Path("examples/python").glob("*.py")):
    ast.parse(path.read_text(encoding="utf-8"), filename=str(path))
    print(f"ok {path}")
PY

echo
echo "Node.js syntax:"
for script in examples/node/*.mjs; do
  node --check "$script"
  echo "ok $script"
done

echo
echo "Required product facts:"
for required in \
  'https://token.wdcloud.ai' \
  'https://docs.wdcloud.ai' \
  '/v1/chat/completions' \
  '/v1/messages' \
  '/v1/images/generations' \
  'deepseek-v4-flash' \
  'MIT License' \
  'https://token.wdcloud.ai/sign-up?aff=vRW8'; do
  grep -R -F -q -- "$required" README.md README.en.md LICENSE llms.txt docs examples .env.example
  echo "ok $required"
done

if grep -R -n -E --exclude-dir=.git \
  'WDCLOUD_MODEL=gpt-5\.4|WDCLOUD_MODEL:-gpt-5\.4|WDCLOUD_MODEL \|.*gpt-5\.4' .; then
  echo "Legacy default chat model found" >&2
  exit 1
fi
echo "ok default chat model is not gpt-5.4"

echo
echo "Secret scan:"
if grep -R -n -E --exclude-dir=.git 'sk-[A-Za-z0-9_-]{20,}' .; then
  echo "Possible hard-coded API key found" >&2
  exit 1
fi
echo "ok no API key-shaped values"

echo
echo "WDCloud quickstart check complete. No network request was made."
