---
layout: post
image:
  feature: https://ciscodude.net/static/blog-img/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
title: "Building an OpenBSD BGP Looking Glass"
date: 2013-01-27 23:03:00 -0600
comments: false
categories:
- Nerd Projects
- Networking
- IPv6
- ISP
- BGP
- System Administration
---
One of the really handy things that has been included in OpenBSD for quite some while, is a handy shell, and CGI BGP looking glass. Rather than copy and paste someone elses blog, I'll just [link the handy guide I followed](http://www.knowledgebombs.net/blog/2012/12/13/bgplg-from-scratch.html). This guide is complete, including explaining why ping/ping6/traceroute/traceroute6 don't work under /var in the chrooted environment.

<!--more-->

Since apache is being phased out in OpenBSD, I wonder what the solution will be for nginx? Someone will probably rewrite it in a fancy way.

**Update:** I have since [written a blog](/2014/05/14/openbsd-5-dot-5-bgplg/) about building an OpenBSD BGPLG with nginx.
