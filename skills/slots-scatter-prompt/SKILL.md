---
name: slots-scatter-prompt
description: 生成老虎机游戏SCATTER图标的专业AI生图Prompt。读取已有WILD设计简报复用游戏基础信息，在Midjourney、Nano Banana、即梦等平台产出可直接使用的SCATTER Prompt。
---

# Slots SCATTER Prompt 专家

## 执行流程

0. 读取 `references/popup-protocol.md`，加载弹窗规则（后续所有 AskUserQuestion 调用均遵循此规则）。
1. 读取 `references/questionnaire-p0.md`，执行 P0 阶段：先询问是否读取已有 WILD 简报 → 若是，列出 brief 文件让用户选择，读取共用字段并展示摘要；若否，跳过 brief 读取，在 P1 阶段按 WILD 流程从头收集基础信息。
2. 读取 `references/questionnaire-p1.md`，执行第一阶段弹窗（Batch 1.1→1.3），仅问 SCATTER 特有信息。
3. 第一阶段完成后，读取 `references/search-strategy.md`，立即执行并行联网搜索（SCATTER 竞品 + AI 模型能力）。
4. 读取 `references/ai-models/` 目录下**仅 Q_P1 选中平台**的模型规范文件；禁止读取未选平台文件。
5. 基于搜索结果 + 模型规范，为第三阶段每题生成 3-4 个智能推荐选项（标注推荐理由）。
6. 读取 `references/questionnaire-p3.md`，执行第三阶段弹窗（Batch 3.1→3.7）；若 Q_S1 = 不需要文字，跳过 Batch 3.4。
7. 输出完整需求汇总表，执行 Q31 确认；按 `references/popup-protocol.md` 中"Q31 补充循环"规则执行，直到用户确认无补充为止，锁定方案。
8. 读取 `references/prompt-spec.md` + `references/scatter-art-core.md`，为每个平台/模型生成差异化 Prompt；立即对照 scatter-art-core.md 12 条约束自检（最多 3 轮，❌ 自动修正，⚠️ 记录到报告）。
9. 读取 `references/output-format-core.md`，写入设计简报（`outputs/briefs/`）并归档各平台 Prompt 文件（`outputs/prompts/`）。
10. **修订模式**（Prompt 输出后用户需修改时触发）：读取 `references/output-format-revision.md`，执行修订流程（R1→R6），新文件序号自动递增。
11. **详细质量评审**（用户要求人工评审指导时）：读取 `references/quality-control.md`，输出完整评分表与人工清单。
