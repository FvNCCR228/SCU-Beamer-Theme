# 选项详情

> 用户查询具体选项时加载此文件。快速查阅选项列表和场景配置见 [config-overview.md](config-overview.md)。

### 1. ColorDisplay

| 方案 | PrimaryC | IntersperseC | AlertedTextC | AuxiliaryC | NomalTextC | BackgroundC |
|------|----------|-------------|-------------|-----------|-----------|------------|
| `JXred` (默认) | scured (锦绣红) | scured40 | scured90 | scugrey50 | black | white |
| `BSblue` | scublue (宝石蓝) | scublue40 | scublue90 | scugrey50 | black | white |

`Custom`：用户自定义 12 个语义颜色 token，未定义的回退到 JXred 默认值。详见 customization.md。

### 2. BlockDisplay

| 风格 | 效果 |
|------|------|
| `colorful` (默认) | 每种环境不同颜色 |
| `followtheme` | 所有环境跟随主题主色 |
| `allgrey` | 所有环境灰色 |

### 3. CodeTheme

| 值 | 引擎 | 环境要求 | 特点 |
|----|------|---------|------|
| `listing` (默认) | listings 宏包 | 无额外依赖 | 需手动定义关键字/注释高亮样式 |
| `minted` | minted v3+ | TeX Live 2024+ | Pygments 高亮开箱即用，支持行高亮 |
| `minted2` | minted v2 | Python + Pygments + `-shell-escape` | 兼容 TeX Live < 2024 |

### 4. MintedStyle

仅 `CodeTheme=minted` 或 `minted2` 时生效。

| 值 | 效果 |
|----|------|
| `lightmode` (默认) | 浅色背景，Pygments 默认风格 |
| `darkmode` | 深色背景，Pygments rrt 风格 |
| `⟨custom⟩` | 任意 Pygments 风格名（如 `dracula`、`monokai`） |

### 5. LanguageMode

| 值 | 页眉节导航 | cleveref 语言 |
|----|-----------|--------------|
| `cn` (默认) | 水平导航栏，显示所有节标题 | 中文 |
| `en` | 仅当前节标题，无导航栏 | `english` |

### 6. Miniframes

| 值 | 效果 |
|----|------|
| `follow` (默认) | 迷你帧圆点紧跟小节标题后，超出时自动换行 |
| `separate` | 圆点独立显示在节导航栏下方右侧，单行 |
| `none` | 不显示 |

### 7. NavigationTool

- `1` = 小节导航 (上一节 / 回起点 / 下一节)
- `2` = 演示导航 (回起点 / 查找 / 跳到末尾)
- `3` = Acrobat 菜单 (后退 / 全屏 / 前进)
- 用 `-` 组合，顺序无关；`none` = 无导航

### 9. FontTheme

`Auto` 模式自动检测 OS：探测 `/Library/Keychains` → Mac，`C:/Windows/System32/cmd.exe` → Win，否则 Ubuntu。

| 预设 | Sans | Mono | CJK Sans | CJK Italic | CJK Mono |
|------|------|------|----------|------------|----------|
| `Ubuntu` | Roboto | Ubuntu Mono | Noto Sans CJK SC | AR PL KaitiM GB | ctex 自动 |
| `Win` | Segoe UI | Consolas | Microsoft YaHei | KaiTi | ctex 自动 |
| `Mac` | Helvetica | Menlo | PingFang SC | Kaiti SC | ctex 自动 |
| `Fandol` | Latin Modern Sans | Latin Modern Mono | FandolHei | FandolKai | ctex 自动 |
| `Source-Han` | Latin Modern Sans | Latin Modern Mono | Source Han Sans SC | LXGW WenKai | LXGW WenKai |
| `Source-Han(Local)` | Latin Modern Sans | Latin Modern Mono | fonts/SourceHanSansSC-Regular.otf | fonts/LXGWWenKai-Medium.ttf | fonts/LXGWWenKai-Medium.ttf |
| `ZhongYi(Local)` | Latin Modern Sans | Latin Modern Mono | fonts/simhei.ttf | fonts/simkai.ttf | fonts/simfang.ttf |

`Custom`：用户通过 `\beamer@scu@fontextend` 自定义。详见 customization.md。

### 10. MathFont

| 值 | 字体 | 特点 |
|----|------|------|
| `LM` (默认) | Latin Modern Math | 开箱即用 |
| `XITS` | XITS Math | 需系统安装 |
| `⟨custom⟩` | 任意 OpenType Math 字体名 | 需系统安装 |

### 11. BIBMode / BIBStyle

| BIBMode | 效果 |
|---------|------|
| `biber` (默认) | 加载 biblatex + biber，GB/T 7714-2015 样式，自动读取 `ref.bib` |
| `none` | 不加载参考文献 |

`BIBStyle` 仅 `BIBMode=biber` 时生效，默认 `biber-gb7714`。

### 12. ContentMuticols

| 值 | 效果 |
|----|------|
| `true` (默认) | 小节目录帧双栏布局 |
| `false` | 单栏 |

### 13. Background

| 值 | 正文背景 | 封面背景 | 小节目录背景 |
|----|---------|---------|------------|
| `SCU-Full` (默认) | 有 (带 logo) | 有 | 有 (带校训) |
| `SCU-Lite` | / | 有 | / |
| `none` | / | / | / |

`Custom`：用户通过三个路径宏自定义各页背景图片。详见 customization.md。

### 14. VI

| 值 | 效果 |
|----|------|
| `SCU` (默认) | 使用 `resources/` 中的校徽、校名、建筑、校训图片 |
| `Custom` | 用户通过 `\beamer@scu@viextend` 自定义四个图片标识符 (lg, lg-name, landmark, verify)。详见 customization.md |

---

> **相关模块**：[config-overview.md](config-overview.md)（选项速查）| [workflow.md](workflow.md)（任务流程）| [templates.md](templates.md)（代码模板）| [mwe.md](mwe.md)（完整 MWE）| [typography.md](typography.md)（排版规则）| [customization.md](customization.md)（高级定制）| [troubleshooting.md](troubleshooting.md)（问题排查）| [入口 SKILL.md](../SKILL.md)
