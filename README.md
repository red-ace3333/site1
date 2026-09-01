# 我的博客 (red-ace3333/site1)

一个基于 **Hugo (Extended)** 静态网站生成器构建的个人博客项目，部署于 **GitHub Pages**，
通过 GitHub Actions 自动构建与发布。

在线地址：**https://red-ace3333.github.io/site1/**

## 技术栈

- **静态网站生成器**：Hugo Extended（构建脚本使用 v0.152.2）
- **主题**：
  - **reimu**（当前使用，已内置为仓库普通目录，基于上游 v0.13.4 并做了 6 处定制化修复）
  - **hugo-theme-stack**（备用，git submodule，未修改可直接跟随上游）
- **内容格式**：Markdown
- **样式**：SCSS/CSS（Hugo Pipes 构建）
- **交互**：TypeScript → JavaScript（Hugo js.Build 转译 + minify）
- **版本控制**：Git
- **评论系统**：Waline（默认 **关闭**，需配置自有 `serverURL` 后启用）
- **数学公式**：KaTeX
- **CI/CD**：GitHub Actions (`.github/workflows/hugo.yaml`)
- **部署**：GitHub Pages

## 项目结构

```
.
├── .github/workflows/hugo.yaml   # CI 构建 & Pages 部署流水线（Hugo + TZ=Asia/Shanghai）
├── content/                      # 博客文章内容
│   └── post/                     # 博客文章 page bundle
├── static/                       # 静态资源（原样拷贝到站点根）
│   └── images/posts/             # 文章配图（按文章分子目录）
├── themes/                       # 主题
│   ├── reimu/                    # ⭐ 主主题：仓库内置的定制化版本（普通目录，非 submodule）
│   └── hugo-theme-stack/         # 备用主题：git submodule（未改动，跟随上游 CaiJimmy/hugo-theme-stack）
├── resources/_gen/               # Hugo SCSS/JS 编译缓存（跟踪入仓加速 CI）
├── public/                       # Hugo 构建产物（可直接部署；CI 每次会重建覆盖）
├── hugo.yaml                     # ⭐ 默认配置（主构建使用，baseURL 含 /site1 子路径）
├── hugo-reimu.yaml               # 备用配置（切换 reimu 主题用，占位参数已对齐正式配置）
├── hugo-stack.yaml               # 备用配置（切换 stack 主题用）
├── .gitmodules                   # 子模块声明：仅保留 hugo-theme-stack（reimu 已转为普通目录）
└── README.md                     # 本文件
```

## 功能特性

- ✅ 响应式设计，适配不同设备
- ✅ 中文内容优化（CJK 断行/字体配置，TZ=Asia/Shanghai 时区对齐）
- ✅ 数学公式渲染（KaTeX）
- ✅ 代码块高亮 + 一键复制 + 行数阈值自动折叠
- ✅ 评论系统（Waline，**需自行部署后填入 `serverURL` 启用**）
- ✅ 文章分类与标签（含 RSS、分页、OpenGraph `article:tag` 多标签）
- ✅ 文章元数据管理（front-matter 规范见下文）
- ✅ 图片统一存储管理：`static/images/posts/<标题>/` + 绝对路径引用
- ✅ 夜间模式：`auto / light / dark` 三态循环切换按钮（localStorage 记忆）
- ✅ 动画效果：AOS（滚动渐入）+ 返回顶部透明度渐变 + 主题色从 banner 自动提取
- ✅ Pjax 局部刷新（smooth 切换 + TOC / Sidebar 状态保持）
- ✅ 返回顶部、目录侧栏、移动端导航
- ✅ GitHub Actions 自动构建 + Pages 部署

## 快速开始

### 环境要求

| 组件 | 要求 | 说明 |
|------|------|------|
| **Hugo Extended** | **≥ 0.152.2**（推荐与 CI 同版本） | **必须 extended 版**（含 Dart-SASS / ESBuild，用于 SCSS 编译、TS→JS 转译） |
| Git | ≥ 2.30 | `submodule` 命令用于 hugo-theme-stack |
| （可选）Node.js | ≥ 18 | reimu 主题内开发工具 / prettier 格式化用，不参与 Hugo 本身构建 |

> ⚠️ **Hugo 标准版 vs Extended 区别**：仓库 CI 下载的是 `hugo_extended_*` 版本。
> 若用普通版会报 `TOCSS` / `js.Build` 相关错误，SCSS 和 TS 文件无法编译。

### 安装步骤

1. **克隆仓库**（`--recurse-submodules` 会把备用主题 hugo-theme-stack 一起拉下；reimu 已内置无需额外操作）
   ```bash
   git clone --recurse-submodules git@github.com:red-ace3333/site1.git
   cd site1
   ```

   如果 clone 时忘了加 `--recurse-submodules`，手动补拉备用主题：
   ```bash
   git submodule update --init themes/hugo-theme-stack
   # reimu 无需执行：已经是仓库普通目录了
   ```

2. **（可选）安装 reimu 主题开发依赖**
   ```bash
   # 仅在你要改主题并跑 prettier/husky 时需要
   cd themes/reimu
   npm install
   cd ../..
   ```
   Hugo 构建主题文件（SCSS/TS）**不依赖 Node**：Hugo Extended 自带 ESBuild / Dart-SASS。

3. **启动本地开发服务器**
   ```bash
   hugo server -D          # -D 包含 draft: true 的草稿文章
   # 或带 minify / 使用不同配置文件：
   # hugo server -D --config hugo-stack.yaml    # 切换到 stack 主题预览
   ```

4. **访问博客**
   ```
   http://localhost:1313/site1/
   ```
   因为 `baseURL` 配置了 `/site1` 子路径，本地访问也要带上 `/site1/` 后缀匹配生产环境行为。

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

## 配置说明

主要配置文件为 `hugo.yaml`，包含以下核心配置：

| 配置项 | 说明 | 关键字段 |
|--------|------|----------|
| 网站基本信息 | 标题、描述、作者、版权署名 | `title`, `params.author`, `copyright` |
| 构建环境 | 生产/开发切换（影响 minify / 资源路径） | `hugo --environment production` |
| GitHub Pages 子路径 | `/site1/` 前缀，`baseURL` + `vendor.yml.local` 需同步 | `baseURL`, `themes/reimu/data/vendor.yml` 的 `local:` |
| 主题 | 默认 `reimu`（在 `theme:` 下切换） | `theme: reimu` |
| 深色模式 | `auto` / `true` / `false`，**值必须加引号**避免 YAML 布尔转换 | `params.dark_mode.enable: "auto"` |
| 评论系统 | Waline，**部署自己的服务端后再启用并填 `serverURL`** | `params.waline.enable`, `params.waline.serverURL` |
| 代码块 | 超过 N 行自动折叠 / 复制版权声明 | `params.code_block.expand`, `params.clipboard.*` |
| CI 时区 | 与 zh-CN 站点对齐（+08:00），避免日期偏移 | `.github/workflows/hugo.yaml` 的 `TZ: Asia/Shanghai` |

## 构建与部署

### 构建静态文件（本地）

```bash
# 与 CI 等价的完整构建（推荐）
hugo --gc --minify
# 或者轻量构建（仅用于看产物）
hugo
```

构建后的静态文件将输出到 `public/` 目录。`--gc` 会清理无用的 `resources/_gen` 缓存；
`--minify` 会压缩 HTML/CSS/JS 并生成带哈希指纹的 CSS 文件名用于缓存击穿。

### 部署方法

#### 🏆 推荐：GitHub Actions + GitHub Pages（当前仓库已开箱启用）

仓库自带 `.github/workflows/hugo.yaml`，**只要 push 到 `main` 分支就会自动触发**：
1. Checkout 代码（包含 hugo-theme-stack submodule）
2. 安装 Hugo Extended v0.152.2
3. 设置时区 `Asia/Shanghai`
4. `hugo --minify` 构建
5. 上传 Pages artifact → 部署到 `red-ace3333.github.io/site1/`

**不需要任何手动操作**。本仓库 Settings → Pages → Source 已经配置为 Deploy from Actions。

监控构建进度：
```
https://github.com/red-ace3333/site1/actions
```

#### 其他静态托管（备用）

如果想迁移到其他平台，直接取 `public/` 目录部署：

| 平台 | 关键参数 |
|------|---------|
| **Vercel / Netlify** | Build command 留空，Publish directory 填 `public/`；**注意根路径 `/site1/` 如果平台给的是自定义域名要同步改 `baseURL`** |
| **自建 Nginx** | 见下方示例（root 指向 public 目录） |

#### Nginx 部署示例

```nginx
server {
    listen       80;
    server_name  yourdomain.com;

    # 如果部署在子路径（与 GitHub Pages 行为一致），用 alias；根域名部署用 root 即可
    location /site1/ {
        alias  /path/to/your/blog/public/;
        index  index.html;
        try_files $uri $uri/ /site1/404.html;
    }

    # 静态资源长缓存
    location ~* \.(css|js|woff2?|ttf|eot|otf|png|jpg|jpeg|gif|svg|webp|ico)$ {
        expires 30d;
        add_header Cache-Control "public, immutable";
    }
}
```

## 开发与维护

### 主题更新流程

#### 🔧 主主题 reimu（仓库内置，普通目录）

> ⚠️ reimu **不再是 git submodule**，不要执行 `cd themes/reimu && git pull`（里面没有 `.git` / `origin`，会直接报错）。
>
> 当前 reimu 基线上游版本：**v0.13.4 + 6 处定制化 Bug 修复（commit 19d74b6 快照）**

需要升级原主题时，用 **diff + patch** 方式（因为已做核心代码改动，git merge 一定有冲突）：

```bash
# 1. 从上游拉一个临时副本到 /tmp 对比
git clone --depth 1 https://github.com/D-Sketon/hugo-theme-reimu.git /tmp/reimu-upstream

# 2. 生成 diff（把上游新版本 → 应用到我们本地的定制版）
diff -ruN themes/reimu /tmp/reimu-upstream > /tmp/reimu-upgrade.patch

# 3. 逐行审查 patch：
#    - 保留我们的 Bug 修复（main.ts 函数/ pjax_main / vendor.yml / head.html 等）
#    - 合入上游的新功能 / 新配置字段
patch -p1 --dry-run < /tmp/reimu-upgrade.patch    # 先 dry-run 预览
patch -p1 < /tmp/reimu-upgrade.patch              # 确认无误再真应用

# 4. 构建验证
hugo --gc --minify
```

#### 🧩 备用主题 hugo-theme-stack（git submodule）

stack 没做定制，按标准 submodule 升级即可：

```bash
cd themes/hugo-theme-stack
git checkout main
git pull origin main
cd ../..
git add themes/hugo-theme-stack
git commit -m "chore: 更新 hugo-theme-stack 到最新上游"
```

### 清理构建缓存

```bash
# 仅清理 public/（不影响 resources/_gen 的编译缓存，速度快）
hugo --cleanDestinationDir

# 连同资源缓存一起清理（SCSS/JS 会重新编译，通常只在切换 Hugo 大版本时用）
rm -rf public/ resources/_gen/
hugo --gc --minify
```

## 安全注意事项

1. **不要在配置文件中存储敏感信息**（Waline App ID 密钥、统计 token、密码等）。如要接入，改用 GitHub Secrets + CI 环境变量注入。
2. **Waline 评论先部署再启用**：`params.waline.serverURL` 禁止填官方示例 `https://waline.vercel.app`，必须是你自己部署的服务；未部署前保持 `enable: false` 防止 CORS 请求失败/访客数据泄漏。
3. **YAML 字符串要加引号**：`enable: auto` / `enable: on` / `enable: yes` 在 YAML 1.1 是布尔值不是字符串；加引号写成 `"auto"` / `"on"` / `"yes"`。
4. **保持 CI 时区与站点一致**：中文站点默认 `Asia/Shanghai`，与所有文章 front-matter 的 `+08:00` 对齐；避免改到 `America/Los_Angeles` 之类时区导致日期排序错乱、sitemap 时间戳偏移。
5. **定期更新依赖**：Hugo Extended、stack 子模块（`git submodule update --remote`）、以及 Node 开发依赖（`cd themes/reimu && npm update`）。
6. **启用 HTTPS**：GitHub Pages 默认已经开启。自定义域名时记得强制 HTTPS 重定向。
7. **vendor CDN 路径与本地路径要对齐**：如果未来修改 `baseURL` 的子路径前缀，`themes/reimu/data/vendor.yml` 的 `local:` 字段要同步加前缀。

## 修复与变更日志

（本仓库维护的重要结构性修复，便于未来回溯）

| 日期 | 说明 | 对应 commit |
|------|------|-------------|
| 2026-09-01 | **20 项隐藏 Bug 修复**（4 严重：`auto` 布尔转换、throttle/debounce 上下文、`window.name` 全局污染、CI 时区错位；7 中等：侧边栏 current 方向、sidebarTop 空保护、`og:article:tag` 格式、Waline 占位地址等；9 轻微） | `8502009`（主仓库）、子模块 `19d74b6`（后被方案 B 内嵌） |
| 2026-09-01 | **themes/reimu 从 git submodule 转为普通目录**，消除 `github.com/D-Sketon/hugo-theme-reimu` 的跨仓库依赖，保证 CI 构建能拿到所有修复；`hugo-theme-stack` 保留 submodule | `59d3043` |
| 2026-09-01 | README 全面更新（仓库地址、Hugo Extended 要求、部署流程、主题升级方式、联系方式、安全清单） | 见本次 commit |

## 许可证

- 本项目代码部分（配置、工作流、本 README 等）采用 **MIT 许可证**
- **themes/reimu/**：继承原作者的许可证（上游 D-Sketon/hugo-theme-reimu，详见其 `LICENSE` 文件，目录内已包含）
- **themes/hugo-theme-stack/**：以 submodule 形式引入，跟随上游 CaiJimmy/hugo-theme-stack 的许可证

## 联系方式

如有问题或建议，欢迎通过以下方式联系：

- Email: [3131097328@qq.com](mailto:3131097328@qq.com)
- GitHub: [@red-ace3333](https://github.com/red-ace3333)
- Issues: [github.com/red-ace3333/site1/issues](https://github.com/red-ace3333/site1/issues)

---

**最后更新时间**：2026-09-01（README 改版 + 20 Bug 修复 + themes/reimu 结构调整）