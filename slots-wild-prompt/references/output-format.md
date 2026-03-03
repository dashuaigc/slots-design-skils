# 输出归档格式规范

供 SKILL.md 第 10 步调用。定义存档路径、命名规则、各平台文件内容格式。

---

## 存档路径

```
../../outputs/prompts/
```

自检循环完成后**自动存档**，无需用户确认。

---

## 核心原则：纯 Prompt 输出

- **每个平台单独一个文件**。
- 文件内**只包含 Prompt 内容**，不含需求摘要、自检报告、设计说明等额外信息。
- 用户拿到文件后可直接复制粘贴到对应平台使用。

---

## 各平台输出格式

### Midjourney — 仅英文 `.md`

文件内容**只有**英文 Prompt，可直接粘贴到 Discord/Midjourney。

```markdown
[英文 Prompt 内容，含 --ar --v 等参数]
```

**示例文件名：** `midjourney_caishen_toon3d_20260303_001.md`

---

### Nano Banana 2 — 中英文 JSON `.json`

文件内容为 JSON 格式，包含英文和中文两个版本。

```json
{
  "platform": "Nano Banana 2",
  "model": "[模型版本]",
  "prompt_en": "[英文 Prompt 内容]",
  "prompt_cn": "[中文 Prompt 内容]"
}
```

**示例文件名：** `nb2_caishen_toon3d_20260303_001.json`

---

### 即梦 — 仅中文 `.md`

文件内容**只有**中文 Prompt（不超过 800 字），可直接粘贴到即梦平台。

```markdown
[中文 Prompt 内容]
```

**示例文件名：** `jimeng_caishen_toon3d_20260303_001.md`

---

### 其他平台 — 按平台偏好 `.md`

文件内容为该平台最优输入语言的 Prompt。

**示例文件名：** `[平台缩写]_[主题]_[风格]_[日期]_[序号].md`

---

## 文件命名规则

```
格式：[平台缩写]_[主题关键词]_[风格代码]_[YYYYMMDD]_[NNN].[ext]
```

### 平台缩写

| 平台 | 缩写 |
|------|------|
| Midjourney | `midjourney` |
| Nano Banana 2 | `nb2` |
| 即梦 | `jimeng` |
| Stable Diffusion | `sd` |
| Flux | `flux` |
| DALL-E | `dalle` |

### 主题关键词

从游戏主题提取，小写英文，空格用 `_` 替代，最长 20 字符。
示例：`caishen` / `tumbbad` / `olympus` / `dragon`

### 风格代码

| 代码 | 含义 |
|------|------|
| `real3d` | 写实 3D 渲染 |
| `toon3d` | 风格化/卡通 3D |
| `illustration` | 手绘厚涂插画 |
| `flat2d` | 2D 扁平插画 |
| `gothic` | 哥特暗黑水彩 |
| `concept` | 概念原画风格 |
| `ink` | 水墨/东方风格 |
| `anime` | 日系动漫插画 |
| `cyberpunk` | 赛博朋克/霓虹科幻 |
| `pixel` | 像素/复古像素艺术 |

### 日期与序号

- 日期：当天 `YYYYMMDD`
- NNN：三位数序号，从 `001` 起自动递增

### 自动递增逻辑

```
1. 读取 outputs/prompts/ 目录下所有文件名
2. 提取同前缀（[平台]_[主题]_[风格]_[日期]）的文件数量
3. 新文件序号 = 现有数量 + 1，补齐为 3 位数
4. 如目录为空或无同前缀文件，序号 = 001
```

### 命名示例

```
midjourney_caishen_toon3d_20260303_001.md
nb2_caishen_toon3d_20260303_001.json
jimeng_caishen_toon3d_20260303_001.md
```

---

## 汇总确认弹窗

存档前需执行一次汇总确认：

```
AskUserQuestion：
  question: "以上设计需求汇总已生成，请确认是否有需要补充或修改的信息？"
  multiSelect: true
  options:
    - 确认无误，继续生成 Prompt
    - 需要修改[某项]（请在"其他"中说明）
    - 需要补充[某项]（请在"其他"中说明）
```

如用户需修改或补充，允许**单次补正**后再次确认。

---

## 收尾询问

存档完成后告知用户每个文件的完整路径，然后弹窗：

```
AskUserQuestion：
  question: "设计方案已完成并已存档，你希望接下来做什么？"
  multiSelect: true
  options:
    - 生成不同视角/光照/材质的变体 Prompt
    - 为配套符号（SCATTER/高价值图标）生成风格一致 Prompt
    - 拿到生图结果后进行二次图像自检
```
