---
layout: post
image:
  feature: https://ciscodude.net/static/blog-img/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
title: "I'm doing AnyCast!"
date: 2013-10-05 16:19:04 -0600
comments: false
categories:
- Anycast
- Nerd Projects
- Networking
- IPv6
- ISP
- BGP
- System Administration
---
I am now doing AnyCast with IPv4/IPv6 on <a href="https://henchman21.net">henchman21.net</a>.

I have a lo1 interface with 206.220.196.21/32 and 2604:4280:6865:6e63:686d:616e:3231:21/128 bound to it, running on 2 virtual machines, one at home, one @ 167 Lombard. I am then running <del>OpenOSPFD</del>Bird on them to inject the route into OSPF.

<!--more-->

Most places get the copy from the VM @ Lombard, but my house gets the copy on VM here.

I don't currently allow my OSPF injection to leave my house, so only my house gets this local copy.

<del>Unfortunately FreeBSD only has OpenOSPFD 4.3 and only IPv4, I don't know why they're so far behind. I may switch to something else for OSPF.</del> I have switched to Bird.

I intend to do http/https and DNS over this AnyCast service in the future.

**Update Later that day:**

I switched from net/openospfd to net/bird and net/bird6, these provide ipv4 and ipv6 OSPF routing to allow the use of 2604:4280:6865:6e63:686d:616e:3231:21/128 as anycast as well too. This is actually 2604:4280: + henchman encoded in hex + :21

Software Used:

*	FreeBSD 9.2
*	net/bird &amp; net/bird6
*	www/nginx
*	bind9 (down the road)

