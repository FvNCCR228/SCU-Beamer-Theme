#!/bin/bash
set -e

# get-manual-tex.sh: 从 SCU Beamer Theme 仓库 manual 分支
#                    获取用户手册的 LaTeX 文件

# 配置原分支和文件列表
SOURCE_BRANCH="manual"
FILES=("manual-sec/" "manual.tex" "tmp/build/manual-sec/")

# 从原分支获取文件
git restore --source "$SOURCE_BRANCH" "${FILES[@]}"
echo "Done! Manual TeX Files copied from branch $SOURCE_BRANCH"
