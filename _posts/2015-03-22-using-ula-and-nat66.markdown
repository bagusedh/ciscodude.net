---
layout: post
title: "Using ULA and NAT66"
date: 2015-03-22 20:53:32 -0500
description: "What are IPv6 Unique Local Addresses (ULA)? Why would you ever want to use NAT with IPv6? These two questions are directly related. If you were running services with ULAs, you would want to translate those addresses into public addresses. This is where NAT66 comes in."
comments: false
categories:
- Networking
- IPv6
- Nerd Projects
- Network Monitoring
- System Administration
---
What are IPv6 Unique Local Addresses (ULA)? Why would you ever want to use NAT with IPv6? These two questions are directly related. If you were running services with ULAs, you would want to translate those addresses into public addresses. This is where NAT66 comes in.

## Unique Local Addresses

Unique Local Addresses (ULA) are defined in [RFC4193](https://tools.ietf.org/html/rfc4193). They are the approximate IPv6 counterpart of the [RFC1918](https://tools.ietf.org/html/rfc1918) IPv4 Private Addresses. They are generated from within the `fd00::/8` block. SixXS has a [generator](https://www.sixxs.net/tools/grh/ula/) which follows the [guidelines](https://tools.ietf.org/html/rfc4193#section-3.2.2) set out in the RFC.

So once you generate yourself a /48 for your site, you can assign those addresses to the systems inside your firewall. Next we'll use OpenBSD to handle IPv6 NAT, with identical syntax to IPv4 -- reducing the chance of error.

## Using NAT66 With OpenBSD

The following is an example of how to use NAT66 to NAT local IPv6 traffic out a specific address. This could be adapted to NAT each internal IP out as a different IPv6 address.

{% highlight text %}
# IPv4 and IPv6 NAT
#match out on egress inet from !(egress:network) to any nat-to (egress:0)
match out on egress inet6 from !(egress:network) to any nat-to 2620:42:c000:6::10

# Webservers
pass in on egress inet6 proto tcp to (egress) port 443 rdr-to fd84:5f5b:a3e4:1::25
{% endhighlight %}

Don't forget to allow IPv6 forwarding:

`sysctl net.inet6.ip6.forwarding=1`

## Real World?

So where would you use this in the real world?

Say your provider [only gives you a single /64](http://www.reddit.com/r/ipv6/comments/2so374/managing_a_single_64/) and doesn't route you any addresses. 

Maybe you've got a few VPSs at provider and you're load balancing a few backends across a private network using an nginx frontend.

I have a feeling we'll see a lot of this in small business networks where IPv6 design will mirror IPv4 blindly.
