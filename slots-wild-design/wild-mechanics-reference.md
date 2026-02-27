# WILD 机制深度参考手册

## 标准替代规则

WILD图标作为万能牌，替代规则通常为：
- 替代所有普通图标（A/K/Q/J/10/9）
- 替代所有高价值图标（游戏主题图标）
- **不替代** SCATTER（分散图标）
- **不替代** BONUS（奖励图标）
- **不替代** 其他特殊功能图标

## WILD 赔付规则变体

### 变体A：最高赔付
当WILD参与连线时，计算所有可能的替代组合，取赔付最高的结果。

### 变体B：WILD自身有赔付
WILD本身也有赔率表，可以独立连线获得赔付。

### 变体C：仅作替代无自身赔付
WILD只能替代其他图标，自身不形成赔付组合。

---

## 各类WILD机制详解

### 扩展WILD（Expanding Wild）

**触发条件：**
- 条件A：任意WILD落入触发列时自动扩展
- 条件B：WILD参与赢线时才触发扩展
- 条件C：特定列（如第3列）出现时扩展

**扩展方向：**
- 纵向扩展：填满整列（最常见）
- 横向扩展：填满整行（较少见）
- 全屏扩展：填满所有格子（特殊大奖模式）

**动画时序：**
```
T+0ms:   WILD正常落入
T+200ms: 震动/冲击波效果
T+400ms: 开始向上下扩展
T+800ms: 扩展完成，全列高亮
T+1000ms: 开始计算赢线
```

---

### 粘性WILD（Sticky Wild）

**常见应用场景：**
- 免费游戏中：每次触发WILD都固定在原位，累积叠加
- 特殊回合中：初始放置若干粘性WILD
- Re-spin机制：有WILD的位置锁定，其余卷轴重新旋转

**状态管理数据结构：**
```javascript
class StickyWildManager {
  constructor() {
    this.stickyPositions = new Set(); // Set of "col_row" strings
    this.remainingSpins = {};         // position -> remaining spins
  }

  addSticky(col, row, duration = -1) {
    const key = `${col}_${row}`;
    this.stickyPositions.add(key);
    this.remainingSpins[key] = duration; // -1 = permanent
  }

  decrementAndClean() {
    for (const [key, spins] of Object.entries(this.remainingSpins)) {
      if (spins > 0) {
        this.remainingSpins[key]--;
        if (this.remainingSpins[key] === 0) {
          this.stickyPositions.delete(key);
          delete this.remainingSpins[key];
        }
      }
    }
  }
}
```

---

### 倍数WILD（Multiplier Wild）

**倍率叠加规则：**

| 叠加模式 | 说明 | 示例 |
|---------|------|------|
| 相加 | 倍率相加 | 2x + 3x = 5x |
| 相乘 | 倍率相乘 | 2x × 3x = 6x |
| 取最高 | 只取最大倍率 | max(2x, 3x) = 3x |

**倍率显示规范：**
- 位置：图标右上角或正中心
- 字体：粗体，清晰可读
- 颜色：金色为主，对比度高
- 动画：数字弹出 + 金币/钻石粒子爆发

**常见倍率配置：**
```
低频高倍：5x(5%), 4x(10%), 3x(20%), 2x(65%)
均衡分布：5x(10%), 3x(30%), 2x(60%)
固定倍率：2x(100%)
```

---

### 漫游WILD（Roaming/Walking Wild）

**移动规则：**
- 每次旋转后向指定方向移动1格
- 到达边缘后消失或从对侧出现
- 可触发Re-spin直到WILD离开卷轴

**位置追踪：**
```javascript
class RoamingWild {
  constructor(col, row, direction = 'left') {
    this.col = col;
    this.row = row;
    this.direction = direction; // 'left' | 'right' | 'up' | 'down'
  }

  move(gridCols, gridRows) {
    switch (this.direction) {
      case 'left':  this.col = (this.col - 1 + gridCols) % gridCols; break;
      case 'right': this.col = (this.col + 1) % gridCols; break;
      case 'up':    this.row = (this.row - 1 + gridRows) % gridRows; break;
      case 'down':  this.row = (this.row + 1) % gridRows; break;
    }
    return { col: this.col, row: this.row };
  }

  isOffGrid(gridCols) {
    return this.direction === 'left' && this.col < 0;
  }
}
```

---

### 爆炸WILD（Exploding Wild）

**爆炸范围定义：**
```
十字形（Cross）：
    [ ]
  [W][X][ ]
    [ ]

菱形（Diamond）：
      [ ]
    [ ][ ][ ]
  [ ][ ][X][ ][ ]
    [ ][ ][ ]
      [ ]

方形（Square 3x3）：
  [ ][ ][ ]
  [ ][X][ ]
  [ ][ ][ ]
```

**转化类型：**
- 爆炸范围内所有格子变成WILD
- 爆炸范围内随机选择N个格子变成WILD
- 爆炸后触发Re-spin

---

## RTP影响分析

不同WILD类型对游戏RTP（返奖率）的影响幅度参考：

| WILD类型 | RTP贡献估算 | 波动性影响 |
|---------|------------|---------|
| 标准WILD | +1% ~ +3% | 低 |
| 扩展WILD | +3% ~ +8% | 中 |
| 粘性WILD（免费游戏） | +5% ~ +15% | 高 |
| 2x倍数WILD | +3% ~ +6% | 中 |
| 5x倍数WILD | +1% ~ +4% | 极高 |
| 漫游WILD+Re-spin | +4% ~ +10% | 高 |

> 注意：实际RTP需通过数学模型和蒙特卡洛模拟（1亿+轮次）精确计算。

---

## 监管合规要点

设计WILD功能时需注意各地区监管要求：

- **英国GC**：WILD替代必须向玩家清晰展示，不得隐瞒倍率叠加规则
- **马耳他MGA**：免费游戏中的粘性WILD需在帮助页面明确说明
- **瑞典Spelinspektionen**：游戏规则中必须包含WILD所有可能行为的描述
- **通用原则**：WILD动画不得误导玩家对赢得金额的预期
