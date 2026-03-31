---
name: kkstyle-diagram-board-noline-screenshot
description: "把文章、笔记、提纲或项目说明生成成信息图白板无描边、弱边界的信息海报 HTML，并可按固定比例截图为 PNG。Use when the user wants a no-line version, borderless version, softened-edge version, or a diagram board, flowchart poster, whiteboard explainer, sticky-note infographic, or both HTML and image output in a more structured visual-explanation direction."
metadata:
  clawdbot:
    requires:
      bins:
        - google-chrome
        - chromium
        - chrome
---

# KKStyle Diagram Board No-Line Screenshot

## Overview

这个 skill 用来把原始信息做成“信息图白板、流程图讲解板、结构化讲述页”风格，而不是漫画封面、极简发布页或手写课堂笔记风。
默认优先产出 `3:4` 的 no-line diagram-board poster：大标题、右上角数据卡、摘要条、多模块流程板、连接箭头感，以及固定日期 + 固定二维码 + 固定卡卡 IP。
这个版本不使用明显黑色描边，主要靠色块、留白、阴影和轻微明暗差来区分层级。

默认保持三个交付阶段，除非用户明确要求跳过：
1. 先用一句话判断信息更适合流程讲解还是分块说明。
2. 输出完整 HTML，包含内嵌 CSS。
3. 明确自检结构清晰、层级稳定、阅读路径直观。

## Workflow

### 1. 先判断内容适合哪种 diagram-board

- 流程讲解型：适合步骤、协作链路、从输入到输出的内容，默认优先。
- 模块拆解型：适合“组成部分 + 职责说明”。
- 对照框架型：适合“左侧主逻辑 + 右侧补充说明”。
- 结构摘要型：适合标题、结论、若干模块便签和底部来源信息。

信息少时，用更强的标题和一个数据卡撑住。
信息多时，用模块框、箭头和分层面板消化，不要堆大段正文。

### 2. 先定比例，再定阅读路径

- `3:4`：默认主结构。标题 + 数据卡 + 摘要条 + 左右双区块 + 流程节点 + 底部说明 + 固定二维码和 IP。
- `4:3`：适合横向流程板。
- `1:1`：适合简化版结构图。
- `9:16`：适合竖版讲解页。
- `16:9`：适合演示封面式白板摘要。

精确尺寸见 [references/layout-presets.md](references/layout-presets.md)。

### 3. 遵循 diagram-board 视觉规则

- 背景像干净白板或浅色图解板，可带轻网格、点阵或便签块。
- 模块以白底卡、彩色标签、连接线、箭头和提示贴纸组成。
- 标题要像“这是一页能讲清楚事情的结构图”。
- 右上角保留一张高识别数据卡，用来放步骤数、模块数、版本或比例。
- 顶部固定日期条，格式用 `YYYY年MM月DD日`。
- 右下角固定带 `合作交流` 二维码和 `是卡卡呀` IP 组合。
- 整体要清晰、可视化、可讲解，不要做成普通文档。

另外，避免可见的粗黑边框和强线稿分隔。

详细规则见 [references/diagram-board-design-rules.md](references/diagram-board-design-rules.md)。

### 4. 固定品牌区

每张海报都必须带上固定右下角组合：

- 使用 `assets/contact-code.png` 作为固定二维码位，下方文案 `合作交流`。
- 使用 `assets/kk-character.jpeg` 作为固定 IP 位，下方文案 `是卡卡呀`。
- 二维码卡和 IP 卡保持同尺寸，但边界以柔和阴影和浅分隔呈现。
- 这组内容要保持在最上层，不能被卡片边缘压住。

日期条也默认固定显示：

- 放在顶部偏右，像贴在白板边缘的日期贴纸。
- 优先使用内容里的明确日期；没有就使用当天日期。
- 日期只用 `YYYY年MM月DD日`。

### 5. 写截图优先的 HTML

- 使用精确像素尺寸，不依赖 `100vw` / `100vh`。
- 先定标题、右上数据卡、摘要条，再安排流程板和模块框。
- 用边框、标签、虚线、箭头提示阅读路径。
- 左下角来源信息和建议语要适当上提。
- 右下角品牌区和顶部日期都必须稳定可见。

### 6. 内容布局规则

- 标题优先做 1 到 3 行。
- 摘要条负责解释“这张图要帮用户看懂什么”。
- 主内容至少拆成两个结构区，不要整块文字直排。
- 箭头、编号、标签只能帮助理解，不能喧宾夺主。
- 底部二维码和 IP 的标签只是说明，不是第二视觉中心。

### 7. 需要 PNG 时再截图

如果用户要求图片输出，先保存 HTML，再运行：

```bash
./scripts/capture_card.sh input.html output.png 3:4
```

## Output Contract

1. 第一行只写一句话，判断信息更适合哪种图解结构。
2. 然后输出完整 HTML 代码块。
3. 如果用户还要图片，HTML 后补一行说明比例和截图命令。

## Resources

### `references/diagram-board-design-rules.md`

需要确定配色、流程块、标签、连接关系和图解节奏时打开。

### `references/layout-presets.md`

需要查看比例和尺寸时打开。

### `assets/diagram-board-card-template.html`

需要一个现成的信息图白板风海报骨架时使用。

### `assets/kk-character.jpeg`

固定 IP 图。

### `assets/contact-code.png`

固定合作二维码图。

### `scripts/image_to_data_uri.py`

需要把本地图片内联进 HTML 时运行。

### `scripts/capture_card.sh`

需要把本地 HTML 转成 PNG 时运行。

## Failure Checks

- 最后看起来像普通表格或文档，而不是讲解板。
- 流程关系不清楚，读者不知道先看哪里。
- 模块框很多，但没有层次和连接逻辑。
- 二维码或 IP 缺失，或者被挡住。
- 日期条缺失、格式错误或位置太弱。
