---
layout: post
image:
  feature: https://ciscodude.net/static/blog-img/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
title: "HA Recursive DNS with dnsdist and exabgp"
date: 2017-02-02 22:30:38 -0500
comments: false
share: true
description: "I've wanted to use exabgp along with dnsdist to provide anycasted, highly available recursive DNS servers ever since discovering dnsdist."
categories: 
- Networking
- Nerd Projects
- CLI
- IPv6
- BGP
- ISP
- System Administration
- Anycast
- Programming
- Network Monitoring
---
I've wanted to use exabgp along with dnsdist to provide anycasted, highly available recursive DNS servers ever since discovering dnsdist. 

This is a fourth in blog series about DNS, specifically awesome things that can be done with dnsdist. This one was inspired by [this blog post about exabgp and healthchecks](https://sysadminblog.net/2016/04/exabgp-bgp-routing-health-checks/), as well as [this custom lua dnsdist load balancing policy](https://github.com/sysadminblog/dnsdist-configs/blob/master/orderedLeastOutstanding.lua).

## Routing, Front and Back Ends

*	BGP: AS395089 on router, AS65101 w/ exabgp/dnsdist load balancers 
*	4x dnsdist load balancers as client facing DNS resolvers
*	4x PowerDNS recursor backends
*	Google Public DNS as backup recursor backends

Active node is chosen using MED, lowest wins. This primary and secondary each mirror each others config, and then there is a 3rd on-net that runs both, and lastly one off-vm and off-net running a tunnel back.

{% img /static/blog-img/2017-02-02-dnsdist-lb-exabgp-w-offsite.png %}

## Linux Configuration

Linux is funny about loopback type addresses. I was unable to get Debian to reliably bring up the interfaces I wanted so I ended up just putting them in `rc.local` which is a hack, but it works reliably at least.

{% highlight config %}
# /etc/rc.local
ip link add dev dns1_dummy type dummy
ip link set dns1_dummy up
ip addr add dev dns1_dummy 192.160.102.235/32
ip addr add dev dns1_dummy 2605:e200:d00a:5301::/64

ip link add dev dns2_dummy type dummy
ip link set dns2_dummy up
ip addr add dev dns2_dummy 192.160.102.236/32
ip addr add dev dns2_dummy 2605:e200:d00a:5302::/64

# /etc/sysctl.conf
net.ipv6.conf.eth0.accept_ra=0
net.ipv4.conf.all.arp_filter=1
{% endhighlight %}

## dnsdist Configuration

dnsdist binds to the two local IP addresses (v4 and v6) as well as all of the anycasted addresses (2x v4 and 2x v6). I am also using a custom weighted/tiered load balancer policy that chooses servers with the highest weight first, then the next level of weight if none are available from that weight tier, and so on. That load balancing policy is available [here](https://github.com/tbaschak/dnsdist-configs/blob/master/orderedwrandom.lua).

{% highlight lua %}
dofile('/etc/dnsdist/orderedwrandom.lua')
setServerPolicyLua("orderedwrandom", orderedwrandom)

-- Local Addresses to bind to
setLocal("192.160.102.135:53")
addLocal("[2605:e200:d00d:300::135]:53")

-- Anycasted addresses to bind to
addLocal("192.160.102.235:53")
addLocal("192.160.102.236:53")
addLocal("[2605:e200:d00a:5301::]:53")
addLocal("[2605:e200:d00a:5302::]:53")

-- QUERY ACLS
-- Add our own IP space
addACL("192.160.102.0/24")
addACL("2605:e200:d000::/44")

newServer{address="192.160.102.144", name="DNS1", order=1, weight=1000}
newServer{address="192.160.102.146", name="DNS3", order=1, weight=1000}
newServer{address="2001:4860:4860::8888", name="G V6 Pri", order=3, weight=1}
newServer{address="8.8.8.8", name="G V4 Pri", order=3, weight=1}
newServer{address="2001:4860:4860::8844", name="G V6 Sec", order=3, weight=1}
newServer{address="8.8.4.4", name="G V4 Sec", order=3, weight=1}

addAnyTCRule()
{% endhighlight %}

## exabgp and healthchecks

The blog mentioned above which inspired me to attempt this also had a [github repo](https://github.com/sysadminblog/exabgp-healthcheck) which I [forked](https://github.com/tbaschak/exabgp-healthcheck). 

One sample healthchecked entry:

{% highlight config %}
[dns1v4]
nexthop=192.160.102.230
command="dig @192.160.102.235 a.root-servers.net. a +short"
ip=192.160.102.235
disable=/etc/exabgp/healthcheck_dns1v4.disable
{% endhighlight %}

The command= line is the check, anything which returns non-zero when it fails will work. This makes it very very easy to write a check. Disabling BGP advertisements is as simple as touching the file listed in the disable= line. This can be handy before reboots to take down BGP gracefully and fail over to other servers gracefully.

## Experience so far

I've had weird issues with what appears to be next-hop and IPv6, which I've temporarily resolved by using the fe80 link-local addresses as the next-hop. For whatever reason this seems to fix things. This could be an issue specifically with Mikrotik BGP, and IPv6 next-hops. I'm tempted to add a Cisco router to the mix and peer with that and see if that makes things less strange.


