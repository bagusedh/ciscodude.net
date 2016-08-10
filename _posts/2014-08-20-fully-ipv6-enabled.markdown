---
layout: post
title: "Fully IPv6 Enabled"
date: 2014-08-20 14:23:28 -0500
description: "With the deployment of a new nameserver at DigitalOcean NYC3 yesterday, I have hit a fairly significant personal milestone -- All of my public facing services are now fully IPv6 enabled."
comments: false
categories: 
- Nerd Projects
- IPv6
- Cisco
- Virtualization
- SaltStack
- System Administration
- Networking
image:
  feature: https://ciscodude.net/static/blog-img/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
share: true
---
With the deployment of a new nameserver at [DigitalOcean](https://www.digitalocean.com/?refcode=f6432a6e1354) NYC3 yesterday (to replace one at NYC2, which doesn't have IPv6), I have hit a fairly significant personal milestone -- All of my public facing services are now fully IPv6 enabled. 

This includes:

*	Various http/https websites running nginx and Apache
	*	Some of which are anycasted
*	Mail services
	*	SMTP (postfix)
	*	IMAPS (dovecot)
	*	POP3S (dovecot)
*	DNS
	*	Nameservers
	*	Recursive DNS
*	System services like SSH, FTP
*	SSL VPN which gives out IPv4 and IPv6 addresses
	*	Cisco ASA running Cisco ASA 9.1(3)
*	SaltStack
*	Nagios monitoring
	*	2 dual-stack instances

I enjoy the output from check-soa now for my zones:

{% highlight text %}
check-soa -i ciscodude.net
ns0.ciscodude.net.
	199.202.21.6: OK: 2014081301 (0 ms)
	2604:4280:d000:11::6: OK: 2014081301 (0 ms)
ns1.henchcdn.com.
	2400:6180:0:d0::55:9001: OK: 2014081301 (238 ms)
	128.199.164.153: OK: 2014081301 (272 ms)
ns2.henchman21.net.
	2604:a880:800:10::8:7001: OK: 2014081301 (35 ms)
	104.131.53.95: OK: 2014081301 (43 ms)
ns3.hcdn.pw.
	2a03:b0c0:1:d0::f:c001: OK: 2014081301 (101 ms)
	178.62.61.54: OK: 2014081301 (108 ms)
{% endhighlight %}

In addition, I have native IPv6 access at home. There is also a local Hurricane Electric tunnel server in Winnipeg now, and also a local Hurricane anycast DNS resolver.

{% highlight text %}
traceroute6 -q1 -I 2001:470:20::2
traceroute to 2001:470:20::2 (2001:470:20::2), 30 hops max, 80 byte packets
 1  2604:4280:d000:11::1 (2604:4280:d000:11::1)  0.400 ms
 2  vl270.ar1.400wb.ipv6.as14866.net (2604:4280:14:866::270:1)  1.092 ms
 3  vl13.ix1.400wb.ipv6.ywg.as14866.net (2604:4280:14:866::13:2)  1.336 ms
 4  he-ix.v6.wpgix.net (2001:504:2c::20)  3.466 ms
 5  ordns.he.net (2001:470:20::2)  3.245 ms
{% endhighlight %}

