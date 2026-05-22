#!/bin/bash
set -e

# 用法: ./install-plugin.sh -e <插件名> [-nogit]
# 示例: ./install-plugin.sh -e example
# 列表: ./install-plugin.sh -l
# 搜索: ./install-plugin.sh -s <关键词>

# 颜色
GREEN='\033[0;32m'
NC='\033[0m'

# 配置
# 插件 | PLUGINS[插件名]="仓库(用户/仓库) 分支"
# 设置 | FILES[插件名]="文件1 文件2 文件3"
# 格式 | NAME[插件名]="插件显示名称"
declare -A PLUGINS
declare -A FILES
declare -A NAME

# 插件: 示例 - example
PLUGINS[example]="user/repo main"
FILES[example]="file1.sty file2.tex"
NAME[example]="示例插件"

# 插件: 新三国天意爷主题 - TianYiYe
PLUGINS[TianYiYe]="FvNCCR228/SCU-Beamer-Theme main"
FILES[TianYiYe]="main.pdf fonts/README.md"
NAME[TianYiYe]="新三国天意爷主题"

# 继续添加更多插件
# PLUGINS[xxx]="user/repo main"
# FILES[xxx]="file1.sty file2.tex"
# NAME[xxx]="插件显示名称"

# ----------------------------------------

# 解析参数
PLUGIN_NAME=""
NOGIT=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -e)
            if [[ -z "$2" ]] || [[ "$2" == -* ]]; then
                echo "错误: -e 选项需要指定插件名"
                exit 1
            fi
            PLUGIN_NAME="$2"
            shift 2
            ;;
        -l)
            echo "可用插件:"
            for key in "${!PLUGINS[@]}"; do
                echo "  $key - ${NAME[$key]}"
            done
            exit 0
            ;;
        -s)
            echo "搜索结果:"
            for key in "${!PLUGINS[@]}"; do
                if [[ "$key" == *"$2"* ]] || [[ "${NAME[$key]}" == *"$2"* ]]; then
                    echo "  $key - ${NAME[$key]}"
                fi
            done
            exit 0
            ;;
        -nogit)
            NOGIT=true
            shift
            ;;
        *)
            echo "用法:"
            echo "  $0 -e <插件名> [-nogit] 安装插件"
            echo "  $0 -l 列出所有插件"
            echo "  $0 -s <关键词> 搜索插件"
            exit 1
            ;;
    esac
done

if [ -z "$PLUGIN_NAME" ]; then
    echo "错误: 请指定插件名"
    echo "用法:"
    echo "  $0 -e <插件名> [-nogit] 安装插件"
    echo "  $0 -l 列出所有插件"
    echo "  $0 -s <关键词> 搜索插件"
    exit 1
fi

# 检查插件是否存在
if [ -z "$PLUGIN_NAME" ] || [ -z "${PLUGINS[$PLUGIN_NAME]}" ] || [ -z "${FILES[$PLUGIN_NAME]}" ] || [ -z "${NAME[$PLUGIN_NAME]}" ]; then
    echo "错误: 插件 '$PLUGIN_NAME' 不存在或配置不完整"
    echo "请运行:"
    echo "  $0 -l 列出所有插件"
    echo "  $0 -s <关键词> 搜索插件"
    exit 1
fi

# 解析仓库信息
read -r REPO BRANCH <<< "${PLUGINS[$PLUGIN_NAME]}"
FILE_LIST="${FILES[$PLUGIN_NAME]}"

# 检查是否可用 git
USE_GIT=false
if [ "$NOGIT" = false ] && command -v git &> /dev/null; then
    USE_GIT=true
fi

echo -e "${GREEN}正在从 $REPO 下载插件 '${NAME[$PLUGIN_NAME]}'..., 包含文件: $FILE_LIST${NC}"

# 缓存目录
CACHE_DIR="./tmp/plug/plug-$PLUGIN_NAME"
mkdir -p "$CACHE_DIR"

# 下载到缓存目录
if [ "$PLUGIN_NAME" != "example" ]; then
    if [ "$USE_GIT" = true ]; then
        # 使用 git sparse-checkout 下载
        echo -e "${GREEN}使用 git 下载...${NC}"
        TEMP_DIR=$(mktemp -d)
        ORIGINAL_DIR=$(pwd)
        git clone --depth 1 --filter=blob:none --sparse "https://github.com/$REPO" "$TEMP_DIR"
        cd "$TEMP_DIR"
        git sparse-checkout set $FILE_LIST
        cd "$ORIGINAL_DIR"
        for item in $FILE_LIST; do
            mkdir -p "$CACHE_DIR/$(dirname "$item")"
            cp "$TEMP_DIR/$item" "$CACHE_DIR/$item"
        done
        rm -rf "$TEMP_DIR"
    else
        # 使用 curl 下载
        echo -e "${GREEN}使用 curl 下载...${NC}"
        for item in $FILE_LIST; do
            url="https://raw.githubusercontent.com/$REPO/$BRANCH/$item"
            dest="$CACHE_DIR/$item"

            echo -e "  下载 $item..."
            mkdir -p "$(dirname "$dest")"
            curl -sL "$url" -o "$dest"
        done
    fi
else
    # 示例模式
    for item in $FILE_LIST; do
        url="https://raw.githubusercontent.com/$REPO/$BRANCH/$item"
        dest="$CACHE_DIR/$item"

        echo -e "  下载 $item... curl -sL $url -o $dest"
        mkdir -p "$(dirname "$dest")"
    done
fi

echo -e "${GREEN}下载完成!${NC}"

# 复制到工作目录（项目根目录）
WORK_DIR="$(pwd)"
echo -e "${GREEN}正在复制文件到工作目录 $WORK_DIR...${NC}"

for item in $FILE_LIST; do
    src="$CACHE_DIR/$item"
    dest="$WORK_DIR/$item"

    mkdir -p "$(dirname "$dest")"
    if [ -f "$dest" ]; then
        echo -e "${GREEN}冲突: $dest 已存在${NC}"
        read -p "保留哪个？(1=现有文件 2=新文件): " choice
        if [ "$choice" = "2" ]; then
            cp "$src" "$dest"
            echo -e "${GREEN}已覆盖 $dest${NC}"
        else
            echo -e "${GREEN}保留现有文件 $dest${NC}"
        fi
    else
        cp "$src" "$dest"
    fi
done

echo -e "${GREEN}插件 '${NAME[$PLUGIN_NAME]}' 安装完成!${NC}"

# 提示是否删除缓存目录
read -p "是否删除缓存目录 $CACHE_DIR?(y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -rf "$CACHE_DIR"
    echo -e "${GREEN}已删除 $CACHE_DIR${NC}"
fi
