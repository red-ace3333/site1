# 我的博客

一个基于 Hugo 静态网站生成器构建的个人博客项目。

## 技术栈

- **静态网站生成器**：Hugo
- **主题**：reimu
- **内容格式**：Markdown
- **样式**：SCSS/CSS
- **交互**：TypeScript/JavaScript
- **版本控制**：Git
- **评论系统**：Waline
- **数学公式**：KaTeX

## 项目结构

```
.
├── content/          # 博客文章内容
│   └── post/         # 博客文章目录
├── static/           # 静态资源
│   └── images/       # 图片资源
├── themes/           # 主题目录
│   ├── reimu/        # reimu主题
│   └── *.archive/    # 归档的其他主题
├── hugo.yaml         # 网站配置文件
└── README.md         # 项目文档
```

## 功能特性

- ✅ 响应式设计，适配不同设备
- ✅ 支持中文内容，优化CJK语言显示
- ✅ 数学公式渲染（KaTeX）
- ✅ 代码高亮显示
- ✅ 评论系统（Waline）
- ✅ 文章分类与标签
- ✅ 文章元数据管理
- ✅ 图片统一存储管理
- ✅ 夜间模式支持
- ✅ 动画效果

## 快速开始

### 环境要求

- Hugo 0.132.0 或更高版本
- Git

### 安装步骤

1. 克隆仓库
   ```bash
   git clone <仓库地址>
   cd <仓库目录>
   ```

2. 安装依赖（可选，根据主题要求）
   ```bash
   # 如需要，安装主题依赖
   cd themes/reimu
   npm install
   cd ../..
   ```

3. 启动本地服务器
   ```bash
   hugo server -D
   ```

4. 访问博客
   ```
   http://localhost:1313
   ```

## 内容管理

### 新建文章

```bash
hugo new post/新文章标题/index.md
```

### 文章元数据规范

```yaml
---
title: "文章标题"
description: "文章描述"
date: 2025-11-22T20:39:57+08:00
image: "/images/posts/文章标题/封面图.jpg"
math: false
license: ""
hidden: false
comments: true
draft: false
toc: true
tags: ["标签1", "标签2"]
categories: ["分类"]
---
```

### 图片管理

所有文章图片请统一存储在 `static/images/posts/文章标题/` 目录下，在文章中使用绝对路径引用：

```markdown
![图片描述](/images/posts/文章标题/图片文件名.jpg)
```

## 构建与部署

### 构建静态文件

```bash
hugo --minify
```

构建后的静态文件将输出到 `public/` 目录。

### 部署方法

可以将 `public/` 目录部署到任何静态网站托管服务，例如：

- GitHub Pages
- Vercel
- Netlify
- 自己的服务器（Nginx、Apache等）

#### Nginx 部署示例

```nginx
server {
    listen 80;
    server_name yourdomain.com;
    root /path/to/your/blog/public;
    index index.html;
    
    location / {
        try_files $uri $uri/ =404;
    }
}
```

## 配置说明

主要配置文件为 `hugo.yaml`，包含以下核心配置：

- **网站基本信息**：标题、描述、作者等
- **语言配置**：默认语言、多语言支持
- **主题配置**：主题选择、主题特定配置
- **评论系统**：Waline配置
- **分析工具**：Google Analytics等

## 开发与维护

### 更新主题

```bash
# 使用git子模块更新主题
cd themes/reimu
git pull origin main
cd ../..
```

### 清理构建缓存

```bash
hugo --cleanDestinationDir
```

## 安全注意事项

- 不要在配置文件中存储真实的API密钥或敏感信息
- 定期更新依赖和主题版本
- 启用HTTPS确保网站安全

## 许可证

本项目采用 MIT 许可证。

## 联系方式

如有问题或建议，欢迎通过以下方式联系：

- Email: [your-email@example.com]
- GitHub: [your-github-username]

---

**最后更新时间**：2026-01-15