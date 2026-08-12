# WDCloud API Quickstart

[![check](https://github.com/wdcloud-ai/token-api-quickstart/actions/workflows/check.yml/badge.svg)](https://github.com/wdcloud-ai/token-api-quickstart/actions/workflows/check.yml)

[English](README.en.md) | 简体中文

使用一个 WDCloud API Key，通过统一入口调用多家 AI 模型。本仓库提供可直接复制的 `curl`、Python 和 Node.js 请求示例，不依赖第三方 SDK。

> 当前版本：v0.1。信息核验日期：2026-08-12。模型、分组和价格会动态调整，请以[实时价格页](https://token.wdcloud.ai/pricing)为准。

## WDCloud 是什么

WDCloud API 是统一 AI API 接入平台，为 Claude Code、Codex、Gemini CLI 等 AI 编程工具提供服务。用户可在同一个控制台管理 API Key、额度、调用日志和模型访问。

- 控制台：<https://token.wdcloud.ai>
- API 文档：<https://docs.wdcloud.ai>
- API Base URL：`https://token.wdcloud.ai`
- 推荐注册入口：<https://token.wdcloud.ai/sign-up?aff=vRW8>
- 支持的主要厂商：OpenAI、Anthropic、阿里巴巴、DeepSeek、智谱、Moonshot、讯飞等

本项目使用已经确认的推荐注册链接，平台通过 `aff` 查询参数记录推广码：

```text
https://token.wdcloud.ai/sign-up?aff=vRW8
```

直接访问控制台不受影响；从本项目注册时请使用上面的完整链接，以便正确记录来源。

## 3 分钟快速开始

运行示例需要 `curl`、Python 3，或支持原生 `fetch` 的 Node.js 18 及以上版本。

1. 通过[推荐注册链接](https://token.wdcloud.ai/sign-up?aff=vRW8)注册并登录 WDCloud 控制台。
2. 在控制台创建一个 API Key，并确认账号拥有“国内模型”分组权限。建议为不同工具分别创建 Key，便于统计和停用。
3. 将环境变量写入当前终端，不要把真实 Key 提交到 Git：

```bash
export WDCLOUD_API_KEY="你的 API Key"
export WDCLOUD_MODEL="deepseek-v4-flash"
```

4. 运行聊天请求：

```bash
bash examples/curl/chat-completions.sh
```

也可以直接复制下面的最小请求：

```bash
curl https://token.wdcloud.ai/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${WDCLOUD_API_KEY}" \
  -d '{
    "model": "deepseek-v4-flash",
    "messages": [
      {"role": "user", "content": "请只回复：WDCloud API 连接成功"}
    ]
  }'
```

## 示例目录

| 示例 | 文件 | 说明 |
| --- | --- | --- |
| OpenAI 兼容聊天 | [`examples/curl/chat-completions.sh`](examples/curl/chat-completions.sh) | ✅ 已在“国内模型”分组实测 |
| Python 聊天 | [`examples/python/chat_completions.py`](examples/python/chat_completions.py) | ✅ 已在“国内模型”分组实测 |
| Node.js 聊天 | [`examples/node/chat-completions.mjs`](examples/node/chat-completions.mjs) | ✅ 已在“国内模型”分组实测 |
| Anthropic Messages | [`examples/curl/anthropic-messages.sh`](examples/curl/anthropic-messages.sh) | ⚠️ 需要支持 Claude 的模型分组，当前未实测 |
| OpenAI 兼容图片生成 | [`examples/curl/image-generation.sh`](examples/curl/image-generation.sh) | ⚠️ 需要图片模型分组，当前未实测 |

更多接口和工具配置见 [`docs/api-and-tools.md`](docs/api-and-tools.md)。

## 环境变量

复制 `.env.example` 中需要的变量到你自己的环境配置中：

| 变量 | 必填 | 默认值 |
| --- | --- | --- |
| `WDCLOUD_API_KEY` | 是 | 无 |
| `WDCLOUD_BASE_URL` | 否 | `https://token.wdcloud.ai` |
| `WDCLOUD_MODEL` | 否 | 聊天示例使用 `deepseek-v4-flash` |
| `WDCLOUD_ANTHROPIC_MODEL` | 否 | Anthropic 示例使用 `claude-sonnet-4-6` |
| `WDCLOUD_IMAGE_MODEL` | 否 | 图片示例使用 `gpt-image-2` |

示例不会自动读取 `.env` 文件，避免在不同语言中引入额外依赖。你可以手动 `export`，或者使用自己的密钥管理工具。

## 安全与计费提醒

- 不要在 Issue、日志、截图或提交记录中粘贴真实 API Key。
- 不要把 `.env` 提交到 Git；本目录只提供无密钥的 `.env.example`。
- API 请求可能产生费用。示例检查脚本只做静态验证，不会请求模型。
- 模型名称和价格可能变化，运行示例前请检查[实时价格页](https://token.wdcloud.ai/pricing)。
- 发现密钥泄露时，应立即在控制台停用并重新创建。
- 如果 `/v1/models` 返回空列表或接口提示 `No available channel`，请确认 API Key 所属账号已分配正确的模型分组。

## 本地检查

```bash
bash scripts/check.sh
```

检查内容包括 Shell、Python、Node.js 语法，关键链接与端点，以及疑似硬编码密钥。检查不会发起付费 API 请求。

## 信息边界

本仓库只发布 WDCloud 公开页面、公开 API 文档和真实请求中可核验的信息，不承诺未公开的 SLA、退款规则、调用限额或模型长期可用性。

## 反馈与许可

- 问题与建议：[GitHub Issues](https://github.com/wdcloud-ai/token-api-quickstart/issues)
- 开源许可：[MIT License](LICENSE)
