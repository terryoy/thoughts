---
layout: post
title: 继续尝试搭建Vim的工作环境
tags: misc
date: 2020-02-02
author: terryoy
---

之前在mac下面一直用atom editor，整体感觉还好，但有点受不了它的一些效率问题，而且有时会跟chrome一起卡死。这次趁着换windows电脑的机会，抽空再研究一下vim的工作流，尝试能在工作中应用到（老实说，这个技能不方便peer programming）。

## NeoVim

目前都说nvim是一个优秀的fork版本，我也就以这个为基础尝试搭环境了，反正据说新版的Vim 8借用了它不少的概念，而且保持了一定的兼容。

学习vim的时候最难的是记忆各种按键命令，这么多年了仍然没有变。我觉得要能高效实用vim，学习方法很重要。因此我的思路是，首先要了解其知识脉络，要理解它的“语言”和它的“辅助工具”是什么。VIM其实有非常详尽的文档，因此问题就在于遇到不会的时候怎样更好地利用文档来解决而不是用搜索引擎来解决。

### 帮助文档

VIM的帮助文档工具是非常强大的，首先你要学会检索其帮助内容：

```
:h
```

用help的缩写“h”，就可以快速地调出帮助的功能，但先不要急着按回车，因为`:h`后面是可以跟帮助主题或者按键的描述。如下面红框所示的，这些都可以作为被帮助搜索的关键字：

![image-20200202175726681](C:\Users\terry\AppData\Roaming\Typora\typora-user-images\image-20200202175726681.png)

其次是，在你填入主题的时候，并不需要全部都记住这些关键字，而是可以使用tab来进行提示，并查找到你想要的主题：

![image-20200202175452555](C:\Users\terry\AppData\Roaming\Typora\typora-user-images\image-20200202175452555.png)

而如果光标在某个关键字下，你想查看该关键字的相关帮助，可以用 `Ctrl+]` 跳转。其中最重要的一个主题应该属于这个了：

```
:h quickref
```



### Vim语言

要牢记一长串快捷键并不容易，但Vim的快捷键设计是有一定的语言逻辑的，掌握了这个内在的逻辑对理解Vim指令有更好的帮助。

一个常用的Vim的语句可以简单表达为：`verb` + `modifier` + `object`。

| Verbs       | Modifiers                                        | Objects             |
| ----------- | ------------------------------------------------ | ------------------- |
| v(isual)    | i(nside)                                         | w(ord)              |
| c(hange)    | a(round)                                         | s(entence)          |
| d(elete)    | t(ill...finds a character)                       | p(aragraph)         |
| y(ank/copy) | f(ind...like till exept including the character) | b(lock/parentheses) |
|             | /(查找string或regex)                             | t(ag, 比如HTML/XML) |

以下看一些例句：

* diw(delete inside word)，删除当前单词
* cis(change inside sentence)，更改当前句子
* ci"



### 一些核心功能

#### Auto Commands（查看帮助 `:h autocmd` ）

`autocmd`可以基于文件名或文件类型来配置一些特定的选项。比如：

```
" 给文件后缀名设置文件类型
autocmd BufRead,BufNewFile *.pp setfiletype ruby
" 给某个文件类型设置属性 
autocmd FileType yaml set tabstop=2 shiftwidth=2
```

#### Persistent undo（查看帮助 `:h undo-persistence`）

可以让你持久化文件修改的历史。当你下一次打开同一个文件的时候，你仍然能得到之前的编辑历史。这个功能一旦你习惯上了就很难再适应其他编辑器。

#### Clipboard（查看帮助 `:h 'clipboard'）

Linux下面剪贴板是非常复杂的，虽然y & p 按键可以做复制和粘贴，但你要在与其他应用之间（如浏览器）做复制粘贴的话，还需要特别的配置。(见参考文章1)

#### Mappings(查看帮助 `:h mapping`)













#### 参考文档

* 1. [How I revamped my Vim setup](https://alex.dzyoba.com/blog/vim-revamp/)
* 2. [Learn to speak vim — verbs, nouns, and modifiers!](https://yanpritzker.com/learn-to-speak-vim-verbs-nouns-and-modifiers-d7bfed1f6b2d)

