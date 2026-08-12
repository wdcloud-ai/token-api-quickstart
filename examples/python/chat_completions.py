#!/usr/bin/env python3
"""Call the WDCloud OpenAI-compatible chat endpoint with the Python standard library."""

import json
import os
import sys
import urllib.error
import urllib.request


api_key = os.environ.get("WDCLOUD_API_KEY")
if not api_key:
    raise SystemExit("Set WDCLOUD_API_KEY before running this example")

base_url = os.environ.get("WDCLOUD_BASE_URL", "https://token.wdcloud.ai").rstrip("/")
model = os.environ.get("WDCLOUD_MODEL", "deepseek-v4-flash")
payload = {
    "model": model,
    "messages": [
        {
            "role": "user",
            "content": "请只回复：WDCloud API 连接成功",
        }
    ],
    "stream": False,
}
request = urllib.request.Request(
    f"{base_url}/v1/chat/completions",
    data=json.dumps(payload, ensure_ascii=False).encode("utf-8"),
    headers={
        "Authorization": f"Bearer {api_key}",
        "Accept": "application/json",
        "Content-Type": "application/json",
        "User-Agent": "wdcloud-api-quickstart/1.0 (+https://docs.wdcloud.ai)",
    },
    method="POST",
)

try:
    with urllib.request.urlopen(request, timeout=60) as response:
        print(json.dumps(json.load(response), ensure_ascii=False, indent=2))
except urllib.error.HTTPError as error:
    print(error.read().decode("utf-8", errors="replace"), file=sys.stderr)
    raise SystemExit(f"WDCloud request failed with HTTP {error.code}") from error
