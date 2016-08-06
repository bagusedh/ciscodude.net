---
layout: post
image:
  feature: https://ciscodude.net/static/blog-img/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
title: "dnsdist with pdns recursors"
date: 2016-08-01 20:30:38 -0500
comments: false
share: true
description: "PowerDNS makes a mighty fine authoritative, and also recursive DNS server. They also recently added a DNS-aware DNS load balancer. This article deals with load balancing multiple backend caches to keep all of them hot and working the most efficiently."
categories: 
- Networking
- Nerd Projects
- CLI
- IPv6
---
PowerDNS makes a mighty fine authoritative, and also recursive DNS server. They also recently added a DNS-aware DNS load balancer. This article deals with load balancing multiple backend caches to keep all of them hot and working the most efficiently.

This is a second in blog series about DNS, specifically awesome things that can be done with dnsdist.

### Front and Back Ends

*	2x dnsdist load balancers as client facing DNS resolvers
*	2x PowerDNS recursor backends

{% img /static/blog-img/2016-08-01-dnsdist-pdns-rec-smaller.png %}

### dnsdist Configuration

The config for dnsdist is very simple, skipping over the binds and ACLs as they're not relevant here, below is the parts of the config that matter:

{% highlight lua %}
newServer{address="192.0.2.3", name="DNS1", order=1}
newServer{address="192.0.2.4", name="DNS3", order=1}
setServerPolicy(wrandom)
{% endhighlight %}

### pdns Configuration

PowerDNS is very easy to set up to be a secure resolver. Two lines of config is all thats needed.

{% highlight config %}
allow-from=192.160.102.0/24, 2605:e200:d000::/44
local-address=0.0.0.0, ::
{% endhighlight %}

### Experience so far

This set up has been running for three days now, and taking all of the recursive DNS queries for my system. Both back ends are receiving an equal (average) 8 QPS and responding to the majority of those from Packet Cache within 1ms. I am able to take either back end down and dnsdist notices this and stops routing queries to that backend. When it comes back up it starts taking queries again.

