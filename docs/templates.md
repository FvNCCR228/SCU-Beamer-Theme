# 帧与环境模板库

## 帧类型

主题自动生成的帧：封面帧（`\AtBeginDocument`）、目录帧（`\AtBeginSubsection`，标题"目录"或"Outline"，受 `ContentMuticols` 控制是否双栏）。无需手动创建。
```tex
\begin{frame}{帧标题}
  内容
\end{frame}
```

### 带副标题的帧
```tex
\begin{frame}{帧标题}{帧副标题}
  内容
\end{frame}
```
页眉显示为「帧标题 | 帧副标题」，竖线分隔符自动使用 `SecondaryAuxiliaryC` 颜色。

### 帧选项

| 选项 | 作用 |
|------|------|
| `fragile` | 含 `\verb`、`verbatim`、`scucode` 时**必须**加 |
| `t` | 内容顶部对齐（默认居中） |
| `b` | 内容底部对齐 |
| `plain` | 无页眉页脚，全屏 |
| `allowframebreaks` | 内容过长时自动分帧，可用 `=\num` 设阈值。仅用于参考文献等自动生成内容，内容帧应手动拆分并加序号 `标题 (1/N)` |

选项写在 `\begin{frame}[...]` 的方括号中，可组合：
```tex
\begin{frame}[fragile, t]{代码示例}
  \begin{scucode}{python}{训练脚本}
    model.fit(data, epochs=100)
  \end{scucode}
\end{frame}
```

### 双栏帧

两栏宽度之和应小于 `\textwidth`，留出间距：
```tex
\begin{frame}{方法对比}
  \begin{columns}[T, onlytextwidth]
    \begin{column}{.45\textwidth}
      \structure{本文方法}
      \begin{itemize}
        \item 端到端训练
        \item 参数量更少
      \end{itemize}
    \end{column}
    \hfill
    \begin{column}{.45\textwidth}
      \structure{基线方法}
      \begin{itemize}
        \item 两阶段流程
        \item 需要预处理
      \end{itemize}
    \end{column}
  \end{columns}
\end{frame}
```
`[T]` 顶部对齐，`[c]` 居中。`onlytextwidth` 确保不超出文本区域。

### Overlay 覆盖层

逐步展示内容，常用于演讲时逐条揭示要点。

**按项指定页码** `<n->`：
```tex
\begin{frame}{模型流程}
  \begin{itemize}
    \item<1-> 输入：文本 + 图像
    \item<2-> 文本编码 → BERT → 文本特征
    \item<3-> 视觉编码 → ViT → 视觉特征
    \item<4-> 跨模态融合 → 输出
  \end{itemize}
  \only<5>{\structure{核心创新：交叉注意力融合层}}
\end{frame}
```

**自动逐条 + 高亮当前项** `[<+-| alert@+>]`：
```tex
\begin{frame}{逐步展示}
  \begin{itemize}[<+-| alert@+>]
    \item 第一步
    \item 第二步
    \item 第三步
  \end{itemize}
\end{frame}
```

**`\pause` 暂停**（简单场景）：
```tex
\begin{frame}{动机分析}
  现有方法存在两个主要问题：
  \pause
  \begin{enumerate}
    \item 特征对齐不充分
    \item 计算复杂度过高
  \end{enumerate}
\end{frame}
```

**`\onslide` 精确控制**：
```tex
\onslide<1->{始终显示}
\onslide<2-3>{仅第2-3页}
\onslide<4->{第4页起}
```

Overlay 也适用于公式（见「分步推导」）。

### Fragile 帧 (含 verbatim/代码)
```tex
\begin{frame}[fragile]{含代码的帧}
  \begin{scucode}{python}{训练代码}
    model = TransformerModel(d_model=512)
    optimizer = Adam(lr=1e-4)
  \end{scucode}
\end{frame}
```

### Plain 帧 (无页眉页脚)
```tex
\begin{frame}[plain]{}
  \begin{figure}
    \centering
    \includegraphics[width=\textwidth]{image/architecture-full.pdf}
  \end{figure}
\end{frame}
```

### 附录帧
```tex
\appendix
\section{附录}
\begin{frame}{补充实验}
  内容
\end{frame}
```
`\appendix` 后的帧不计入主页码。

---

## 定理/证明环境

共 14 个环境，全部支持 overlay、tcolorbox 选项和 label。

**完整签名**（除 `scuproof` 和 `scuremark` 外）：
```tex
\begin{scu<name>}*[<overlay>][<tcb options>]{<标题>}*[<label后缀>]  % 外侧 *: 无编号; 内侧 *: 抑制"定理x"前缀
  内容
\end{scu<name>}
```

**`scuproof` 和 `scuremark` 签名**（无 `*` 变体）：
```tex
\begin{scuproof}[<overlay>][<tcb options>]{<标题>}[<label后缀>]
  证明内容
\end{scuproof}
```

`scuproof` 末尾自动显示 $\qed$ 符号。

### 完整环境列表

| 环境 | 用途 | 样式 (colorful) | Label 前缀 | 中/英名 |
|------|------|---------|------|------|
| `scutheorem` | 定理 | tcbtheo (蓝) | `theo:` | 定理/Theorem |
| `sculemma` | 引理 | tcblem (绿) | `lemm:` | 引理/Lemma |
| `scucorollary` | 推论 | tcblem (绿) | `coro:` | 推论/Corollary |
| `scuproposition` | 命题 | tcbdef (蓝) | `propo:` | 命题/Proposition |
| `scudefinition` | 定义 | tcbdef (蓝) | `def:` | 定义/Definition |
| `scuproperty` | 性质 | tcbdef (蓝) | `prope:` | 性质/Property |
| `scuexample` | 例子 | tcbexa (灰) | `exam:` | 例/Example |
| `scuremark` | 注记 | tcbexa (灰) | `rema:` | 注/Remark |
| `scualgorithm` | 算法 | tcbexa (灰) | `algo:` | 算法/Algorithm |
| `scuproof` | 证明 | tcbexa (灰) | (无) | 证明/Proof |
| `scuaxiom` | 公理 | tcbtheo (蓝) | `axio:` | 公理/Axiom |
| `scucondition` | 条件 | tcbcond (黄) | `cond:` | 条件/Condition |
| `scuconclusion` | 结论 | tcblem (绿) | `conc:` | 结论/Conclusion |
| `scuassumption` | 假设 | tcbcond (黄) | `assu:` | 假设/Assumption |

### 用法示例

```tex
% 标准用法
\begin{scutheorem}{收敛性定理}
  对于任意初始值 $x_0$，迭代序列收敛到 $x^*$。
\end{scutheorem}

% 无编号 (* 在环境名后, 抑制计数器)
\begin{scutheorem}*{无编号定理}
  内容
\end{scutheorem}

% 抑制前缀 (* 在标题后, 仅显示标题文字)
\begin{scutheorem}{自定义标题}*
  内容
\end{scutheorem}

% 带 overlay
\begin{scuexample}<2->{示例}
  第2页起显示
\end{scuexample}

% 带 tcolorbox 选项
\begin{scudefinition}[]{自定义宽度定义}
  内容
\end{scudefinition}

% 带 label
\begin{scutheorem}{重要定理}[mylabel]
  内容，可用 \cref{theo:mylabel} 引用
\end{scutheorem}

% 证明
\begin{scuproof}
  由 Lipschitz 连续性可得收敛性。
\end{scuproof}
```

颜色由 `BlockDisplay` 控制：`colorful` 各色区分，`followtheme` 跟随主色，`allgrey` 全灰。

---

## 代码环境

### scucode — 内联代码块

**完整签名：**
```tex
\begin{scucode}[<tcb选项>]{<标题>}*[<label后缀>]{<语言>}[<代码选项>]<转义符>
  代码
\end{scucode}
```

- `<tcb选项>`: tcolorbox 参数（如 `sidebyside`、`comment`）
- `*`: 抑制"源码x"编号前缀（计数器仍递增，无编号用 `scucode*` 环境）
- `<label后缀>`: 生成 `code:xx` 形式的 label
- `<代码选项>`: minted/listings 参数（如 `highlightlines=2-4`）
- `<转义符>`: 默认 `||`，在代码中可用 `|LaTeX命令|` 嵌入 LaTeX

```tex
\begin{scucode}{cpp}{核心算法}
  for (int i = 0; i < n; ++i) {
    sum += data[i];
  }
\end{scucode}
```

### scucode* — 无编号版本
```tex
\begin{scucode*}{代码片段}{python}
  print("hello")
\end{scucode*}
```

### scucodeinput — 从文件导入
```tex
\scucodeinput[<tcb选项>]{<标题>}*[<label后缀>]{<语言>}[<代码选项>]{<文件名>}<转义符>
```
文件路径相对于 `./sourcecode/`。

### scucodeinputnocounter — 从文件导入 (无编号)
```tex
\scucodeinputnocounter{标题}{python}{sourcecode/demo.py}
```

代码高亮由 `CodeTheme` 控制：
- `listing`（默认）：listings 宏包，无需额外依赖
- `minted`：minted v3+，自动索引缓存，**无需 `-shell-escape`**
- `minted2`：minted v2 兼容模式，**需要 `-shell-escape` + Python + Pygments**

`MintedStyle` 控制 minted 配色：`lightmode`（默认）/ `darkmode` / 自定义样式名。

---

## 数学公式

### 行内
```tex
质能方程 $E = mc^2$
```

### 行间
```tex
\begin{equation}
  E = mc^2
\end{equation}
```

### 多行对齐
```tex
\begin{align}
  a &= b + c \\
  d &= e + f
\end{align}
```
`\notag` / `\nonumber` 可抑制单行编号。

### 分步推导 (overlay)
```tex
\begin{frame}{推导过程}
  \begin{align}
    \only<1->{L &= -\log p(y|x)} \\
    \only<2->{&= -\sum_i y_i \log \hat{y}_i} \\
    \only<3->{&= -\sum_i y_i \log \frac{e^{z_i}}{\sum_j e^{z_j}}}
  \end{align}
\end{frame}
```

### 证明过程（定理 + 分步展示）
```tex
\begin{frame}{收敛性分析}
  \begin{scutheorem}{收敛性定理}
    对于任意初始值 $x_0$，迭代序列收敛到 $x^*$。
  \end{scutheorem}

  \pause
  \begin{scuproof}{}
    \begin{enumerate}
      \item<2-> 由 Lipschitz 连续性：$|f(x) - f(y)| \leq L|x - y|$
      \item<3-> 构造 Lyapunov 函数 $V(x) = \|x - x^*\|^2$
      \item<4-> 证明 $\Delta V \leq -\alpha V$，其中 $\alpha > 0$
      \item<5-> 由比较原理，$V(x_k) \to 0$，即 $x_k \to x^*$
    \end{enumerate}
  \end{scuproof}
\end{frame}
```

### 长公式换行 (multline)
```tex
\begin{multline}
  首行左对齐 \\
  中间行居中 \\
  末行右对齐
\end{multline}
```

### 单公式对齐 (split)
```tex
\begin{equation}
  \begin{split}
    f(x) &= (a+b)^2 \\
         &= a^2 + 2ab + b^2
  \end{split}
\end{equation}
```

### 分段函数 (dcases)
```tex
\begin{equation}
  f(x) = \begin{dcases}
    x^2 & x \geq 0 \\
    -x  & x < 0
  \end{dcases}
\end{equation}
```
`dcases` 使用 displaystyle（需 `mathtools`），与 `cases`（textstyle）不同。

### 矩阵
```tex
\begin{equation}
  \mathbf{A} = \begin{pmatrix}
    a_{11} & a_{12} \\
    a_{21} & a_{22}
  \end{pmatrix}
\end{equation}
```

数学字体由 `MathFont` 控制：`LM`（Latin Modern Math，默认）或 `XITS`（XITS Math）。

---

## 图片

主题预设的图片搜索路径（`graphicspath`）：`image/`, `images/`, `figure/`, `figures/`, `resources/`

### 单图
```tex
\begin{frame}{实验结果}
  \begin{figure}
    \centering
    \includegraphics[width=0.8\textwidth]{result.pdf}  % 无需写 image/
    \caption{不同方法的性能对比}
  \end{figure}
\end{frame}
```

### 并排图
```tex
\begin{frame}{可视化对比}
  \begin{columns}[T]
    \begin{column}{.48\textwidth}
      \centering
      \includegraphics[width=\textwidth]{before.pdf}
      \structure{处理前}
    \end{column}
    \begin{column}{.48\textwidth}
      \centering
      \includegraphics[width=\textwidth]{after.pdf}
      \structure{处理后}
    \end{column}
  \end{columns}
\end{frame}
```

---

## 表格

**三线表**（`booktabs`，有编号，适合数据对比，表格宽度应 ≥ 0.5`\textwidth`，过窄时可用 `w{c}{宽度}` 或 `p{宽度}` 固定列宽）：
```tex
\begin{table}
  \centering
  \begin{tabular}{lccc}
    \toprule
    方法 & BLEU-4 & CIDEr & SPICE \\
    \midrule
    Baseline & 34.1 & 112.5 & 21.3 \\
    本文方法 & \alert{38.2} & \alert{121.3} & \alert{24.8} \\
    \bottomrule
  \end{tabular}
\end{table}
```

**布局表**（无编号，`\midrule` 分隔表头，适合参数对照）：
```tex
\begin{tabular}{r|l}
  选项 & 说明 \\
  \midrule
  ColorDisplay & 配色方案 \\
  LanguageMode & 语言模式 \\
\end{tabular}
```

列格式：`l`(左)、`c`(中)、`r`(右)、`p{宽度}`(定宽)、`m{宽度}`(垂直居中)、`w{l}{宽度}`(固定宽度)。合并：`\multicolumn{n}{格式}{内容}`、`\multirow{n}{*}{内容}`。

---

## 参考文献

主题内置 `biblatex` + `biber` + GB/T 7714-2015（`BIBMode=biber` 时）。

```tex
% 脚注引用（推荐用于 slides）：
详见 \footfullcite{key2024}

% 脚注引用（带自定义编号）：
\footnotemark
\footfullcitetext[1]{key2024}

% 正文引用：
如文献 \cite{key2024} 所述

% 打印全部引用：
\nocite{*}

% 末尾文献列表（可选，slides 通常不需要）：
\printbibliography
```

文献库在主文件 `\addbibresource{ref.bib}` 指定。`BIBMode=none` 可禁用。

---

## 交叉引用

| 命令 | 输出 | 适用场景 |
|------|------|---------|
| `\ref{label}` | 编号 | 定理、公式、图表 |
| `\cref{label}` | 类型+编号 | 推荐，自动加"定理"/"图"等前缀 |
| `\crefrange{label1}{label2}` | 类型+编号范围 | 引用连续编号范围 |
| `\vref{label}` | 标题+页码 | 含页码跳转 |
| `\pageref{label}` | 页码 | 注意：主题已同步为帧编号 |
| `\nameref{label}` | 标题 | |

Label 前缀约定：`theo:`(定理)、`fig:`(图)、`eq:`(公式)、`code:`(代码)

---

## 文本强调

| 命令 | 效果 |
|------|------|
| `\structure{文字}` | 结构强调（跟随 PrimaryC），支持 overlay：`\structure<2->{文字}` |
| `\alert{文字}` | 警示强调（跟随 AlertedTextC），支持 overlay：`\alert<2->{文字}` |
| `\emph{文字}` | 中文模式下默认下划线，英文模式下默认斜体 |
| `\textbf{文字}` | 粗体 |
| `\textit{文字}` | 斜体 |
| `\texttt{文字}` | 等宽 |

---

> **相关模块**：[workflow.md](workflow.md)（任务流程）| [mwe.md](mwe.md)（完整 MWE）| [typography.md](typography.md)（排版规则）| [config-overview.md](config-overview.md)（配置速查）| [customization.md](customization.md)（高级定制）| [troubleshooting.md](troubleshooting.md)（问题排查）| [入口 SKILL.md](../SKILL.md)
