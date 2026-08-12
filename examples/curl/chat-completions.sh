#!/usr/bin/env bash
set -euo pipefail

: "${WDCLOUD_API_KEY:?Set WDCLOUD_API_KEY before running this example}"

base_url="${WDCLOUD_BASE_URL:-https://token.wdcloud.ai}"
model="${WDCLOUD_MODEL:-deepseek-v4-flash}"

if [[ ! "$model" =~ ^[A-Za-z0-9._:-]+$ ]]; then
  echo "WDCLOUD_MODEL contains unsupported characters" >&2
  exit 1
fi

curl --fail-with-body --silent --show-error \
  "${base_url%/}/v1/chat/completions" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${WDCLOUD_API_KEY}" \
  --data @- <<JSON
{
  "model": "${model}",
  "messages": [
    {
      "role": "user",
      "content": "请只回复：WDCloud API 连接成功"
    }
  ],
  "stream": false
}
JSON
