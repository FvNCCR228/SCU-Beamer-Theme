#!/bin/bash
set -e

# push-manual-tex.sh: 将用户手册的 LaTeX 文件推送到
#                     SCU Beamer Theme 仓库 manual 分支

# 配置工作树目录和文件列表
WORKTREE_DIR="../worktree-manual"
FILES=("manual-sec/" "manual.tex" "tmp/build/manual-sec/")

# 同步文件到工作树目录
for item in "${FILES[@]}"; do
    rsync -a "$item" "$WORKTREE_DIR/$item"
done
echo "Done! Manual TeX Files copied to worktree $WORKTREE_DIR"
