---
name: kkstyle-poster-comic-screenshot
description: "漫画海报风信息卡。适合强情绪封面、pop-art 信息表达；输出固定日期、二维码、IP 位的 HTML，并可截图为 PNG。"
argument-hint: "[topic or notes]"
disable-model-invocation: true
metadata:
  clawdbot:
    requires:
      bins:
        - google-chrome
        - chromium
        - chrome
---

# KKStyle Poster Comic Screenshot

## Overview

这个 skill 用来把原始信息做成“漫画海报、pop-art、粗黑描边、对话框”风格，而不是课堂笔记风、极简科技风或编辑设计风。
默认优先产出 `3:4` 的 poster-comic poster：爆炸标题、对话框摘要、右上亮色爆点牌、双栏内容区、顶部日期贴纸，以及固定二维码 + IP 右下角组合。

默认保持三个交付阶段，除非用户明确要求跳过：
1. 先用一句话判断信息密度。
2. 输出完整 HTML，包含内嵌 CSS。
3. 明确自检文字清晰、漫画装饰不会盖住正文。

## Workflow

### 1. 先判断内容适合哪种漫画卡

- 推荐漫画海报型：适合工具、项目、课程、观点推荐，默认使用。
- 对话框摘要型：一句主标题 + 一个气泡导语 + 多块短句卡。
- 爆点卡型：大词组 + 数字牌 + 多条补充信息。
- 封面页型：强标题 + 多个标签 + 底部提醒条。

信息少时，靠爆点牌、对话框、标签撑画面。
信息多时，先做块状归纳，不要把漫画海报写成文章页。

### 2. 先定比例，再定阅读路径

- `3:4`：默认主结构。爆炸标题 + 右上爆点牌 + 对话框摘要 + 双栏内容块 + 上提的底部信息条 + 固定二维码和 IP。
- `4:3`：适合横版漫画封面风。
- `1:1`：适合社媒方卡，减少块数，强化一到两个爆点。
- `9:16`：适合竖版漫画封面或故事页预告。
- `16:9`：适合视频封面或大标题横幅。

精确尺寸见 [references/layout-presets.md](references/layout-presets.md)。

### 3. 遵循 poster-comic 视觉规则

- 背景用亮黄、亮红、亮蓝、奶白，辅以 halftone 点阵和粗黑描边。
- 标题要像漫画封面字，粗、炸、直接。
- 摘要可以放在对话框或圆角气泡里。
- 右上角保留亮色爆点牌，用来放数字、关键词或结论。
- 顶部固定一个日期贴纸，格式用 `YYYY年MM月DD日`。
- 右下角固定带 `合作交流` 二维码和 `是卡卡呀` IP 组合。
- 整体要热闹但仍可读，不要为了漫画感牺牲信息层次。

详细规则见 [references/poster-comic-design-rules.md](references/poster-comic-design-rules.md)。

### 4. 固定品牌区

每张海报都必须带上固定右下角组合：

- 使用 `${CLAUDE_SKILL_DIR}/assets/contact-code.png` 作为固定二维码位，下方文案 `合作交流`。
- 使用 `${CLAUDE_SKILL_DIR}/assets/kk-character.jpeg` 作为固定 IP 位，下方文案 `是卡卡呀`。
- 二维码卡和 IP 卡保持同尺寸。
- 这组内容要保持在最上层，不能被漫画边框、爆点牌或底部块压住。

日期贴纸也默认固定显示：

- 放在顶部偏右，像封面贴纸。
- 优先使用内容里的明确日期；没有就使用当天日期。
- 日期只用 `YYYY年MM月DD日`。

### 5. 写截图优先的 HTML

- 使用精确像素尺寸，不依赖 `100vw` / `100vh`。
- 先定标题、爆点牌、摘要气泡，再安排双栏内容。
- halftone 点阵和爆炸形只放在边缘或留白区，不要压正文。
- 左下角来源信息和建议语要适当上提。
- 右下角品牌区和顶部日期都必须稳定可见。

### 6. 内容布局规则

- 标题优先做 1 到 3 行，像漫画封面主词组。
- 摘要先讲“这是什么”和“为什么值得看”。
- 内容多时优先拆成块，不要整页大段说明。
- 底部二维码和 IP 的标签只是说明，不是第二主标题。

### 7. 需要 PNG 时再截图

如果用户要求图片输出，先保存 HTML，再运行：

```bash
"${CLAUDE_SKILL_DIR}/scripts/capture_card.sh" input.html output.png 3:4
```

## Output Contract

1. 第一行只写一句话，判断信息密度。
2. 然后输出完整 HTML 代码块。
3. 如果用户还要图片，HTML 后补一行说明比例和截图命令。

## Resources

### `references/poster-comic-design-rules.md`

需要确定配色、爆点牌、对话框和漫画感层次时打开。

### `references/layout-presets.md`

需要查看比例和尺寸时打开。

### `examples.md`

需要看 Claude Code 里的推荐 slash command 写法、输入组织方式和改稿示例时打开。

### `assets/poster-comic-card-template.html`

需要一个现成的漫画海报风骨架时使用。

### `assets/kk-character.jpeg`

固定 IP 图。

### `assets/contact-code.png`

固定合作二维码图。

### `scripts/image_to_data_uri.py`

需要把本地图片内联进 HTML 时运行。

### `scripts/capture_card.sh`

需要把本地 HTML 转成 PNG 时运行。

## Failure Checks

- 最后看起来像普通彩色海报，没有漫画封面感。
- 装饰太多导致正文难读。
- 爆点牌、标题、对话框和正文层级不清晰。
- 二维码或 IP 缺失，或者被挡住。
- 日期贴纸缺失、格式错误或位置太弱。
