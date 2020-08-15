---
published: false
layout: post
title: CMS-Free网站工具调研
date: '2020-08-15 17:30'
---
## CMS-Free网站工具调研

所谓CMS Free就是不再用传统的重型CMS工具来管理站点内容，而是使用轻量级的markdown和网站模板来制作网站（如Jekyll就是其中一个热门的方案）。

鉴于现在我使用Github Pages的服务来放自己的博客网站，一直想找一个方便的编辑工具，虽然Typora很好，可以本地预览，可以插图片，但毕竟对小白（比如我老婆）不友好。所以想想网上应该有人做过基于jekyll的网站编辑工具，果然搜Jekyll Editors可以搜出来[一堆][1]。

比如这篇文章就是在[prose.io][3]下面写的。

查了一下前面三个有代表性的产品，大概特性如下：

### 1. Netlify CMS

项目的主要目标应该是接入netlify的服务，提供了一些语言下的依赖包，比如可以本地安装npm的包，从而让你可以把编辑器的功能嵌入到你的静态网站中，并且架构上尽可能地实现可配置给不同的供应商使用。最终你的内容数据（markdown、网络资源）会被netlify.com拉取并进行构建，部署在netlify的hosting服务上。

相信Netlify可以提供比Github有更多的建站自由度，所以有时间折腾的话不妨考虑这个方案。

### 2. Prose

这个产品完全是针对Github Pages设计的开源项目，只要在网站中你完成github授权，就可以轻松管理你名下的项目的Markdown文件，对齐进行编辑、保存和更新。

它有一个Github Pages版部署在[prose.io][3]上，因为绝大部分功能都是直接运行在客户端的，只是依赖了一个Gatekeeper建立与Github API的通信。你可以把这个Gatekeeper部署在自己的服务器上，完全由自己来掌控所有东西。


### 3. Jekyll Admin

这个是一个Jekyll的插件，主要满足了在本地跑起Jekyll服务以后，有一个前端界面可以管理对应的文章、静态资源等。所以如果你没有一台服务器来跑整个Jekyll服务的话，就只能在作为本地host的一个处理方式。但它的好处是不用关联github api，因为是直接用本地仓库的。

## 参考

[1]: https://github.com/planetjekyll/awesome-jekyll-editors
[2]: https://github.com/netlify/netlify-cms
[3]: http://prose.io/


