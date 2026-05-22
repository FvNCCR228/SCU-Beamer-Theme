#!/bin/bash
set -e

# 配置原分支和文件列表
SOURCE_BRANCH="manual"
FILES=("manual-sec/" "manual.tex")

# 从原分支获取文件
git restore --source "$SOURCE_BRANCH" "${FILES[@]}"

echo "Done! Files copied from $SOURCE_BRANCH"
