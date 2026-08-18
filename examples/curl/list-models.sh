#!/usr/bin/env bash
set -euo pipefail

: "${WDCLOUD_API_KEY:?Set WDCLOUD_API_KEY before running this example}"

base_url="${WDCLOUD_BASE_URL:-https://token.wdcloud.ai}"

curl --fail-with-body --silent --show-error \
  "${base_url%/}/v1/models" \
  -H "Authorization: Bearer ${WDCLOUD_API_KEY}" \
  -H "Accept: application/json"
