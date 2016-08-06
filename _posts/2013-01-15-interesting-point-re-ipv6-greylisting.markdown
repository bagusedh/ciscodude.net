---
layout: post
image:
  feature: https://ciscodude.net/images/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
title: "Interesting Point Re: IPv6 Greylisting"
date: 2013-01-15 22:22:00 -0600
comments: false
categories:
- Security
- Networking
- IPv6
- System Administration
---
I was browsing some of the [IPv6 related blog posts on HE.net](http://ipv6.he.net/certification/popular_postings.php), and I came across [this interesting one](http://warrenkwok.blogspot.hk/2013/01/greylisting-and-dual-stack-mail-servers.html) regarding greylisting.

<!--more-->

Because of "happy eyes" a connection that immediately fails on IPv6 will fail over to IPv4, so if greylisting is used only on IPv6 it will not be as effective as planned.
