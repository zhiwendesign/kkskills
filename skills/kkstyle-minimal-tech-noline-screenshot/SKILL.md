---
name: kkstyle-minimal-tech-noline-screenshot
description: "把文章、笔记、提纲或摘要生成成极简科技发布页无描边、弱边界的信息海报 HTML，并可按固定比例截图为 PNG。Use when the user wants a no-line version, borderless version, softened-edge version, or a minimal tech poster, product-launch layout, modern keynote style, restrained futuristic information design, or both HTML and image output in a clean technology direction."
metadata:
  clawdbot:
    requires:
      bins:
        - google-chrome
        - chromium
        - chrome
---

# KKStyle Minimal Tech No-Line Screenshot

## Overview

这个 skill 用来把原始信息做成“极简科技发布页、产品发布、现代 keynote 海报”风格，而不是手写笔记风、漫画风或像素风。
默认优先产出 `3:4` 的 no-line minimal-tech poster：极简大标题、右上指标卡、清晰摘要、双栏内容区、顶部日期条，以及固定二维码 + IP 右下角组合。

默认保持三个交付阶段，除非用户明确要求跳过：
1. 先用一句话判断信息密度。
2. 输出完整 HTML，包含内嵌 CSS。
3. 明确自检文字清晰、对比充足、结构稳定。

## Workflow

### 1. 先判断内容适合哪种 tech 卡

- 推荐发布页型：适合产品、工具、平台、能力介绍，默认使用。
- 参数摘要型：大标题 + 数字卡 + 两栏说明。
- 路线图型：标题 + 一句导语 + 多块能力标签。
- 极简封面型：一句主题 + 关键参数 + 一个结论条。

信息少时，用强标题和指标卡撑住画面。
信息多时，用双栏和清晰分割，不要靠很多装饰。

### 2. 先定比例，再定阅读路径

- `3:4`：默认主结构。科技刊头 + 大标题 + 指标卡 + 导语 + 双栏内容 + 上提的底部信息条 + 固定二维码和 IP。
- `4:3`：适合横版发布摘要。
- `1:1`：适合社媒参数海报。
- `9:16`：适合产品发布竖版封面。
- `16:9`：适合 keynote 封面或宽屏介绍页。

精确尺寸见 [references/layout-presets.md](references/layout-presets.md)。

### 3. 遵循 minimal-tech 视觉规则

- 背景用浅灰白、银白、石墨灰，少量青色或电蓝强调。
- 结构以大留白、细分割线、圆角科技卡为主。
- 标题要干净、强、有发布页感。
- 右上角保留一张指标卡，用来放数字、性能、时长或版本信息。
- 顶部固定日期条，格式用 `YYYY年MM月DD日`。
- 右下角固定带 `合作交流` 二维码和 `是卡卡呀` IP 组合。
- 整体要克制、精密、现代，不要花里胡哨。

另外，避免可见的粗黑边框和强线稿分隔。

详细规则见 [references/minimal-tech-design-rules.md](references/minimal-tech-design-rules.md)。

### 4. 固定品牌区

每张海报都必须带上固定右下角组合：

- 使用 `assets/contact-code.png` 作为固定二维码位，下方文案 `合作交流`。
- 使用 `assets/kk-character.jpeg` 作为固定 IP 位，下方文案 `是卡卡呀`。
- 二维码卡和 IP 卡保持同尺寸，但边界以柔和阴影和浅分隔呈现。
- 这组内容要保持在最上层，不能被卡片边缘压住。

日期条也默认固定显示：

- 放在顶部偏右，像发布页 meta 标签。
- 优先使用内容里的明确日期；没有就使用当天日期。
- 日期只用 `YYYY年MM月DD日`。

### 5. 写截图优先的 HTML

- 使用精确像素尺寸，不依赖 `100vw` / `100vh`。
- 先定刊头、标题、指标卡，再安排导语和双栏内容。
- 用分割线、透明度、阴影控制层次，不用堆很多装饰。
- 左下角来源信息和建议语要适当上提。
- 右下角品牌区和顶部日期都必须稳定可见。

### 6. 内容布局规则

- 标题优先做 1 到 3 行。
- 导语负责解释“是什么”和“为什么值得看”。
- 内容多时拆成双栏或多卡，不要堆段落。
- 底部二维码和 IP 的标签只是说明，不是第二视觉中心。

### 7. 需要 PNG 时再截图

如果用户要求图片输出，先保存 HTML，再运行：

```bash
./scripts/capture_card.sh input.html output.png 3:4
```

## Output Contract

1. 第一行只写一句话，判断信息密度。
2. 然后输出完整 HTML 代码块。
3. 如果用户还要图片，HTML 后补一行说明比例和截图命令。

## Resources

### `references/minimal-tech-design-rules.md`

需要确定配色、分割线、科技卡和文案气质时打开。

### `references/layout-presets.md`

需要查看比例和尺寸时打开。

### `assets/minimal-tech-card-template.html`

需要一个现成的极简科技风海报骨架时使用。

### `assets/kk-character.jpeg`

固定 IP 图。

### `assets/contact-code.png`

固定合作二维码图。

### `scripts/image_to_data_uri.py`

需要把本地图片内联进 HTML 时运行。

### `scripts/capture_card.sh`

需要把本地 HTML 转成 PNG 时运行。

## Failure Checks

- 最后看起来像普通商务 PPT，没有科技发布页感。
- 画面太空却没有层次支撑。
- 指标卡、标题、正文层级不清楚。
- 二维码或 IP 缺失，或者被挡住。
- 日期条缺失、格式错误或位置太弱。
