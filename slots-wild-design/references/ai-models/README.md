# AI 模型规范文件说明

本目录存放各 AI 生图平台的模型能力与 Prompt 规范文档，供技能第二阶段读取使用。

---

## 文件命名规则

```
[平台英文名]-models.md
```

示例：
- `midjourney-models.md` — Midjourney 模型规范
- `jimeng-models.md` — 即梦模型规范
- `gemini-models.md` — Nano Banana 2 (Gemini) 模型规范
- `stable-diffusion-models.md` — Stable Diffusion 模型规范
- `flux-models.md` — Flux 模型规范

---

## 文档内容结构

每个模型规范文档应包含以下部分：

```markdown
# [平台名] 模型规范文档

## [模型名]

### 基本信息
- 发布日期
- 当前状态（最新/稳定/旧版）

### Prompt 能力
- 语言偏好（中文/英文/双语）
- 结构方式（关键词/自然语言/结构化段落）
- 最大长度（词数/字数限制）
- 支持参数

### 美术风格
- 擅长风格
- 不擅长
- 质量特点

### Prompt 构建技巧
- 有效技巧1
- 有效技巧2
- 常见误区

---

## 模型对比速查表
| 模型 | 语言风格 | 输出分辨率 | 核心特性 | 推荐场景 |
|-------|---------|-----------|----------|---------|

---

## 常用关键词库
```

---

## 已完成的模型文档

| 文件名 | 平台 | 状态 |
|-------|------|------|
| `midjourney-models.md` | Midjourney | ✅ 完成 |
| `jimeng-models.md` | 即梦 | ✅ 完成 |
| `gemini-models.md` | Nano Banana 2 (Gemini) | ✅ 完成 |

---

## 待补充的平台

以下平台暂无规范文档，技能执行时如选中会基于 WebSearch 结果自动生成临时文档：

- Stable Diffusion
- Flux
- DALL-E
- Firefly
- Leonardo

---

## 维护建议

1. **定期更新**：每季度检查各平台是否有新模型发布
2. **技巧收集**：根据实际使用反馈，更新"Prompt 构建技巧"部分
3. **关键词库扩展**：根据常用需求，扩展"常用关键词库"内容
