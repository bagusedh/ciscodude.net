---
layout: post
title: "Mikrotik SNMP Oddity"
date: 2015-01-19 14:48:58 -0600
comments: false
description: "I've been trying to track down an issue with SNMP on one of two redundant Mikrotik Cloud Core CCR1036-12G-4S routers."
categories: 
- Nerd Projects
- Networking
- System Administration
- CLI
- Security
- BGP
- Network Monitoring
- Troubleshooting
share: true
---
I've been trying to track down an issue with SNMP on one of two redundant Mikrotik Cloud Core CCR1036-12G-4S routers. For some reason, approximately 40 days ago, one of the two routers stopped responding to SNMP from my monitoring station on its "loopback" (which is actually a Mikrotik bridge with no interfaces on it)

I've been troubleshooting this at various levels, to no avail. Some of the things tried, in order.

*	turning SNMP off/on on the router
*	changing SNMP community
*	packet capture at the edge firewall
*	torch on the router in question
*	tcpdump on the monitoring host itself, while running the following to generate SNMP traffic

{% highlight bash %}
while true; do snmpwalk -v2c -c community hostname system; done
{% endhighlight %}

Tcpdump on the monitoring host itself showed no response from the IP in question. The firewall showed the connections making it outbound, and no response coming back either. Torch also showed inbound packets, but no outbound packets. 

At this point I began to suspect a software issue/oddity. I ran a search for SNMP under the general products forum on forum.mikrotik.com, and found the [following thread](http://forum.mikrotik.com/viewtopic.php?f=2&t=64439) which seemed to be the same problem I was having.

During my troubleshooting process, I had tried to make SNMP requests to an interface IP, but as that interface wasn't the return path, it also exhibited the same problems (no return traffic).

I changed my `/etc/hosts` file entry for the monitored host to be the "closest" interface IP on the router, and SNMP instantly started responding. 

I would consider this a bug in the implementation on the Mikrotik, apparently its needed for weird NAT situations. My response would be "well don't create weird NAT situations then", but that's not how Mikrotik feels about the issue.

After figuring out the problem, I made the following diagram to explain what had been happening. The blue path is to the router (BGP2), and the red path is the path the router would choose to return traffic over. Due to the SNMP implementation though, it refuses to return traffic via a different interface.

<img src="/static/blog-img/2015-01-19-mikrotik-snmp-interfaces.png">
