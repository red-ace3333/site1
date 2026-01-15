#!/bin/bash

# Hugo主题快速切换脚本
# 用于在reimu和hugo-theme-stack主题之间切换

echo "=== Hugo主题切换工具 ==="
echo

# 当前主题检测
CURRENT_THEME=$(grep "theme:" /home/redace/site1/hugo.yaml | cut -d ' ' -f 2)
echo "当前主题: $CURRENT_THEME"
echo

# 检查主题目录状态
THEME_DIR="/home/redace/site1/themes"
REIMU_ARCHIVE="$THEME_DIR/reimu.archive"
STACK_ARCHIVE="$THEME_DIR/hugo-theme-stack.archive"
REIMU="$THEME_DIR/reimu"
STACK="$THEME_DIR/hugo-theme-stack"

# 切换到hugo-theme-stack主题
function switch_to_stack() {
    echo "正在切换到 hugo-theme-stack 主题..."
    
    # 检查hugo-theme-stack是否被归档
    if [ -d "$STACK_ARCHIVE" ]; then
        echo "  - 恢复hugo-theme-stack主题目录..."
        mv "$STACK_ARCHIVE" "$STACK"
    fi
    
    # 检查reimu是否需要归档
    if [ -d "$REIMU" ] && [ "$CURRENT_THEME" = "reimu" ]; then
        echo "  - 归档reimu主题目录..."
        mv "$REIMU" "$REIMU_ARCHIVE"
    fi
    
    # 更新配置文件
    echo "  - 更新配置文件..."
    cp /home/redace/site1/hugo-stack.yaml /home/redace/site1/hugo.yaml
    
    # 清理构建缓存
    echo "  - 清理构建缓存..."
    rm -rf /home/redace/site1/public
    
    echo "✅ 切换完成！"
    echo "使用 hugo server -D 查看效果"
}

# 切换到reimu主题
function switch_to_reimu() {
    echo "正在切换到 reimu 主题..."
    
    # 检查reimu是否被归档
    if [ -d "$REIMU_ARCHIVE" ]; then
        echo "  - 恢复reimu主题目录..."
        mv "$REIMU_ARCHIVE" "$REIMU"
    fi
    
    # 检查hugo-theme-stack是否需要归档
    if [ -d "$STACK" ] && [ "$CURRENT_THEME" = "hugo-theme-stack" ]; then
        echo "  - 归档hugo-theme-stack主题目录..."
        mv "$STACK" "$STACK_ARCHIVE"
    fi
    
    # 更新配置文件
    echo "  - 更新配置文件..."
    cp /home/redace/site1/hugo-reimu.yaml /home/redace/site1/hugo.yaml
    
    # 清理构建缓存
    echo "  - 清理构建缓存..."
    rm -rf /home/redace/site1/public
    
    echo "✅ 切换完成！"
    echo "使用 hugo server -D 查看效果"
}

# 显示帮助信息
function show_help() {
    echo "使用方法：$0 [选项]"
    echo
    echo "选项："
    echo "  stack    切换到 hugo-theme-stack 主题"
    echo "  reimu    切换到 reimu 主题"
    echo "  status   显示当前主题状态"
    echo "  help     显示帮助信息"
    echo
    echo "示例："
    echo "  $0 stack    # 切换到 hugo-theme-stack 主题"
    echo "  $0 reimu    # 切换到 reimu 主题"
}

# 显示状态信息
function show_status() {
    echo "=== 主题状态信息 ==="
    echo "当前主题: $CURRENT_THEME"
    echo
    echo "主题目录状态:"
    if [ -d "$REIMU" ]; then
        echo "  reimu: 已激活"
    elif [ -d "$REIMU_ARCHIVE" ]; then
        echo "  reimu: 已归档"
    else
        echo "  reimu: 不存在"
    fi
    
    if [ -d "$STACK" ]; then
        echo "  hugo-theme-stack: 已激活"
    elif [ -d "$STACK_ARCHIVE" ]; then
        echo "  hugo-theme-stack: 已归档"
    else
        echo "  hugo-theme-stack: 不存在"
    fi
    echo
}

# 主程序逻辑
case "$1" in
    stack)
        switch_to_stack
        ;;
    reimu)
        switch_to_reimu
        ;;
    status)
        show_status
        ;;
    help)
        show_help
        ;;
    *)
        # 无参数时，如果当前是reimu主题，则切换到stack主题
        if [ "$CURRENT_THEME" = "reimu" ]; then
            switch_to_stack
        else
            switch_to_reimu
        fi
        ;;
esac

echo
