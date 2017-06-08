---
title: hhkb基本设置
date: 2017-05-28 22:09:48
tags: Tools, hhkb, karabiner
---


终于还是下手买了 hhkb professinal2, 这款键盘可以说是键盘里面的终极版了。
基本设置网上一搜一般都有, 现在记录几个用起来严重不顺手的地方，以及解决方案：

### 方向键
方向键， 默认方向键是 Fn + \[/;'  使用起来感觉不太舒服，可以使用  [Hammerspoon](http://www.hammerspoon.org/) 来重新映射上下左右的方向键。
vim 党倾向于使用 ctrl + jkhl 来表示上下左右，所以在 hammerspoon 的 init.lua 中添加如下 lua 脚本：
```
local function pressFn(mods, key)
	if key == nil then
		key = mods
		mods = {}
	end

	return function() hs.eventtap.keyStroke(mods, key, 1000) end
end

local function remap(mods, key, pressFn)
	hs.hotkey.bind(mods, key, pressFn, nil, pressFn)	
end


remap({'ctrl'}, 'h', pressFn('left'))
remap({'ctrl'}, 'j', pressFn('down'))
remap({'ctrl'}, 'k', pressFn('up'))
remap({'ctrl'}, 'l', pressFn('right'))

remap({'ctrl', 'shift'}, 'h', pressFn({'shift'}, 'left'))
remap({'ctrl', 'shift'}, 'j', pressFn({'shift'}, 'down'))
remap({'ctrl', 'shift'}, 'k', pressFn({'shift'}, 'up'))
remap({'ctrl', 'shift'}, 'l', pressFn({'shift'}, 'right'))

remap({'ctrl', 'cmd'}, 'h', pressFn({'cmd'}, 'left'))
remap({'ctrl', 'cmd'}, 'j', pressFn({'cmd'}, 'down'))
remap({'ctrl', 'cmd'}, 'k', pressFn({'cmd'}, 'up'))
remap({'ctrl', 'cmd'}, 'l', pressFn({'cmd'}, 'right'))

remap({'ctrl', 'alt'}, 'h', pressFn({'alt'}, 'left'))
remap({'ctrl', 'alt'}, 'j', pressFn({'alt'}, 'down'))
remap({'ctrl', 'alt'}, 'k', pressFn({'alt'}, 'up'))
remap({'ctrl', 'alt'}, 'l', pressFn({'alt'}, 'right'))

remap({'ctrl', 'shift', 'cmd'}, 'h', pressFn({'shift', 'cmd'}, 'left'))
remap({'ctrl', 'shift', 'cmd'}, 'j', pressFn({'shift', 'cmd'}, 'down'))
remap({'ctrl', 'shift', 'cmd'}, 'k', pressFn({'shift', 'cmd'}, 'up'))
remap({'ctrl', 'shift', 'cmd'}, 'l', pressFn({'shift', 'cmd'}, 'right'))

remap({'ctrl', 'shift', 'alt'}, 'h', pressFn({'shift', 'alt'}, 'left'))
remap({'ctrl', 'shift', 'alt'}, 'j', pressFn({'shift', 'alt'}, 'down'))
remap({'ctrl', 'shift', 'alt'}, 'k', pressFn({'shift', 'alt'}, 'up'))
remap({'ctrl', 'shift', 'alt'}, 'l', pressFn({'shift', 'alt'}, 'right'))

remap({'ctrl', 'cmd', 'alt'}, 'h', pressFn({'cmd', 'alt'}, 'left'))
remap({'ctrl', 'cmd', 'alt'}, 'j', pressFn({'cmd', 'alt'}, 'down'))
remap({'ctrl', 'cmd', 'alt'}, 'k', pressFn({'cmd', 'alt'}, 'up'))
remap({'ctrl', 'cmd', 'alt'}, 'l', pressFn({'cmd', 'alt'}, 'right'))

remap({'ctrl', 'cmd', 'alt', 'shift'}, 'h', pressFn({'cmd', 'alt', 'shift'}, 'left'))

```
之后就可以使用 ctrl + jkhl 来作为上下左右键啦！ 并且是全局生效的。

### IDE 调试F1 ~ F10 键

java 开发使用 ide，调试不免用到 F7~F10 ， hhkb 中需要按住 Fn + 7~10， 特别麻烦， work around 的方法是重新映射，需要下载 [Karabiner-Elements](https://github.com/tekezo/Karabiner-Elements/blob/master/usage/README.md) 将数字键7~10 映射成 F7 - F10 ， 这样调试时候就方便多啦。不过要使用普通7-10时，需要设置回来；可以建立两个 karabiner 的 profile，来回切换，debug 时候切换成 profile1， 非 debug 时候切换到 profile2.

### Karabiner-Elements 不同的 profile 之间的切换
接上一条，设置了多个 profile 之后，profile 之间的切换没有快捷键，每次要点鼠标切换不同 profile 非常不方便。
最终找个一个解决方案还比较合适，方法如下：
Karabiner-Element 的配置配置文件在 ~/.config/karabiner/karaniber.json 
其中当前使用哪个 profile 是由这句控制的：
```
 "name": "Default",  # Default is my profile name.
 "selected": true
```
selected: true 表示当前 profile 被激活，false 标识没有激活。 所以方法就是写段脚本改变不同 profile 的 selected 值。

例如我有两个 profile： Default & Debug 
我就写了两个小脚本
```
#  Default-profile.sh
echo "Using K-Default profile"
gsed -i '/"name": "Debug"/!b;n;c"selected": true,' ~/.config/karabiner/karabiner.json
gsed -i '/"name": "Default"/!b;n;c"selected": false,' ~/.config/karabiner/karabiner.json
```

```
#  Debug-profile.sh
echo "Using K-Debug profile"
gsed -i '/"name": "Debug"/!b;n;c"selected": true,' ~/.config/karabiner/karabiner.json
gsed -i '/"name": "Default"/!b;n;c"selected": false,' ~/.config/karabiner/karabiner.json
```
(因为 mac 下的 sed 的工作方式和linux 下 sed 稍有不同，这里使用了gsed（gnu-sed）, 可以使用 brew install gsed 来安装

然后将两个脚本写入到 bashrc  中，alias 一下，这样不同 profile 之间的切换就非常方便了。


其他方面暂时没有遇到不顺手的，遇到的时候再来补充啦。
