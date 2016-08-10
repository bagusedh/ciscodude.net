---
layout: post
noindex: true
title: "New Looking Glass"
date: 2014-11-24 01:50:35 -0600
comments: false
description: "I've often wished for a more customizable Looking Glass to run, which doesn't necessarily need to include BGP output. I found this recently in LookingGlass which I have set up on lg.hextet.net."
categories: 
- Nerd Projects
- IPv6
- System Administration
- Networking
- CLI
- Programming
image:
  feature: https://ciscodude.net/static/blog-img/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
share: true
---
I've often wished for a more customizable Looking Glass to run, which doesn't necessarily need to include BGP output. I found this recently in [LookingGlass](http://github.com/telephone/LookingGlass) which I have set up on [lg.hextet.net](http://lg.hextet.net/).

This simple but effective PHP script favours nginx for configuration which is more than fine with me, it is preferred. It also implements configurable rate limiting to prevent abuse. The setup script also creates/links whatever size test files you would like to offer as well which is quite handy. All-in-all a very handy package. The only thing which would add to this noc-tool-in-a-box would be if it perhaps automatically created a speedtest.net mini test site along with the download test links. :-)

- - -

I've [submitted an issue with the upstream](https://github.com/telephone/LookingGlass/issues/25) on this utility to install the mtr-tiny package on Debian instead of mtr. I may write this patch myself, and submit it too depending on upstream interest.
