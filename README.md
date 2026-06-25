# 四川大学Beamer模板

[![GitHub stars](https://img.shields.io/github/stars/FvNCCR228/SCU-Beamer-Theme?style=social)](https://github.com/FvNCCR228/SCU-Beamer-Theme)
[![GitHub forks](https://img.shields.io/github/forks/FvNCCR228/SCU-Beamer-Theme?style=social)](https://github.com/FvNCCR228/SCU-Beamer-Theme)
[![Gitee](https://img.shields.io/badge/-Gitee-C71D23?logo=gitee&logoColor=white&style=flat)](https://gitee.com/NCCR/SCU_Beamer_Slide-demo)
[![LaTeX](https://img.shields.io/badge/-LaTeX%20Beamer-008080?logo=latex&logoColor=white&style=flat)](https://www.latex-project.org/)
[![知乎](https://img.shields.io/badge/-知乎-0066FF?logo=zhihu&logoColor=white&style=flat)](https://www.zhihu.com/column/c_1498346349729361920)
[![TeXPage](https://img.shields.io/badge/-TeXPage-2e5090?logo=tex&logoColor=white&style=flat)](https://www.texpage.com/zh/template/91b96607-7702-4a85-b696-658d260db5b9)

![Version](https://img.shields.io/github/v/release/FvNCCR228/SCU-Beamer-Theme?label=Version)
[![Skill](https://img.shields.io/badge/Skill-beamer--scu-blue)](https://github.com/FvNCCR228/SCU-Beamer-Theme/tree/skill)
![Discussions](https://img.shields.io/github/discussions/FvNCCR228/SCU-Beamer-Theme?label=Discussions)
![Issues](https://img.shields.io/github/issues-raw/FvNCCR228/SCU-Beamer-Theme?label=Issues)
![License](https://img.shields.io/badge/License-LPPL--1.3c-green)

本项目参考了Beamer, Tcolorbox等官方文档, 参考了stackoverflow中的诸多问题；

主要参考了中国科学技术大学Beamer模板 [USTCBeamerSX](https://github.com/ysx2000/USTCBeamerSX/), 少量参考了清华大学Beamer模板 [THU-Beamer-Theme](https://github.com/tuna/THU-Beamer-Theme/) 及其衍生的各大学的Beamer模板, 还参考了中国科学技术大学Beamer模板 [ustcbeamer](https://github.com/ustctug/ustcbeamer/).


<img width="750" alt="image" src="./docs/assert/assert-1.png" />
<img width="750" alt="image" src="https://github.com/user-attachments/assets/a9c2518c-c3f6-4298-86d3-376833a110e5" />
<img width="750" alt="image" src="https://github.com/user-attachments/assets/5086df2b-462a-44bd-be9c-a897655eb7dd" />


## 快速开始

### 1. 克隆或下载项目

**Git 克隆:**

```bash
git clone https://github.com/FvNCCR228/SCU-Beamer-Theme.git
```

国内用户可使用 Gitee 镜像 (更新可能略有延迟):

```bash
git clone https://gitee.com/NCCR/SCU_Beamer_Slide-demo.git
```

**从 Release 下载:**

前往 [GitHub Releases](https://github.com/FvNCCR228/SCU-Beamer-Theme/releases) 或 [Gitee Releases](https://gitee.com/NCCR/SCU_Beamer_Slide-demo/releases) 下载.

### 2. 创建主 `.tex` 文件

「以下假设主文件命名为 `exp.tex` 」创建方式有两种:

- **基于 MWE 修改:** 展开下方 MWE (最小工作示例), 保存为 `exp.tex` 即可编译;
- **参考示例:** 直接参考仓库中的 `main.tex` 或 `main-en.tex` 示例文件创建 `exp.tex`.

<details>
<summary><b>MWE (exp.tex)</b></summary>

```latex
% !TeX encoding = UTF-8
% !TeX TS-program = latexmk
% UTF-8 格式 + latexmk 编译, 使用前请阅读用户手册!

% ---------------- %
%      导言区      %
% ---------------- %
\PassOptionsToPackage{cmyk}{xcolor}% 解决设置 CMYK 颜色时生成 PDF 的色彩偏移
\documentclass[
  % draft,           % 草稿模式
  % handout,         % 讲义模式
  aspectratio=169, % 演示比例(推荐) 16:9
  hyperref, UTF8, CJK%
]{beamer}

% -------- SCU Beamer Theme Config --------
\usetheme[
	% ColorDisplay=, % JXred ⚙️ | BSblue | Custom → 主题色显示设置
	% BlockDisplay=, % colorful ⚙️ | followtheme | allgrey → 区块颜色显示设置
	% CodeTheme=, % listing ⚙️ | minted | minted2 → 代码高亮显示设置
	% MintedStyle=, % lightmode ⚙️ | darkmode | ⟨custom⟩ → minted 样式设置 (需优先设置 CodeTheme = minted | minted2)
	% LanguageMode=, % cn ⚙️ | en → 语言模式设置
	% Miniframes=, % follow ⚙️ | separate | none → 页眉小节迷你帧设置
	% NavigationTool=, % 1-2-3 ⚙️ | ⟨参考 Manual 设置⟩ | none → 页脚导航工具栏设置
	% FontTheme=, % Auto ⚙️ | Ubuntu | Win | Mac | Fandol | Source-Han | ... | Custom → 字体主题设置
	% MathFont=, % LM ⚙️ | XITS | ⟨custom⟩ → 数学字体设置
	% BIBMode=, % biber ⚙️ | none → 参考文献引擎设置
	% BIBStyle=, % biber-gb7714 ⚙️ → 参考文献样式设置 (设置 BIBMode=none 时无效)
	% ContentMuticols=, % true ⚙️ | false → 目录帧双栏显示设置
	% Background=, % SCU-Full ⚙️ | SCU-Lite | Custom | none → 背景显示设置
]{scu}

% -------- Packages --------
% \usepackage[xx]{xx}
\usepackage{multicol, multirow}

% -------- TitlePage Config --------
% [<in footline>]   → 方括号内容, 缩写, 显示在页脚
% {<in title page>} → 花括号内容, 全称, 显示在封面
% ----------------
\title[Short 标题]{Full 标题}
\subtitle{副标题}% subtitle 未设置页脚显示项, 请在 title 中设置.
\author[页脚作者]{作者一\inst{1}\inst{a} \and 作者二\inst{2}\inst{b}}
\institute{%
	\inst{1} 机构一
	\vspace*{-6pt} \and
	\inst{2} ~Institution Two
	\vspace*{-6pt} \and
	\inst{a} \mailscu{author1@example.com} ~\inst{b} \mailscu{author2@example.com}
}
\date{\today}

% ---------------- %
%      正文区      %
% ---------------- %
\begin{document}

\section{第一节}
\subsection{第一小节}
\begin{frame}{帧标题}
	\begin{itemize}
		\item 示例内容一
		\item 示例内容二
	\end{itemize}
\end{frame}

\begin{frame}{帧标题}{帧小标题}
	\begin{columns}
		\begin{column}{.5\textwidth}
			\structure{栏一标题}

			示例内容一

			示例内容二
		\end{column}
		\begin{column}{.5\textwidth}
			\structure{栏二标题}

			示例内容三

			示例内容四
		\end{column}
	\end{columns}
\end{frame}

\subsection{第二小节}
\begin{frame}{公式示例}
	质能方程
	\begin{equation}
		E = mc^2
	\end{equation}
\end{frame}

\section{第二节}
\subsection{动画示例}
\begin{frame}{动画演示}
	\begin{itemize}
		\item<1-> 第一步: 准备工作
		\item<2-> 第二步: 编写内容
		\item<3-> 第三步: 编译生成
		\item<4-> 第四步: 完成!
	\end{itemize}
	\only<4>{\structure{动画演示结束.}}
\end{frame}

% -------- Appendix --------
\appendix
\section{附录}
\subsection{附录}
\begin{frame}{附录}
	附录内容.
\end{frame}

\end{document}
```

</details>

### 3. 导入章节 `.tex` 文件

建议将演示内容按章节拆分到单独的 `.tex` 文件中, 方便管理大型演示文稿.

**在 `include-sec/` 目录下创建各章节文件**, 例如:

```
include-sec/
├── sec-introduction.tex
├── sec-method.tex
└── sec-conclusion.tex
```

> `include-sec/` 是 SCU Beamer Theme 预设的章节 `.tex` 文件存放目录. 本模板通过 latexmk 将编译中间文件 (aux 文件等) 输出至 `tmp/build/`, 而由于 latexmk 迁移 aux 输出目录时出于安全考虑不会自动创建子目录, 本模板已提前在 `tmp/build/` 下创建好对应的子目录.

**每个章节文件只需包含帧内容** (无需 `\documentclass` 和 `\begin{document}`), 例如:

```latex
% include-sec/sec-introduction.tex
\section{引言}
\subsection{背景}
\begin{frame}{研究背景}
    此处填写内容.
\end{frame}
```

**然后在主文件 `exp.tex` 中通过 `\include` 或 `\input` 导入**:

```latex
% 在 \begin{document} 之后
\include{include-sec/sec-introduction}
\include{include-sec/sec-method}
\include{include-sec/sec-conclusion}
```

> **`\include` 与 `\input` 的区别:**
> - `\include` 会自动在前后插入 `\clearpage`, 适合章节级别, 支持 `\includeonly` 选择性编译;
> - `\input` 直接嵌入内容, 不分页, 适合小片段.

### 4. 编译

```bash
latexmk exp.tex
```

### 5. 清理 (可选)

当出现编译异常 (如交叉引用错误、缓存污染) 或需要重新完整编译时, 可清理中间文件:

```bash
latexmk -c            # 清除中间文件
latexmk -c exp.tex    # 清除指定文件的中间文件
latexmk -C            # 清除全部生成文件
latexmk -C exp.tex    # 清除指定文件的全部生成文件
```

> `-c` 仅清除 `.aux`, `.log`, `.toc` 等中间文件, 保留 PDF; `-C` 连同 PDF 一并清除.

> **!! 注意事项:**
> - 在线平台 (如 TeXPage, Overleaf) 编译时, 请上传整个工作文件夹, 否则可能出现因文件缺失导致的编译异常;
> - 模板已内置丰富的配置选项, 建议先查阅用户手册 (配置选项见「基础设置」章节, 项目结构见「附录B」); 如确需修改 `.sty` 文件, 请先了解模板结构, 保留备份后参照文件内注释进行实验性修改;
> - 推荐使用 `latexmk` 编译; 若无法使用 latexmk, 可在编辑器中配置编译引擎为 XeLaTeX, 参考文献引擎为 Biber, 并按 XeLaTeX → Biber → XeLaTeX → XeLaTeX 的顺序编译四轮.


## AI 辅助 (Claude Code Skill)

本模板提供了 [Claude Code](https://docs.anthropic.com/en/docs/claude-code) 专用的 Skill (位于 `skill` 分支), 可辅助编写与修改 Beamer 演示文稿.

### 功能

- 将论文/报告转写为 Beamer Slides
- 从零创建 Slides
- 修改已有 Slides (配色、动画等)
- 辅助配置主题参数
- 排查编译问题

### 使用方式

1. 安装 Claude Code CLI:
   ```bash
   npm install -g @anthropic-ai/claude-code
   ```
2. 安装 [CC Switch](https://github.com/farion1231/cc-switch), 在 Skills 面板中安装本模板的 Skill:
   - URL: `https://github.com/FvNCCR228/SCU-Beamer-Theme`
   - 分支: `skill`
3. 在项目目录下启动 Claude Code, 输入 `/beamer-scu` 或用自然语言描述需求即可触发 Skill (如 "帮我用 SCU beamer 做一个答辩 Slides")


## 模板设计

### 背景

封面与正文板块采用不同背景, 正文背景采用低透明度淡色, 增强正文文本等辨识性.
	
### 页眉

采用双行设计;

首行为节标题导航栏, 显示幻灯整体思路, 还附带四川大学校名; 

次行为标题栏, 左侧显示小节标题与迷你帧(圆点)形式的当前小节帧进度}, 右侧显示当前幻灯标题. (编者认为小节迷你帧能在较清晰呈现进度的同时, 节约大量空间, 也能避免某节中幻灯页数过多, 导致标题导航挤压溢出)

### 页脚

采用双行设计;

首行为导航栏, 左侧显示报告标题, 右侧为导航模块; 次行为信息行, 左中右分别为作者、机构、日期与页码.

### 环境

模板定义了定理, 代码等多种环境演示.


### 关于修改

若有修改意见欢迎邮件联系编者, 当然, 编者不一定有时间, 请谅解.

若本校的 LaTeX 大佬百忙之中能对本模板提出批评指正, 鄙人在此万分感谢各位的支持.

感谢模板中所使用部分代码的原作者, 也感谢模板所调用宏包的诸位作者前辈.

欢迎友校的朋友们对此模板进行修改, 不过这个模板可能有点点难改, 希望能看懂我的注释, 但愿吧.


## 更新记录

v1.0a - 初始版本
