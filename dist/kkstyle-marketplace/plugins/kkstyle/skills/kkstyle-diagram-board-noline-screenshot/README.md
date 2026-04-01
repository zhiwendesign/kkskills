# KKStyle Diagram Board No-Line Screenshot

`kkstyle-diagram-board-noline-screenshot` 是一个把文本内容整理成“信息图白板无描边风”海报的 skill 包。它适合把项目介绍、流程拆解、工具说明、框架总结、步骤指南这类内容，做成一张结构清晰、边界更柔和、可直接截图导出的 `3:4` 信息海报。

和普通海报模板不同，这个 skill 的核心不是“装饰感”，而是“讲清楚关系”。默认版式会优先强调：

- 大标题
- 右上角指标卡
- 一条摘要说明
- 左右双区块的主内容
- 步骤卡 / 节点卡 / 连接关系
- 固定日期贴纸
- 固定二维码 `合作交流`
- 固定 IP 位 `是卡卡呀`

## 适合什么内容

这套风格适合以下类型：

- 工具、平台、项目的结构说明
- 多步骤流程讲解
- 模块拆解和职责分工
- 方法论、框架、工作流总结
- “先看结论，再看结构”的说明型内容

不太适合的内容：

- 强情绪、强视觉冲击的宣传封面
- 偏漫画、偏杂志、偏课堂手写感的内容
- 需要大量图片主导而不是结构主导的版式

## 风格特点

`diagram-board` 的视觉语言更接近“白板讲解图”而不是“普通文章卡片”：

- 背景是浅色白板 / 网格板
- 模块用卡片和标签组织
- 结构关系通过虚线、编号、箭头感来引导
- 标题负责建立主题
- 指标卡负责建立爆点
- 摘要条负责建立阅读入口
- 左右分区负责展开内容

整体目标是让用户一眼知道：

1. 这张图在讲什么
2. 应该先看哪里
3. 后面的信息怎么继续读

## 默认版式结构

默认输出优先使用 `3:4` 比例，结构大致如下：

1. 顶部左侧是风格标签和模式标签
2. 顶部右侧是日期贴纸，格式固定为 `YYYY年MM月DD日`
3. 第一屏主视觉由大标题和指标卡组成
4. 标题下方是一条摘要条，负责用一句话概括这张图的价值
5. 中间主体分成左右两个信息区
6. 左侧通常更适合步骤、流程、主线
7. 右侧通常更适合节点、补充结构、辅助说明
8. 底部是收尾能力标签、项目地址和一句话建议
9. 右下角固定是二维码和卡卡 IP

## 目录结构

```text
kkstyle-diagram-board-noline-screenshot/
├── README.md
├── SKILL.md
├── agents/
│   └── openai.yaml
├── assets/
│   ├── diagram-board-card-template.html
│   ├── contact-code.png
│   └── kk-character.jpeg
├── references/
│   ├── diagram-board-design-rules.md
│   └── layout-presets.md
└── scripts/
    ├── capture_card.sh
    └── image_to_data_uri.py
```

## 每个文件的作用

### `SKILL.md`

这是给 agent 用的主说明文件，定义了：

- skill 的触发场景
- 默认工作流
- 输出契约
- 固定品牌元素
- 失败检查项

如果你要调整 agent 的默认行为，优先改这里。

### `agents/openai.yaml`

这是 UI 元信息文件，用于显示：

- skill 名称
- 简短描述
- 默认提示词

如果你希望 skill 在技能列表里展示得更清楚，可以调整这里。

### `assets/diagram-board-card-template.html`

这是当前风格的基础 HTML 模板。它已经内置了：

- 白板背景
- 顶部标签
- 日期贴纸
- 大标题区
- 指标卡
- 摘要条
- 左右信息区
- 底部项目地址 / 一句话建议
- 右下角固定二维码和 IP

如果你要改视觉样式、边距、颜色、卡片结构，这个文件是最主要的入口。

### `references/diagram-board-design-rules.md`

这是设计规则文件，主要用于约束：

- 整体气质
- 配色体系
- 布局偏好
- 图解关系
- 日期贴纸和底部联系区的规则

如果你后面要继续扩这个风格，建议先改这份规则，再改模板。

### `references/layout-presets.md`

这里定义了不同输出比例的尺寸参考。默认主结构使用 `3:4`，但如果后面你要扩展成：

- `1:1`
- `4:3`
- `9:16`
- `16:9`

可以先参考这里。

### `scripts/capture_card.sh`

把 HTML 模板渲染成 PNG。适合本地快速出图。

### `scripts/image_to_data_uri.py`

把本地图片转成 data URI，适合把图片资源内联进 HTML，避免外部路径问题。

## 如何调用这个 skill

在支持 skill 的 agent 环境里，可以直接这样调用：

```text
Use $kkstyle-diagram-board-noline-screenshot to turn these notes into a diagram-board 3:4 explainer poster.
```

也可以更具体一点：

```text
Use $kkstyle-diagram-board-noline-screenshot to make this feel like a structured infographic whiteboard.
```

如果你只想要 HTML：

```text
Use $kkstyle-diagram-board-noline-screenshot and give me the HTML only.
```

如果你同时要 HTML 和 PNG：

```text
Use $kkstyle-diagram-board-noline-screenshot to generate both the HTML and a PNG render.
```

## 推荐输入方式

为了让这套风格表现更稳定，建议输入内容时尽量带上这些信息：

- 标题或主题
- 核心结论
- 3 到 6 个模块 / 步骤 / 节点
- 项目地址或文章来源
- 一句话建议或收尾总结
- 如果内容里有日期，尽量明确写出来

推荐输入示例：

```text
主题：OpenClaw Manager 可视化管理工具
亮点：仪表盘、消息渠道、14+ AI 提供商
结构：
1. 为什么值得看
2. 核心功能
3. 支持的平台
4. 适合谁用
项目地址：https://github.com/xxx/yyy
一句话建议：先从简单配置开始体验
日期：2026年03月26日
```

## 输出行为

这个 skill 的默认输出是三段式：

1. 先用一句话判断内容更适合哪种图解结构
2. 输出完整 HTML
3. 如果用户要求图片，再补充截图说明

默认要求：

- 文字必须清楚
- 结构必须可读
- 日期必须可见
- 二维码和 IP 必须存在
- 二维码和 IP 卡尺寸一致
- 底部说明要上提，不能塌到最底边

## 固定品牌元素

这个风格默认带两个固定品牌位和一个固定日期位：

### 顶部日期贴纸

- 位置：顶部右侧
- 形式：像贴在白板边缘上的标签
- 格式：`YYYY年MM月DD日`
- 优先使用正文内给出的日期，没有则使用当天日期

### 二维码区域

- 图片：`assets/contact-code.png`
- 文案：`合作交流`
- 位置：右下角左侧

### IP 区域

- 图片：`assets/kk-character.jpeg`
- 文案：`是卡卡呀`
- 位置：右下角右侧

这两张卡默认保持同尺寸，并始终处于最上层，避免被卡片边界挡住。

## 本地出图

如果你要把模板直接渲染成 PNG，可以执行：

```bash
/Users/bytedance/Downloads/Skills/kkstyle-skills/skills/kkstyle-diagram-board-noline-screenshot/scripts/capture_card.sh \
  /Users/bytedance/Downloads/Skills/kkstyle-skills/skills/kkstyle-diagram-board-noline-screenshot/assets/diagram-board-card-template.html \
  /tmp/diagram-board-output.png \
  3:4
```

如果只是想验证模板有没有成功生成图片，也可以沿用当前仓库的方式直接出 baseline。

## 如何定制这个风格

最常见的定制点有这些：

### 改标题区

改 [assets/diagram-board-card-template.html](./assets/diagram-board-card-template.html) 里的：

- `.title`
- `.hero`
- `.metric-card`

适合调整：

- 标题字号
- 标题换行
- 指标卡大小
- 指标卡位置

### 改流程感

如果想让“白板流程图”感更强，可以重点改：

- `.steps`
- `.steps::before`
- `.step-card`
- `.step-label`
- `.connector`

适合调整：

- 虚线强度
- 节点间距
- 编号块大小
- 箭头和连接关系

### 改模块感

如果想更像“信息图卡片墙”，重点改：

- `.node`
- `.feature-band`
- `.feature`
- `.summary`

适合调整：

- 模块卡数量
- 模块底色
- 摘要条强度
- 底部能力卡密度

### 改品牌区

如果要微调底部二维码和 IP，重点看：

- `.contact-cluster`
- `.code-card`
- `.ip-card`
- `.slot-caption`

通常建议只改位置和尺寸，不建议去掉，因为这是这套风格的固定识别区。

## 常见问题

### 1. 为什么做出来像普通文档？

通常是因为：

- 标题不够强
- 摘要条太弱
- 模块之间没有连接关系
- 内容直接整段堆进卡片里

解决方式：

- 把内容改写成“标题 + 结论 + 结构块”
- 每块只保留一个重点
- 加强步骤编号、节点标签或连接提示

### 2. 为什么画面显得空？

通常是因为：

- 模块数量太少
- 摘要太短
- 底部信息没有上提
- 指标卡存在感不够

解决方式：

- 给内容增加 3 到 5 个明确结构点
- 把标题下的摘要写完整
- 提升底部信息区
- 让指标卡承载一个明确数字

### 3. 为什么画面显得乱？

通常是因为：

- 每个节点文字太多
- 颜色过多
- 连接关系过多
- 左右区都在讲主线

解决方式：

- 左侧讲主线，右侧讲补充
- 每张卡片只放一个要点
- 控制颜色在 3 到 4 种主色内
- 让摘要条先统一阅读入口

## 推荐维护方式

如果你后面继续迭代这套 skill，建议按这个顺序改：

1. 先改 [references/diagram-board-design-rules.md](./references/diagram-board-design-rules.md)
2. 再改 [SKILL.md](./SKILL.md)
3. 最后改 [assets/diagram-board-card-template.html](./assets/diagram-board-card-template.html)

这样可以保证：

- 规则层先统一
- agent 行为和风格同步
- 模板改动不会偏离最初定义

## 当前状态

这个 skill 已经具备完整可用结构：

- 有独立 `SKILL.md`
- 有 `agents/openai.yaml`
- 有设计规则
- 有现成模板
- 有截图脚本
- 有固定品牌资产

适合继续拿来直接生成海报，也适合在这个基础上继续做更强的分支版本，比如：

- 更偏流程图的版本
- 更偏卡片墙的版本
- 更偏技术架构图的版本
