---
layout: post
image:
  feature: https://ciscodude.net/static/blog-img/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
title: "Mikrotik, VRRP, and IPv6"
date: 2017-01-19 00:10:50 -0600
comments: false
share: true
description: "I recently setup IPv6 first-hop redundancy in my colocated environment using Mikrotik and VRRP. It didn't work the same way I'd come to expect from using it in IPv4 environments and I set out to figure out why."
categories: 
- Nerd Projects
- Networking
- System Administration
- CLI
- Network Monitoring
- System Administration
- Troubleshooting
- IPv6
- ISP
---
I recently setup IPv6 first-hop redundancy in my colocated environment using Mikrotik and VRRP. It didn't work the same way I'd come to expect from using it in IPv4 environments and I set out to figure out why.

### Expectations

My expecations for VRRP and IPv6 were the same as IPv4, that a backup router would take over the default gateway IP address on a subnet and the mac address associated with that gateway within 3s (a reasonable automatic failover time)

### Failover Testing...

When VRRP failed over to a backup router all IPv6 ssh sessions I had open to the LAN segment went dead, and were disconnected eventually. This was not what was expected....

### So What Happened?

I logged into several of the linux systems to confirm what their default IPv6 route was set to. It was the public unicast address ending in `::1` for that VLAN. The mac address was the virtual mac address. There was also a 2nd default route with an `fe80` address. 

### Experimentation and Troubleshooting

I experimented with the advertise option back and forth on the VLAN and VRRP interfaces with no effect. Finally looking to tune RA settings I ended up in the `IPv6 -> ND` dialog. This seemed to be the right place finally.

### What Made Things Work?

What made things work in the end was adding the following to both routers to prevent sending RA advertisements over the VLAN interface (VRRP interface is then included in the default ND policy which allows RA)

#### Primary Router

{% highlight config %}
/interface vrrp
add interface=vlan300-theovmtraffic name=vrrp300-v6 preemption-mode=no priority=120 v3-protocol=ipv6 vrid=2

/ipv6 address
add address=2605:e200:d00d:300::1 interface=vrrp300-v6
add address=2605:e200:d00d:300::2 advertise=no interface=vlan300-theovmtraffic

/ipv6 nd
add advertise-mac-address=no hop-limit=64 interface=vlan300-theovmtraffic ra-lifetime=none
{% endhighlight %}

#### Secondary Router

{% highlight config %}
/interface vrrp
add interface=vlan300-theovmtraffic name=vrrp300-v6 preemption-mode=no priority=80 v3-protocol=ipv6 vrid=2

/ipv6 address
add address=2605:e200:d00d:300::1 interface=vrrp300-v6
add address=2605:e200:d00d:300::3 advertise=no interface=vlan300-theovmtraffic

/ipv6 nd
add advertise-mac-address=no hop-limit=64 interface=vlan300-theovmtraffic ra-lifetime=none
{% endhighlight %}

