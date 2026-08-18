#!/usr/bin/env bash
set -euo pipefail

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$root_dir"

test -f .github/workflows/check.yml
echo "ok GitHub Actions workflow"

test -f CITATION.cff
test -f docs/official-project.md
echo "ok official project metadata files"

echo "Shell syntax:"
for script in examples/curl/*.sh scripts/*.sh; do
  bash -n "$script"
  echo "ok $script"
done

echo
echo "Official identity consistency:"
for path in README.md llms.txt docs/official-project.md; do
  for required in \
    'WDCloud（沃动云集）' \
    'https://github.com/wdcloud-ai/token-api-quickstart' \
    'https://gitee.com/jc1990/token-api-quickstart' \
    '95615131237'; do
    grep -F -q -- "$required" "$path"
  done
  echo "ok $path"
done

if grep -E -q 'AI API QUICKSTART|WHY WE BUILT IT|ONE GATEWAY|3-MINUTE START|COPY & RUN|VERIFICATION FIRST|SAFE BY DEFAULT' \
  docs/social/xiaohongshu/quickstart-launch/source/carousel.html \
  docs/social/xiaohongshu/quickstart-launch/README.md; then
  echo "English Xiaohongshu headline found" >&2
  exit 1
fi
echo "ok Xiaohongshu headlines use Chinese"

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
echo "JSON and TOML syntax:"
python3 - <<'PY'
import json
import tomllib
from pathlib import Path

for path in sorted(Path("examples/tools").rglob("*.json")):
    json.loads(path.read_text(encoding="utf-8"))
    print(f"ok {path}")

for path in sorted(Path("examples/tools").rglob("*.toml")):
    tomllib.loads(path.read_text(encoding="utf-8"))
    print(f"ok {path}")
PY

echo
echo "Xiaohongshu image dimensions:"
python3 - <<'PY'
import struct
from pathlib import Path

asset_dir = Path("docs/social/xiaohongshu/quickstart-launch/assets")
expected = [
    "01-cover.png",
    "02-problem.png",
    "03-architecture.png",
    "04-steps.png",
    "05-code.png",
    "06-verification.png",
    "07-safety.png",
]

for name in expected:
    path = asset_dir / name
    header = path.read_bytes()[:24]
    if header[:8] != b"\x89PNG\r\n\x1a\n":
        raise SystemExit(f"not a PNG: {path}")
    width, height = struct.unpack(">II", header[16:24])
    if (width, height) != (1080, 1440):
        raise SystemExit(f"unexpected dimensions for {path}: {width}x{height}")
    print(f"ok {path} {width}x{height}")

preview = Path("docs/assets/repo-social-preview.png")
header = preview.read_bytes()[:24]
if header[:8] != b"\x89PNG\r\n\x1a\n":
    raise SystemExit(f"not a PNG: {preview}")
width, height = struct.unpack(">II", header[16:24])
if (width, height) != (1280, 640):
    raise SystemExit(f"unexpected dimensions for {preview}: {width}x{height}")
print(f"ok {preview} {width}x{height}")
PY

echo
echo "Required product facts:"
for required in \
  'https://token.wdcloud.ai' \
  'https://docs.wdcloud.ai' \
  '/v1/chat/completions' \
  '/v1/models' \
  '/v1/responses' \
  '/v1/messages' \
  '/v1/images/generations' \
  'deepseek-v4-flash' \
  'ANTHROPIC_BASE_URL' \
  'model_providers.wdcloud' \
  'GOOGLE_GEMINI_BASE_URL' \
  'MIT License'; do
  grep -R -F -q -- "$required" README.md README.en.md LICENSE llms.txt docs examples .env.example
  echo "ok $required"
done

grep -R -F -q -- \
  '[注册链接](https://token.wdcloud.ai/sign-up?aff=vRW8)' \
  README.md docs CHANGELOG.md llms.txt
echo "ok registration link"

grep -F -q -- \
  '[立即注册并创建 API Key →](https://token.wdcloud.ai/sign-up?aff=vRW8)' \
  README.md
echo "ok prominent registration entry"

python3 - <<'PY'
import re
from pathlib import Path
approved = "https://token.wdcloud.ai/sign-up?aff=vRW8"
paths = [Path("README.md"), Path("README.en.md"), Path("CHANGELOG.md"), Path("llms.txt"), Path(".env.example")]
paths.extend(
    path
    for path in Path("docs").rglob("*")
    if path.is_file() and path.suffix in {".md", ".txt", ".html"}
)

invalid = []
non_registration_navigation = []
for path in paths:
    text = path.read_text(encoding="utf-8")
    for match in re.finditer(r"https://token\.wdcloud\.ai/sign-up[^\s)>`\"]*", text):
        if match.group(0) != approved:
            invalid.append(f"{path}: {match.group(0)}")

    navigation_patterns = (
        r"\]\((https://token\.wdcloud\.ai[^)\s]*)\)",
        r"<(https://token\.wdcloud\.ai[^>\s]*)>",
        r"href=[\"'](https://token\.wdcloud\.ai[^\"']*)[\"']",
    )
    for pattern in navigation_patterns:
        for match in re.finditer(pattern, text):
            url = match.group(1)
            if url != approved:
                non_registration_navigation.append(f"{path}: {url}")

if invalid:
    raise SystemExit("Unapproved registration URL found:\n" + "\n".join(invalid))

print("ok all registration URLs use the approved link")

if non_registration_navigation:
    raise SystemExit(
        "Clickable token platform URL other than the approved registration link found:\n"
        + "\n".join(non_registration_navigation)
    )

print("ok all clickable token platform URLs use the approved registration link")
PY

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
