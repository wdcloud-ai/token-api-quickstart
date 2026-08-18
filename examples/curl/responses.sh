#!/usr/bin/env bash
set -euo pipefail

# Requires an account and model group that support the Responses API.
# This example is statically checked but has not been live-tested for v0.2.
: "${WDCLOUD_API_KEY:?Set WDCLOUD_API_KEY before running this example}"
: "${WDCLOUD_RESPONSES_MODEL:?Set WDCLOUD_RESPONSES_MODEL to an available model ID}"

base_url="${WDCLOUD_BASE_URL:-https://token.wdcloud.ai}"
model="${WDCLOUD_RESPONSES_MODEL}"

if [[ ! "$model" =~ ^[A-Za-z0-9._:-]+$ ]]; then
  echo "WDCLOUD_RESPONSES_MODEL contains unsupported characters" >&2
  exit 1
fi

curl --fail-with-body --silent --show-error \
  "${base_url%/}/v1/responses" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${WDCLOUD_API_KEY}" \
  --data @- <<JSON
{
  "model": "${model}",
  "input": "请只回复：WDCloud Responses API 连接成功"
}
JSON
