---
name: slots-wild-prompt
description: 生成老虎机游戏WILD图标的专业AI生图Prompt。用于在Midjourney、Nano banana、即梦等平台产出可直接使用的Prompt，通过分阶段弹窗问卷收集信息，联网搜索竞品与AI模型规范，智能生成美术选项，生成多平台差异化Prompt。
---

# Slots WILD Prompt 专家

## 目标

- 分阶段弹窗收集需求，不跳题，不合并提问。
- 基于确认方案生成平台定制 Prompt。
- 输出纯 Prompt 文件，支持后续版本迭代。

## 执行流程

1. 读取 `references/questionnaire.md` 第一阶段问题集。
2. 读取 `references/popup-protocol.md`，按协议执行第一阶段弹窗（Batch 1.1→1.4）。
3. 第一阶段完成后，读取 `references/search-strategy.md`，执行并行联网搜索。
4. 读取 `references/ai-models/` 目录下用户选中平台的模型规范文件。
5. 基于搜索结果 + 模型能力，为第三阶段每题生成智能推荐选项。
6. 读取 `references/questionnaire.md` 第三阶段问题集，按协议执行弹窗（Batch 3.1→3.7）。
7. 输出完整需求汇总表，弹窗确认无误后锁定方案。
8. 读取 `references/prompt-spec.md`，为每个平台/模型生成差异化 Prompt。
9. 读取 `references/self-check-spec.md`，立即自检循环（最多 3 轮），直到全部通过。
10. 读取 `references/output-format.md`，**每个平台单独一个文件**归档至 `../../outputs/prompts/`。

## 弹窗问询硬性要求

- 优先使用 `AskUserQuestion` 工具执行弹窗问询。
- 每次调用只提交 1 个问题，`questions` 数组长度必须为 1。
- 每题提供 2-3 个互斥选项，推荐项放第一位并标注 `(Recommended)`，利用客户端自动 `Other` 作为"第4项其他"。
- 对业务多选字段（如目标平台），拆分为连续单选子题。
- 对条件子字段必须追问（如"是否要边框=是"→ 继续问样式/材质/粗细）。
- 对 WILD 文字必须组合追问：文字结构、材质、主题融合元素、超框比例、特效处理。
- 阶段A和阶段B都必须逐题确认，不允许更改提问顺序。
- 详细规则与降级策略见 `references/popup-protocol.md`。

## Prompt 生成规则

- 对每个平台分别生成独立 Prompt，禁止简单互译或复制外壳。
- 每条 Prompt 必须覆盖：主体、风格、材质、光照、配色、构图、WILD文字、边框、背景、负向限制、技术约束。
- 风格描写必须量化表达：写实等级、细节可读度、材质粗糙度/金属度倾向、边缘锐度、饱和度区间。
- 主体与边框关系必须写入：主体轻微超框（默认 2%-6% 视觉超越）。
- WILD 字体必须融入游戏主题元素，禁止泛用空泛字体描述。
- 若用户提供竞品信息，拆分"可借鉴点"和"避免点"分别写入 Prompt。
- 详细规范与强制写入项见 `references/prompt-spec.md`。

## 输出规则

- **每个平台单独输出一个文件**，文件内只包含 Prompt 内容，不含需求摘要、自检报告等额外信息。
- 各平台输出语言与格式：

| 平台 | 输出内容 | 文件格式 |
|------|---------|---------|
| **Midjourney** | 仅英文 Prompt | `.md` |
| **Nano Banana 2** | 中英文双语 Prompt | `.json` |
| **即梦** | 仅中文 Prompt | `.md` |
| **其他平台** | 按平台偏好语言 | `.md` |

- 归档路径：`../../outputs/prompts/`
- 详细模板与命名规则见 `references/output-format.md`。

## 参考文件装载策略

- 首先读取 `references/questionnaire.md`。
- 弹窗前读取 `references/popup-protocol.md`。
- 第一阶段完成后读取 `references/search-strategy.md`。
- 平台确认后读取 `references/ai-models/` 对应文件。
- 生成 Prompt 前读取 `references/prompt-spec.md` 和 `references/wild-art-spec.md`。
- 自检时读取 `references/self-check-spec.md`。
- 输出文档前读取 `references/output-format.md`。
