# 本地开发环境配置指南

本文档介绍如何在 Linux 与 macOS (OS X) 环境中配置并运行本仓库的 Jekyll 本地开发环境。

## 先决条件

- Ruby 3.0 及以上版本（推荐使用 3.2.x）。
- Bundler 2.4 或更高版本。
- Node.js 与 Yarn *可选*（仅在需要编译前端资产时使用）。
- Git。

### 使用版本管理工具（推荐）

Linux 与 macOS 用户都可以使用 [mise](https://github.com/jdx/mise) 或 [rbenv](https://github.com/rbenv/rbenv) 管理 Ruby 版本。示例：

```bash
# 安装 mise（macOS 使用 Homebrew）
brew install mise
mise use --global ruby@3.2.3
```

或：

```bash
# 安装 rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
~/.rbenv/bin/rbenv init
rbenv install 3.2.3
rbenv global 3.2.3
```

## 步骤一：克隆仓库

```bash
git clone https://github.com/<your-name>/thoughts.git
cd thoughts
```

## 步骤二：安装依赖

在首次运行或更新 Gemfile 后，需要执行 Bundler 安装依赖。

```bash
bundle install
```

> 如果你希望将依赖安装到项目目录中，可运行：
>
> ```bash
> bundle install --path vendor/bundle
> ```

## 步骤三：运行开发服务器

执行以下命令启动本地 Jekyll 服务：

```bash
bundle exec jekyll serve
```

默认情况下，开发服务器会运行在 <http://127.0.0.1:4000>。启动后，可在浏览器中访问以预览站点。

### 常见参数

- `--livereload`：启用实时刷新（Jekyll 4 默认启用）。
- `--drafts`：同时渲染 `_drafts` 目录下的草稿文章。
- `--future`：渲染未来日期的文章。

示例：

```bash
bundle exec jekyll serve --livereload --drafts
```

## 平台差异

### Linux

- 某些发行版需要额外安装构建依赖，如 `build-essential`、`libffi-dev`、`libyaml-dev` 等，以便编译原生扩展（例如 `sassc`）。
- 在 Debian/Ubuntu 系统上可以运行：
  ```bash
  sudo apt-get update
  sudo apt-get install -y build-essential libffi-dev libyaml-dev zlib1g-dev
  ```

### macOS (OS X)

- 建议使用 [Homebrew](https://brew.sh/) 安装依赖：
  ```bash
  brew install ruby
  ```
- 如果使用系统自带 Ruby，可能需要在安装依赖时添加 `sudo` 权限或自定义 `GEM_HOME`。
- 若出现 `ffi` 或 `sassc` 编译失败，可通过安装 Xcode Command Line Tools 解决：
  ```bash
  xcode-select --install
  ```

## 运行测试构建

在 CI 或本地验证站点可构建时，使用：

```bash
bundle exec jekyll build
```

构建成功后，静态文件会输出到 `_site/` 目录。

## 其它常见问题

1. **Bundler 提示权限不足**：请确认项目目录具有写权限，或配置本地 gem 安装目录。
2. **无法连接到 rubygems.org**：可尝试配置网络代理或使用镜像源，例如 `https://gems.ruby-china.com/`。
3. **Gem 原生扩展编译失败**：检查是否已安装 C/C++ 编译工具链，以及 `libffi`、`zlib`、`openssl` 等开发库。

完成以上步骤后，你就可以在本地愉快地编辑和预览本站内容了。
