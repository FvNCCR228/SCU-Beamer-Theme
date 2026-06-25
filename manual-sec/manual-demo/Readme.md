# 处理pdf页面（处理pdf页面对应的对象）

1. Inkscape. 选中选区(不是背景图片) -> 编辑-制作一个位图副本 -> 图层与对象-将位图副本移动至裁剪组中（如果是插入的对象）-隐藏初始的背景原图

2. Inkscape. 导出-图像大小-DPI40-导出pdf格式

xx 1. Acrobat. 导出压缩 pdf -> Inkscape. 导出-图像大小-DPI40-导出pdf格式

# 裁剪对象

Inkscape. 绘制矩形 -> 设置xy、宽、高（如设置125pt） -> 剪切组

# 示例内容
**inkscape 1.5(dev)**

## `base-settings-authors-1.pdf` `base-settings-authors-2.pdf`
1. 右键 pdf → inkscape 打开
2. 内部导入 →  "Clip to 无" - "分组依据 PDF 对象" - "绘制所有文本" → 导入
3. 删除最后一个图像(多余背景)
4. 选中当前背景图像 → 编辑 - 制作一个位图副本(ALT+B) → 删除原图像
5. 选中 landmark 图像 → 编辑 - 制作一个位图副本(ALT+B) → 删除原图像
6. 文件 - 清理文档 → 文件 - 导出 → 自定义 → "DPI 40" - "将文字转换为路径" → 导出(Cario)
(可用 Acrobat 再减小大小)

## `appendix-themescu-ColorDisplay-1.pdf` `appendix-themescu-ColorDisplay-2.pdf`
1. 右键 pdf → inkscape 打开
2. 内部导入 →  "Clip to 无" - "分组依据 PDF 对象" - "绘制所有文本" "页面 all" → 导入
3. 页面 1,2 删除最后一个图像(多余背景)
4. 页面 1-4 选中当前背景图像 → 编辑 - 制作一个位图副本(ALT+B) → 删除原图像
5. 页面 1 选中 landmark 图像 → 编辑 - 制作一个位图副本(ALT+B) → 删除原图像
6. 选中每个页面 宽缩小 1/2(即 64 mm) → 设置每个页面的 xy 值 → 制作 4 宫格
7. 文件 - 清理文档 → 文件 - 导出 → 自定义 → "DPI 40" - "将文字转换为路径" → 导出(Cario)
(可用 Acrobat 再减小大小)

##
1. 右键 pdf → inkscape 打开
2. 内部导入 →  "Clip to 无" - "分组依据 PDF 对象" - "绘制所有文本" "页面1" → 导入
% inkscape 导入单页 pdf 且转换背景为位图后, (1)每个对象宽缩小 1/2(即 181.414). (2)设置 5 个对象的 y 值分别为 0, 60, 120, 180, 210. (3)点击导出选项卡 - 自定义, 右 181.414, 底部 240, 单位 pt, DPI 40, 导出为 PDF.