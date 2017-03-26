---
title: linux实用技巧
tags: linux
date: 2017-03-26 17:21:13
---


### 1. vi write with sudo
vi 修改了文件之后，保存时发现没有权限，work aroound 方式：
```bash
:w !sudo tee %              # 用 sudo 命令保存当前文件
# why?  see: http://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work
:w !sudo sh -c "cat > %"    # 作用同上
```
其中 
* `:w`  :write file.
* `!{cmd}`: run shell command.
* `%` :current file.

