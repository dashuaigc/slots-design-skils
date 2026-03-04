---
name: nano-banana-generation
description: 调用 Nano Banana 2（Gemini-3.1-Flash-Image-Preview）API 生成图像。支持从已有 Prompt 文件直接生图，或手动输入 Prompt，自动轮询任务状态并下载结果图片。
---

# Nano Banana 图像生成

## 目标

- 一键调用 Nano Banana 2 API，将 Prompt 转化为图片。
- 支持从 `outputs/prompts/` 下已有的 nb2 JSON 文件读取 Prompt。
- 自动轮询任务状态，完成后下载图片到本地。

## 执行流程

1. 读取 `references/api-config.md`，检查 API Key 配置状态。
2. 若未配置，读取 `references/execution-flow.md` Step 2，执行首次配置引导。
3. 读取 `references/questionnaire.md`，收集生成参数：
   - **Batch 1**：弹窗选择 Prompt 来源（从文件或手动输入）。
   - **语言自动选择**：优先 `prompt_en`，无则用 `prompt_cn`，不弹窗。
   - **Batch 2**：弹窗选择画面比例、分辨率、生成数量（3 题一组）。
   - **自动默认**：联网搜索双开、无参考图（除非用户主动提供）。
4. 读取 `references/api-spec.md`，直接构建请求并调用生成 API，不再弹窗确认。
5. 读取 `references/execution-flow.md` Step 5，执行轮询直到任务完成或失败。
6. 读取 `references/execution-flow.md` Step 6，自动下载图片到 `../../outputs/images/` 并展示结果。

## 输出规则

- 图片自动下载到 `../../outputs/images/`，无需确认。
- 文件命名：`nb2_<主题>_<风格>_<YYYYMMDD>_<NNN>.png`。
- 下载完成后使用 Read 工具展示图片。

## 错误处理

- 401 引导重新配置 API Key，402 引导充值，429 等待重试，500/502 自动重试。
- 详细错误处理规则见 `references/execution-flow.md`。

## 参考文件装载策略

- 启动时读取 `references/api-config.md`。
- 首次配置时读取 `references/execution-flow.md` Step 2。
- 收集参数时读取 `references/questionnaire.md`。
- 调用 API 时读取 `references/api-spec.md`。
- 轮询和结果处理时读取 `references/execution-flow.md` Step 5-6。
