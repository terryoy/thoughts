---
layout: post
title: 不要浪费时间在修问题上
tags: misc
author: terryoy
---

今天晚上从八点半开始，花了足足四个小时，尝试在公司项目模块下改一个webpack配置，以希望能够在模块层面跑起一个web项目来测试该模块——然而最终还是失败。

其实这个问题在第一个小时里面已经卡在那里了，由于一直没有弄明白webpack的一些机制，于是在几个不同的配置参数上改来改去。一边在搜索引擎上找答案线索，一边在本地不断重复跑webpack调试，但其实核心问题还是由于自己对DllPlugin机制不了解，以及webpack-dev-server下面是怎样配其一个dev服务器的功能不了解。

这次总结的经验就是，与其花大量的时间在“调试”问题上，还不如把这些时间放在真正弄明白整个机制上获得更大的收获。因为在这四个小时里面，如果我把剩下的三个小时都花在阅读webpack的文档，系统地了解它的plugin机制是怎么工作的，就不至于好无方向地在变换方法尝试；并且，即使我这次侥幸可以把它调通，我仍然还是不了解它为什么会这样工作，下次仍然要花那么多时间在解决一个类似的问题上——而且，这个问题又不是什么价值百万的问题，几时解决了并不会给你带来什么成就感。

然而，如果你从这个问题上重新整理了你的知识，充分理解了它背后的原理，能够在下次遇到同类问题的时候马上可以得出结论，那这些时间就会花得非常值得。

因此，节省这个时间的最好办法是：

>  在判断目前不能理解该问题的时候，就不要急着尝试解决这个问题，而是尝试去弄明白工作原理，再回过头来解决问题。

由于我是一个“受压力驱动”的人，所以我感觉过去这种问题我已经反反复复犯过很多次了，浪费了无数的黄金时间。比如说花一个星期装系统，反复调试一些不能工作的设备，等等。以后必须要知道“知识”和“问题”哪个价值更高！不要为问题而舍弃了学习知识的时间。