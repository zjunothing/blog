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

### 2. grep 命令
```
grep "my_word" . -r                     # 当前文件夹下查找"my_word",  .表示当前文件夹，-r Recursively
grep -A1 "spring-context" pom.xml       # 显示匹配行以及之后的一行, -A after。 用来查找特定 jar 并显示版本

# !Attention
grep "my_file.xml"  *.jar                 # 查找 jar 中的特定文件
find *.jar | xargs -n1 zipgrep "my_word"  # 查找 jar 中的特定内容
# 此处 xargs -n1 表示一次传入一个参数给后面的 zipgrep， 因为 zipgrep 命令一次只接收一个参数！
```

### 3. find 命令
``` bash
# 批量文件操作
# find 和 xargs 连用时，养成习惯 -print0 | xargs -0 ，表示用NUL（\u00）做文件分隔，这样就能处理特殊文件名了。
find . -name "*.md" -type f  -print0 | xargs -0 -I{} mv {} {}_bak     # 批量备份某种文件,  -I 获取input
for f in $(find . -name "*_bak" -type f); mv "$f" "${f%_bak}"          # convert back.
find . -name "*_bak" -print0 | xargs -0 -I {} mv {} $(echo {}|sed 's/_bak//g')   # Why this can NOT work?

find . -name "*.md" -print0 | xargs -0 -I {} cp -p {} /target_path/     # 批量拷贝

find . -name "*.md" -print0 | xargs -0 sed 's/foo/bar/g'                # 批量替换文件中的 foo 到 bar
find . -name "*.md" -print0 | xargs -0 -i '' 's/foo/bar/g'              # mac 中需要加上-i参数，参数值置空标识不备份
find ./test -not -name "*.php" | xargs rm -rf                           # 删除所有非.php 的文件

```

### 4. sudo 与 redirect 联合使用
sudo之后使用了重定向，则重定向不会具有sudo权限 参考[这里](http://stackoverflow.com/questions/82256/how-do-i-use-sudo- to-redirect-output-to-a-location-i-dont-have-permission-to-wr)
``` bash
sudo sh -c 'ls /root/ > /root/test.out'  # 使整个命令都用sudo权限执行
```

