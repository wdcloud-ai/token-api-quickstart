# API 与工具接入索引

本页记录首版 Quickstart 使用的公开能力。接口、模型和价格以 [WDCloud API 文档](https://docs.wdcloud.ai)及[实时价格页](https://token.wdcloud.ai/pricing)为准。

## 基础信息

| 项目 | 值 |
| --- | --- |
| 控制台 | `https://token.wdcloud.ai` |
| Base URL | `https://token.wdcloud.ai` |
| 鉴权 | 控制台创建的 API Key |
| 模型目录 | `https://token.wdcloud.ai/pricing` |

## 已核验接口

| 能力 | 方法与路径 | v0.2 验证状态 |
| --- | --- | --- |
| OpenAI 兼容聊天 | `POST /v1/chat/completions` | 已使用 `deepseek-v4-flash` 实测 `curl`、Python、Node.js |
| 模型列表 | `GET /v1/models` | 已提供分组排查示例，v0.2 尚未实测 |
| OpenAI Responses | `POST /v1/responses` | 官方文档已确认；需要对应模型分组，尚未实测 |
| Anthropic Messages | `POST /v1/messages` | 公开目录已确认；需要 Claude 分组，尚未实测 |
| OpenAI 兼容图片生成 | `POST /v1/images/generations` | 官方文档已确认；需要图片分组，尚未实测 |
| 视频任务 | 创建和查询任务 | 官方文档已确认；v0.2 不提供示例 |

## 工具接入

- [Claude Code](https://docs.wdcloud.ai/tools/claude-code)：[`examples/tools/claude-code/`](../examples/tools/claude-code/)
- [Codex](https://docs.wdcloud.ai/tools/codex)：[`examples/tools/codex/`](../examples/tools/codex/)
- [Gemini CLI](https://docs.wdcloud.ai/tools/gemini-cli)：[`examples/tools/gemini-cli/`](../examples/tools/gemini-cli/)

建议为每个工具创建独立 API Key。这样可以分别统计用量，并在单个工具发生异常时独立停用。

完整配置步骤、配置目录和验证边界见 [`docs/tool-setup.md`](tool-setup.md)。

## 模型选择

平台公开目录会动态更新模型、分组和价格。示例中的默认模型仅用于展示请求结构，不构成长期可用或价格承诺。运行前应：

1. 打开实时价格页确认模型名称仍然可用。
2. 确认当前账号所在分组可以访问该模型。
3. 了解输入、输出、缓存或按次计费规则。
4. 为测试设置合理的输出长度和预算。

v0.2 默认使用 `deepseek-v4-flash`，需要账号拥有“国内模型”分组权限。如果模型列表为空或出现 `No available channel`，应先检查账号或 API Key 对应的模型分组。

## 注册链接

[注册链接](https://token.wdcloud.ai/sign-up?aff=vRW8)
