#!/usr/bin/env bash
set -euo pipefail

# Requires an account with access to a Claude-enabled model group.
# This example was statically checked but not live-tested for v0.2.
: "${WDCLOUD_API_KEY:?Set WDCLOUD_API_KEY before running this example}"

base_url="${WDCLOUD_BASE_URL:-https://token.wdcloud.ai}"
model="${WDCLOUD_ANTHROPIC_MODEL:-claude-sonnet-4-6}"

if [[ ! "$model" =~ ^[A-Za-z0-9._:-]+$ ]]; then
  echo "WDCLOUD_ANTHROPIC_MODEL contains unsupported characters" >&2
  exit 1
fi

curl --fail-with-body --silent --show-error \
  "${base_url%/}/v1/messages" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${WDCLOUD_API_KEY}" \
  -H "anthropic-version: 2023-06-01" \
  --data @- <<JSON
{
  "model": "${model}",
  "max_tokens": 256,
  "messages": [
    {
      "role": "user",
      "content": "请只回复：WDCloud API 连接成功"
    }
  ]
}
JSON
