---
layout: post
title: 命令行工作环境再次上手
s: terminal-again
tags: linux
date: 2017-12-31
---

买了一台新电脑以后，加上之前入手的HHKB type-s，现在终于可以开始打造一个纯hacker型的开发和工作的环境了。

我打算第一步是先把多年以来想拿起来的VIM重新学习一遍，让它真正可以融入到我的每个日常工作里。之前虽然也用不少vi，但毕竟都是键盘鼠标并用的，而且只用到了一些很基本的功能，能胜任一些命令行下的工作，但未能真正用到最高效的方式。如果能够完全摒弃鼠标的话，我估计开发效率会更高很多。当然，其实也有可能是某些开发工作还是必须依赖鼠标的，越接近前端界面性质的工作，越可能需要鼠标的交互。


## Tmux - 命令行下的多窗口多任务

我们用各种GUI系统，给我们带来最方便的好处是它们可以有多个工作桌面（desktop，或者叫workspace），在每个桌面上你可以打开不同的应用程序，这样在一台电脑上，你可以方便切换正在做的不同工作。比如说一个桌面用来浏览网页，用另一个来打开编程工具，然后还有一个桌面放聊天工具。这样当你在切换桌面的时候可以专注在当前的工作上，并且可以方便地在不同工作中暂停、切换和恢复。

那如果你只在命令行界面下又怎么办呢？——[Tmux](https://github.com/tmux/tmux/wiki)，它可以实现跟其他GUI界面相类似的多窗口，多工作区切换的功能，而且是在纯字符界面的终端下实现，仅通过键盘来操作（解放鼠标！）

在这里就不详细介绍安装方法和配置了，只简单记录一下我可能会常用到的一些功能快捷键，以便我自己查询。

#### 1 基本概念

__tmux__ 有三个层级：session会话, window窗体, pane面板。

如果你用ssh的话，可以随时用以下命令恢复到上一个session的状态，不管你是程序突然中止了或者是按快捷键退出的，都可以恢复。

```bash
$ tmux attach
```

当进入一个tmux session以后，默认是会打开一个window窗体，通过快捷键，你可以将window切分成多个不同的pane面板，然后再通过快捷键在不同的面板之间切换。


#### 2  快捷键

__tmux__的快捷键都要先输入一个特殊的快捷键为前缀（`Ctrl+b`），一般成为tmux key，以下快捷键列表里就直接省略了。

（注：C = Ctrl， M = Alt）

```

# 在Window下对pane的操作

  %   切分成左右两个pane
  "   切分成上下两个pane
  !   关掉除当前以外的所有pane
  x   关掉当前的pane
  上下左右方向键  按方向切换焦点到不同的pane里
  o   下一个pane
  ;   上一个使用的pane
  q   列出pane数字

  {   将pane移动到上一个位置
  }   将pane移动到下一个位置
  C-o 将pane向上滚
  M-o 将pane向下滚

  M-上下左右  调整大小（5行为单位）
  C-上下左右  调整大小（1行为单位）

  M-1 水平平分
  M-2 垂直平分
  M-3 主界面垂直平分
  M-4 主界面水平评分
  M-5 tiled layout？
  Space   切换到下一种pane layout


# 对Window的操作

  0-9 选择window从0至9
  $   重命名当前window
  p   上一个window
  n   下一个window
  l   上一个使用的window
  w   显示window列表
  ,   重命名当前window
  &   关掉当前window
  c   开一个新的window

# 对Session的操作

  (   上一个session
  )   下一个session
  L   上一个使用的session
  s   显示session列表
  $   重命名当前session
  d   detach当前session

# 其他

  ?   列出快捷键
  :   出来像vi一样的命令行

```

除此以外，tmux还有一个叫做`copy-mode`的模式，本来是用于选择和复制的，但在终端里还可以帮助你翻看前面的内容。以下是copy-mode相关的快捷键：

```



```



更多信息可以查阅tmux的man page，里面有详细的快捷键列表:
[man tmux](http://man.openbsd.org/OpenBSD-current/man1/tmux.1#KEY_BINDINGS)

#### 3 配置文件

tmux的配置文件默认是读取`/etc/tmux.conf`，然后再尝试读取`~/.tmux.conf`文件。另外，还可以通过`source-file`命令来指定配置文件。这就意味着你可以设计一个专注做某件事情的workspace，然后把相应的配置写到一个conf文件里，通过以下命令初始化这个workspace：

```shell
$ tmux source-file ~/.tmux/workspace1.conf
```







#### 4 命令（Commands）

tmux本身有许多命令行参数可以利用，不管是在配置文件还是命令，都通过这些命令来完成必要的配置或者是脚本操作。用以下命令可以查看所有的tmux命令：

```shell
$ tmux list-commands
```

举个例子说，我们可以通过session来创建多个工作空间，这时可以用上session相关的命令

```shell
# 查看所有session
$ tmux list-sessions
# 新建一个session
$ tmux new-session -c start-directory -s session-name
# 判断session是否存在
$ tmux has-session -t target-session
# 


```





### 参考链接

1. Vim的官方文档: <https://vim.sourceforge.io/docs.php>
2. 终极至上！将Vim打造成全新的集成开发环境！: <https://linux.cn/article-2355-1.html>
3. 开发者的使用Vim插件系列: <https://linux.cn/article-7901-1-rel.html>
4. Linux中国关于Vim的文章: <https://linux.cn/tag-vim.html> 
5. 如何将Vim打造成一个成熟的IDE: <https://linux.cn/article-3314-1.html>
6. 使用tmux打造更强大的终端: <https://linux.cn/article-8421-1.html>
