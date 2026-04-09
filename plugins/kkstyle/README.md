# KKStyle Claude Code Plugin

`kkstyle` 是这套仓库的 Claude Code plugin 封装版本。

它把仓库里的 `16` 个海报 skill 通过 Claude Code 的 plugin 结构暴露出来，适合：

- 用 `claude --plugin-dir` 本地调试
- 通过 marketplace 分发和安装
- 在多个项目间复用同一套海报 skill

## 本地测试

在仓库根目录运行：

```bash
claude --plugin-dir ./plugins/kkstyle
```

然后就可以在 Claude Code 里调用 namespaced skill，例如：

```text
/kkstyle:kkstyle-kksticker-screenshot 主题：这次更新最值钱的点；结构：1. 变化亮点 2. 现在能怎么玩 3. 适合谁先试
```

## 通过仓库内置 marketplace 安装

先把这个仓库作为 marketplace 加到 Claude Code：

```text
/plugin marketplace add /absolute/path/to/kkstyle-skills
```

再安装 plugin：

```text
/plugin install kkstyle@kkstyle-marketplace
```

## 结构说明

- `.claude-plugin/plugin.json`：plugin manifest
- `skills/`：插件暴露给 Claude Code 的 namespaced skills

这个 plugin 的 `skills/` 目录由仓库脚本自动同步，源文件仍然维护在仓库顶层的 `kkstyle-*` 目录中。
