---
layout: post
title: "IPAM: NIPAP"
date: 2014-03-23 20:47:17 -0500
comments: false
categories:
- Nerd Projects
- Networking
- ISP
- IPv6
- CLI
- System Administration
---
While I [wrote about IPAM](/2013/01/07/ipam-ip-address-management/) last January, I never finished setting up everything in subnetsmngr. It was difficult to allocate a custom subnet, requiring going into the database to actually insert the prefix, and then rebuild the remaining subnets around the hole created. The discussion has come up on NANOG again, and someone suggested [NIPAP](http://spritelink.github.io/NIPAP/index.html). NIPAP is also based on postgres (its built in support for IP addresses makes it much easier than MySQL).

I spent some time this weekend setting up NIPAP, and there are some really nice features in it.

*	easily allocate any subnet, not just the next available
*	IPv4/IPv6 feature parity
*	VRF support
*	CLI for the hardcore
*	functional and stylish web interface
*	ability to assign subnets in specific areas from a pool
*	ability to document reservations, as well as individual /32 and /128 hosts
