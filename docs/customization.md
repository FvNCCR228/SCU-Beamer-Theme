# 高级定制

> **生成规则**：以下代码中，宏名和 token 名（如 `\beamer@scu@fontextend`、`PrimaryC`、`lg`）是主题内部接口，**必须原样使用**。花括号 `{}` 中的具体值（字体名、RGB 数值、文件路径、尺寸）是示例，根据用户需求替换。

## 自定义配色 (ColorDisplay=Custom)

在 `\usetheme` 前定义 12 个语义颜色 token（未定义的自动回退到 JXred 默认值）。

颜色定义命令：
- `\definecolor{名称}{模型}{值}` — 从颜色模型直接定义，常用模型：`cmyk`(0-1)、`RGB`(0-255)、`rgb`(0-1)、`HTML`(6位hex)、`gray`(0-1)
- `\colorlet{名称}{已有颜色}` — 从已有颜色派生或混合，支持 `颜色!比例!颜色` 语法

12 个 token 名称和分组固定，**不可更改**：

```tex
% 主题色组
\definecolor{PrimaryC}{RGB}{42, 74, 107}%
\definecolor{AuxiliaryC}{RGB}{139, 0, 0}%
\definecolor{SecondaryAuxiliaryC}{RGB}{184, 134, 11}%
\colorlet{IntersperseC}{PrimaryC!60!AuxiliaryC!40}%

% 文本色组
\definecolor{NomalTextC}{RGB}{34, 34, 34}%
\definecolor{AlertedTextC}{RGB}{165, 42, 42}%
\definecolor{BackgroundC}{RGB}{248, 248, 250}%
\colorlet{HighlightCodeLineC}{PrimaryC!10!BackgroundC}%

% 区块色组
\colorlet{BlockExampleC}{PrimaryC!12!BackgroundC}%
\colorlet{BlockDefinitionC}{PrimaryC!90!black}%
\colorlet{BlockLemmaC}{AuxiliaryC!8!BackgroundC}%
\colorlet{BlockConditionC}{SecondaryAuxiliaryC!10!BackgroundC}%
```

注意：语义颜色名 `NomalTextC` 是源码中的拼写（缺少 'r'），**必须**使用此拼写。

---

## 自定义字体 (FontTheme=Custom)

> **警告**：设置 `FontTheme=Custom` 但未预定义 `\beamer@scu@fontextend` 会导致 `\PackageError`。

宏名 `\beamer@scu@fontextend` 固定，**不可更改**。字体名根据用户需求替换：

```tex
\def\beamer@scu@fontextend{%
  \setsansfont{Cinzel}%               % sans 字体名
  \setmonofont{Consolas}%             % mono 字体名
  \setCJKsansfont{FZYaoTi}%           % CJK sans 字体名
    [ItalicFont = {FZShuTi}]%         % CJK sans italic 字体名
  \setCJKmonofont{FZShuTi}%           % CJK mono 字体名
}
```

字体查找方式：
- **Windows**: Win+R → `ms-settings:fonts`
- **macOS**: Font Book 应用
- **Linux**: `fc-list`、`fc-list :lang=zh`、`fc-list | grep "FontName"`

---

## 自定义背景 (Background=Custom)

三个宏名固定，**不可更改**。花括号内为背景图片路径：

```tex
\def\scu@path@bg{./resources/backgroundoftitlepage(Light).png}%           % 正文背景
\def\scu@path@bgoftitle{./resources/backgroundoftitlepage(Light).png}%    % 封面背景
\def\scu@path@bgofsubsectoc{./resources/backgroundoftitlepage(Light).png}% % 小节目录背景
```

**注意：文件名不能包含下划线 `_`**（draft 模式下 `_` 会被当作数学模式字符，导致报错）。

---

## 自定义 VI (VI=Custom)

> **警告**：设置 `VI=Custom` 但未预定义 `\beamer@scu@viextend` 会导致 `\PackageError`。

宏名 `\beamer@scu@viextend` 和四个标识符名（`lg`、`lg-name`、`landmark`、`verify`）固定，**不可更改**。图片路径和尺寸根据用户需求替换：

```tex
\def\beamer@scu@viextend{%
  % Logo:: 校名.
  \pgfdeclareimage[width=40pt]{lg}{./resources/SCUname.pdf}%
  % Logo+Name:: 校徽+校名.
  \pgfdeclareimage[height=36pt]{lg-name}{./resources/SCUlogo+name.pdf}%
  % Landmark:: 标志性建筑.
  \pgfdeclareimage[height=80pt]{landmark}{./resources/SCUbuilding.png}%
  % Verify:: 校训.
  \pgfdeclareimage[height=30pt]{verify}{./resources/SCUverify.png}%
}
```

页脚 logo 宽度可通过 `LogoWidth=⟨dimen⟩` 调整以适应新图片。

---

## 创建扩展宏包

推荐将自定义配置封装为独立 `.sty` 文件。以 `extension-TianYiYe.sty` 为例：

### 步骤

1. 在项目根目录创建 `extension-xxx.sty`（文件名自定）
2. 在其中定义颜色、字体、背景、VI
3. 用 `\PassOptionsToPackage` 传递选项给 `beamerthemescu`
4. 在 `.tex` 导言区中**先** `\usepackage{extension-xxx}`，**再** `\usetheme`

### 宏包文件(汇总示例)

```tex
\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{extension-TianYiYe}[2026/01/01 Custom Extension]

% ---- 定义颜色 ----
\definecolor{PrimaryC}{RGB}{42, 74, 107}%
\definecolor{AuxiliaryC}{RGB}{139, 0, 0}%
\definecolor{SecondaryAuxiliaryC}{RGB}{184, 134, 11}%
\colorlet{IntersperseC}{PrimaryC!60!AuxiliaryC!40}%
\definecolor{NomalTextC}{RGB}{34, 34, 34}%
\definecolor{AlertedTextC}{RGB}{165, 42, 42}%
\definecolor{BackgroundC}{RGB}{248, 248, 250}%
\colorlet{HighlightCodeLineC}{PrimaryC!10!BackgroundC}%
\colorlet{BlockExampleC}{PrimaryC!12!BackgroundC}%
\colorlet{BlockDefinitionC}{PrimaryC!90!black}%
\colorlet{BlockLemmaC}{AuxiliaryC!8!BackgroundC}%
\colorlet{BlockConditionC}{SecondaryAuxiliaryC!10!BackgroundC}%

% ---- 定义字体 ----
\def\beamer@scu@fontextend{%
  \setsansfont{Cinzel}%
  \setmonofont{Consolas}%
  \setCJKsansfont{FZYaoTi}[ItalicFont = {FZShuTi}]%
  \setCJKmonofont{FZShuTi}%
}

% ---- 定义背景 ----
\def\scu@path@bg{./resources/backgroundoftitlepage(Light).png}%
\def\scu@path@bgoftitle{./resources/backgroundoftitlepage(Light).png}%
\def\scu@path@bgofsubsectoc{./resources/backgroundoftitlepage(Light).png}%

% ---- 定义 VI ----
\def\beamer@scu@viextend{%
  \pgfdeclareimage[width=40pt]{lg}{./resources/SCUname.pdf}%
  \pgfdeclareimage[height=36pt]{lg-name}{./resources/SCUlogo+name.pdf}%
  \pgfdeclareimage[height=80pt]{landmark}{./resources/SCUbuilding.png}%
  \pgfdeclareimage[height=30pt]{verify}{./resources/SCUverify.png}%
}

% ---- 传递选项至 SCU 主题 ----
\PassOptionsToPackage{%
  LogoWidth=100pt,%           % 根据 VI 图片宽度调整
  FontTheme=Custom,%
  MathFont={Fira Math},%      % 数学字体名
  ColorDisplay=Custom,%
  Background=Custom,%
  VI=Custom%
}{beamerthemescu}
```

### 使用方式

```tex
\PassOptionsToPackage{cmyk}{xcolor}%
\documentclass[hyperref, UTF8, CJK, aspectratio=169]{beamer}

\usepackage{extension-TianYiYe}%  必须在 \usetheme 之前
\usetheme{scu}%                    不要在此重复扩展包已传递的参数
```

**关键规则**：
- 扩展包必须在 `\usetheme` 之前加载
- 不要在 `\usetheme` 选项中重复扩展包已传递的参数
- 也可以通过配置宏包选项，为不同机构定制多套颜色/字体主题

---

## 插件系统

项目支持外部插件（GitHub 托管的扩展包）。

- 注册表：`docs/dev/plugins.conf`（INI 格式）
- 安装：`./docs/install-plugin.sh -e <插件名>`（Linux）或 `install-plugin.bat`（Windows）
- 下载缓存：`tmp/plug/`

---

> **相关模块**：[config-overview.md](config-overview.md)（配置速查）| [config-detail.md](config-detail.md)（选项详情）| [workflow.md](workflow.md)（任务流程）| [templates.md](templates.md)（代码模板）| [mwe.md](mwe.md)（完整 MWE）| [typography.md](typography.md)（排版规则）| [troubleshooting.md](troubleshooting.md)（问题排查）| [入口 SKILL.md](../SKILL.md)
