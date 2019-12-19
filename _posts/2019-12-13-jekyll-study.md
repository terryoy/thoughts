---
layout: post
title: Jekyll框架学习
tags: dev
author: terryoy
---

## 一、初始化一个Github Pages网站

首先要装上Ruby、Bundler、Jekyll这些就[不细说了](https://jekyllrb.com/docs/)，然后用Jekyll在当前目录创建一个网站的骨架：

```bash
$ jekyll new .
```

这个程序默认是会把jekyll的版本设在Gemfile里面的， 如果你想用Github Pages的版本，那么要去Gemfile里面把```gem jekyll```这一行注释掉，而开启```gem github-pages```这一行。同时留意注释里面的内容，你还可以把Github Pages的包更新到最新版。

初始化以后就会有jekyll的骨架，默认是minima的主题。内容结构大致如下：

* _pages下存放独立页面
* _posts下存放博客文章
* _drafts下存放草稿，当你用”--drafts"命令执行jekyll的预览的时候，这部分才会显示在生成的页面上
* _site，jekyll生成的内容，不用提交到代码仓
* _config.yaml，站点配置文件
* Gemfile，软件依赖的配置文件

你可以在本地跑以下命令进行预览（“--drafts”是包含_drafts草稿一起显示的意思，默认是不显示draft）：

```
$ bundle exec jekyll serve --drafts
```



## 二、Ruby傻瓜书

因为Jekyll是用Ruby语言开发的，所以要懂一点最基本的Ruby知识，才方便扩展网站的功能。

### Gem & Gemfile

居然Ruby语言叫做“红宝石”，那么它的软件包称为[“Gem（宝石）”](https://guides.rubygems.org/what-is-a-gem/)就不奇怪了。Jekyll也是通过一个Gemfile来声明它所依赖的软件，除此以外，你还可以通过它来安装自己的插件。但gem原本有自己的一套工具，而[Gemfile](https://bundler.io/gemfile.html)则是Bundler的规范。Bundler就好像是Python里面的pip一样，而Gemfile就像pip用到的requirements.txt一样。

如果没有Gemfile的话，可以运行以下命令生成：

```
$ bundle init
```

Gemfile的配置信息包括：

* source，指明软件包的注册数据库（RubyGems server）
* group，将软件依赖设定不同的组，因为在某些场景下希望根据条件安装或不安装部分软件包，所以就可以通过groups来讲他们进行分类。同时，可以在某个gem后面的:group => []参数，指定要安装的软件组，又或者是通过bundle的```--widthout```参数来指定不安装某个组
* gem，具体的某个软件包，同时可以在软件包后面指明要引用的版本

## 三、Jekyll组成

### Liquid 模板语言

Liquid模板语言跟Django所用的语法非常相似，所以在这里不必过多叙说。主要分成三类：

| Object  | 作用         | 例子                                              |
| ------- | ------------ | ------------------------------------------------- |
| Objects | 显示属性内容 | ```{% raw %}{{ object.title }}{% endraw %}```     |
| Tags    | 逻辑控制     | ```{% raw %}{% if page.side_bar %}{% endraw %}``` |
| Filter  | 内容处理     | ```{% raw %}{{ hi | capitalize }}{% endraw %}```  |



### Front Matter 头部信息

Front Matter的格式主要是YAML定义的一系列数据，以两段三横线“---”包着的内容，作用是在业内定义一些所需要的变量。

Front matter支持的数据可以有很多，因为只要是页面或插件用到的变量，都可以在front matter这里定义，所以一般会有以下一些变量：

| 变量名               | 范围 | 作用                                                         |
| -------------------- | ---- | ------------------------------------------------------------ |
| layout               | 全局 | 本页面使用的layout名字。                                     |
| permalink            | 全局 | 自定义链接。（如果你的网页链接不想使用默认的“year/month/day/title.html”格式的话） |
| published            | 全局 | 如果你想把这个页面隐藏起来，则设为false。                    |
| title                | 标题 | 标题                                                         |
| date                 | Post | 发布日期                                                     |
| category, categories | Post | 分类                                                         |
| tags                 | Post | 标签                                                         |

如果你在Front Matter里面定义了其他变量，可以使用```{% raw %}{{ page.变量名 }}{% endraw %}```的方式引用。



### Layouts & Includes 布局设计

在```_layouts```目录下，可以定义各种不同的layout给内容使用（通过Front Matter指定）。Layout文件以“.html”格式编写，配合liquid模板语言，并可以互相继承和扩展。因此你可以根据自己需要，设计出不同的页面模板。一般会有几种模板：

* _layouts/default.html
* _layouts/post.html
* _layouts/list.html

诸如此类等等。

而Includes则是放在```_includes```目录下，一般也写成html格式，但里面往往是html代码片段，供模板引用。比如说会有这些：

* _includes/navigation.html

诸如此类等等。



### Data Files 数据文件

除了在_config.yml文件以外，可能你还有一些别的信息想整理成数据文件管理，那么你可以在目录下创建一些数据文件，用yaml格式来编写一些网站所需要用到的数据。

例如，如果你创建了一个“_data/navigation.yml”文件，用来存放导航栏的链接数据：

```
- name: Home
	link: /
- name: About
	link: /about.html
```

那么就可以在模板里面引用这些数据：

```
<nav>
{% raw %}
  {% for item in site.data.navigation %}
    ...
  {% endfor %}
{% endraw %}
</nav>
```



### Assets 资源

静态资源主要分以下几类：

* assets
  * css
  * images
  * js
* _sass
  * .scss file for import

这里值得留意的是你可以用SASS来编写你的css文件，只要创建一个以“.scss”结尾的样式文件即可，而如果你创建一个```/assets/css/styles.scss```的文件，内容为：

```
---
---
@import "main";
```

这个front matter会告诉Jekyll这个文件需要被处理，而且它会从“_sass”目录里面搜寻到main.scss并把内容编译过去。































