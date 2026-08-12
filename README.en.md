# WDCloud API Quickstart

[![check](https://github.com/wdcloud-ai/token-api-quickstart/actions/workflows/check.yml/badge.svg)](https://github.com/wdcloud-ai/token-api-quickstart/actions/workflows/check.yml)

English | [简体中文](README.md)

Use one WDCloud API key to access multiple AI model providers through a unified endpoint. This repository contains copy-ready `curl`, Python, and Node.js examples without third-party SDK dependencies.

> Current version: v0.1. Facts were last verified on 2026-08-12. Models, routing groups, and prices are dynamic; check the [live pricing page](https://token.wdcloud.ai/pricing) before use.

## What is WDCloud?

WDCloud API provides a unified AI API gateway for tools such as Claude Code, Codex, and Gemini CLI. The same console manages API keys, quota, request logs, and model access.

- Console: <https://token.wdcloud.ai>
- API documentation: <https://docs.wdcloud.ai>
- API base URL: `https://token.wdcloud.ai`
- Referral registration: <https://token.wdcloud.ai/sign-up?aff=vRW8>
- Providers listed by the public catalog include OpenAI, Anthropic, Alibaba, DeepSeek, Zhipu, Moonshot, and iFlytek.

This project uses an approved referral URL. WDCloud records its attribution with the `aff` query parameter:

```text
https://token.wdcloud.ai/sign-up?aff=vRW8
```

Use the complete URL above when registering from this project so that the source is attributed correctly.

## Quick start

The examples require `curl`, Python 3, or Node.js 18+ with native `fetch` support.

1. Register through the [referral link](https://token.wdcloud.ai/sign-up?aff=vRW8), then sign in to the WDCloud console.
2. Create an API key and confirm that the account has access to the `国内模型` (domestic models) group. Separate keys per tool make usage easier to trace and revoke.
3. Export your key and preferred model without committing either to Git:

```bash
export WDCLOUD_API_KEY="your API key"
export WDCLOUD_MODEL="deepseek-v4-flash"
```

4. Run the chat example:

```bash
bash examples/curl/chat-completions.sh
```

## Examples

| Example | File | Endpoint |
| --- | --- | --- |
| OpenAI-compatible chat | [`examples/curl/chat-completions.sh`](examples/curl/chat-completions.sh) | ✅ Live-tested with the domestic models group |
| Python chat | [`examples/python/chat_completions.py`](examples/python/chat_completions.py) | ✅ Live-tested with the domestic models group |
| Node.js chat | [`examples/node/chat-completions.mjs`](examples/node/chat-completions.mjs) | ✅ Live-tested with the domestic models group |
| Anthropic Messages | [`examples/curl/anthropic-messages.sh`](examples/curl/anthropic-messages.sh) | ⚠️ Requires a Claude-enabled group; not live-tested yet |
| OpenAI-compatible image generation | [`examples/curl/image-generation.sh`](examples/curl/image-generation.sh) | ⚠️ Requires an image-enabled group; not live-tested yet |

See [`docs/api-and-tools.md`](docs/api-and-tools.md) for endpoints and tool integration links.

## Safety and billing

- Never paste a real API key into issues, logs, screenshots, or commits.
- API requests may incur charges. The repository checks are static and never call a model.
- Confirm the selected model and current price on the [live pricing page](https://token.wdcloud.ai/pricing).
- Revoke and replace any exposed key immediately.
- If `/v1/models` is empty or a request reports `No available channel`, verify the model group assigned to the API key's account.

Run local checks with:

```bash
bash scripts/check.sh
```

## Feedback and license

- Questions and suggestions: [GitHub Issues](https://github.com/wdcloud-ai/token-api-quickstart/issues)
- License: [MIT](LICENSE)
