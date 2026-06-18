# 任务工作流

## 标题页配置

### 命令说明

```tex
\title[页脚短标题]{封面完整标题}   % 方括号=页脚显示，花括号=封面显示
\subtitle{副标题}                  % 仅封面显示，不出现在页脚
\author[页脚作者]{封面作者}        % 多作者用 \inst{} + \and
\institute{机构}                   % 多机构用 \inst{} + \and
\date{\today}
```

如需页脚显示副标题，放在 `\title` 的可选参数中：
```tex
\title[主标题 | 副标题]{封面完整标题}
```

### 多作者 + 多机构

```tex
\author[张三, 李四]{%
  张三\inst{1}\inst{a} \and 李四\inst{2}\inst{b}%
}
\institute{%
  \inst{1} 四川大学计算机学院
  \vspace*{-6pt} \and
  \inst{2} ~Management Science, Business School
  \vspace*{-6pt} \and
  \inst{a} ~\textit{zhangsan@scu.edu.cn}
  ~\inst{b} ~\textit{lisi@scu.edu.cn}%
}
```

- `\inst{}` 标注机构/邮箱编号，`\and` 分隔作者
- `\vspace*{-6pt}` 消除 `\and` 产生的多余间距
- 英文文本前用 `~` 避免间距问题
- 机构和邮箱可分开为不同 `\inst` 编号

---

## 任务 1：论文/报告 → Slides 转换

### 流程

1. **读取源文档** — 分析结构：`\section`、`\subsection`、正文段落、公式、图表、参考文献
2. **提取要点** — 每个 section/subsection 提炼核心要点（见 typography.md 压缩策略）
3. **规划帧结构** — 遵循排版规则（见 typography.md）
4. **生成代码** — 按照模板生成 beamer-scu 代码（见 templates.md）
5. **处理特殊内容** — 公式、图表、代码、参考文献的转换

> 任务完成后询问用户是否执行**任务 4**（编译日志溢出检测与修复）。

### 转换原则

| 源文档元素 | Slides 处理 |
|-----------|------------|
| 背景/动机段落 | 压缩为短语句 + 要点列表 |
| **核心定理/命题** | **完整保留**，使用 `scutheorem` 等环境 |
| **证明/推导过程** | **保留关键步骤**，用 overlay `<n->` 逐步揭示，不要省略为结论 |
| 长公式 | 分步展示 (overlay `<n->`)，推导过程保留中间步骤 |
| 大表格 | 保留完整数据，拆分为多个表或分帧展示 |
| 多图 | `columns` 并排 |
| 参考文献 | `\footfullcite{}` 脚注式引用 |
| 算法伪代码 | `scualgorithm` 环境 |
| 实验结果 | 保留核心指标，用 `\alert{}` 高亮最优值 |

> **重要**：理论推导和证明过程是论文的核心贡献，转换时应保留完整逻辑链，而非仅给出最终结论。用 `\pause` 或 `<n->` 逐步展示推导步骤，既保持可读性又不丢失理论完整性。

### 章节文件组织

建议将内容按章节拆分到 `include-sec/` 目录：

```
include-sec/
├── sec-introduction.tex
├── sec-method.tex
├── sec-result.tex
└── sec-conclusion.tex
```

主文件中用 `\include{include-sec/sec-introduction}` 引入。

`\include` vs `\input`：
- `\include` 自动 `\clearpage`，适合章节级，支持 `\includeonly` 选择性编译
- `\input` 直接嵌入不分页，适合小片段

每个章节文件只需帧内容，无需 `\documentclass` 和 `\begin{document}`：
```tex
% include-sec/sec-introduction.tex
\section{引言}
\subsection{背景}
\begin{frame}{研究背景}
  内容
\end{frame}
```

---

## 任务 2：从零创建 Slides

向用户确认以下信息，再选择配置并生成代码：

| 问题 | 影响的配置 |
|------|-----------|
| 主题/标题？ | `\title`, `\author` |
| 语言？ | `LanguageMode` (cn/en) |
| 预计时长？ | 决定帧数 (1-2 分钟/帧) |
| 配色偏好？ | `ColorDisplay` (红/蓝/自定义) |
| 是否有代码？ | `CodeTheme` (listing/minted) |
| 是否有参考文献？ | `BIBMode` (biber/none) |
| 幻灯片比例？ | `aspectratio` (169/1610/43) |

> 任务完成后询问用户是否执行**任务 4**（编译日志溢出检测与修复）。

---

## 任务 3：修改已有 Slides

读取用户的 `.tex` 文件，识别当前配置，按需修改。

- **改配置**：修改 `\usetheme[...]{scu}` 中的选项
- **加帧**：在合适位置插入新 `\begin{frame}...\end{frame}`
- **改样式**：修改 Block 颜色、导航、背景等
- **加动画**：为已有帧添加 overlay `<n->` 或 `\pause`
- **修复问题**：参见 troubleshooting.md

> 任务完成后询问用户是否执行**任务 4**（编译日志溢出检测与修复）。

---

## 任务 4：编译日志溢出检测与修复

编译后读取日志、检测溢出、逐条修复。检测规则与修复策略见 troubleshooting.md "Overfull hbox/vbox 溢出"。

### 流程

1. **编译** — `latexmk <file>.tex`
2. **定位日志** — 按以下优先级查找编译日志：
   - 默认路径：`tmp/build/<file>.log`（本项目的 `.latexmkrc` 设定 `$aux_dir = 'tmp/build'`）
   - 若不存在：读取 `.latexmkrc`，从 `$aux_dir` 获取实际的辅助文件目录
   - 若项目无 `.latexmkrc`：在项目根目录下搜索 `<file>.log`
3. **提取溢出** — 匹配 `Overfull \hbox` / `Overfull \vbox`，提取溢出量和行号
4. **过滤** — 溢出量 ≤ 3pt → 跳过；> 3pt → 需修复
5. **修复** — 按 troubleshooting.md 中的修复策略逐条处理
6. **重编译验证** — 重新编译确认溢出消除

---

> **相关模块**：[config-overview.md](config-overview.md)（配置速查）| [config-detail.md](config-detail.md)（选项详情）| [templates.md](templates.md)（代码模板）| [mwe.md](mwe.md)（完整 MWE）| [typography.md](typography.md)（排版规则）| [customization.md](customization.md)（高级定制）| [troubleshooting.md](troubleshooting.md)（问题排查）| [入口 SKILL.md](../SKILL.md)
