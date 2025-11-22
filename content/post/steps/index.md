---
title: "Steps"
description: steps to build a Hugo site
date: 2025-11-22T20:40:28+08:00
image: 
math: 
license: 
hidden: false
comments: true
draft: true
toc: true
---

# Hugo 网站搭建步骤总结

## 初始化和项目创建

### 1. 初始化 Git 仓库
```bash
git init .
```
- 在 `site1` 目录初始化 Git 仓库
- 默认创建 `master` 分支

### 2. 创建 Hugo 站点
```bash
hugo new site . --force --format yaml
```
- 在当前目录创建 Hugo 站点
- 使用 `--force` 覆盖现有文件
- 配置文件格式为 YAML

### 3. 创建内容页面
```bash
hugo new content pages/hellow.md
hugo new content pages/steps.md
hugo new content pages/红楼梦.md
```
- 在 `content/pages/` 目录下创建三个 Markdown 页面
- 支持中英文文件名

## 主题配置

### 4. 安装 PaperMod 主题
```bash
git clone https://github.com/adityatelange/hugo-PaperMod themes/PaperMod --depth=1
```
- 克隆 PaperMod 主题到 `themes` 目录
- 使用 `--depth=1` 只获取最新提交，节省空间

### 5. 修复配置文件错误
- 初始配置中出现 YAML 格式错误：`theme:["PaperMod"]`
- 正确格式应为：`theme: PaperMod` 或 `theme: "PaperMod"`

## 本地开发和测试

### 6. 启动本地服务器
```bash
hugo serve
# 或
hugo server
```
- 启动 Hugo 开发服务器
- 默认地址：http://localhost:1313/
- 支持热重载，文件修改后自动重新构建

### 7. 构建统计信息
- 页面数量：从 10 → 11 → 13（随着内容增加）
- 构建时间：17ms → 10ms（优化后）
- 环境：development（开发环境）

## 版本控制管理

### 8. 配置 Git 用户信息
```bash
git config --global user.email "3131097328@qq.com"
git config --global user.name "Redace"
```
- 设置全局 Git 配置
- 为提交记录提供作者信息

### 9. 提交代码变更
```bash
git add .
git commit -m "第一版"
git commit -m "第二版"
```
- 添加所有文件到暂存区
- 创建两个版本提交
- 注意：主题作为子模块添加（mode 160000）

### 10. 查看提交历史
```bash
git log
```
- 显示提交记录和变更历史

## 项目结构
```
site1/
├── archetypes/     # 内容模板
├── assets/         # 资源文件
├── content/        # 网站内容
│   └── pages/      # 页面文件
├── data/           # 数据文件
├── layouts/        # 布局文件
├── static/         # 静态文件
├── themes/         # 主题文件
│   └── PaperMod/   # PaperMod 主题
├── public/         # 构建输出
└── hugo.yaml       # 配置文件
```

## 关键命令总结
1. **初始化**: `git init` + `hugo new site`
2. **内容创建**: `hugo new content`
3. **主题安装**: `git clone` 到 themes 目录
4. **本地开发**: `hugo serve`
5. **版本控制**: `git add` + `git commit`
6. **配置注意**: 正确的 YAML 格式和 Git 用户配置

这个流程展示了从零开始创建 Hugo 静态网站并管理版本控制的完整过程。