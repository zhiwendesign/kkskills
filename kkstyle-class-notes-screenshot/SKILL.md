---
name: kkstyle-class-notes-screenshot
description: "手写课堂笔记风海报。适合课程总结、学习笔记、知识清单；输出固定日期、二维码、IP 位的 HTML，并可截图为 PNG。"
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

# KKStyle Class Notes Screenshot

## Overview

这个 skill 用来把原始信息做成“课堂笔记、手写标记、纸张笔记页”风格，而不是海豹贴纸风、拼贴风、编辑设计风或像素掌机风。
默认优先产出 `3:4` 的 class-notes poster：手写题目、荧光笔高亮、双栏笔记块、顶部日期标签，以及固定二维码 + IP 右下角组合。

默认保持三个交付阶段，除非用户明确要求跳过：
1. 先用一句话判断信息密度。
2. 输出完整 HTML，包含内嵌 CSS。
3. 明确自检文字清晰、装饰不会遮住正文。

## Workflow

### 1. 先判断内容适合哪种笔记页

先看内容适合哪种 class-notes 卡：

- 推荐课堂总结型：适合课程、工具、方法论、学习资源，默认使用。
- 知识点清单型：一个主标题 + 多个短结论块。
- 复盘笔记型：一个主观点 + 两栏支持信息。
- 考点提要型：标题 + 高亮标签 + 底部提醒条。

信息少时，用标签、高亮和补充条把画面撑满。
信息多时，先分成三到五个知识块，再落到不同笔记框。

### 2. 先定比例，再定阅读路径

- `3:4`：默认主结构。手写标题 + 右上重点条 + 高亮摘要 + 双栏笔记块 + 上提的底部说明 + 固定二维码和 IP。
- `4:3`：适合横版课堂白板感总结。
- `1:1`：适合社媒知识卡，控制块数，保持焦点。
- `9:16`：适合竖版讲义封面，标题和高亮条竖向展开。
- `16:9`：适合课程封面或横版讲义页，减少段落，增加标签。

精确尺寸见 [references/layout-presets.md](references/layout-presets.md)。

### 3. 遵循 class-notes 视觉规则

默认视觉语言：

- 背景像笔记本纸、方格纸或浅色课堂讲义纸。
- 标题像粗记号笔写出来的课程标题。
- 重点信息可用荧光笔高亮、手绘框线、便签条。
- 顶部固定一个日期标签，格式用 `YYYY年MM月DD日`。
- 右下角固定带 `合作交流` 二维码和 `是卡卡呀` IP 组合。
- 整体要像“整理得很好看的课堂笔记”，不是乱糟糟手账。

详细规则见 [references/class-notes-design-rules.md](references/class-notes-design-rules.md)。

### 4. 固定品牌区

每张海报都必须带上固定右下角组合：

- 使用 `${CLAUDE_SKILL_DIR}/assets/contact-code.png` 作为固定二维码位，下方文案 `合作交流`。
- 使用 `${CLAUDE_SKILL_DIR}/assets/kk-character.jpeg` 作为固定 IP 位，下方文案 `是卡卡呀`。
- 二维码卡和 IP 卡保持同尺寸。
- 这组内容要保持在最上层，不能被笔记框边缘或纸张层挡住。

日期标签也默认固定显示：

- 放在顶部偏右，像课堂讲义日期签。
- 优先使用内容里的明确日期；没有就使用当天日期。
- 日期只用 `YYYY年MM月DD日`。

### 5. 写截图优先的 HTML

- 使用精确像素尺寸，不依赖 `100vw` / `100vh`。
- 先定标题和高亮摘要，再做双栏笔记块。
- 线条和手绘装饰只能增强笔记感，不能破坏可读性。
- 左下角来源信息和建议语要适当上提。
- 右下角品牌区和顶部日期都必须稳定可见。

### 6. 内容布局规则

- 标题优先做 1 到 3 行。
- 摘要先讲“这是什么”和“为什么值得看”。
- 内容多时先做分点，再落到笔记框。
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

### `references/class-notes-design-rules.md`

需要确定配色、线条、手写感和高亮方式时打开。

### `references/layout-presets.md`

需要查看比例和尺寸时打开。

### `examples.md`

需要看 Claude Code 里的推荐 slash command 写法、输入组织方式和改稿示例时打开。

### `assets/class-notes-card-template.html`

需要一个现成的课堂笔记风海报骨架时使用。

### `assets/kk-character.jpeg`

固定 IP 图。

### `assets/contact-code.png`

固定合作二维码图。

### `scripts/image_to_data_uri.py`

需要把本地图片内联进 HTML 时运行。

### `scripts/capture_card.sh`

需要把本地 HTML 转成 PNG 时运行。

## Failure Checks

- 最后看起来像普通白底海报，没有笔记页或课堂感。
- 手绘装饰太多导致正文难读。
- 高亮、标题和正文层级不清晰。
- 二维码或 IP 缺失，或者被挡住。
- 日期标签缺失、格式错误或位置太弱。
