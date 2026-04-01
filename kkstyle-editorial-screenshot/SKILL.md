---
name: kkstyle-editorial-screenshot
description: "编辑设计风海报。适合观点摘要、导读卡片、杂志封面感内容；输出固定日期、二维码、IP 位的 HTML，并可截图为 PNG。"
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

# KKStyle Editorial Screenshot

## Overview

这个 skill 用来把原始信息做成“杂志封面、编辑设计、现代印刷版式”风格，而不是亮蓝海豹贴纸风，也不是暖纸拼贴风。
默认优先产出 `3:4` editorial poster：刊头式标题、右上重点信息牌、摘要导语、双栏正文块、顶部日期标签，以及固定二维码 + IP 右下角组合。

默认保持三个交付阶段，除非用户明确要求跳过：
1. 先用一句话判断信息密度。
2. 输出完整 HTML，包含内嵌 CSS。
3. 明确自检文字清晰、层级稳定、装饰不压正文。

## Workflow

### 1. 先判断内容适合哪种 editorial 卡

先看内容适合哪种 editorial 海报：

- 推荐杂志页型：适合工具、课程、资源、观点型内容，默认使用。
- 封面标题型：一句大标题 + 一句导语 + 一组重点指标。
- 双栏摘要型：左侧主结论，右侧辅助说明。
- 清单评论型：主标题 + 数字牌 + 多个短段落块。

信息少时，靠标题、导语和重点牌撑画面。
信息多时，优先拆成双栏或多块，不要用一大段正文破坏版式。

### 2. 先定比例，再定阅读路径

editorial 风格也必须先按比例排版：

- `3:4`：默认主结构。刊头式标题 + 右上重点牌 + 导语区 + 双栏内容 + 上提的底部信息条 + 固定二维码和 IP。
- `4:3`：适合横版专题摘要，左侧主栏，右侧信息栏。
- `1:1`：适合社媒封面，减少块数，强化标题和导语。
- `9:16`：适合故事封面，把标题做成上下分段。
- `16:9`：适合视频封面，减少正文，增加数字或标签牌。

精确尺寸见 [references/layout-presets.md](references/layout-presets.md)。

### 3. 遵循 editorial 视觉规则

默认视觉语言：

- 背景用偏米白、纸白、墨黑，辅以少量深红或砖红强调。
- 主体像杂志页、专题页或现代设计期刊，不要做成网页截图。
- 标题用高对比、大字号、刊头感排版。
- 右上角保留重点牌，用来放数字、阅读时长、分类或结论。
- 顶部固定一个日期标签，格式用 `YYYY年MM月DD日`。
- 右下角固定带 `合作交流` 二维码和 `是卡卡呀` IP 组合。
- 整体要克制、清晰、利落，不要花哨装饰过多。

详细规则见 [references/editorial-design-rules.md](references/editorial-design-rules.md)。

### 4. 固定品牌区

每张海报都必须带上固定右下角组合：

- 使用 `${CLAUDE_SKILL_DIR}/assets/contact-code.png` 作为固定二维码位，下方文案 `合作交流`。
- 使用 `${CLAUDE_SKILL_DIR}/assets/kk-character.jpeg` 作为固定 IP 位，下方文案 `是卡卡呀`。
- 二维码卡和 IP 卡保持同尺寸。
- 这组内容要保持在最上层，不能被版面边界压住。

日期标签也默认固定显示：

- 放在顶部偏右位置，像杂志页的日期签。
- 优先使用内容里的明确日期；没有就使用当天日期。
- 日期只用 `YYYY年MM月DD日`。

### 5. 写截图优先的 HTML

输出给截图器的 HTML 必须是固定画布：

- 使用精确像素尺寸，不依赖 `100vw` / `100vh` 作为主布局。
- 清空默认边距：`html, body { margin: 0; }`。
- 先定标题区和右上重点牌，再安排导语和双栏内容。
- 用分割线、刊头、小标签控制节奏，不依赖大量装饰。
- 左下角来源信息和建议语要适当上提，避免底部发空。
- 右下角固定品牌区和顶部日期都必须稳定可见。

推荐这些结构元素：

- 杂志刊头式标题
- 高对比分割线
- 小型分类签或 issue tag
- 右上重点牌
- 双栏内容模块
- 细长底部信息条

### 6. 内容布局规则

特别注意：

- 标题优先做 1 到 3 行，像封面主标题，不要拉成长段。
- 导语负责解释“是什么”和“为什么值得看”。
- 内容多时优先拆栏，不要堆成大段说明。
- 底部二维码和 IP 的标签只是说明，不能变成第二视觉中心。
- 强调信息优先靠大小、对比和位置，不靠复杂装饰。

### 7. 需要 PNG 时再截图

如果用户要求图片输出，先保存 HTML，再运行：

```bash
"${CLAUDE_SKILL_DIR}/scripts/capture_card.sh" input.html output.png 3:4
```

脚本会自动查找 Chrome / Chromium，并在 `--headless=new` 失败时回退到 `--headless`。
如果最终 HTML 和 skill 自带素材不在同一目录，优先把本地图内联成 data URI，可用：

```bash
"${CLAUDE_SKILL_DIR}/scripts/image_to_data_uri.py" "${CLAUDE_SKILL_DIR}/assets/kk-character.jpeg"
```

## Output Contract

处理 editorial 卡片请求时：

1. 第一行只写一句话，判断信息密度。
2. 然后输出完整 HTML 代码块。
3. 如果用户还要图片，HTML 后补一行说明比例和截图命令。

解释尽量短，HTML 才是主要交付物。

## Resources

### `references/editorial-design-rules.md`

需要确定配色、标题对比、分栏节奏、强调色和文案语气时打开。

### `references/layout-presets.md`

需要查看支持比例和对应画布尺寸时打开。

### `examples.md`

需要看 Claude Code 里的推荐 slash command 写法、输入组织方式和改稿示例时打开。

### `assets/editorial-card-template.html`

需要一个现成的高对比 `3:4` 编辑设计海报骨架时使用。

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

- 最后看起来像普通网页，而不是杂志页或专题海报。
- 标题没有形成主视觉，层级平掉了。
- 强调色滥用，导致画面吵。
- 双栏被写成大段落，阅读路径不清晰。
- 底部二维码或 IP 缺失，或者被挡住。
- 日期标签缺失、格式不对，或者位置太弱。
