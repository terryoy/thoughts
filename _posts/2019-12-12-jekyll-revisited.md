---
layout: post
title: 重新学习用Jekyll在Github Pages搭建博客
tags: dev
date: 2019-12-12 12:18
author: terryoy

---

自从知道Github Pages做博客Hosting的便捷性以后，以前用过好多种Static Site Generator的方法来生成自己的博客内容，从最初由于熟悉python而选用的liquidluck，到后来学会NodeJS以后试用的Hexo，但觉得改起来都很繁琐，最后回归于最本质的github pages自带的jekyll。

使用Jekyll的好处是如果模板都是内置的，你可以聚焦在日志和页面上，如果你想定制样式，也很方便，支持SASS的样式定制，支持html模板的修改。这些对于喜欢折腾的geek来说都很方便，唯一的缺点就是想让老婆使用起来应该门槛还是有点高，主要是git操作、编辑器、图床这三个问题。

除此以外，想做一个有自己特色的博客，主题还是要自己好好研究一翻的，因此也借这个机会再整理一下静态博客的知识，以更好定制出一个风格化的博客网站。

### 一、Github Pages和Jekyll

Jekyll的可定制程度应该蛮高的，有很多插件，但之前我都只是集中精力在写文章上，因此也没有机会对它进行深入的研究。Github Pages使用的Jekyll肯定不是最新版，但应该会有一套支持的特性集，所以我们要考虑的是怎样在这套基础上扩展功能。因此会有以下几点的考虑：

* 是否可以自己定制样式
* 是否可以自己定制更多的模板内容
* 是否可以引用外部插件（非Github列表内的），以支持：
  * 扩展Markdown特性
  * 组件化引入第三方服务或数据
  * 扩展网站功能

我去找了一下Github Pages的Jekyll版本，里面确实有不少插件是我之前都没用过的，可以适当研究一下如何应用。因为很多时候我对模板里面的内容组织、组件样式都不太满意，更多的是想知道如何在一个模板的基础上去修改它。我希望改出来的最终是一个我自己的版本。

来源：[【Github Pages的依赖版本一览】](https://pages.github.com/versions/)

| Dependency                                                   | Version |
| :----------------------------------------------------------- | :------ |
| [jekyll](https://rubygems.org/gems/jekyll)                   | 3.8.5   |
| [github-pages-health-check](https://rubygems.org/gems/github-pages-health-check) | 1.16.1  |
| [github-pages](https://rubygems.org/gems/github-pages)       | 203     |
| [html-pipeline](https://rubygems.org/gems/html-pipeline)     | 2.12.2  |
| [jekyll-avatar](https://rubygems.org/gems/jekyll-avatar)     | 0.7.0   |
| [jekyll-coffeescript](https://rubygems.org/gems/jekyll-coffeescript) | 1.1.1   |
| [jekyll-commonmark-ghpages](https://rubygems.org/gems/jekyll-commonmark-ghpages) | 0.1.6   |
| [jekyll-default-layout](https://rubygems.org/gems/jekyll-default-layout) | 0.1.4   |
| [jekyll-feed](https://rubygems.org/gems/jekyll-feed)         | 0.13.0  |
| [jekyll-gist](https://rubygems.org/gems/jekyll-gist)         | 1.5.0   |
| [jekyll-github-metadata](https://rubygems.org/gems/jekyll-github-metadata) | 2.12.1  |
| [jekyll-mentions](https://rubygems.org/gems/jekyll-mentions) | 1.5.1   |
| [jekyll-optional-front-matter](https://rubygems.org/gems/jekyll-optional-front-matter) | 0.3.2   |
| [jekyll-paginate](https://rubygems.org/gems/jekyll-paginate) | 1.1.0   |
| [jekyll-readme-index](https://rubygems.org/gems/jekyll-readme-index) | 0.3.0   |
| [jekyll-redirect-from](https://rubygems.org/gems/jekyll-redirect-from) | 0.15.0  |
| [jekyll-relative-links](https://rubygems.org/gems/jekyll-relative-links) | 0.6.1   |
| [jekyll-remote-theme](https://rubygems.org/gems/jekyll-remote-theme) | 0.4.1   |
| [jekyll-sass-converter](https://rubygems.org/gems/jekyll-sass-converter) | 1.5.2   |
| [jekyll-seo-tag](https://rubygems.org/gems/jekyll-seo-tag)   | 2.6.1   |
| [jekyll-sitemap](https://rubygems.org/gems/jekyll-sitemap)   | 1.4.0   |
| [jekyll-swiss](https://rubygems.org/gems/jekyll-swiss)       | 1.0.0   |
| [jekyll-theme-architect](https://rubygems.org/gems/jekyll-theme-architect) | 0.1.1   |
| [jekyll-theme-cayman](https://rubygems.org/gems/jekyll-theme-cayman) | 0.1.1   |
| [jekyll-theme-dinky](https://rubygems.org/gems/jekyll-theme-dinky) | 0.1.1   |
| [jekyll-theme-hacker](https://rubygems.org/gems/jekyll-theme-hacker) | 0.1.1   |
| [jekyll-theme-leap-day](https://rubygems.org/gems/jekyll-theme-leap-day) | 0.1.1   |
| [jekyll-theme-merlot](https://rubygems.org/gems/jekyll-theme-merlot) | 0.1.1   |
| [jekyll-theme-midnight](https://rubygems.org/gems/jekyll-theme-midnight) | 0.1.1   |
| [jekyll-theme-minimal](https://rubygems.org/gems/jekyll-theme-minimal) | 0.1.1   |
| [jekyll-theme-modernist](https://rubygems.org/gems/jekyll-theme-modernist) | 0.1.1   |
| [jekyll-theme-primer](https://rubygems.org/gems/jekyll-theme-primer) | 0.5.4   |
| [jekyll-theme-slate](https://rubygems.org/gems/jekyll-theme-slate) | 0.1.1   |
| [jekyll-theme-tactile](https://rubygems.org/gems/jekyll-theme-tactile) | 0.1.1   |
| [jekyll-theme-time-machine](https://rubygems.org/gems/jekyll-theme-time-machine) | 0.1.1   |
| [jekyll-titles-from-headings](https://rubygems.org/gems/jekyll-titles-from-headings) | 0.5.3   |
| [jemoji](https://rubygems.org/gems/jemoji)                   | 0.11.1  |
| [kramdown](https://rubygems.org/gems/kramdown)               | 1.17.0  |
| [liquid](https://rubygems.org/gems/liquid)                   | 4.0.3   |
| [minima](https://rubygems.org/gems/minima)                   | 2.5.1   |
| [nokogiri](https://rubygems.org/gems/nokogiri)               | 1.10.6  |
| [rouge](https://rubygems.org/gems/rouge)                     | 3.13.0  |
| [ruby](https://www.ruby-lang.org/en/downloads/)              | 2.5.3   |
| [safe_yaml](https://rubygems.org/gems/safe_yaml)             | 1.0.5   |
| [sass](https://rubygems.org/gems/sass)                       | 3.7.4   |



### 二、Markdown编辑器的选择

Markdown编辑器的选择主要考虑以下几点：

* **所见即所得**及**元素控件**。对于小白来说，用纯文本写Markdown是挺不友好的；即使对于码农来说，像表格这种高阶的操作，用纯手工打也得累死。所以这两点的基础编辑功能是选择编辑器最重要考虑的。
* **可以管理外部目录**。有很多笔记软件都支持Markdown编辑，但数据都是存在云笔记里面的，我们只是想单纯地用来管理

目前我看了几个App Store搜Markdown搜出来的笔记型软件都不太适用，只发现一个[【typora】](https://www.typora.io/)是符合我想法的。我主要考察的几点它都满足了，一开始我还担心它会不会不支持jekyll需要的markdown头部的元数据（layout、title等），但发现支持得还不错，应该就是选用这款了。而且不知道为什么，我感觉用了这个工具以后，确实写起来效率比在命令行下用vi、或者用代码工具atom editor都要高一些。（写作思路的流畅表达是一个编辑工具最重要的功能！）

#### Github代码管理

另外，对于码农来说毫无难度的Git，对小白来说还是有上手难度的。这里我考虑的是找一个合适的GUI git工具，让我老婆自己能够理解图形界面的操作并能合并代码，就已经可以满足要求了。

### 三、图床

图床和视频床应该是个人博客的普遍问题了，因为静态网站本身自己不太方便承载过多的二进制内容。刚好之前在推特上关注的[@磨刀工具](https://twitter.com/modaotool)推荐了一款叫做[【uPic】](https://blog.svend.cc/upic/)的工具，支持多种图床的统一操作，看起来是符合生成图片链接在Markdown里插入的需要的，但还需要考虑的是图片大小的问题。

因此作为图床工具主要考虑的是：

* 上传、生成链接的便捷性
* 生成缩略图的功能
* 视频、文件等二进制内容的存储和查看

如果上面三条需求都满足得到的话就已经比较合适了，剩下的问题都只是怎么接进我的Jekyll模板里而已。



