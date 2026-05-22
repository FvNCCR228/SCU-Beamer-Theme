#!/bin/bash
set -e

# 配置目标分支和文件列表
TARGET_BRANCH="manual"
FILES=("manual-sec/" "manual.tex")

CURRENT_BRANCH=$(git branch --show-current)

# 切换到目标分支并从原分支获取文件
git checkout "$TARGET_BRANCH"
git restore --source "$CURRENT_BRANCH" "${FILES[@]}"

echo "Done! Files copied to $TARGET_BRANCH"
echo "Commit changes! Then run \`git checkout $CURRENT_BRANCH\` to switch back"
