---
layout: post
title: 命令行下画图调研
tags: 
date: 2019-10-14 12:40
---


最近工作中越来越感觉到画图的重要，但是一般来说没有一个理想的画图模板或工具来生成一些通用的图，如果有更适合程序员的画图工具，那应该是基于命令行和数据描述生成图片的工具。

因此这两天打算花时间调研一些画图的命令行工具看看哪个更合适。


### 1. Diagrams

* 网址：<https://github.com/francoislaberge/diagrams>
* 语言：JavaScript

一个NodeJS下的工具，可以生成多种图：流程图，序列图，单向图（Graphviz's Dot），和铁路图（一般用来描述文法用的，又称“语法图”）


### 2.  Goseq

* 网址：<https://github.com/lmika/goseq>
* 语言：Go

上面那个的序列图比较漫画风，这个工具只画序列图，但看起来正式一些。



### 3. Ascidia

* 网址：<https://github.com/Frimkron/Ascidia>
* 语言：Python

这个项目有点意思，是帮你把AsciiArt的图表渲染成图片。这就意味着你可以用ASCII的方式来画图，里面定义了大量的图像元素的写法。比如：

* 线（Lines）
* 盒子（Boxes）
* 连接器（Connectors）
* 象征符号（Symbols）
* 文字

不过问题是，用ASCII方式画图，怎样才可以足够高效呢？利用Atom的Code Snippet？

### 4. Ditaa(DIagram Through Ascii Art)

* 网址：<https://github.com/stathissideris/ditaa>
* 语言：Java

这个项目跟Ascidia类似，应用可能更广泛。跟Ascidia相比的差别有：

* 语法稍有些不同，自定义box可以有更多样式参数
* 支持设颜色
* 有较多的现成项目引用了它，比如ditaa-web，还有支持org-mode的
* 另外还可以支持一些插件


### 5. PlantUML

* 网址：<https://github.com/plantuml/plantuml>
* 语言：Java

支持主要的UML图，比如：

* 序列图
* 用例图
* 类图
* 活动图（流程图）
* 组件图
* 状态图
* 对象图
* 部署图
* 定时图

还有其他常用图：

* 甘特图
* 思维导图


### 6. Kroki

* 网址：<https://github.com/yuzutech/kroki>
* 语言：Java，JavaScript，Python

一个大合集的web服务，包括了BlockDiag、PlantUML、Ditaa、GraphViz、Mermaid等各种方案的实现，提供一个统一的web接口来实现图片的导出。

同时还支持SVG、PNG、PDF等各种格式。


### 7. gnuplot

* 网址：<http://www.gnuplot.info/>
* 语言：C

gnuplot跟GNU没有任何关系。这是一个除了画chart的非常广泛被使用的软件。




