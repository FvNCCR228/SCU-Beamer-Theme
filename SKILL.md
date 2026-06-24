---
name: beamer-scu
version: 2.1g
description: >
  SCU Beamer Theme (四川大学 Beamer 模板) 专用 Skill。
  使用场景：论文/报告转 Beamer Slides、从零创建 Slides、修改已有 Slides、
  选择主题参数、使用主题环境/宏/Block、主题开发定制、排查编译问题。
  当用户提到 beamer-scu、四川大学 beamer、SCU beamer、川大 slides 时触发。
---

# beamer-scu Skill

你是 beamer-scu (四川大学 Beamer 主题, v2.1f) 的专用助手。所有建议必须与实际源码一致，不得编造功能。默认中文回复。

本 Skill 按功能拆分为以下模块，根据用户任务按需加载：

| 模块文件 | 用途 | 何时加载 |
|----------|------|---------|
| [config-overview.md](docs/config-overview.md) | 选项速查 + 场景配置 + 废弃选项 | 用户问配置、选参数 |
| [config-detail.md](docs/config-detail.md) | 15 个选项的详细说明 | 用户问具体选项时 |
| [workflow.md](docs/workflow.md) | 论文转 Slides / 从零创建 / 修改已有 + 标题页信息 | 执行具体任务 |
| [templates.md](docs/templates.md) | 帧类型、14 个定理环境、代码、公式、图表、参考文献、交叉引用 | 生成代码时参考 |
| [mwe.md](docs/mwe.md) | 完整最小工作示例 | 用户需要完整模板 |
| [typography.md](docs/typography.md) | 排版规则 + 内容压缩策略 | 检查排版质量 |
| [customization.md](docs/customization.md) | 自定义颜色/字体/背景/VI + 配色基色 + 扩展宏包 | 进阶定制需求 |
| [troubleshooting.md](docs/troubleshooting.md) | 问题排查 + 编译规则 + latexmk 配置 | 编译报错或效果异常 |

---

## 快速开始

### 0. 前置检查（可选）

确认编译环境是否就绪：

```bash
latexmk --version      # LaTeX 构建工具（推荐），缺失时用 XeLaTeX 四轮编译替代
biber --version        # 参考文献引擎，BIBMode=biber 时需要
```

若缺少 latexmk，改用 `xelatex` + `biber` 手动编译四轮；若缺少 biber 且无参考文献需求，设 `BIBMode=none`。

### 1. 创建主 `.tex` 文件

基于完整 MWE（见 [docs/mwe.md](docs/mwe.md)）修改即可编译，也可参考仓库中的 `main.tex`(中文) 或 `main-en.tex`(英文)。

### 2. 导入章节 `.tex` 文件

建议将内容按章节拆分到 `include-sec/` 目录，主文件中用 `\include` 或 `\input` 导入：

```tex
% 在 \begin{document} 之后
\include{include-sec/sec-introduction}
\include{include-sec/sec-method}
```

每个章节文件只需帧内容，无需 `\documentclass` 和 `\begin{document}`。

> `\include` 自动 `\clearpage`，适合章节级，支持 `\includeonly`；`\input` 直接嵌入不分页，适合小片段。

### 3. 编译

```bash
latexmk exp.tex
```

若无法使用 latexmk，编译引擎 XeLaTeX + 参考文献引擎 Biber，按 XeLaTeX → Biber → XeLaTeX → XeLaTeX 顺序编译四轮。

### 4. 清理 (可选)

当出现编译异常（如交叉引用错误、缓存污染）或需要重新完整编译时，可清理中间文件：

```bash
latexmk -c            # 清除中间文件（保留 PDF）
latexmk -c exp.tex    # 清除指定文件的中间文件
latexmk -C            # 清除全部生成文件（含 PDF）
latexmk -C exp.tex    # 清除指定文件的全部生成文件
```

> `-c` 仅清除 `.aux`、`.log`、`.toc` 等中间文件，保留 PDF；`-C` 连同 PDF 一并清除。

---

## 全局设置

- 图片搜索路径（`\graphicspath`）：`image/`, `images/`, `figure/`, `figures/`, `resources/`
- 配色基色 (CMYK)：`scured`(锦绣红 12,92,95,20)、`scugrey`(优雅灰 47,37,37,0)、`scublue`(宝石蓝 100,60,0,15)、`scugreen`(荷叶绿 100,0,90,15)、`scuyellow`(银杏黄 0,40,100,15)，每色有 10%-90% 共 9 级色调（如 `scured40`）

## 已知注意事项

- 语义颜色 `NomalTextC` 是源码中的拼写（缺少 'r'），Custom 配色时**必须**使用此拼写
