# 配置速查

## 选项一览表

> **使用场景**：**常用** = 一般用户可按需调整；**微调** = 仅细节调整时；**仅自定义时** = `Custom` 需预定义宏。非高度自定义场景下不要主动建议 Custom 或微调选项。

| 选项 | 序号 | 可选值 | 默认 | 说明 | 场景 |
|------|------|--------|------|------|------|
| `ColorDisplay` | 1 | `JXred`, `BSblue`, `Custom` | `JXred` | 配色方案 | 常用；`Custom` 仅自定义时 |
| `BlockDisplay` | 2 | `colorful`, `followtheme`, `allgrey` | `colorful` | 区块颜色风格 | 常用 |
| `CodeTheme` | 3 | `listing`, `minted`, `minted2` | `listing` | 代码高亮引擎 | 常用 |
| `MintedStyle` | 4 | `lightmode`, `darkmode`, `⟨custom⟩` | `lightmode` | minted 样式（需先设 `CodeTheme=minted` 或 `minted2`） | 微调 |
| `LanguageMode` | 5 | `cn`, `en` | `cn` | 语言模式 | 常用 |
| `Miniframes` | 6 | `follow`, `separate`, `none` | `follow` | 小节进度圆点 | 常用 |
| `NavigationTool` | 7 | `none`, `1`, `2`, `3`, `1-2`, `1-3`, `2-3`, `1-2-3` | `1-2-3` | 页脚导航工具（数字用 `-` 连接，顺序无关） | 常用 |
| `LogoWidth` | 8 | `⟨dimen⟩` | `48pt` | 页脚 logo 区域宽度（`VI=Custom` 替换图片时可能需调整） | 仅自定义时 |
| `FontTheme` | 9 | `Auto`, `Ubuntu`, `Win`, `Mac`, `Fandol`, `Source-Han`, `Source-Han(Local)`, `ZhongYi(Local)`, `Custom` | `Auto` | 字体方案（`Auto` 自动检测 OS） | 常用（预设值）；`Custom` 仅自定义时 |
| `MathFont` | 10 | `LM`, `XITS`, `⟨custom⟩` | `LM` | 数学字体 | 微调 |
| `BIBMode` | 11 | `biber`, `none` | `biber` | 参考文献引擎 | 常用 |
| `BIBStyle` | 12 | `biber-gb7714` | `biber-gb7714` | 参考文献样式（仅 `BIBMode=biber` 时生效） | 微调 |
| `ContentMuticols` | 13 | `true`, `false` | `true` | 目录双栏 | 常用 |
| `Background` | 14 | `SCU-Full`, `SCU-Lite`, `none`, `Custom` | `SCU-Full` | 背景模式 | 常用（`Full`/`Lite`/`none`）；`Custom` 仅自定义时 |
| `VI` | 15 | `SCU`, `Custom` | `SCU` | 视觉识别系统 | `Custom` 仅自定义时 |

---

## 场景 → 配置决策

### 1. 学术会议报告 (中文)
```tex
\usetheme{scu}
```

### 2. 学术会议报告 (英文，仅当前节标题，无节导航栏)

英文节标题通常较长，`en` 模式下页眉仅显示当前节标题，不显示节导航栏，避免溢出。

```tex
\usetheme[
  LanguageMode=en,
]{scu}
```

### 3. 代码演示 / 技术分享

minted 基于 Pygments，语法高亮开箱即用，支持行高亮；listings 需手动定义关键字、注释等高亮样式。

```tex
\usetheme[
  CodeTheme=minted,
  % MintedStyle=,       % 可选，自定义 Pygments 风格（如 dracula、monokai 等）
]{scu}
```

`MintedStyle` 值可以是任意 Pygments 风格名，在 [Pygments 官网](https://pygments.org/styles/) 可预览所有内置风格。

### 4. 无参考文献
```tex
\usetheme[
  BIBMode=none,
]{scu}
```

### 5. 简洁风格 (仅在用户明确要求时)
```tex
\usetheme[
  Background=none,
  Miniframes=none,
  NavigationTool=none,
]{scu}
```

---

## documentclass 参数

### aspectratio

| 值 | 比例 | 尺寸 |
|----|------|------|
| `169` | 16:9 | 160mm x 90mm（推荐） |
| `1610` | 16:10 | 160mm x 100mm |
| `43` | 4:3 | 默认 |
| `149` | 14:9 | 140mm x 90mm |
| `141` | 1.41:1 | 148.5mm x 105mm |
| `54` | 5:4 | 125mm x 100mm |
| `32` | 3:2 | 135mm x 90mm |
| `2013` | 20:13 | 140mm x 91mm |

### 其他参数

| 参数 | 作用 |
|------|------|
| `t` | 全局文本垂直对齐为顶部（默认居中），单帧可用 `\begin{frame}[c]` 或 `[b]` 覆盖 |
| `draft` | 草稿模式：隐藏 pgf/TikZ 图形、禁用 hyperref、隐藏页眉页脚，加速编译 |
| `handout` | 讲义模式：去除 overlay 动画，生成静态版本。可配合 `pgfpages` 多页合一 |

`handout` 多页合一示例：
```tex
\usepackage{pgfpages}
\pgfpagesuselayout{2 on 1}[a4paper,border shrink=5mm]
```

---

## 已废弃选项

> 检测到用户使用废弃选项时，提示修正并说明原因。

| 废弃选项 | 替代 | 原因 |
|----------|------|------|
| `Miniframes = negate` | `Miniframes = none` | `negate` 语义不直观，统一为 `none` |
| `NavigationTool = negate` | `NavigationTool = none` | 同上 |
| `Background = true` | `Background = SCU-Full` | 布尔值无法区分 Full/Lite/none，改为枚举 |
| `Background = false` | `Background = SCU-Lite` | 同上 |
| `CodeDisplay = ⟨value⟩` | `CodeTheme = ⟨value⟩` | 统一命名风格，`Display` 改为 `Theme` |

```tex
% 旧写法
\usetheme[Background=true, CodeDisplay=minted]{scu}
% 新写法
\usetheme[Background=SCU-Full, CodeTheme=minted]{scu}
```

---

> **相关模块**：[config-detail.md](config-detail.md)（选项详情）| [workflow.md](workflow.md)（任务流程）| [templates.md](templates.md)（代码模板）| [mwe.md](mwe.md)（完整 MWE）| [typography.md](typography.md)（排版规则）| [customization.md](customization.md)（高级定制）| [troubleshooting.md](troubleshooting.md)（问题排查）| [入口 SKILL.md](../SKILL.md)
