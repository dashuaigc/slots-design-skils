---
name: slots-wild-prompt
description: 生成老虎机游戏WILD图标的专业AI生图Prompt。用于在Midjourney、Nano banana、即梦等平台产出可直接使用的Prompt，通过分阶段弹窗问卷收集信息，联网搜索竞品与AI模型规范，智能生成美术选项，生成多平台差异化Prompt。
---

# Slots WILD Prompt 专家

## 弹窗规则（内联）

- 使用 `AskUserQuestion`；每次 `questions` 数组最多 **4 题**；同批次所有题目合并为一次调用，用户一次性提交
- 每题 2-3 个互斥选项；推荐项放第一位末尾标注 `(Recommended)`；客户端自动追加 `Other`
- **条件追问**：含前置条件的题目（如 Q9b→Q9c-Q9f）先在同批主弹窗中问前置题，获得回答后若触发条件，再发起独立的追问批次（每次最多4题合并）
- 进度提示：每批后告知"已收到 [当前批次/总批次]"
- **降级策略**（工具不可用时）：改普通文本逐题提问，一题一问，选项格式"1-3项 + 4.其他（填写...）"
- **Q31 补充循环**：用户选"需要补充"→ 追问该补充内容的造型/色彩/材质细节（1题）→ 再问"还有补充吗？" → 循环直到确认无补充为止，才锁定方案

---

## 执行流程

1. 读取 `references/questionnaire-p1.md`，执行第一阶段弹窗（Batch 1.1→1.4）。
2. 第一阶段完成后，读取 `references/search-strategy.md`，立即执行并行联网搜索（竞品 + AI 模型能力）。
3. 读取 `references/ai-models/` 目录下**仅 Q13 选中平台**的模型规范文件；禁止读取未选平台文件。
4. 基于搜索结果 + 模型规范，为第三阶段每题生成 3-4 个智能推荐选项（标注推荐理由）。
5. 读取 `references/questionnaire-p3.md`，执行第三阶段弹窗（Batch 3.1→3.7）。
6. 输出完整需求汇总表，执行 Q31 确认；按上方"弹窗规则·Q31 补充循环"执行，直到用户确认无补充为止，锁定方案。
7. 读取 `references/prompt-spec.md` + `references/wild-art-core.md`，为每个平台/模型生成差异化 Prompt；立即对照 wild-art-core.md 12 条约束自检（最多 3 轮，❌ 自动修正，⚠️ 记录到报告）。
8. 读取 `references/output-format-core.md`，写入设计简报（`outputs/briefs/`）并归档各平台 Prompt 文件（`outputs/prompts/`）。
9. **修订模式**（Prompt 输出后用户需修改时触发）：读取 `references/output-format-revision.md`，执行修订流程（R1→R6），新文件序号自动递增。
10. **详细质量评审**（用户要求人工评审指导时）：读取 `references/quality-control.md`，输出完整评分表与人工清单。
