# 问题排查

## 常见问题

### 页眉/页脚/页码不显示
**原因**：首次编译或新增帧。
**解决**：再次编译。主题 latexmk 配置 `max_repeat=1`（单次编译），需手动多次运行 `latexmk`。非最终版本可忽略此问题。

### 参考文献列表为空
**原因**：biber 未运行。
**解决**：手动运行 `biber main` 后再编译。或在编辑器中配置编译顺序为 XeLaTeX → Biber → XeLaTeX → XeLaTeX。

### `#` 字符报错
**原因**：正文中 `#` 未转义。
**解决**：正文用 `\#`；`\newcommand` 中用 `##1`。

### `\verb` 命令报错
**原因**：帧缺少 `fragile` 选项。
**解决**：`\begin{frame}[fragile]{标题}`。或在帧前使用 `\cprotEnv`（来自 `cprotect` 宏包，需先 `\usepackage{cprotect}`）。

### minted 编译报错
**原因**：
- minted v2：缺少 Python 或 Pygments，需要 `-shell-escape`
- minted v3：通常不需要 `-shell-escape`，检查 TeX Live 版本

**解决**：
1. 确认 TeX Live >= 2024（使用 minted v3）
2. 如使用 minted v2：安装 Python + `pip install Pygments`，传递 `-shell-escape`
3. 或改用 `CodeTheme=listing`（无需额外依赖）

### Tab 字符显示为 `^^I`
**原因**：代码中的 Tab 字符被转义。
**解决**：在 latexmk 配置中添加 `-8bit` 参数（已有默认配置），或手动转换 Tab 为空格。

### 交叉引用错误
**原因**：编译次数不够。
**解决**：多次运行 latexmk，或修改 `.latexmkrc` 中 `$max_repeat`。

### Overleaf 编译超时
**原因**：在线平台编译时间限制。
**解决**：本地编译；或用 `draft` 模式加速；或上传完整工作文件夹。

### 色彩偏移
**原因**：未加载 CMYK 颜色模式。
**解决**：确保有 `\PassOptionsToPackage{cmyk}{xcolor}` 在 `\documentclass` 之前。

### `\pageref` 显示的不是帧编号
**原因**：`\pageref` 返回 PDF 页码，而非帧编号。
**解决**：主题已通过 `\AtBeginEnvironment` 将 `page` 计数器同步为 `framenumber`，正常使用 `\pageref` 即可。如仍有问题，检查是否有多余的 `\setcounter{page}` 干扰。

### Overfull hbox/vbox 溢出

编译后扫描 `.log` 文件（路径：`tmp/build/<file>.log`），检测溢出警告。

**日志格式：**
```
Overfull \hbox (15.2pt too wide) in paragraph at lines 100--105
Overfull \vbox (30.0pt too high) in paragraph at lines 200--210
```

**阈值：≤ 3pt 的溢出忽略**（屏幕上不可见），仅修复 > 3pt 的溢出。

提取规则：
1. 匹配 `Overfull \\hbox` 或 `Overfull \\vbox`
2. 提取括号中的溢出量（如 `15.2pt`）
3. 提取 `at lines X--Y` 定位源文件行号
4. 溢出量 > 3pt → 需修复；≤ 3pt → 跳过

**水平溢出修复：**

| 溢出内容 | 修复方式 |
|----------|---------|
| 文本行过长 | 缩短文字、拆分为多行要点、或加 `\small` / `\footnotesize` |
| 图片过宽 | 设 `width=\linewidth` 或 `width=0.8\textwidth` |
| 表格过宽 | `\resizebox{\linewidth}{!}{\begin{tabular}...\end{tabular}}` |
| 列宽溢出 | 减小各列宽度，确保和 < `\textwidth`（如 `.45+.45`） |
| URL 过长 | 用 `\url{}` 或 `\path{}`，加 `\sloppy` |
| 公式过长 | `split` / `multline` / `aligned` 换行 |
| 嵌套列表缩进 | 减少嵌套层级（最多 2 层） |

**垂直溢出修复：**

| 溢出内容 | 修复方式 |
|----------|---------|
| 单帧内容过多 | 手动拆分为多帧，标题加序号 `标题 (1/N)`（参考文献帧可用 `allowframebreaks`） |
| 图片过高 | `height=0.6\textheight` 限制高度 |
| 公式 + 文字挤占 | 公式独占帧，或 overlay `<n->` 分步展示 |

---

## latexmk 配置要点

| 配置 | 值 | 说明 |
|------|-----|------|
| `$pdf_mode` | `5` | xelatex + xdvipdfmx 两步 |
| `$aux_dir` | `tmp/build` | 辅助文件目录 |
| `$max_repeat` | `1` | 单次编译（交叉引用需重编） |
| `$go_mode` | `3` | 强制至少编译一次 |
| `$force_mode` | `1` | 遇错继续 |
| `shell-escape` | 默认注释 | minted v3 不需要；v2 需要取消注释 |

---

> **相关模块**：[config-overview.md](config-overview.md)（配置速查）| [workflow.md](workflow.md)（任务流程）| [templates.md](templates.md)（代码模板）| [mwe.md](mwe.md)（完整 MWE）| [typography.md](typography.md)（排版规则）| [customization.md](customization.md)（高级定制）| [入口 SKILL.md](../SKILL.md)
