---
layout: post
title: "OSPF and IPv6"
date: 2013-03-10 13:20:00 -0600
comments: false
categories:
- Cisco
- Networking
- IPv6
- ISP
- System Administration
---
Having recently setup BGP for a new IPv6 space, I wanted to make sure that IPv6 wasn't a "second class citizen" on the network, so it needed to be routed redundantly internally as well. I picked a /48 to pull subnets out of for routing, and then matched up the 4th quad with the VLAN ID for administration ease and simplicity.


The important commands are as follows:

{% highlight config %}
ipv6 unicast-routing

ipv6 router ospf 6
 router-id xx.xxx.xxx.xx
 log-adjacency-changes
 redistribute connected
 redistribute static

interface VlanXX
 ipv6 address XXXX:XXXX:X:XX::2/64
 ipv6 ospf 6 area 0.0.0.0

ipv6 access-list secure6_ssh
 permit ipv6 2604:4280:D00D::/48 any
 deny ipv6 any any

line vty 5 15
 ipv6 access-class secure6_ssh in
{% endhighlight %}

This sets up an interface for OSPF, setup up an ACL for secure ssh access over IPv6, and sets up IPv6 OSPF routing process ID 6. It is a good idea to specify a router-id, because if your router has no IPv4 addresses it will not be able to pick a router-id and never form adjacencies.

I like that all the ipv6 related commands on Cisco all start with ipv6, ipv6 address, ipv6 access-list, ipv6 router, ipv6 ospf, etc etc. It is nice that they were able to unify all the commands under one heading.
