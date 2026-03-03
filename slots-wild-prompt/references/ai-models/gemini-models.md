# Nano Banana 2（Gemini Image Generation）模型规范文档

## Nano Banana 2

### 基本信息
- 发布日期：2026年2月26日
- 技术名称：Gemini 3.1 Flash Image
- 当前状态：最新版本（Latest）

### Prompt 能力
- 语言偏好：英文或中文均可（结构化规格段落）
- 结构方式：**结构化分段格式**，每段明确标注维度
- 最大长度：无硬性字数限制，按需求可扩展
- 支持参数：通过结构化描述控制，无专用参数

### 美术风格
- 擅长风格：写实3D、卡通3D、插画、材质渲染、文字渲染
- 不擅长：像素艺术（需特殊描述）
- 质量特点：
  - 分辨率：512px 到 4K 可选
  - 角色一致性：最多5个角色保持一致
  - 物体精度：最多14个物体精确渲染
  - 文字渲染：精准可读
  - 真实世界知识：联网实时信息

### Prompt 结构规范

**标准结构模板：**

```
**Subject:** [主体描述，精确详细]

**Style:** [风格描述，包含：渲染方式/几何形体/视觉语言参考]

**Character/Object Design:**
- [属性1]
- [属性2]
- [属性3]
...

**Materials:** [材质描述，具体细节]

**Lighting:** [光照描述，具体参数]

**Composition:** [构图描述，占比、位置、边框]

**Frame/Background:** [边框与背景描述]

**Text:** [WILD文字描述]

**Canvas:** [画布描述]

**Color Palette:** [色彩描述，色相数量/饱和度]

**Avoid:** [负向排除，明确列出]
```

### Prompt 构建技巧

**有效技巧：**
1. 结构化分段：每段用 `**标题:**` 开头，清晰区分维度
2. 详细优先：Nano Banana 2 理解复杂描述，可写详细规格
3. 联网知识：可利用真实世界知识描述特定材质/文化元素
4. 文字渲染强：可精确描述文字字体、材质、发光效果

**常见误区：**
1. 纯自然语言：未分段时效果不如结构化格式
2. 缺少维度标注：重要维度如主体、材质、光照需明确
3. 忽略文字渲染：文字渲染是Nano Banana 2强项，需充分描述

### 特殊能力

**角色一致性：**
- 最多保持5个角色一致
- 适合：多角色构图、家族角色设计

**物体精度：**
- 最多精确渲染14个物体
- 适合：复杂场景、多道具构图

**文字渲染：**
- 支持精准文字渲染
- 适合：带文字的图标、文字排版设计

**真实世界知识：**
- 联网实时搜索
- 适合：历史人物、真实材质、文化元素

---

## Nano Banana Pro

### 基本信息
- 发布日期：2025年11月
- 当前状态：稳定高质量版本

### Prompt 能力
- 语言偏好：英文（结构化段落）
- 结构方式：分段结构描述
- 无硬字数限制

### 美术风格
- 擅长风格：高质量渲染、材质细节、光影真实
- 质量特点：比原始版本质量更高，细节更丰富

### 注意
- 已被Nano Banana 2替代，仅作稳定性参考

---

## Nano Banana 1 / 原始版

### 基本信息
- 发布日期：2025年8月
- 当前状态：原始版本

### 注意
- 已被后续版本替代，仅作基础功能参考

---

## 模型对比速查表

| 模型 | 语言风格 | 输出分辨率 | 核心特性 | 推荐场景 |
|-------|---------|-----------|----------|---------|
| **Nano Banana 2** | 结构化英中 | 512px-4K | 文字渲染强、角色一致性、联网知识 | 最新版，全场景适用 ⭐ |
| **Nano Banana Pro** | 结构化英文 | 高质量 | 高质量材质渲染 | 需要更高质量的场景 |
| **Nano Banana 1** | 结构化英文 | 标准 | 基础功能 | 旧版参考 |

---

## Nano Banana 2 常用英文关键词库

```
【结构化标题】
**Subject:**              主体
**Style:**                风格
**Character Design:**       角色设计
**Materials:**            材质
**Lighting:**             光照
**Composition:**           构图
**Frame:**               边框
**Background:**           背景
**Text:**                文字
**Canvas:**              画布
**Color Palette:**        色彩
**Avoid:**               排除

【风格】
stylized cartoon 3D     风格化卡通3D
rounded forms           圆润造型
exaggerated proportions  夸张比例
bright metallic highlights 明亮金属高光

【材质】
embossed texture         浮雕纹理
polished gold          抛光金
antique copper         古铜
gemstone accents       宝石点缀

【光照】
overhead key light      顶光主光源
golden ambient bounce   金色环境反射光
specular hotspots     镜面高光点
warm tonality          暖色调性

【构图】
bilateral symmetry       双边对称
occupies 80-90%       占用80-90%
protrudes 4%          突出4%
5% safe margin         5%安全边距

【边框】
thin single-line        纤细单线
2-4% of canvas       2-4%画布宽度
rounded rectangle      圆角矩形

【文字】
3D embossed relief     3D浮雕立体感
ornamental curling serifs 装饰性花体卷曲衬线
primary gold-toned      主色金色
luminous warm halo       发光暖光晕

【负向】
double-line frames      双线边框
heavy stone borders     厚重石框
white backgrounds      白色背景
desaturated palette     低饱和度配色
three-quarter angle     四分之三视角
subject touching edges   主体接触边缘
```
