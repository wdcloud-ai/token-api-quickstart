# AI 编程工具接入

本页提供 Claude Code、Codex 和 Gemini CLI 的可复制配置。配置来自 WDCloud 公开文档，并在本仓库进行 JSON、TOML 与静态内容检查；v0.2 尚未使用真实令牌逐项实测。

模型名称、工具配置和分组权限可能变化。开始前请在[实时价格页](https://token.wdcloud.ai/pricing?aff=vRW8)确认模型，并优先参考 WDCloud 的最新工具文档。

## 通用建议

- 为每个工具创建独立 API Key，便于统计、限流和停用。
- 不要把真实 Key 提交到仓库。
- 将示例复制到用户配置目录后再替换占位符。
- Base URL 使用 `https://token.wdcloud.ai`，不要自行追加 `/v1`。

## Claude Code

官方文档：[Claude Code 接入](https://docs.wdcloud.ai/tools/claude-code)

1. 安装 Claude Code：

```bash
npm install -g @anthropic-ai/claude-code
```

2. 将 [`examples/tools/claude-code/settings.example.json`](../examples/tools/claude-code/settings.example.json) 的内容合并到：

- macOS / Linux：`~/.claude/settings.json`
- Windows：`%USERPROFILE%\.claude\settings.json`

3. 将 `YOUR_WDCLOUD_API_KEY` 替换为 Claude Code 专用分组令牌，再运行：

```bash
claude
```

## Codex CLI

官方文档：[Codex 接入](https://docs.wdcloud.ai/tools/codex)

OpenAI 当前配置参考确认：自定义 `model_provider` 应放在用户级 `~/.codex/config.toml`，不能依赖项目级 `.codex/config.toml` 覆盖提供商配置。

1. 安装 Codex CLI：

```bash
npm install -g @openai/codex@latest
```

2. 复制配置：

```text
examples/tools/codex/config.example.toml → ~/.codex/config.toml
examples/tools/codex/auth.example.json   → ~/.codex/auth.json
```

Windows 对应目录是 `%USERPROFILE%\.codex\`。

3. 将 `YOUR_WDCLOUD_API_KEY` 替换为 Codex 专用分组令牌。运行前确认示例中的模型仍可用，然后启动：

```bash
codex
```

配置格式同时参考 [OpenAI Codex 配置说明](https://learn.chatgpt.com/docs/config-file/config-reference)。

## Gemini CLI

官方文档：[Gemini CLI 接入](https://docs.wdcloud.ai/tools/gemini-cli)

1. 安装 Gemini CLI：

```bash
npm install -g @google/gemini-cli
```

2. 复制配置：

```text
examples/tools/gemini-cli/gemini.env.example → ~/.gemini/.env
examples/tools/gemini-cli/settings.example.json → ~/.gemini/settings.json
```

Windows 对应目录是 `%USERPROFILE%\.gemini\`。

3. 替换 `YOUR_WDCLOUD_API_KEY`，确认 `GEMINI_MODEL` 当前可用，然后启动：

```bash
gemini
```

## 验证边界

| 内容 | 状态 |
| --- | --- |
| 配置文件语法与必需字段 | ✅ 静态检查 |
| 配置值与 WDCloud 公开工具文档一致 | ✅ 2026-08-18 核验 |
| Claude Code 真实会话 | ⚠️ 待专用分组令牌实测 |
| Codex 真实会话 | ⚠️ 待专用分组令牌实测 |
| Gemini CLI 真实会话 | ⚠️ 待专用分组令牌实测 |

遇到问题时查看[故障排查](troubleshooting.md)。
