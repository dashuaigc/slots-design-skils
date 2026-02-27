# 参考资料库 / References

此文件夹用于存放老虎机图标设计的参考资料和案例素材，供 `slots-wild-design` 技能生成 Prompt 时参考。

---

## 文件夹结构

```
references/
├── wild-icons/          ← 优秀 WILD 图标截图/样例（直接截图放入即可）
├── competitor-games/    ← 竞品游戏截图与分析（按游戏名命名子文件夹）
├── style-guides/        ← 风格指南、美术规范 PDF / 参考图
└── prompt-examples/     ← 实测效果好的 Prompt 记录（按平台分类）
```

---

## 使用方法

### wild-icons/
放入你收集的优质 WILD 图标图片。命名建议：
```
[游戏名]_[工作室]_wild.png
例：deadwood_nolimit_wild.png
    gates_of_olympus_pragmatic_wild.png
```

### competitor-games/
按游戏/工作室名建子文件夹，放入截图：
```
competitor-games/
├── Nolimit-City/
├── Pragmatic-Play/
└── ELK-Studios/
```

### style-guides/
存放美术风格参考文档，例如：
- 工作室官方美术指南 PDF
- 风格拆解分析笔记（Markdown）
- 配色板截图

### prompt-examples/
记录实测效果好的 Prompt，按平台分类：
```
prompt-examples/
├── midjourney/
├── jimeng/
└── nano-banana2/
```

文件命名建议：`[主题]_[风格]_[模型版本]_[评分].md`
例：`tumbbad_horror3d_mjv7_4.5star.md`

---

## 提示

- 向 Claude 发送设计请求时，可以将此文件夹的图片路径告知 Claude，让其作为参考
- 文件无大小限制，按项目分组即可
- 定期清理不再参考的素材
