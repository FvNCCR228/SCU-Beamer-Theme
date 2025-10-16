# 四川大学Beamer模板

本项目参考了Beamer, Tcolorbox等官方文档, 参考了stackoverflow中的诸多问题；

主要参考了中国科学技术大学Beamer模板 [USTCBeamerSX](https://github.com/ysx2000/USTCBeamerSX/), 少量参考了清华大学Beamer模板 [THU-Beamer-Theme](https://github.com/tuna/THU-Beamer-Theme/) 及其衍生的各大学的Beamer模板, 还参考了中国科学技术大学Beamer模板 [ustcbeamer](https://github.com/ustctug/ustcbeamer/).


## 项目地址

-GitHub: https://github.com/FvNCCR228/SCU-Beamer-Theme

-Gitee: https://gitee.com/NCCR/SCU_Beamer_Slide-demo

![image](https://github.com/FvNCCR228/SCU_Beamer_Slide-demo/assets/94803387/84aeb3c5-b9d1-4f61-93fc-6fefa083be8c) ![image](https://github.com/FvNCCR228/SCU_Beamer_Slide-demo/assets/94803387/3c5e7015-a932-43c1-a5a0-81ed77ccdbfb)




## 使用说明

!! 请使用 `UTF-8` 格式, 设置 `XeLaTeX`和 `Biber` 进行编译( `main.tex` 或 `manual.tex` );

!! 使用前请阅读用户手册;
			
在线编辑请上传整个工作文件夹, 否则会出现严重错误(Bug遍地飞);
			
!! 对 LaTeX 不熟悉的情况下, 请勿轻易改动 `.sty` 文件(宏包文件)中代码, 也可按照文件中注释进行实验性修改(注意保留备份);

目前本模板仅在编者的 Windows 11 系统上编译通过, Overleaf 编译失败(不是完全失败, 我很伤心);

使用 LaTeX 时一定要善用搜索引擎, 要积极搜索国外论坛.


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
