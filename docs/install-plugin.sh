#!/bin/bash
set -e

# install-plugin.sh: SCU Beamer Theme 扩展主题插件安装脚本
#                    支持从 GitHub 仓库下载指定文件到项目中
# 用法: ./install-plugin.sh -e <插件名> [-nogit]
# 示例: ./install-plugin.sh -e example
# 列表: ./install-plugin.sh -l
# 搜索: ./install-plugin.sh -s <关键词>

# ----------------------------------------
# 颜色
# ----------------------------------------

GREEN='\033[0;32m'
NC='\033[0m'

# ----------------------------------------
# 加载插件配置
# ----------------------------------------

declare -A PLUGINS
declare -A BRANCHES
declare -A FILES
declare -A NAME

# 从同目录下的 plugins.conf 加载插件配置 (INI 格式)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)" || SCRIPT_DIR="."
CONF_FILE="$SCRIPT_DIR/dev/plugins.conf"

load_plugins() {
    if [ ! -f "$CONF_FILE" ]; then
        echo "错误: 配置文件 $CONF_FILE 不存在"
        exit 1
    fi
    local section=""
    while IFS='=' read -r key value; do
        # 跳过空行和注释
        [[ -z "$key" || "$key" =~ ^[[:space:]]*# ]] && continue
        # 去除首尾空白
        key="${key#"${key%%[![:space:]]*}"}"
        key="${key%"${key##*[![:space:]]}"}"
        # 解析 section [name]
        if [[ "$key" =~ ^\[(.*)\]$ ]]; then
            section="${BASH_REMATCH[1]}"
            continue
        fi
        [[ -z "$section" ]] && continue
        # 去除 value 首尾空白
        value="${value#"${value%%[![:space:]]*}"}"
        value="${value%"${value##*[![:space:]]}"}"
        case "$key" in
            repo) PLUGINS["$section"]="$value" ;;
            branch) BRANCHES["$section"]="$value" ;;
            files) FILES["$section"]="$value" ;;
            name) NAME["$section"]="$value" ;;
        esac
    done < "$CONF_FILE"
}

load_plugins

# ----------------------------------------
# 解析参数
# ----------------------------------------

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

# ----------------------------------------
# 校验插件
# ----------------------------------------

if [ -z "$PLUGIN_NAME" ] || [ -z "${PLUGINS[$PLUGIN_NAME]}" ] || [ -z "${BRANCHES[$PLUGIN_NAME]}" ] || [ -z "${FILES[$PLUGIN_NAME]}" ] || [ -z "${NAME[$PLUGIN_NAME]}" ]; then
    echo "错误: 插件 '$PLUGIN_NAME' 不存在或配置不完整"
    echo "请运行:"
    echo "  $0 -l 列出所有插件"
    echo "  $0 -s <关键词> 搜索插件"
    exit 1
fi

REPO="${PLUGINS[$PLUGIN_NAME]}"
BRANCH="${BRANCHES[$PLUGIN_NAME]}"
FILE_LIST="${FILES[$PLUGIN_NAME]}"

# ----------------------------------------
# 下载插件文件
# ----------------------------------------

# 检查是否可用 git
USE_GIT=false
if [ "$NOGIT" = false ] && command -v git &> /dev/null; then
    USE_GIT=true
fi

echo -e "${GREEN}正在从 $REPO 下载插件 '${NAME[$PLUGIN_NAME]}'..., 包含文件: $FILE_LIST${NC}"

CACHE_DIR="./tmp/plug/plug-$PLUGIN_NAME"
mkdir -p "$CACHE_DIR"

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
    # 示例模式: 仅打印下载命令, 不实际下载
    for item in $FILE_LIST; do
        url="https://raw.githubusercontent.com/$REPO/$BRANCH/$item"
        dest="$CACHE_DIR/$item"

        echo -e "  下载 $item... curl -sL $url -o $dest"
        mkdir -p "$(dirname "$dest")"
    done
fi

echo -e "${GREEN}下载完成!${NC}"

# ----------------------------------------
# 复制到工作目录
# ----------------------------------------

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

# ----------------------------------------
# 清理缓存
# ----------------------------------------

read -p "是否删除缓存目录 $CACHE_DIR?(y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -rf "$CACHE_DIR"
    echo -e "${GREEN}已删除 $CACHE_DIR${NC}"
fi
