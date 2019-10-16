---
layout: post
title: 命令行写Presentation的工具
tags: 
date: 2019-10-16 12:26
---


上一篇分享了一些画图的工具，觉得离准备一个ppt还有差了点什么，这回再补上一些写ppt的工具。


## 1. 用Markdown写PPT


### 1.1 mdp - A command-line based markdown presentation tool

* 链接：<https://github.com/visit1985/mdp>
* 技术：C，ncurses

在终端显示presentation的工具，使用Markdown格式作为编写内容的方式。


### 1.2 mdv - A simple, styled command-line presentation tool using markdown, built with blessed-vue

* 链接：<https://github.com/smketterer/mdv>
* 技术：JS


有更丰富的样式，也是在终端显示的，基于markdown的presentation。


### 1.3 Pochani: Turn Markdown into elegant presentations

* 链接：<https://github.com/theanam/pochani>
* 技术：JS

把Markdown格式的presentation导出为HTML的网页presentation，还可以自己改CSS样式。


## 2. 自定义格式

### 2.1 bashpoint

* 链接：<https://github.com/dolik-rce/bashpoint>
* 技术：Bash

纯shell实现的终端工具，自定义的格式有点类似html，但写起来应该很麻烦。


## 3. 其他格式

### 3.1 Vitaly

* 链接：<https://github.com/brianyu28/vitality>
* 格式：yaml
* 技术：python，yaml

使用yaml格式定义的 presentation，html模版，但还没有效果预览的文档。

### 3.2 orgp

* 链接：<https://github.com/fangqian/orgp>
* 格式：org-mode
* 技术：C++

类似mdp，只不过是基于org-mode，只打算支持部分简单的样式格式。


### 3.3 reveal.js

* 链接：<https://github.com/hakimel/reveal.js>
* 格式：HTML/Markdown
* 技术：JS

一个HTML presnetation框架，功能比较完整，也有不少其他工具是引用reveal.js来作为输出框架的。它甚至可以用来导出其他格式（如pdf）的ppt。

slides.com还提供了一个在线编辑器来编辑reveal的演讲稿。

### 3.4 spectacle

* 链接：<https://github.com/FormidableLabs/spectacle>
* 格式：React
* 技术：JS

功能和完整度跟Reveal.js相似，利用了React的优点，你可以在里面使用一些动态渲染的技巧，还支持多屏渲染，比reveal.js走得更往前一步。

