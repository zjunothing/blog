---
title: dig 命令
date: 2017-03-23 22:06:25
tags: Linux
---
dig 命令是一个DNS 查询工具，可以用来向域名服务器（NS） 查询域名对应的 IP。
理解 dig 命令的输出有助于理解 DNS 的工作原理。

下面是一个 dig 命令的典型输出
{% asset_img img1.png %}
1. Header 信息，如dig版本号等
2. 查询信息，因为我们没有指定查询类型，所以默认是 A （Address） 类型的查询。 IN 表示 Internet 
3. 查询结果，给出域名对应的地址Address， 86400为缓存时间。
4. Authority section：告诉我们哪些域名服务器负责解析zjunothing.com域名。 可以看到查询类型是 NS， 表示ns3.linode.com这台域名服务器负责解析 zjunothing.com 域名。
5. Additinal section: 告诉我们每个域名服务器的地址。 查询类型变回 A
6. 统计信息。

dig 中常见的查询类型有：
* A:   the IP address
* NS : nameservers
* CNAME: alias(别名)
* MX : mail exchanges
* TXT: text annotations

可以使用 dig ANY 来指定匹配任何类型的查询
下面是 dig ANY google.com 的查询结果
{% asset_img img2.png %}


另外,还有些常用的 dig 命令
```bash
dig zjunothing.com +trace       #  可以看到整个 dns 的请求解析过程
dig zjunothing.com +short       #  short display. 
dig -x 8.8.8.8                  #  反向解析，从 ip 找对应的域名
dig @8.8.8.8 zjunothing.com     #  用 @dnsserver 来指定从特定 dns 查询。默认的 dnsserver 定义在  /etc/resolv.conf 
```




