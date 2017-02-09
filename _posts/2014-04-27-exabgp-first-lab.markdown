---
layout: post
noindex: true
title: "exabgp: first lab"
date: 2014-04-27 11:45:46 -0500
comments: false
categories:
- Networking
- Anycast
- IPv6
- BGP
- Nerd Projects
- Network Monitoring
- Programming
- Virtualization
---
I have been doing a [lot](https://www.iweb-hosting.co.uk/blog/using-bgp-to-serve-high-availability-dns.html) [of](http://vincent.bernat.im/en/blog/2013-exabgp-highavailability.html) [reading](https://github.com/Exa-Networks/exabgp/wiki) about [exabgp](https://github.com/Exa-Networks/exabgp). exabgp is a python BGP implementation which doesn't implement any host routing functionality at all, just transforms BGP messages into plain text or JSON which can be easily manipulate by scripts. This works both directions, allowing monitoring of route advertisements received from other BGP speakers, and injection of routes into a system.

This can be used to create your own BGP looking glass tools and high availability tools which automatically isolate and remove dead/broken services, be part of DDoS mitigation strategy, be a route server, or even inject anycast routes. I have collected my [exabgp-thoughts](https://github.com/tbaschak/exabgp-thoughts) into a github repo. My lab config also gets its own [repo](https://github.com/tbaschak/exabgp-labs) althought this is still blank at the time of writing.

I am interested in exploring all of these different roles for exabgp, as well as others which I haven't even conceived yet, so I have started setting up a lab to begin my own testing. My lab is pretty similar to [vincentbernat/network-lab](https://github.com/vincentbernat/network-lab/tree/master/lab-exabgp), I have the same host names and network topology. I have provisioned 8 Debian VMs so far for my lab. I have 2 edge routers which will run Bird fully meshed to 3 distribution routers, each distribution router has a worker connected to it totalling 3 workers as well. I intend on adding 2 route servers as well. In my case I will be attempting to build a route reflector (within one AS or confederation), and then also a route server (like an IX would use) using exabgp.

Scenarios I plan on labbing, and the order I'll tackle them likely:

*	high availability and anycast (DNS, web) using BGP
*	exabgp as a route reflector within a single AS or confederation
*	exabgp as an IX route server
*	bgp looking glass on top of route reflector and route server as well
*	DDoS mitigation through blackholing, and also injection of more specific routes to direct traffic to a scrubber appliance
	*	There is also another project I'd like to explore in combination with this -- [exaddos](https://github.com/Exa-Networks/exaddos), which aims to integrate with exabgp to allow a one-click anti-DDoS solution

**Update 2014-05-04:** I haven't had enough time this week to finish firing up these VMs and starting to create my labs yet.
