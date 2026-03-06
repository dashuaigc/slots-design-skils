# slots-design-skils

面向 Cluade 的slots游戏设计技能仓库，当前收录了用于生成 `WILD` 图标 Prompt 和调用 Nano Banana 生图的两套 workflow。这个仓库不是独立应用，而是放进 `.Cluade` 后直接调用的 skill 集合。

## 包含的 Skills

| Skill | 作用 | 适用场景 | 主要输出 |
|---|---|---|---|
| `slots-wild-prompt` | 通过分阶段问卷、竞品搜索和模型规范约束，生成可直接投喂 Midjourney、Nano Banana、即梦等平台的 WILD 图标 Prompt | 需要为slots游戏设计 `WILD` 图标、整理美术约束、生成多平台 Prompt | `outputs/briefs/` 设计汇总、`outputs/prompts/` Prompt 文件 |
| `nano-banana-generation` | 调用 Nano Banana 2 API，根据已有 Prompt 文件或手动输入内容生成图片，并自动轮询下载结果 | 已经有 Prompt，想直接出图验证视觉方向 | `outputs/images/` 图片文件 |

## 适合谁

- 想把slots游戏图标设计流程沉淀为可复用 skill 的 Cluade 用户
- 想快速批量产出 `WILD` 图标 Prompt 的美术 / 产品 / 设计人员
- 想把 Prompt 生成和生图验证串成闭环的人

## 推荐目录结构

建议把仓库内容放在项目的 `.cluade/` 下，并和输出目录并排放置：

```text
.cluade/
  skills/
    slots-wild-prompt/
    nano-banana-generation/
    README.md
  outputs/
    briefs/
    prompts/
    images/
```

这样两个 skill 中使用的相对路径可以直接工作。

## 快速开始

### 1. 放置 skill 目录

将仓库 clone 到你的 .cluade 目录：

```bash
git clone https://github.com/dashuaigc/slots-design-skils.git
```

然后把仓库内容放到你的 `.cluade/` 下。

### 2. 准备输出目录

确认以下目录存在：

```text
.cluade/outputs/briefs
.cluade/outputs/prompts
.cluade/outputs/images
```

### 3. 配置 Nano Banana API Key

如果你要使用 `nano-banana-generation`，需要先在 `nano-banana-generation/references/api-config.md` 中配置本地 API Key。不要把真实密钥提交到公开仓库。

### 4. 在 cluade 中直接调用

示例 1：生成 WILD 图标 Prompt

```text
使用 slots-wild-prompt，帮我为埃及主题 slot 游戏生成一个写实 3D 的 WILD 图标 Prompt，目标平台是 Midjourney 和 Nano Banana。
```

示例 2：根据已有 Prompt 生图

```text
使用 nano-banana-generation，从 outputs/prompts/ 里现有的 nb2 Prompt 文件生成图片。
```

## 典型工作流

### Workflow A: 从需求到 Prompt

1. 调用 `slots-wild-prompt`
2. 按弹窗问卷完成主题、风格、构图、材质、文字样式等信息收集
3. 等待 skill 执行竞品搜索、模型规范匹配和 Prompt 生成
4. 在 `outputs/briefs/` 和 `outputs/prompts/` 查看结果

### Workflow B: 从 Prompt 到出图

1. 准备好 Nano Banana 可用的 Prompt
2. 调用 `nano-banana-generation`
3. 选择从已有 Prompt 文件读取，或手动输入 Prompt
4. 等待任务轮询完成后，在 `outputs/images/` 查看图片

### Workflow C: 闭环迭代

1. 先用 `slots-wild-prompt` 产出多平台 Prompt
2. 再用 `nano-banana-generation` 快速验证 Nano Banana 方向
3. 不满意时回到 Prompt 继续修订，再次生图

## 仓库结构

```text
slots-design-skils/
  docs/
    plans/
  nano-banana-generation/
    SKILL.md
    references/
  slots-wild-prompt/
    SKILL.md
    references/
  README.md
```

## 使用说明

- `slots-wild-prompt` 是“先问卷、再搜索、再生成”的流程型 skill，适合需求还没有被结构化的时候使用。
- `nano-banana-generation` 是“直接执行生图”的工具型 skill，适合已经有 Prompt、只差出图验证的时候使用。
- 两个 skill 都依赖 cluade 的交互式 skill 机制，不是双击即用的桌面工具。
- `slots-wild-prompt` 涉及联网搜索竞品与模型能力，使用时需要具备网络访问能力。
- 建议把输出目录留在本地项目中，不要把大量中间产物和图片默认提交进技能仓库。

## 说明

如果你想扩展新的slots游戏设计能力，可以按当前结构继续新增 skill 文件夹，并保持每个 skill 至少包含：

- `SKILL.md`
- `references/`
- 清晰的输入、输出和路径约定

当前仓库更适合作为个人或团队内部的 cluade 技能库基础模板，再按自己的设计流程继续扩展。
