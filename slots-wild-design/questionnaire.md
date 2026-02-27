# WILD 图标设计问卷定义
# 供 SKILL.md 调用，分7批通过 AskUserQuestion 工具交互呈现

## 问卷执行规则
- 共 7 批，每批调用一次 AskUserQuestion 工具（最多4题/批）
- 每批等待用户完整回答后才进入下一批
- Batch 7 为特殊流程（分步执行），见 §7 说明
- 用户选择"其他"时，等待其补充文字描述

---

## Batch 1｜创意方向（4题）
*明确游戏世界观与目标受众*

### Q1.1 游戏主题类型
header: 游戏主题
multiSelect: true
options:
  - 神话史诗（古埃及 / 希腊 / 北欧 / 美索不达米亚）
  - 东方幻想（中国 / 日本 / 印度 / 东南亚神话）
  - 黑暗灵异（恐怖 / 克苏鲁 / 暗黑奇幻 / 亡灵）
  - 财富喜庆（招财 / 节日 / 宝藏 / 赌场经典）

### Q1.2 世界观氛围
header: 世界观氛围
multiSelect: false
options:
  - 史诗宏大（壮阔、神圣、令人仰望）
  - 神秘压抑（未知、压迫、令人不安）
  - 黑暗恐怖（腐朽、血腥、诅咒感）
  - 华丽奢靡（奢华、闪耀、令人垂涎）

### Q1.3 情绪基调
header: 情绪基调
multiSelect: true
options:
  - 震撼 / 敬畏（面对强大力量）
  - 神秘 / 压迫（未知与危险）
  - 兴奋 / 期待（即将爆发的能量）
  - 华丽 / 奢靡（财富与尊贵感）

### Q1.4 目标玩家群体
header: 目标玩家
multiSelect: false
options:
  - 休闲玩家（移动端为主，图标应简洁易读）
  - 核心玩家（有经验，可接受丰富视觉）
  - 高端深度玩家（注重美术质量与细节）
  - 均衡设计（兼顾以上）

---

## Batch 2｜WILD 主体设定（4题）
*明确 WILD 图标的核心主体物*

### Q2.1 主体物类别
header: 主体物类别
multiSelect: false
options:
  - 神明 / 神像 / 祭祀物（宗教/神话造物）
  - 宝石 / 水晶 / 宝物（财富类象征物）
  - 生物 / 怪兽 / 神兽（动物或奇幻生物）
  - 武器 / 道具 / 器物（剑、权杖、圣杯等）

### Q2.2 主体物形态
header: 主体形态
multiSelect: false
options:
  - 单一主体居中（宝石、神像、符文石等）
  - 垂直构图（人物、权杖、建筑柱体等）
  - 对称有机形（展翅生物、神明、植物）
  - 放射 / 爆炸构图（光芒、魔法爆发等）

### Q2.3 主体物象征意义
header: 象征意义
multiSelect: false
options:
  - 最高权威（守护神、力量源泉、无上权力）
  - 诅咒 / 禁忌（危险之物、代价与贪欲）
  - 财富象征（金钱、丰收、好运的化身）
  - 神秘力量（魔法、未知能量、秘密钥匙）

### Q2.4 灵感来源
header: 灵感来源
multiSelect: false
options:
  - 特定电影 / 文学作品（请在"其他"中说明作品名）
  - 真实神话 / 历史原型（请在"其他"中说明）
  - 游戏世界观原创（无现实对应，纯创作）
  - 竞品游戏参考（请在"其他"中说明游戏名）

---

## Batch 3｜游戏架构（4题）
*了解 WILD 在游戏系统中的技术上下文*

### Q3.1 卷轴布局
header: 卷轴布局
multiSelect: false
options:
  - 3×3（经典布局）
  - 5×3（主流布局，最常见）
  - 5×4 / 6×4（现代宽格局）
  - 其他（请在"其他"中描述）

### Q3.2 符号格形状与比例
header: 符号格形状
multiSelect: false
options:
  - 正方形（1:1，最通用）
  - 竖向长方形（如 2:3，移动竖屏）
  - 横向长方形（如 3:2）
  - 其他（圆形、六边形等，请描述）

### Q3.3 WILD 的符号层级
header: WILD层级
multiSelect: false
options:
  - 最高层级（游戏无独立 Jackpot 图标，WILD 即顶级）
  - 次高层级（有独立 Jackpot / Grand Prize，WILD 低一级）
  - 功能型（特殊机制 WILD，视觉不需要最突出）
  - 不确定（按最高层级设计）

### Q3.4 目标市场与监管
header: 目标市场
multiSelect: true
options:
  - 印度（India，注意文化敏感性与宗教符号）
  - 欧洲通用（MGA 马耳他，限制适中）
  - 亚洲市场（中国 / 东南亚 / 日本，文化敏感度不同）
  - 全球通用（无特定监管限制）

---

## Batch 4｜绘画风格与基础材质（4题）

### Q4.1a 绘画风格（主流商业组）
header: 主流风格
multiSelect: false
options:
  - 写实3D渲染（PBR材质/体积光/真实光照，参考：Gonzo's Quest、Blood Suckers、Deadwood xNudge、Tombstone RIP）
  - 风格化3D / 卡通3D（圆润夸张/鲜艳高光/卡通比例，参考：Gates of Olympus、Big Bass、Sugar Rush、Pragmatic Play系列）
  - 手绘厚涂插画（油画笔触/高对比阴影/手工质感，参考：Nolimit City、ELK Studios、Yggdrasil系列）
  - 2D扁平插画（简洁色块/现代感/矢量质感，参考：Hacksaw Gaming、NetEnt新系列）
  - 哥特暗黑水彩/素描（手绘恐怖水彩/铅笔素描质感，参考：Dead's Story、Spirit of Dead、Relax Gaming暗黑系列）
  - 概念原画风格（电影概念艺术/写实与风格化中间，参考：Big Time Gaming、Just For The Win）
  - 水墨 / 东方风格（中国水墨笔意/留白意境，参考：东方主题老虎机、福禄寿系列）
  - 日系动漫插画（日系线稿/赛璐璐渲染，参考：Niji系列、日系Pachislot主题）

> 注：赛博朋克/霓虹科幻 或 像素/复古像素艺术 可通过上方任一问题的"其他"选项描述。

### Q4.2 主材质类型
header: 主材质
multiSelect: false
options:
  - 金属类（黄金 / 古铜 / 锈铁 / 镀铬）
  - 有机类（骨骼 / 木材 / 面团泥土 / 皮革）
  - 宝石 / 水晶类（钻石 / 翡翠 / 琥珀 / 水晶）
  - 能量类（火焰 / 冰晶 / 魔法光 / 等离子）

### Q4.3 光照风格
header: 光照风格
multiSelect: false
options:
  - 戏剧性单侧打光（强对比，电影感，暗黑/奇幻首选）
  - 顶光 + 底部反光（游戏图标经典光位，立体感充分）
  - 内发光为主（图标从内部发光，魔法/科幻感）
  - 柔和环境光（均匀漫射，2D 插画风格适用）

---

## Batch 5｜色彩与 WILD 文字（4题）
*确定色调方向及 WILD 文字的视觉设计*

### Q5.1 主色调偏向
header: 色调方向
multiSelect: false
options:
  - 暗色系（黑棕 / 深紫 / 墨绿，暗黑恐怖风格）
  - 亮色系（金红 / 蓝白 / 彩虹，奇幻财富风格）
  - 单一主色主导（请在"其他"中填写偏好颜色或描述）
  - 由AI根据主题自由决定（不做限制）

### Q5.2 "WILD"文字处理与位置
header: WILD文字位置
multiSelect: false
options:
  - 底部·金属浮雕铭文（图标下部1/4区，文字略超出边框下缘，立体金属感）
  - 底部·悬浮光能字（底部飘浮发光文字，超出边框下缘，魔法感）
  - 底部·刻入主体（底部压印融入主体材质，有机一体感）
  - 不含文字（纯图形，"WILD"标识由游戏UI层单独叠加）

### Q5.3 "WILD"字体风格
header: WILD字体风格
multiSelect: false
options:
  - 石刻铭文体（厚重衬线雕刻感，古典庄重，适合神话/历史主题）
  - 哥特暗黑装饰字（尖锐哥特花饰，锋利暗黑气息，适合恐怖/魔幻主题）
  - 魔法符文能量字（发光轮廓/流动笔触/解构感，适合魔法/科幻主题）
  - 圆润粗体手绘字（活泼饱满，适合财富/休闲/喜庆主题）

### Q5.4 "WILD"字体衬线与笔画风格
header: 衬线风格
multiSelect: false
options:
  - 重衬线 / 粗端点（Heavy slab serifs，厚重端点，庄重史诗感）
  - 细尖衬线 / 棘刺感（Sharp pointed serifs，锋利刺状，哥特暗黑感）
  - 无衬线 / 几何笔画（Sans or geometric strokes，现代干净，科技感）
  - 装饰性花体衬线（Ornamental serifs，末端有花饰卷曲，复古华丽感）

---

## Batch 6｜边框与视觉细节（4题）
*图标框架与 WILD 文字关联装饰*

### Q6.1 "WILD"文字关联装饰元素
header: 文字关联装饰
multiSelect: false
options:
  - 无额外装饰（文字独立呈现，仅字形本身）
  - 宝石 / 星光 / 金粒点缀（文字周边散布小宝石/光粒/金尘）
  - 卷草 / 藤蔓 / 羽翼缠绕（有机装饰环绕文字）
  - 符文 / 图腾 / 徽章（神秘纹样或盾章背景环绕文字）

### Q6.2 装饰性边框
header: 边框设计
multiSelect: false
options:
  - 细金属单线框（纤细单线金属边，简约精致，不遮盖主体）
  - 宝石点缀单线细框（极细单线框四角/四边点缀小宝石，轻盈装饰感）
  - 发光单线框（纤细单线发光轮廓，渐变色或单色光，魔法/科技感）
  - 无边框（主体外发光与描边作为视觉边界，完全无框架）

### Q6.3 边框形状
header: 边框形状
multiSelect: false
options:
  - 矩形（标准直角方形框，最通用，适合大多数主题）
  - 圆角矩形（圆角修饰直角框，视觉柔和，现代游戏常见）
  - 圆形（圆形轮廓框，聚焦感强，适合宝石/魔法主体）
  - 椭圆形（竖向椭圆框，适合垂直构图与人物/神像主体）

### Q6.4 视觉复杂度
header: 视觉复杂度
multiSelect: false
options:
  - 偏向简洁（移动端优先，小尺寸清晰，细节适度）
  - 均衡（512px 下细节与可读性平衡，兼顾桌面/移动）
  - 偏向精细（桌面端/展示用途，细节丰富，高清欣赏）
  - 极简（扁平/像素风格，色块明确）

---

## Batch 7｜规格与 AI 生图（特殊分步执行）
*⚠️ 本批次不可一次性弹出全部问题，必须按 Step A → B → C → D 顺序执行（详见 SKILL.md §1.2）*

---

### Step A｜Q7.4 AI 生图平台（单独弹窗，第一个询问）
*先问平台，再根据选择动态搜索模型*

### Q7.4 AI 生图平台
header: 生图平台
multiSelect: true
⚡ 执行顺序：**必须最先单独弹出，用户回答后立即触发 Step B WebSearch**
options:
  - Midjourney
  - 即梦（Jimeng / 字节跳动）
  - Nano Banana 2（Gemini 图像生成）
  - 其他（Stable Diffusion / Flux / DALL-E / Firefly / Leonardo 等，请在"其他"填写）

---

### Step B｜WebSearch（Q7.4 回答后立即执行，无需弹窗）
*自动并行搜索，每个平台至少找到3个可用模型版本，展示分析文字，不弹窗*

---

### Step C｜模型选择弹窗（WebSearch 完成后立即弹出）
*每个平台一道题，选项来自 Step B 搜索结果，合并进一次 AskUserQuestion*
*每平台至少列出3个模型选项（含"始终用最新版"作为保底选项）*

---

### Step D｜其余规格问题（模型选完后合并弹出，4题）

### Q7.1a 画布比例
header: 画布比例
multiSelect: false
options:
  - 1:1 正方形（通用，最兼容，桌面/移动均适用）
  - 2:3 竖向（与主流竖版卡轴符号格比例匹配）
  - 4:5 竖向（折中比例，偏方正竖版）
  - 16:9 横向（宽格局展示/桌面端用途）

### Q7.1b 画布背景色
header: 画布背景色
multiSelect: false
options:
  - #666666 中灰色（标准评审底色，模拟游戏卷轴典型背景，推荐）
  - #999999 浅灰色（高亮环境评审，便于查看暗部细节）
  - 两种都要（分别生成两张，用于对比评审）
  - 透明背景（直接输出透明PNG，适合已有精修流程）

### Q7.2 竞品与风格参照
header: 竞品参照
multiSelect: false
options:
  - NetEnt / Play'n GO（欧洲主流写实3D/精细插画风）
  - Nolimit City / Relax Gaming（暗黑高端写实插画风）
  - Pragmatic Play / ELK Studios（风格化3D，大众化高饱和）
  - 其他（请在"其他"中指定具体游戏/工作室名称，或填"无参考"）

### Q7.3 图标特殊限制与避免元素
header: 内容限制
multiSelect: true
options:
  - 宗教/政治敏感符号（针对监管市场合规）
  - 过度血腥/暴力内容（维持平台年龄分级）
  - 特定文化禁忌（目标市场的文化敏感元素）
  - 暂无特殊限制（按主题正常设计）
