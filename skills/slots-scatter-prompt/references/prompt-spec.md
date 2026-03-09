# Prompt 生成规范

供 SKILL.md 第 8 步调用。定义多平台差异化 SCATTER Prompt 的生成规则。

---

## 核心原则

- 对每个平台/模型**分别生成独立 Prompt**，禁止简单互译或复制外壳。
- **每个平台只输出该平台所需的语言版本**。

---

## 平台专项约束与输出语言

| 平台 | 输出语言 | 文件格式 | 约束 |
|------|---------|---------|------|
| **Midjourney** | 仅英文 | `.md` | 建议精炼在 60-80 词 |
| **Nano Banana** | 中英文双版 | `.md` | 结构化JSON片段，无硬字数限制 |
| **即梦** | 仅中文 | `.md` | 总字数**不超过 800 字**；超出时按优先级删减 |
| **其他平台** | 按平台偏好 | `.md` | 参考 `ai-models/` 对应模型规范文件 |

---

## 内容覆盖清单

每条 Prompt **必须**覆盖以下全部维度：

| 维度 | 说明 |
|------|------|
| 主体 | 主体物描述、形态、占比 |
| 风格 | 绘画风格、写实等级 |
| 材质 | 材质类型（宝石折射/人物皮肤等） |
| 光照 | 光照风格、内外发光处理 |
| 配色 | 主色调、与WILD的色相差体现 |
| 构图 | 视角、主体位置、层次关系 |
| SCATTER 文字 | **若有文字**：文字内容/颜色/字体/立体感/超框；**若无文字**：明确写入不含文字标签 |
| 边框 | 样式、形状、宽度 |
| 背景 | 框内背景处理、画布背景色 |
| 负向限制 | 明确排除的元素 |
| 技术约束 | 分辨率、比例、参数 |

---

## 美术规范强制写入项

以下内容**必须**写入每条 Prompt：

| 规范项 | Prompt 写入要求（EN / CN） |
|-------|--------------------------|
| 视觉层级 | most visually striking symbol in the set, high visual weight / 套图中视觉冲击力最强的图标 |
| 主体占比 65-85% | subject occupies 65-85% of canvas / 主体占比65-85% |
| 主体超框（有时） | 按Q_M1主体类型：人物写3-8%超框；宝石写0-5%棱角超框；无超框则不写 |
| 边框单线细窄 2-4% | thin single-line frame, 2-4% canvas width / 纤细单线边框，画布宽度2-4% |
| 边框形状 | 按用户 Q26_S 答案写入形状 |
| 框内背景 | dark atmospheric background inside frame, strong contrast / 边框内暗色氛围背景，强明暗对比 |
| 与WILD色相差 | distinct color from WILD symbol, hue difference ≥30° / 与WILD图标主色色相差≥30° |
| 外发光 | outer glow equal to or stronger than WILD / 外发光强度不低于同套WILD图标 |
| 宝石类折射 | （仅器物/宝物且Q_FX1≠无特殊折射时）multiple light reflection points, faceted crystal refraction / 多点切割面折射，内外光芒并发 |
| SCATTER 文字（有时） | 按Q_S1选择：有文字→写入文字内容+颜色+3D浮雕+位置+超框；无文字→"no text label, pure symbol design" |
| SCATTER 文字颜色 | 按 Q21_S：gold / silver / purple energy color（不再默认金色） |
| 文字超框（有文字时） | text overflows frame 10-25% downward, 2-5% wider / 文字向下超框10-25%，宽度略超2-5% |
| 画布背景色 | 按 brief 中的 Q7 答案写入 |
| 核心色 ≤ 3 种 | max 3 core colors / 最多3种核心色 |
| 主色饱和度 ≥ 65% | saturation ≥65% / 饱和度≥65% |

---

## SCATTER 主体特化描述策略

### 器物/宝物类（最常见）

```
宝石/水晶类 Prompt 重点：
  EN: faceted [gem type], multiple light reflection points on facets, inner glow,
      high-gloss crystal surface, refracted light sparkles, no skin texture
  CN: 多面切割[宝石类型]，各切割面多点高光，内部晶体发光，高光泽水晶材质，折射光芒

宝箱/神器类 Prompt 重点：
  EN: ornate [artifact type], metallic surface, intricate engraving, magical glow emanating
  CN: 精致[器物类型]，金属质感，复杂铭刻，散发魔法光芒
```

### 人物/角色类

与 WILD 规范相同，但需在 Prompt 中强调"视觉层级超越WILD"：
```
EN: ...more visually dominant than the WILD symbol through stronger glow and more saturated color...
CN: ...通过更强的外发光和更高的色彩饱和度，视觉冲击力超越WILD图标...
```

---

## 文字内容融合规则

SCATTER 文字**必须**融入游戏主题元素（同 WILD 规范）：
- 融入主题纹样（如：古埃及象形纹、北欧符文刻痕）
- 融入铭刻符号（如：宝石镶嵌、能量裂纹）
- 融入材质语言（如：魔法光晕字、水晶折射字）

---

## 竞品信息融合

若联网搜索获得 SCATTER 竞品分析：
- 拆分"可借鉴点"和"避免点"
- 分别写入 Prompt 的正向描述和负向限制
