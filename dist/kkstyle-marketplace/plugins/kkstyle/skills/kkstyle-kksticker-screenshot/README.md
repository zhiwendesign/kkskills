# KKStyle KKSticker Screenshot

`kkstyle-kksticker-screenshot` 是一个把文本内容整理成“吉祥物贴纸白板风”海报的 skill 包。它适合把工具更新、功能亮点、项目说明、版本公告、观点摘要这类内容，做成一张结构明确、记忆点很强、可直接截图导出的 `3:4` 信息海报。

和普通海报模板不同，这个 skill 的核心不是纯漫画感，也不是纯流程图，而是把这些元素压成一块更完整的“角色白板”：

- 蓝网格背景
- 顶部吉祥物白板轮廓
- 标签行
- 日期贴纸
- 右上角亮色侧牌
- 全宽摘要条
- 左右双栏内容板
- 底部能力色条
- 固定二维码 `合作交流`
- 固定 IP 位 `是卡卡呀`

## 适合什么内容

这套风格适合以下类型：

- 工具版本更新和功能上新
- 项目亮点拆解
- “这次最值钱的几个点”式总结
- 平台能力说明
- 左右双栏的对照讲解

不太适合的内容：

- 长段学术文字或论文导读
- 极简科技风发布页
- 暖纸拼贴类生活方式内容
- 需要大量图片主导的版式

## 风格特点

`kksticker` 的视觉语言更接近“一块带人格的贴纸白板”：

- 大背景必须是亮蓝网格板
- 主体是白色圆角白板，而不是普通卡片
- 标题像封面词组，必须够大够直给
- 右上侧牌负责抬出版本、数字或一句强判断
- 摘要条负责讲“为什么值得看”
- 双栏内容负责展开细节
- 底部色条负责收尾和强化记忆点

整体目标是让用户一眼知道：

1. 这张图讲的是什么
2. 最值得先看哪一个点
3. 后面的卡片该按什么顺序读

## 默认版式结构

默认输出优先使用 `3:4` 比例，结构大致如下：

1. 顶部左侧是风格标签和模式标签
2. 顶部右侧是日期贴纸，格式固定为 `YYYY年MM月DD日`
3. 第一屏主视觉由大标题和亮色侧牌组成
4. 标题下方是一条摘要条
5. 中间主体分成左右两个信息区
6. 左侧通常讲“最值钱的变化”
7. 右侧通常讲“现在能怎么玩”
8. 底部先给一排色条，再给来源和一句话建议
9. 右下角固定是二维码和卡卡 IP

## 目录结构

```text
kkstyle-kksticker-screenshot/
├── README.md
├── SKILL.md
├── agents/
│   └── openai.yaml
├── assets/
│   ├── kksticker-card-template.html
│   ├── contact-code.png
│   └── kk-character.jpeg
├── references/
│   ├── kksticker-design-rules.md
│   └── layout-presets.md
└── scripts/
    ├── capture_card.sh
    └── image_to_data_uri.py
```

## 每个文件的作用

### `SKILL.md`

给 agent 的主说明文件，定义风格、工作流、输出契约、品牌位和失败检查项。

### `agents/openai.yaml`

技能列表里显示的名称、简短描述和默认提示词。

### `assets/kksticker-card-template.html`

当前风格的基础 HTML 模板。这里面已经内置了蓝网格背景、吉祥物白板轮廓、侧牌、双栏模块和底部品牌区。

### `references/kksticker-design-rules.md`

风格规则文件，用来约束气质、配色、布局偏好、日期贴纸和底部联系区。

### `references/layout-presets.md`

不同输出比例的尺寸参考。默认主结构使用 `3:4`。

### `scripts/capture_card.sh`

把 HTML 模板渲染成 PNG。

### `scripts/image_to_data_uri.py`

把本地图片转成 data URI，适合把图片资源内联进 HTML。

## 如何调用这个 skill

在支持 skill 的 agent 环境里，可以直接这样调用：

```text
Use $kkstyle-kksticker-screenshot to turn these notes into a kksticker 3:4 explainer poster.
```

也可以更具体一点：

```text
Use $kkstyle-kksticker-screenshot to make this feel like a mascot sticker whiteboard with a bold side card.
```

如果你只想要 HTML：

```text
Use $kkstyle-kksticker-screenshot and give me the HTML only.
```

如果你同时要 HTML 和 PNG：

```text
Use $kkstyle-kksticker-screenshot to generate both the HTML and a PNG render.
```

## 推荐输入方式

为了让这套风格表现更稳定，建议输入内容时尽量带上这些信息：

- 标题或主题
- 一句摘要
- 4 到 8 个亮点 / 变化 / 模块
- 项目地址或文章来源
- 一句话建议或结论
- 如果内容里有日期，尽量明确写出来

推荐输入示例：

```text
主题：autocli.ai 这次更新最值钱的点
摘要：AI 开始自动理解任意网站并接入社区配置
结构：
1. 这次更新最值钱
2. 现在能怎么玩
3. 适合谁先试
4. 一句话判断
项目地址：https://github.com/example/project
一句话建议：如果你想让 AI 更稳定地拿到结构化信息，这次值得立刻试
日期：2026年04月01日
```

## 输出行为

这个 skill 的默认输出是三段式：

1. 先用一句话判断内容更适合哪种 kksticker 结构
2. 输出完整 HTML
3. 如果用户要求图片，再补充截图说明

默认要求：

- 标题必须清楚
- 右上侧牌必须明显
- 双栏必须可读
- 日期必须可见
- 二维码和 IP 必须存在
