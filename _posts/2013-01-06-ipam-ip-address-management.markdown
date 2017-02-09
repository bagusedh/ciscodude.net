---
layout: post
noindex: true
title: "IPAM: IP Address Management"
date: 2013-01-07 19:07:00 -0600
comments: false
categories:
- Nerd Projects
- Networking
- ISP
- System Administration
---
After a [recent discussion](http://mailman.nanog.org/pipermail/nanog/2012-December/thread.html#54210) about IP Address Management (IPAM) software for small ISPs on the NANOG mailing list, I decided to setup subnetsmngr for my ISP. I am a big fan of open source software, and the demos of commercial IPAM software I've seen so far did not impress me at all. The requirements were ... not stated other than php. A little digging resulted the following requirements: php, php gmp library, php postgresql library, and postgresql. Very simple! Postgresql has a built in inet type which is very useful in this case as it holds and validates IPv4 and IPv6 addresses and subnets.

<!--more-->

subnetsmngr was custom written by employees of [Mammoth Networks](http://www.mammothnetworks.com/), who have a very well designed website, and offer a very nice selection of kickass services! subnetsmngr supports IPv4 subnets, IPv6 subnets, sending SWIPs to ARIN, and apparently co-operates with the mysql back-end of powerdns. I need to look into this last part further as it may turn out to be very interesting indeed.

Good IPAM management is very important for a well organized and run network, as documentation errors and gaps cause headaches at the best of times, and are a nightmare to have to debug when a network event is occurring.

EDIT: Update 2013/01/07, I've been corresponding with the folks at Mammoth Networks and they have been receptive to a few feature requests. :-)
