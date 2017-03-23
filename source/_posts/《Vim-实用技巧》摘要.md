---
title: Vim 使用技巧
date: 2017-03-22 22:09:48
tags: Vim
---

## Tip1 . 命令
> . （点）命令是一个很好用的命令，它可以让你重复上次的修改
eg1. 每行向右缩进
{% asset_img img2.png %}
eg2. 在每行末尾添加分号
{% asset_img img1.png %}

_点命令范式： 一键移动，另一键操作 （perfect！)_

## Tip2  操作符 + 动作命令 （operator + motion）
> 可以先查看帮助了解这两个概念 
:h operator
:h motion
```bash
# 举例：
daw         # 删除当前单词 记忆 Delete A Word.  其中 d 为 operator， aw 为 motion
vi"         # 选中引号内的内容。 v为 operator， i" 为 motion
ct,         # 删除当前位置到逗号的所有内容，并进入插入模式。 c 为 operator，t，为 motion
```

_每学一个操作符或者命令动作，就像学习了一个新单词；操作符+动作命令 就像是这些单词组成的句子。 通过operator+motion 不同方式的组合，使得 vim 的编辑能力异常强大。_

## Tip3  插入模式下，更改当前文本
> 在插入模式下，如果要更改文本，只有退格键可用。
若要更改光标右侧的文本，则只能: 切换到普通模式 -> 移动 -> 删除 -> 切回插入模式，非常不方便。
下面是一些技巧，可以在插入模式下更改当前文本，不用切换模式。
```bash
c-h             # c-{char} 标识同时按住 ctrl 和{char}。 删除左边字符，同退格键
c-w             # 删除左侧单词
c-u             # 删除到行首
# 可以设置 vimrc 来添加删除右侧字符的按键, 如添加 inoremap <C-d> <Esc>lxi
c-d             # 删除右侧单词
```

## Tip3 返回普通模式
> 除了 Esc 以外，可以用 c-[ 来返回普通模式
习惯之后，你会发现 c-[  更好用，因为 Esc 键太远！
当然，你的 control 键应该是在Cap键的位置 :)
