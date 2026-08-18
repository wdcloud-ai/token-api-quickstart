# 小红书首发内容包：WDCloud API Quickstart

适用账号：WDCloud 官方账号

目标：用真实开发过程介绍开源 Quickstart，引导用户了解统一 API 接入能力

内容边界：只宣传仓库当前已有内容，不把静态核验写成真实调用成功

## 标题

推荐：

```text
多模型 API 接入，我们做了个开源模板
```

备选：

```text
一个 Key 调多个 AI 模型，3 分钟跑通
```

## 正文

最近我们在整理不同 AI 工具的模型接入流程，最容易重复踩坑的地方，往往不是写业务代码，而是配置 Base URL、API Key、模型分组和请求格式。

所以，我们把最小可用示例整理成了一个开源 Quickstart：

✅ 一个 API Key，通过统一入口调用多家 AI 模型

✅ 提供 curl、Python、Node.js 示例

✅ 提供 Claude Code、Codex、Gemini CLI 配置模板

✅ Key 只通过环境变量或本地工具配置读取

✅ 自带语法检查和疑似密钥扫描

当前已经完成真实调用验证的是“国内模型”分组下的 OpenAI 兼容聊天接口，默认示例使用 `deepseek-v4-flash`。

Claude Code、Codex、Gemini CLI、Responses API 和图片生成示例也已经整理进仓库，但需要对应模型分组，目前明确标记为“官方文档核验与静态检查，待真实会话实测”。

最小流程只有 3 步：

1. 创建 API Key
2. 设置环境变量
3. 运行示例并查看 JSON 响应

项目名：`token-api-quickstart`

下一步我们会继续补真实工具会话、流式响应和常见迁移场景。你最希望先看到 Claude Code、Codex，还是 Gemini CLI 的完整实测？

安全提醒：API 调用可能产生费用；模型、分组和价格请以实时页面为准。不要在截图、Issue 或公开代码中暴露真实 API Key。

## 标签

```text
#AI编程 #开发者工具 #API #Python #Nodejs
#ClaudeCode #Codex #GeminiCLI #DeepSeek #开源项目
```

## 配图顺序

1. `assets/01-cover.png`：首图
2. `assets/02-problem.png`：用户痛点
3. `assets/03-architecture.png`：统一入口示意
4. `assets/04-steps.png`：三步快速开始
5. `assets/05-code.png`：最小 curl 示例
6. `assets/06-verification.png`：验证边界
7. `assets/07-safety.png`：安全提醒与下一篇预告

## 发布检查

- 发布前再次核对默认模型和实时价格页。
- 截图、评论和私信中不要出现真实 API Key。
- 不使用“最低价”“最稳定”“无限量”等无法持续核验的绝对化表述。
- 正文不放站外 URL、二维码或“私信领取”等导流话术；如需承接注册，使用官方账号可用且经平台审核的站内组件。
- 首条评论可补充本次更新范围，但不要用奖励或资料领取诱导互动。

## 后续选题

1. Claude Code 接入 WDCloud：配置文件逐项解释
2. Codex 自定义模型提供商：`config.toml` 怎么写
3. `No available channel` 怎么排查
4. 为什么建议每个 AI 工具使用独立 API Key
5. OpenAI 兼容接口迁移时，只需要改哪些配置

## 视觉来源

背景图由 OpenAI 内置 imagegen 生成，提示词与生成方式记录在本次开发交付说明中。文字卡片由本仓库的 `source/carousel.html` 确定性渲染，便于修改和复用。
