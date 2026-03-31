---
name: kkstyle-retro-pixel-screenshot
description: "把文章、笔记、课程摘要或推荐清单生成成复古像素游戏界面风格的信息海报 HTML，并可按固定比例截图为 PNG。Use when the user wants a retro pixel poster, game UI board, arcade handheld style, chunky HUD-inspired info card, or both HTML and image output in a stronger pixel direction than the default kkstyle poster."
metadata:
  clawdbot:
    requires:
      bins:
        - google-chrome
        - chromium
        - chrome
---

# KKStyle Retro Pixel Screenshot

## Overview

这个 skill 用来把原始信息做成“复古像素、掌机 HUD、游戏状态板”风格，而不是亮蓝海豹贴纸风、暖纸拼贴风或编辑设计风。
默认优先产出 `3:4` 的 retro-pixel poster：像素标题栏、右上状态牌、双栏信息面板、顶部日期 HUD，以及固定二维码 + IP 右下角组合。

默认保持三个交付阶段，除非用户明确要求跳过：
1. 先用一句话判断信息密度。
2. 输出完整 HTML，包含内嵌 CSS。
3. 明确自检文字清晰、像素装饰不压住正文。

## Workflow

### 1. 先判断内容适合哪种像素卡

先看内容适合哪种 retro-pixel 卡：

- 推荐状态板型：适合工具、资源、课程、项目介绍，默认使用。
- 掌机封面型：一句大标题 + 一组状态牌 + 一列短信息。
- 任务面板型：主结论 + 双栏子块 + 底部状态条。
- 清单关卡型：标题 + 爆点数字 + 多个像素框要点。

信息少时，靠状态牌、pixel label 和底部状态条撑住画面。
信息多时，先拆成三到五个块，不要塞成长段。

### 2. 先定比例，再定阅读路径

retro-pixel 风格也必须先按比例排版：

- `3:4`：默认主结构。像素刊头 + 右上状态牌 + 主标题 + 摘要框 + 双栏主面板 + 固定二维码和 IP。
- `4:3`：适合横版控制台面板，左大右小。
- `1:1`：适合方形游戏封面卡，突出一个主词组和三个状态块。
- `9:16`：适合竖版掌机封面，增加状态栏层次。
- `16:9`：适合横幅，减少正文，增加 HUD 标签。

精确尺寸见 [references/layout-presets.md](references/layout-presets.md)。

### 3. 遵循 retro-pixel 视觉规则

默认视觉语言：

- 背景用深蓝黑、像素格、荧光绿或青色状态线。
- 主体像一块复古掌机界面或游戏 HUD，不要做成赛博霓虹海报。
- 标题要有 chunky、blocky、游戏封面式感觉。
- 右上角保留一张状态牌，用来放数字、等级、阅读时长或关键指标。
- 顶部固定一个日期 HUD，格式用 `YYYY年MM月DD日`。
- 右下角固定带 `合作交流` 二维码和 `是卡卡呀` IP 组合。
- 整体要利落、好玩、有像素感，但不能影响可读性。

详细规则见 [references/retro-pixel-design-rules.md](references/retro-pixel-design-rules.md)。

### 4. 固定品牌区

每张海报都必须带上固定右下角组合：

- 使用 `assets/contact-code.png` 作为固定二维码位，下方文案 `合作交流`。
- 使用 `assets/kk-character.jpeg` 作为固定 IP 位，下方文案 `是卡卡呀`。
- 二维码卡和 IP 卡保持同尺寸。
- 这组内容要保持在最上层，不能被像素框边界或底部面板压住。

日期 HUD 也默认固定显示：

- 放在顶部偏右位置，像状态栏时间标签。
- 优先使用内容里的明确日期；没有就使用当天日期。
- 日期只用 `YYYY年MM月DD日`。

### 5. 写截图优先的 HTML

输出给截图器的 HTML 必须是固定画布：

- 使用精确像素尺寸，不依赖 `100vw` / `100vh` 作为主布局。
- 清空默认边距：`html, body { margin: 0; }`。
- 先定顶部 HUD、右上状态牌和主标题。
- 像素格和装饰块要留在边缘和边框，不要压到正文。
- 左下角来源信息和建议语要适当上提。
- 右下角固定品牌区和顶部日期都必须稳定可见。

推荐这些结构元素：

- 像素网格背景
- chunky 边框和状态条
- 右上 HUD 信息牌
- 双栏像素面板
- 底部细长状态信息条

### 6. 内容布局规则

特别注意：

- 标题优先做 1 到 3 行，像游戏封面主标题。
- 摘要先讲“这是什么”和“为什么值得看”。
- 内容多时优先拆块，不要整屏小字。
- 底部二维码和 IP 的标签只是说明，不要抢主信息。
- 强调靠对比、位置和状态牌，不靠过量霓虹色。

### 7. 需要 PNG 时再截图

如果用户要求图片输出，先保存 HTML，再运行：

```bash
./scripts/capture_card.sh input.html output.png 3:4
```

脚本会自动查找 Chrome / Chromium，并在 `--headless=new` 失败时回退到 `--headless`。
如果最终 HTML 不在 `assets/` 目录下，优先把本地图内联成 data URI，可用：

```bash
./scripts/image_to_data_uri.py assets/kk-character.jpeg
```

## Output Contract

处理 retro-pixel 卡片请求时：

1. 第一行只写一句话，判断信息密度。
2. 然后输出完整 HTML 代码块。
3. 如果用户还要图片，HTML 后补一行说明比例和截图命令。

解释尽量短，HTML 才是主要交付物。

## Resources

### `references/retro-pixel-design-rules.md`

需要确定配色、像素层次、HUD 风格、状态牌和文案语气时打开。

### `references/layout-presets.md`

需要查看支持比例和对应画布尺寸时打开。

### `assets/retro-pixel-card-template.html`

需要一个现成的 `3:4` 像素风海报骨架时使用。

### `assets/kk-character.jpeg`

这是固定 IP 角色图，每次出图默认都要带上。

### `assets/contact-code.png`

这是固定合作二维码图，每次出图默认都要带上。

### `scripts/image_to_data_uri.py`

需要把本地图片内联进 HTML 时运行。

### `scripts/capture_card.sh`

需要把本地 HTML 转成 PNG 时运行。

## Failure Checks

出现这些情况时，结果不合格：

- 最后看起来像普通科技海报，没有明显像素和掌机状态板感觉。
- 霓虹色过多，变成赛博感而不是复古像素感。
- 标题、状态牌和正文层级不清晰。
- 底部二维码或 IP 缺失，或者被挡住。
- 日期 HUD 缺失、格式不对，或者位置太弱。
