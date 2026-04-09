---
name: kkstyle-kksticker-screenshot
description: "吉祥物贴纸白板风海报。适合工具更新、功能拆解、亮点对照、双栏讲解；输出固定日期、二维码、IP 位的 HTML，并可截图为 PNG。"
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

# KKStyle KKSticker Screenshot

## Overview

这个 skill 用来把原始信息做成“蓝网格背景、吉祥物白板、贴纸标签、亮色侧牌、双栏模块卡”风格，而不是漫画封面、极简发布页或课堂笔记风。
默认优先产出 `3:4` 的 kksticker poster：大标题、右上角高亮贴纸牌、摘要条、左右双栏内容板、底部能力标签，以及固定日期 + 固定二维码 + 固定卡卡 IP。

默认保持三个交付阶段，除非用户明确要求跳过：
1. 先用一句话判断信息更适合更新公告还是结构拆解。
2. 输出完整 HTML，包含内嵌 CSS。
3. 明确自检主标题、贴纸牌、双栏卡片和底部品牌区都清晰可见。

## Workflow

### 1. 先判断内容适合哪种 kksticker

- 更新公告型：适合版本更新、功能上新、工具变化，默认优先。
- 亮点拆解型：适合“这次最值钱的几个点”。
- 对照讲解型：适合左侧讲核心变化，右侧讲怎么用。
- 摘要清单型：适合一个结论 + 多块短卡。

信息少时，靠标题、侧牌和底部色条撑住画面。
信息多时，优先拆成双栏短卡，不要把吉祥物白板写成文章页。

### 2. 先定比例，再定阅读路径

- `3:4`：默认主结构。标签 + 日期贴纸 + 大标题 + 高亮侧牌 + 摘要条 + 双栏内容 + 底部色条 + 固定二维码和 IP。
- `4:3`：适合横向版本说明板。
- `1:1`：适合社媒总结卡，减少块数，保留标题和侧牌。
- `9:16`：适合竖版预告或更新导览。
- `16:9`：适合视频封面式亮点概览。

精确尺寸见 [references/layout-presets.md](references/layout-presets.md)。

### 3. 遵循 kksticker 视觉规则

- 背景优先用亮蓝网格或蓝色工作板，四周留出可见的边缘空间。
- 主体像一块“会卖萌的白板”，顶部允许有吉祥物耳朵 / 眼睛轮廓。
- 标签、日期、侧牌和底部色条都要像贴纸，而不是普通按钮。
- 标题要粗、大、直接，像一眼能抓住重点的封面词组。
- 右上角保留一张高识别亮色贴纸牌，用来放版本号、结论或关键数字。
- 摘要条负责解释“这次为什么值得看”。
- 中间主体拆成左右双栏卡片，卡片颜色可以浅蓝、浅黄、浅绿和白色交替。
- 顶部固定日期贴纸，格式用 `YYYY年MM月DD日`。
- 右下角固定带 `合作交流` 二维码和 `是卡卡呀` IP 组合。

详细规则见 [references/kksticker-design-rules.md](references/kksticker-design-rules.md)。

### 4. 固定品牌区

每张海报都必须带上固定右下角组合：

- 使用 `${CLAUDE_SKILL_DIR}/assets/contact-code.png` 作为固定二维码位，下方文案 `合作交流`。
- 使用 `${CLAUDE_SKILL_DIR}/assets/kk-character.jpeg` 作为固定 IP 位，下方文案 `是卡卡呀`。
- 二维码卡和 IP 卡保持同尺寸。
- 这组内容要保持在最上层，不能被底部色条或内容卡压住。

日期贴纸也默认固定显示：

- 放在顶部偏右，像贴在白板边缘的日期签。
- 优先使用内容里的明确日期；没有就使用当天日期。
- 日期只用 `YYYY年MM月DD日`。

### 5. 写截图优先的 HTML

- 使用精确像素尺寸，不依赖 `100vw` / `100vh`。
- 先定吉祥物白板轮廓、标签区、日期贴纸和侧牌，再安排双栏内容。
- 蓝色网格背景要留在主体外侧，不能被白板完全盖满。
- 侧牌、底部色条和摘要条只能帮助建立节奏，不能压正文。
- 左下角来源信息和一句话建议要适当上提。
- 右下角品牌区和顶部日期都必须稳定可见。

### 6. 内容布局规则

- 标题优先做 2 到 3 行，像封面主词组。
- 摘要条先讲“发生了什么”和“为什么值得看”。
- 主内容优先拆成 4 到 8 张短卡，不要整页大段说明。
- 左栏通常讲“最值钱的变化”，右栏通常讲“现在能怎么用”。
- 底部二维码和 IP 的标签只是说明，不是第二主标题。

### 7. 需要 PNG 时再截图

如果用户要求图片输出，先保存 HTML，再运行：

```bash
"${CLAUDE_SKILL_DIR}/scripts/capture_card.sh" input.html output.png 3:4
```

## Output Contract

1. 第一行只写一句话，判断内容更适合哪种 kksticker 结构。
2. 然后输出完整 HTML 代码块。
3. 如果用户还要图片，HTML 后补一行说明比例和截图命令。

## Resources

### `references/kksticker-design-rules.md`

需要确定配色、白板轮廓、贴纸牌、卡片节奏和底部色条时打开。

### `references/layout-presets.md`

需要查看比例和尺寸时打开。

### `examples.md`

需要看 Claude Code 里的推荐 slash command 写法、输入组织方式和改稿示例时打开。

### `assets/kksticker-card-template.html`

需要一个现成的吉祥物贴纸白板风海报骨架时使用。

### `assets/kk-character.jpeg`

固定 IP 图。

### `assets/contact-code.png`

固定合作二维码图。

### `scripts/image_to_data_uri.py`

需要把本地图片内联进 HTML 时运行。

### `scripts/capture_card.sh`

需要把本地 HTML 转成 PNG 时运行。

## Failure Checks

- 最后看起来像普通文档或普通卡片墙，而不是吉祥物贴纸白板。
- 蓝网格背景、顶部白板轮廓或右上侧牌不明显。
- 双栏块很多，但没有清楚的阅读路径。
- 二维码或 IP 缺失，或者被底部区域挡住。
- 日期贴纸缺失、格式错误或位置太弱。
