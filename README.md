# WDCloud API Quickstart

[![check](https://github.com/wdcloud-ai/token-api-quickstart/actions/workflows/check.yml/badge.svg)](https://github.com/wdcloud-ai/token-api-quickstart/actions/workflows/check.yml)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

[English](README.en.md) | 简体中文 · [GitHub](https://github.com/wdcloud-ai/token-api-quickstart) · [Gitee](https://gitee.com/jc1990/token-api-quickstart)

**使用一个 WDCloud API Key，通过统一入口调用多家 AI 模型。** 本仓库提供可直接复制的 `curl`、Python、Node.js，以及 Claude Code、Codex、Gemini CLI 配置示例。

> 当前版本：v0.2。信息核验日期：2026-08-18。模型、分组、工具配置和价格会动态调整，请以[实时价格页](https://token.wdcloud.ai/pricing)及[官方文档](https://docs.wdcloud.ai)为准。

![WDCloud API Quickstart：一个 API Key 调用多家 AI 模型](docs/assets/repo-social-preview.png)

## 先看结果

最小聊天请求成功后会返回类似下面的 JSON。实际字段会随模型和协议变化：

```json
{
  "choices": [
    {
      "message": {
        "role": "assistant",
        "content": "WDCloud API 连接成功"
      }
    }
  ]
}
```

当前验证状态：

| 能力 | 状态 |
| --- | --- |
| OpenAI 兼容聊天：`curl`、Python、Node.js | ✅ 已在“国内模型”分组实测 |
| 默认聊天模型 `deepseek-v4-flash` | ✅ 2026-08-12 实测 |
| Claude Code、Codex、Gemini CLI 配置 | ✅ 官方文档核验与静态检查；⚠️ 待真实会话实测 |
| Anthropic Messages、Responses API、图片生成 | ✅ 请求结构静态检查；⚠️ 需要对应模型分组 |

## 3 分钟快速开始

需要 `curl`、Python 3，或支持原生 `fetch` 的 Node.js 18 及以上版本。

1. 在 [WDCloud 控制台](https://token.wdcloud.ai)创建 API Key，并确认账号拥有“国内模型”分组权限。
2. 在当前终端设置环境变量，不要把真实 Key 写入代码：

```bash
export WDCLOUD_API_KEY="你的 API Key"
export WDCLOUD_MODEL="deepseek-v4-flash"
```

3. 运行聊天请求：

```bash
bash examples/curl/chat-completions.sh
```

也可以直接复制最小请求：

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

## 接入 AI 编程工具

仓库提供不含真实密钥的可复制配置：

| 工具 | 配置模板 | 官方文档 |
| --- | --- | --- |
| Claude Code | [`examples/tools/claude-code/`](examples/tools/claude-code/) | [接入文档](https://docs.wdcloud.ai/tools/claude-code) |
| Codex CLI | [`examples/tools/codex/`](examples/tools/codex/) | [接入文档](https://docs.wdcloud.ai/tools/codex) |
| Gemini CLI | [`examples/tools/gemini-cli/`](examples/tools/gemini-cli/) | [接入文档](https://docs.wdcloud.ai/tools/gemini-cli) |

安装、配置目录和验证边界见[完整工具接入指南](docs/tool-setup.md)。建议为每个工具创建独立 Key，便于统计、限流和停用。

## 示例目录

| 示例 | 文件 | 说明 |
| --- | --- | --- |
| OpenAI 兼容聊天 | [`examples/curl/chat-completions.sh`](examples/curl/chat-completions.sh) | ✅ 已实测 |
| Python 聊天 | [`examples/python/chat_completions.py`](examples/python/chat_completions.py) | ✅ 已实测 |
| Node.js 聊天 | [`examples/node/chat-completions.mjs`](examples/node/chat-completions.mjs) | ✅ 已实测 |
| 查询可用模型 | [`examples/curl/list-models.sh`](examples/curl/list-models.sh) | 用于检查 Key 的模型分组 |
| OpenAI Responses | [`examples/curl/responses.sh`](examples/curl/responses.sh) | ⚠️ 需要支持 Responses 的分组 |
| Anthropic Messages | [`examples/curl/anthropic-messages.sh`](examples/curl/anthropic-messages.sh) | ⚠️ 需要 Claude 分组 |
| OpenAI 兼容图片生成 | [`examples/curl/image-generation.sh`](examples/curl/image-generation.sh) | ⚠️ 需要图片模型分组 |

更多接口信息见 [`docs/api-and-tools.md`](docs/api-and-tools.md)。

## 遇到错误

先运行：

```bash
bash examples/curl/list-models.sh
```

常见情况：

- `API key invalid` 或 HTTP 401：检查 Key 是否完整、有效以及分组是否正确。
- `/v1/models` 返回空列表：账号或 Key 可能没有可用模型分组。
- `No available channel`：所选分组当前可能没有该模型的可用通道。
- HTTP 429：检查限流、余额和并发设置，不要无限重试。

完整步骤见[故障排查](docs/troubleshooting.md)。

## WDCloud 是什么

WDCloud API 是统一 AI API 接入平台，为 Claude Code、Codex、Gemini CLI 等 AI 编程工具提供服务。用户可在同一个控制台管理 API Key、额度、调用日志和模型访问。

- 控制台：<https://token.wdcloud.ai>
- API 文档：<https://docs.wdcloud.ai>
- API Base URL：`https://token.wdcloud.ai`
- 主要厂商：OpenAI、Anthropic、阿里巴巴、DeepSeek、智谱、Moonshot、讯飞等

## 安全与计费

- 不要在 Issue、日志、截图或提交记录中粘贴真实 API Key。
- 不要把 `.env`、`auth.json` 或包含真实 Key 的工具配置提交到 Git。
- API 请求可能产生费用；本仓库检查脚本不会请求模型。
- 模型名称、分组和价格可能变化，运行前检查实时价格页。
- 发现密钥泄露时，立即在控制台停用并重新创建。

## 本地检查与路线图

```bash
bash scripts/check.sh
```

检查包括 Shell、Python、Node.js、JSON、TOML 语法，关键链接、端点和疑似硬编码密钥；不会发起付费 API 请求。

后续计划见 [`docs/roadmap.md`](docs/roadmap.md)。问题与建议可提交到 [GitHub Issues](https://github.com/wdcloud-ai/token-api-quickstart/issues)。

## 注册与推广披露

如果你选择从本项目注册，可使用[项目注册链接](https://token.wdcloud.ai/sign-up?aff=vRW8)。该链接包含 `aff=vRW8`，用于记录本项目的来源归因；本仓库不推断或承诺未公开的归因周期、分润规则、SLA、退款规则和长期模型可用性。

本项目采用 [MIT License](LICENSE)。
