---
layout: post
title: 搭建Windows 10下面的工作环境
tags: misc
date: 2020-02-01
author: terryoy
---

由于国内冠状病毒施虐，鄙人滞留在墨尔本，正好让我有机会买一台新电脑work from home一段时间。虽然一直想买台新电脑尝试完全在linux环境下工作，这下虽然买了新电脑，但由于要优先满足工作需要，因此最终选择了在windows下搭环境，适应从mac转过来windows。

### 命令行终端

Windows一直以来最让人无法喜欢的就是没有好的命令行终端工具，在Mac下面用得飞快的很多shell命令，到了windows就残废了，如果没有命令行终端的方案，我是无法工作的。

在命令行下工作，最重要的当然是键盘按键速度（这个需要在系统里面设置）和信息刷新的速度。于是就开始寻找完美的终端程序。

* **alacritty**。原来在Linux下看到alacritty用起来确实很爽，又能利用GPU又能方便配置。但真正下载windows版试用以后，各种rust报错信息，我还得下载老一点的版本的程序才能跑起来，可是跑了两天，又废了。弃之。
* **terminus**。一开始看见界面很舒服（果然有点花哨？），就下载下来试用了，但很快就发现，对键入内容的响应速度有问题啊。按住键的时候，可以明显看到光标的刷新是滞后的，于是不由得怀疑起它的性能来。后来一查，这货居然是用electron做的，简直是web的原罪。弃之。（PS，这里有一个很严重的原则问题，命令行这种对速度要求这么高的东西，怎么能用web来做的呢？出于这个原因，我直接把 **hyper.js** 、 **fluent terminal** 跳过了）
* **cmd**、**Powershell** 、**WSL** 等，windows自带的终端其实感觉速度还可以，毕竟是原生应用，但是不支持tab这个让我很头疼，因为之前在mac下面总是需要在工作环境下开多个tab，在不同的目录同时工作。因此这些虽然能暂时工作，但始终无法胜任。
* **cmder**。之后我看了一些方案基本上都是用ConEmu来做backend的，打开ConEmu的界面一看，那窗体的样式太老套了，就没下载来试。结果发现了一堆用ConEmu写一层封皮的终端，还得先下载ConEmu才能运行，等我把ConEmu下载下来以后，发现他们实现的ConEmu都有了，所以还是再使用一下ConEmu。
* **ConEmu**。目前基本满足我的需求：相应速度高，支持tab，支持unicode。（原来我的需求就是这么简单。。）最后选用了它作为我的命令行终端！

另外，在装Alacritty的时候，发现了[**chocolatey**](https://chocolatey.org/) 这个包管理工具，在命令行下装windows软件还蛮方便的，有点像arch的PKGBUILD那样的东西吧，装windows软件可以省很多麻烦。



### Linux工作环境

因为没有Bash之类的shell很不方便，重新学PowerShell各种东西成本很高，所以还是想装个linux来做开发，这样工具链都是非常熟悉的，马上可以上手。

一开始想用VirtualBox的，但是之前使用VirtualBox作为沙盒也有很多不方便的地方。里面的系统是完全独立的，硬件模拟也很有限，因此无法充分利用宿主机的性能，所以在这个选项上有点犹豫。

然后我又同时对比了一下VMware，按理来说在性能方面能处理得更好，核心的问题是要钱。

最后选择WSL（Windows Subsystem for Linux），虽然版本有限，比如Ubuntu目前只出到18.04，但是完全可以胜任在命令行下要装的各种linux软件和shell工作。而且发现，WSL上如果跑起nginx的话，是直接在宿主电脑上开端口的，这一点非常棒！基本上等于我是同时在用Ubuntu和Windows来管理我的应用和文件。

于是无论是git、nodejs还是python，在WSL下面我都能快速地上手，毫无迁移成本。



### 笔记工具

这个其实没什么好说的，我一直在用 markdown + github 来作为笔记，我只需要的是一个像 **typora** 这样的书写工具。



### 文档查找工具

在Mac下面已经习惯了用Dash用得很爽，唯一比较遗憾的是它没事升了一个版本又要重新交钱，已经付过一次钱的我不想继续交税了，就留在了Dash 4（已经很好用）。

现在来到Windows下面要找类似的文档工具，显然已经有人开发了同样具有价值的工具，只是看交互是否高效而已。找了一下主要有下面几个选择：

* **velocity**，从界面到收费模式看起来都几乎跟Dash一样，大概是同一伙人写出来的？
* **devdocs.io**，web在线搜索，支持离线（通过chrome extension），看起来速度还算快（不知道是不是跟我新电脑有关），如果不想装软件而只是临时用的话，这个应该挺合适的。不过我是需要随时调出来的界面，所以还是继续尝试Zeal。
* **Zeal**，界面用的是gtk那一套，虽然丑了一点。。但支持快捷键和prefix，先用着看看。



### Office文档

我想普通人不会花钱买Office365的吧，每年都要交税，而且还贵；之前在备用机试过WPS了，那些弹窗广告非常恶心，也不推荐；所以接下来主要看一下OpenOffice和LibreOffice。

查了一下历史发现这两者之间的历史渊源蛮搞笑的：OpenOffice最早来自于StarOffice，是Sun收购了以后把它改名叫做“Open Office”。但是Sun又被Oracle收购了，所以Oracle又把它改名叫做“Oracle Open Office”，这种项目一般都会被处理掉，所以最后捐给了Apache基金，让大家可以保持开源开发。

而有一些人从Open Office出来fork了一个版本叫“Libre Office”，有趣的是，他们使用GPL协议。由于Open Office使用的是Apache协议，所以它对GPL是兼容的，Libre Office的团队可以很快地把Open Office的代码迁移到Libre Office上去，但是反过来则不行。因此LibreOffice相对来说会发展得更快一些。

### Docker

装上了WSL2的Ubuntu，本来打算直接在里面用dokcer的，但好像启动不了服务。后来查了一下，Docker Desktop有支持WSL2特性的功能，但是由于是实验性的功能，需要用最新开发版的Windows才可以支持。而开发版的Windows，可以通过提交Insider Program的申请来获得，鉴于工作环境不想用buggy的系统，就忍住不升级了。在Powershell下面用docker命令也是可以正常工作的。