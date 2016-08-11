---
layout: post
title: "Troubleshooting ICMPv6 with Tcpdump"
date: 2014-10-23 20:39:51 -0500
comments: false
description: "I've previously written about my OpenBSD PF firewall in front of my VM server at my colo. I had a firewall rule which used the following variable: icmp6_types=\"{ 2, 128 }\". This wasn't working properly on the LAN side, and I had to disable the ICMPv6 restrictions to get things back to working. I wanted to fix this permanently, the right way, by determining what needed to be allowed and what could be denied without breaking things."
categories:
- Security
- IPv6
- CLI
- Networking
- Network Monitoring
- System Administration
- Troubleshooting
image:
  feature: https://ciscodude.net/static/blog-img/foggy-morning.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
share: true
---
I've [previously written about](/2014/10/09/firewall-log-stats/) my OpenBSD PF firewall in front of my VM server at my colo. I had a firewall rule which used the following variable: `icmp6_types="{ 2, 128 }"`. This wasn't working properly on the LAN side, and I had to disable the ICMPv6 restrictions to get things back to working. I wanted to fix this permanently, the right way, by determining what needed to be allowed and what could be denied without breaking things.

## Tcpdump To The Rescue

I started to tcpdump on the internal interface, to establish exactly which ICMPv6 types were needed for regular operation. I was using `tcpdump -i vlanXX ip6`, which was WAY too verbose. I eventually found [this really helpful blog post (now dead)](http://note-to-self.baker.com/2013/01/01/tcpdump-of-icmpv6-router-advertisments/) [web.archive.org link of the blog](https://web.archive.org/web/20140501050744/http://note-to-self.baker.com/2013/01/01/tcpdump-of-icmpv6-router-advertisments/) which suggested using the following to troubleshoot NDP issues.

{% highlight bash %}
tcpdump -i eth0 'ip6 && icmp6 && (ip6[40] == 133 || ip6[40] == 134 || ip6[40] == 135 || ip6[40] == 136)'
{% endhighlight %}

Looking at the table of [Types of ICMPv6 Messages](https://en.wikipedia.org/wiki/ICMPv6#Types_of_ICMPv6_messages) on Wikipedia, these numbers correspond to the following strings:

ICMPv6 Value | Meaning / Error Message
------------ | -----------------------
133	| Router Solicitation (NDP)	
134	| Router Advertisement (NDP)
135	| Neighbour Solicitation (NDP)
136	| Neighbour Advertisement (NDP)
137	| Redirect Message (NDP)

