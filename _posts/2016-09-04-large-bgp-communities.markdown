---
layout: post
image:
  feature: https://ciscodude.net/static/blog-img/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
title: "Large BGP Communities"
date: 2016-09-04 00:33:00 -0500
comments: false
share: true
description: "One of the things I noticed when I received a 32-bit ASN was that I was unable to use my ASN in my BGP communities. I’m not the only one who has noticed this, and work has begun on a Draft Standard, Large BGP Community to address this shortcoming."
categories: 
- Networking
- ISP
- BGP
- System Administration
- Troubleshooting
- CLI
---
One of the things I noticed when I received a [32-bit ASN](/2016/04/13/as395089/) was that I was unable to use my ASN in my BGP communities. I'm not the only one who has noticed this, and work has begun on a Draft Standard, [Large BGP Community](https://tools.ietf.org/html/draft-heitz-idr-large-community-03) to address this shortcoming.

### RFC Draft

The draft has gone thru several revisions, 00 thru 03 have been released, and 04 is being worked on at the moment on [Github](https://github.com/large-bgp-communities/large-bgp-communities).

### Implementation Status

While this is still a draft, there is a recognized need for some sort of an update to BGP communities to allow use of 32-bit ASNs. So far ExaBGP and Cisco IOS XR have support. Nokia SR-OS, and Bird are currently in progress. This is being tracked at [largebgpcommunities.net](http://largebgpcommunities.net/)

### The RFC Process

I've wanted to be involved in the process of creating an RFC for a while now, and as a result watching this draft progress is very intersting to myself. Also, having a 32-bit ASN, I've got skin in the game.

