---
name: kkstyle-scrapbook-noline-screenshot
description: "把文章、笔记、课程摘要或推荐清单生成成暖米色纸张、胶带、撕纸、便签和杂志拼贴感的信息海报 HTML，并可按固定比例截图为 PNG。Use when the user wants a no-line version, borderless version, softened-edge version, or a scrapbook collage poster, paper-note layout, cozy editorial board, handmade journal style, or both HTML and image output in a warmer alternative to the default kkstyle blue seal poster."
metadata:
  clawdbot:
    requires:
      bins:
        - google-chrome
        - chromium
        - chrome
---

# KKStyle Scrapbook No-Line Screenshot

## Overview

这个 skill 用来把原始信息做成“暖纸感、拼贴感、便签感”的海报，而不是亮蓝像素海豹风。
默认优先产出 `3:4` 的 no-line scrapbook poster：纸张底、拼贴标题、便签摘要、两张主信息纸、上方日期条，以及固定二维码 + IP 右下角组合。

默认保持三个交付阶段，除非用户明确要求跳过：
1. 先用一句话判断信息密度。
2. 输出完整 HTML，包含内嵌 CSS。
3. 明确自检文字清晰，纸张装饰不会压住信息。

## Workflow

### 1. 先判断内容适合哪种拼贴卡

先看内容适合哪种 scrapbook 卡：

- 推荐摘要板：适合工具、课程、资源推荐，默认使用。
- 便签清单板：一个强标题 + 多张短句便签。
- 杂志页板：标题 + 引言 + 两页主内容 + 底部结论。
- 手账感封面：一句主题 + 少量标签 + 一张重点便签。

信息少时，用便签、标签、纸条和结论卡把画面撑满。
信息多时，先归纳成三到五个块，再落到不同纸片上。

### 2. 先定比例，再定阅读路径

scrapbook 风格也必须先按比例排版，不要把一个网页硬缩放：

- `3:4`：默认主结构。标题拼贴 + 右上重点纸卡 + 摘要纸条 + 两张主信息纸 + 上提的底部说明 + 固定二维码和 IP。
- `4:3`：适合横版摘要，左侧主纸张，右侧便签列。
- `1:1`：适合社媒方卡，控制便签数量，保持焦点集中。
- `9:16`：适合竖版故事封面，把标题和日期竖向拉开。
- `16:9`：适合横幅，减少段落，增加短标签和纸条。

精确尺寸见 [references/layout-presets.md](references/layout-presets.md)。

### 3. 遵循 scrapbook 视觉规则

默认视觉语言：

- 背景用暖米色、纸张白、浅棕、橄榄绿、陶土橙。
- 主体不是一整块冷白卡面，而是多层叠放的纸张、便签、标签和胶带。
- 标题要像贴在纸板上的主便签，允许轻微旋转。
- 右上角保留一张重点纸卡，用来放数字、结论或阅读时长。
- 顶部固定一个日期条，格式用 `YYYY年MM月DD日`。
- 右下角固定带 `合作交流` 二维码和 `是卡卡呀` IP 组合。
- 整体要温暖、有手作感、有内容感，不要做成冰冷企业海报。

另外，避免可见的粗黑边框和强线稿分隔。

详细规则见 [references/scrapbook-design-rules.md](references/scrapbook-design-rules.md)。

### 4. 固定品牌区

每张海报都必须带上固定右下角组合：

- 使用 `assets/contact-code.png` 作为固定二维码位，下方文案 `合作交流`。
- 使用 `assets/kk-character.jpeg` 作为固定 IP 位，下方文案 `是卡卡呀`。
- 二维码卡和 IP 卡保持同尺寸，但边界以柔和阴影和浅分隔呈现。
- 这组内容要保持在最上层，不能被纸张边缘或阴影压住。

日期条也默认固定显示：

- 放在上边缘偏右的位置，像贴在纸板上的日期标签。
- 优先使用内容里的明确日期；没有就使用当天日期。
- 日期只用 `YYYY年MM月DD日`。

### 5. 写截图优先的 HTML

输出给截图器的 HTML 必须是固定画布：

- 使用精确像素尺寸，不依赖 `100vw` / `100vh` 作为主布局。
- 清空默认边距：`html, body { margin: 0; }`。
- 先铺背景纸感，再放主纸张层和便签层。
- 纸张可以旋转一点，但正文区要保持可读。
- 标题和重点纸卡优先抓住视线。
- 左下角来源信息和建议语要适当上提，避免底部塌陷。
- 右下角品牌区和顶部日期条都要保持可见。

推荐这些结构元素：

- 撕纸边或多层纸张
- 胶带块、回形针感小装饰
- 重点便签或 polaroid 式数字卡
- 两张主信息纸
- 小标签和纸条式说明

### 6. 内容布局规则

特别注意：

- 标题优先做 1 到 3 行，像主便签，不要做成长段。
- 摘要用一张短纸条说明“这是什么”和“为什么值得看”。
- 大段内容必须拆到不同纸片上，不要整屏细字。
- 底部二维码和 IP 的 caption 只是说明，不是第二主标题。
- 便签和纸条可以有层次，但不要抢主内容。

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

处理 scrapbook 卡片请求时：

1. 第一行只写一句话，判断信息密度。
2. 然后输出完整 HTML 代码块。
3. 如果用户还要图片，HTML 后补一行说明比例和截图命令。

解释尽量短，HTML 才是主要交付物。

## Resources

### `references/scrapbook-design-rules.md`

需要确定配色、纸张层次、胶带感、caption 和文案气质时打开。

### `references/layout-presets.md`

需要查看支持比例和对应画布尺寸时打开。

### `assets/scrapbook-card-template.html`

需要一个现成的暖纸感 `3:4` 拼贴海报骨架时使用。

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

- 最后看起来像普通白底海报，没有纸感和拼贴层次。
- 标题、便签、纸张全都一条线排开，没有 collage 感。
- 纸张装饰压住正文，导致信息难读。
- 底部二维码或 IP 缺失，或者被主纸张挡住。
- 日期条缺失、格式错误，或者位置太悬空。
- 内容太多却没有分纸片，最后整页都在挤小字。
