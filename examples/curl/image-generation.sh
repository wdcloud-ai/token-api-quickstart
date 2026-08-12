#!/usr/bin/env bash
set -euo pipefail

# Requires an account with access to an image-enabled model group.
# This example was statically checked but not live-tested for v0.1.
: "${WDCLOUD_API_KEY:?Set WDCLOUD_API_KEY before running this example}"

base_url="${WDCLOUD_BASE_URL:-https://token.wdcloud.ai}"
model="${WDCLOUD_IMAGE_MODEL:-gpt-image-2}"

if [[ ! "$model" =~ ^[A-Za-z0-9._:-]+$ ]]; then
  echo "WDCLOUD_IMAGE_MODEL contains unsupported characters" >&2
  exit 1
fi

curl --fail-with-body --silent --show-error \
  "${base_url%/}/v1/images/generations" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${WDCLOUD_API_KEY}" \
  --data @- <<JSON
{
  "model": "${model}",
  "prompt": "未来感城市天际线，清晨阳光，写实摄影风格。"
}
JSON
