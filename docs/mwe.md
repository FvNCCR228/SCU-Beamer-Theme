# 完整 MWE（最小工作示例）

以下为 beamer-scu 主题的完整最小工作示例，可直接保存为 `exp.tex` 编译。

```tex
% !TeX encoding = UTF-8
% !TeX TS-program = latexmk
% UTF-8 格式 + latexmk 编译, 使用前请阅读用户手册!

% -------- 导言区 --------
\PassOptionsToPackage{cmyk}{xcolor}%
\documentclass[
  % draft,             % 草稿模式
  % handout,           % 讲义模式
  aspectratio=169,     % 演示比例(推荐) 16:9
  hyperref, UTF8, CJK%
]{beamer}

% -------- SCU Beamer Theme Config --------
\usetheme[
  % ColorDisplay=,    % JXred ⚙️ | BSblue | Custom
  % BlockDisplay=,    % colorful ⚙️ | followtheme | allgrey
  % CodeTheme=,       % listing ⚙️ | minted | minted2
  % MintedStyle=,     % lightmode ⚙️ | darkmode | ⟨custom⟩
  % LanguageMode=,    % cn ⚙️ | en
  % Miniframes=,      % follow ⚙️ | separate | none
  % NavigationTool=,  % 1-2-3 ⚙️ | none | ⟨组合⟩
  % FontTheme=,       % Auto ⚙️ | Ubuntu | Win | Mac | Fandol | ... | Custom
  % MathFont=,        % LM ⚙️ | XITS | ⟨custom⟩
  % BIBMode=,         % biber ⚙️ | none
  % BIBStyle=,        % biber-gb7714 ⚙️
  % ContentMuticols=, % true ⚙️ | false
  % Background=,      % SCU-Full ⚙️ | SCU-Lite | Custom | none
]{scu}

% -------- Packages --------
\usepackage{multicol, multirow, booktabs}

% -------- TitlePage Config --------
% [<in footline>]   → 方括号内容, 缩写, 显示在页脚
% {<in title page>} → 花括号内容, 全称, 显示在封面
\title[短标题 (页脚)]{完整标题 (封面)}
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

% -------- 正文区 --------
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
  \begin{columns}[T, onlytextwidth]
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

---

> **相关模块**：[config-overview.md](config-overview.md)（配置速查）| [config-detail.md](config-detail.md)（选项详情）| [workflow.md](workflow.md)（任务流程）| [templates.md](templates.md)（代码模板）| [typography.md](typography.md)（排版规则）| [customization.md](customization.md)（高级定制）| [troubleshooting.md](troubleshooting.md)（问题排查）| [入口 SKILL.md](../SKILL.md)
