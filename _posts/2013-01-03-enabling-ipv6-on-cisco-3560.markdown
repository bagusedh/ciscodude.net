---
layout: post
image:
  feature: https://ciscodude.net/images/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
title: "Enabling IPv6 on Cisco 3560/3750"
date: 2013-01-03 12:39:00 -0600
comments: false
categories:
- Cisco
- Nerd Projects
- IPv6
- ISP
- System Administration
---
There are a few steps required to enable full support for IPv6 on a Cisco Catalyst 3560 or 3750.

Firstly, you need to change the sdm prefer to `sdm prefer dual-ipv4-and-ipv6 (default | routing | vlan)` which will require a reboot. If you need to do IPv4 route-maps for policy-based routing, you will want `sdm prefer dual-ipv4-and-ipv6 routing`.

Next you will need to enable `ipv6 unicast-routing`. This is much the same as "ip routing" for IPv4 routing. You can also specify no ipv6 source-route the same as IPv4.

The next step is to either set the interface to automatically attempt autoconfiguration by simply using `ipv6 enable` or statically assign an ipv6 address with `ipv6 address 2604:4280:D00D:200::1/64`. This will turn on advertising as well, and clients will auto-configure themselves to match the prefix.

Routing protocols work much the same as with IPv4, although you will find that there is less configuration needed in the "router" section, and more in the individual interface.
