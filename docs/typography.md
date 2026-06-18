# 排版规则

## 帧结构规则

- **每帧 1-2 分钟**，一个 15 分钟报告约 10-15 帧
- **每帧一个核心观点**，不超过 3-4 个要点
- **要点列表**优于长段落，使用 `\begin{itemize}` 或 `\begin{enumerate}`
- **标题简洁**，5-10 字以内
- 每个 `\section` 下应有 `\subsection`（主题在 `\AtBeginSubsection` 自动生成小节目录帧）
- **避免 `allowframebreaks`**（参考文献等自动生成内容除外）— 自动分帧会在任意位置截断，应手动拆分并标注序号：
  ```tex
  % 内容帧：手动拆分
  \begin{frame}{实验结果 (1/3)}
    % 第一部分
  \end{frame}
  \begin{frame}{实验结果 (2/3)}
    % 第二部分
  \end{frame}

  % 参考文献：可用 allowframebreaks
  \begin{frame}[allowframebreaks]{文献目录}
    \nocite{*}
    \printbibliography[heading=none]
  \end{frame}
  ```

## 内容密度上限

| 元素 | 上限 | 超出时处理 |
|------|------|-----------|
| Bullet 条目/帧 | 5-6 条 | 拆分为 2 帧 |
| 公式行数/帧 | 3-4 行 | 分帧或用 `<n->` overlay |
| 表格 | 列数或行数较多时 | 保留完整数据，考虑拆分为多个表、分帧展示、或用图表替代 |
| 代码行数/帧 | 15 行 | 用 `\scucodeinput` 或分帧 |

## 内容压缩策略

### 压缩分级

并非所有内容都适合同等程度压缩。按重要性分为三级：

| 级别 | 内容类型 | 压缩方式 |
|------|---------|---------|
| **保留** | 核心定理/命题/引理、证明推导、关键公式、算法 | 完整保留，用定理环境 + overlay 逐步展示 |
| **适度压缩** | 方法描述、实验设计、相关工作 | 保留关键术语，删去解释性文字，转为要点 |
| **大幅压缩** | 背景介绍、动机论述、文献综述 | 短语句 + 符号替代，仅保留核心观点 |

> **核心原则**：论文的理论贡献（定理、证明、推导）是 slides 的核心内容，**不可省略为结论**。应保留完整逻辑链，用 `<n->` 分步展示推导过程。

### 段落 → 要点（示例）

以下展示如何将论文段落压缩为 slides 要点：

**原始段落示例：**
> 近年来，基于深度学习的目标检测方法取得了显著进展。传统的目标检测方法通常采用两阶段流程，首先通过区域提议网络（Region Proposal Network, RPN）生成候选区域，然后对每个候选区域进行分类和回归。然而，这类方法存在推理速度较慢的问题，难以满足实时检测的需求。为此，研究者们提出了一系列单阶段检测方法，如 YOLO 和 SSD，这些方法直接在特征图上进行预测，大幅提升了检测速度。尽管如此，单阶段方法在小目标检测和密集场景下的精度仍然不如两阶段方法。本文提出了一种改进的特征金字塔网络（Feature Pyramid Network, FPN），通过引入自适应特征融合模块和多尺度注意力机制，在保持单阶段检测速度优势的同时，显著提升了小目标检测精度。在 COCO 数据集上的实验结果表明，本文方法在 AP 指标上达到了 52.3，较基线方法提升了 3.7 个百分点，同时推理速度保持在 45 FPS。

**Slides 压缩（短语句 + 要点结合）：**
```tex
目标检测的核心矛盾：两阶段方法精度高但推理慢，单阶段方法快但小目标检测精度不足。
\begin{itemize}
  \item 两阶段：RPN 生成候选区域 → 逐区域分类回归
  \item 单阶段：YOLO / SSD 直接在特征图上预测
\end{itemize}
本文改进特征金字塔网络 (FPN)，在保持速度优势的同时提升小目标精度：
\begin{itemize}
  \item 自适应特征融合模块：动态调整多层特征权重
  \item 多尺度注意力机制：增强小目标特征响应
\end{itemize}
COCO 数据集结果：AP 达到 \alert{52.3}（+3.7），推理速度 45 FPS。
```

### 压缩技巧（适用于"适度压缩"和"大幅压缩"内容）

- 去掉连接词（"具体而言"、"然后"、"因此"）
- 用符号替代文字（`→` 替代 "映射到"、`$\leftrightarrow$` 替代 "与...之间的"）
- 保留关键术语，删除解释性文字
- 数值结果只保留最终指标，不保留推导过程
- 引用只保留第一作者 + 年份

## 章节组织规则

- `\section` = 主要章节
- `\subsection` = 小节
- 主题自动在每个 `\subsection` 开始处生成小节目录帧
- `\appendix` 后的内容不计入主页码

## 宽度引用

- `\textwidth` — 整页文本区宽度
- `\linewidth` — 当前行/列宽度（在 `columns` 环境中等于列宽，而非整页宽度）

双栏布局中图片宽度用 `\linewidth` 即可自适应列宽。

## 中英混排间距

中英文之间加 `~`（不换行空格）防止断行：
```tex
使用 Transformer~模型进行特征提取
```

## 字体大小规则

主题预设了各元素的字号，一般无需手动调整：

| 元素 | 字号 |
|------|------|
| 帧标题 | `\large\bfseries` |
| 帧副标题 | `\scriptsize\bfseries` |
| 封面标题 | `\LARGE\bfseries` |
| 封面副标题 | `\small\bfseries` |
| 作者 | `\small\bfseries` |
| 日期 | `\footnotesize\bfseries` |

手动调整字号（建议范围 `\footnotesize` 到 `\Large`）：
`\tiny` `\scriptsize` `\footnotesize` `\small` `\normalsize` `\large` `\Large` `\LARGE` `\huge` `\Huge`

---

> **相关模块**：[templates.md](templates.md)（代码模板）| [mwe.md](mwe.md)（完整 MWE）| [workflow.md](workflow.md)（任务流程）| [config-overview.md](config-overview.md)（配置速查）| [customization.md](customization.md)（高级定制）| [troubleshooting.md](troubleshooting.md)（问题排查）| [入口 SKILL.md](../SKILL.md)
