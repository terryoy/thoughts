# 使用说明

## 下载本博客的工程文件

1. 下载master源文件

```bash

$ git clone git@github.com:/terryoy/thoughts.git

```

2. 下载source里的文章

```bash

$ git submodule update --init source

```

3. 安装依赖包

```bash

$ npm install

# 或者用npm的国内镜像安装

$ sudo npm install -g cnpm --registry=https://registry.npm.taobao.org
$ cnpm install

```

4. 进入环境（可执行hexo命令）

```bash

$ source environment.sh

```

## 写文章


1. 新建草稿

layout：post, page, draft, ...

```bash

$ hexo new [layout] [title]

```

2. 已有内容列表

查看现有的页面、文章、草稿等。

type: page, post, route, tag, category

```bash

$ hexo list [type]

```

3. 发布草稿（从draft变成post）

```bash

$ hexo publish [layout] <filename>

```

4. 生成网站内容

```bash

$ hexo generate

```

5. 部署到Github Pages

```bash

$ hexo deploy

```


