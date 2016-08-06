---
layout: post
image:
  feature: https://ciscodude.net/images/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
title: "RFC3021: 31-Bit Prefixes on PtP Links"
date: 2013-10-22 10:26:37 -0600
comments: false
categories:
- Networking
- ISP
- Nerd Projects
- System Administration
---
Unless you've had your head stuck in the sand for the last few years, you've no doubt heard of IPv4 exhaustion by now. This doesn't have anything to do with the packets being too tired to continue, but the depletion of available IPv4 space to allocate. One of the ways that IPv4 exhaustion can be slowed is by using /31 netmasks on point-to-point interfaces which don't require broadcast. Protocols like ARP, OSPF, EIGRP, BGP, all operate just fine without a network and broadcast address.

<!--more-->

The traditional /30 used for point-to-point links uses 4 IP addresses.

*	network address
*	first ip
*	last ip
*	broadcast address

As you can see, this is a 50% waste, any traffic entering the interface/IP is bound for the IP, and vice versa. There is no need for broadcast in a situation like this. <strong>Unfortunately not all devices support /31's</strong>. I've recently moved my own internet to being routed over 2x/31's. The equipment on the ISP side is Cisco, and the equipment on my side is Cisco. This works well. Mikrotik routerboards unfortunately do not support /31's. There is some hackjobbery which can be done to make them work between each other (actually use 2 /32's to cover the /31 IP space). The posts on the Mikrotik forums are in fact quite annoying to try to read through, I could summarize that wasted hour of my life by simply saying "a lot of people don't know how to subnet, at all".

 
