# 故障排查

先运行模型列表请求：

```bash
bash examples/curl/list-models.sh
```

如果该请求失败，先解决 Key、余额、分组或网络问题，再排查具体工具。

## `API key invalid` 或 HTTP 401

- 确认 Key 复制完整，没有空格或换行。
- 确认使用的是当前工具对应的专用分组令牌。
- 在控制台检查令牌是否已删除或失效。
- 不要在错误截图中暴露完整 Key。

## `/v1/models` 返回空列表

通常表示账号或 API Key 没有分配可用模型分组。请在控制台确认 Key 对应的分组和模型权限。

## `No available channel`

当前分组可能没有所选模型的可用通道。请：

1. 在实时价格页确认模型 ID。
2. 检查 Key 所属分组。
3. 换用该分组内的可用模型。
4. 仍无法解决时，携带脱敏请求时间和错误信息联系平台支持。

## Base URL 应该填什么

统一使用：

```text
https://token.wdcloud.ai
```

Claude Code、Codex 和 Gemini CLI 的配置中不要自行追加 `/v1`。直接调用 REST API 时，再使用 `/v1/chat/completions`、`/v1/responses` 等完整路径。

## HTTP 429 或余额不足

- 在控制台检查余额、使用记录和限流信息。
- 降低并发和输出长度。
- 为不同工具使用独立 Key，便于确认异常流量来源。
- 不要对失败请求进行无限重试。

## 工具能启动，但模型请求失败

- 确认工具读取的是预期配置目录。
- 确认配置中的模型 ID 当前存在。
- 确认该 Key 的分组支持对应协议，例如 Anthropic Messages 或 OpenAI Responses。
- 先使用本仓库的最小 `curl` 示例排除工具自身配置问题。

## 提交 Issue 前

请提供：

- 操作系统与版本
- 工具名称与版本
- 使用的接口路径和模型 ID
- 脱敏后的 HTTP 状态码与错误正文
- 大致请求时间

不要提供真实 API Key、完整账单、个人信息或未脱敏日志。
