---
layout: post
title: "Manitoban BGP Growth Rate Strong"
external_url: https://ciscodude.net/2015/03/08/asn-growth-in-manitoba/
date: 2015-10-11 10:05:14 -0500
comments: false
share: true
description: "The number of Manitoban networks running BGP since 2012 has doubled. The first AS number was registered in 1996, and growth was slow and steady up until 2012. In 2012 two Internet Exchanges were announced in Winnipeg. Since then, growth has sky rocketed!"
categories: 
- Networking
- ISP
- Security
- Network Monitoring
- BGP
- System Administration
---
The number of Manitoban networks running BGP since 2012 has doubled. The first AS number was registered in 1996, and growth was slow and steady up until 2012. In 2012 two Internet Exchanges were announced in Winnipeg. Since then, growth has sky rocketed! 

<a href="/bgp/mb/asns/"><img src="/static/blog-img/2015-10-11-asngrowth-thumb.png" /></a>

(This is a followup to an [earlier blog post](/2015/03/08/asn-growth-in-manitoba/) of mine.)

I attribute this growth in networks running BGP directly to the formation of new Internet Exchanges in Manitoba, but also across Canada at the same time. Larger enterprise networks and even smaller ISP networks suddenly became aware of the simplicity that BGP offered. Compared with complex NAT fail over devices which broke many applications, BGP offers simplicity. 

BGP brought attention to stateless routing -- best practices enforce separation of firewalling and routing. This lets each device perform what it is best at. Routers can send and receive packets at high speed when they don't need to inspect the packets and mangle headers. Firewalls due to their inspection and statefulness aren't able to cope with the asymmetric nature of BGP and Internet routing; that a packet could exit one interface and return on another is normally a violation of one of a firewall's security policies.

The ability to advertise an address range or ranges to one or more upstreams, to turn up and down providers to route around problems, and to finally be in control and able to do something when routing problems with one provider caused customer complaints was a much needed solution to a problem which had paralyzed many networks all too often. 

It also came at the right time. 

There is a wide variety of mature hardware and software BGP solutions available today. For those with the available budget: Cisco, Brocade, and Juniper routers fit the bill. For others, Mikrotik and Vyatta/VyOS provided a packaged solution. OpenBGP, Quagga, and Bird software packages are installable for server and virtualization based BGP solutions.

