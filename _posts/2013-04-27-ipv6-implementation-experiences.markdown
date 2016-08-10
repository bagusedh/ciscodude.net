---
layout: post
image:
  feature: https://ciscodude.net/static/blog-img/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
title: "IPv6 Implementation Experiences"
date: 2013-04-27 12:00:00 -0600
comments: false
categories:
- Nerd Projects
- Networking
- IPv6
- Security
- ISP
- BGP
- System Administration
---
I was browsing [/r/ipv6](http://www.reddit.com/r/ipv6) this morning and I felt like writing up my IPv6 implementation experiences. I've played with IPv6 over a tunnel ever since I got DSL back in June, 2001. At the time I was running a custom Linux firewall, and it was very easy to set up a tunnel and get a /64 going. There wasn't much content that was IPv6 at the time, just the dancing turtle on www.kame.net. My next experience IPv6 was when I moved to Winnipeg, I set up a FreeBSD box as an IPv6 tunnel host this time, and had a web server and mail server on IPv6 for a while until I moved apartments.

<!--more-->

Several years later I began working for an ISP (around 2005). Once the network had moved past the planning phases, and the build phases, and had been up and running for a while, we began to brainstorm the next steps we might take. One of these was potentially doing all administration of the network over IPv6 only. It was decided that this was a risk if one of the admins was remote and had no IPv6 access, and so we just enabled IPv6 over a tunnel for certain hosts as a test. Most of my access to the IPv6 enabled hosts was in fact over IPv6, occasionally falling back to IPv4 if there was a connectivity issue or a configuration issue.

Most modern OS's and browsers have whats called "Happy Eyes" which connects both on IPv4 and IPv6, preferring IPv6, and then if IPv6 fails, dropping that connection and using the already open IPv4 one. I do occasionally see this in action when I have an IPv6 routing issue, a website will take some seconds to load, then I'll see the IPv4/IPv6 indicator in Firefox or Chrome switch to IPv4 and I'll know I have a routing issue to fix. It is very intelligent about it, and I've never had to explicitly disable IPv6 to get things to work.

So from the end-user perspective, things are fairly transparent. IPv6 has a vastly increased address space size, which should result in the end of NAT. The end of NAT will make things like VoIP, video conferencing, and other applications which need or work much more efficiently with end-to-end connectivity. One of the potential downsides of this globally connected nature is the difference from NAT. NAT hides all addresses in a network behind one or more public IPs, only exposing explicitly configured services. A host which gets an auto-configured IPv4 address will usually be unable to accept internet traffic without firewall changes, where depending on the setup, might be fully exposed and unprotected by firewall on its auto-configured IPv6 address. This can result in security issues ranging from mild annoyance (printers settings being changed from internet, rebooting, perhaps having the LCD screen messages changed) to very serious security issues (poorly configured MFP type devices with default credentials allowing full document snooping remotely). Poorly planned security and configuration management can result in these so-called Shadow Networks popping up where they were not planned for.

From the server side, things are a little different. Depending on how your OS is configure you may be already seeing all IPv4 IPs as IPv4-mapped IPv6 addresses, such as ::ffff:192.0.2.128. There are many ways of configuring specific applications, nginx and Apache for example allow you to set up a socket that listens on BOTH protocols, or one for each.

From a purely network level perspective, the migration is very easy. Basically, add IPv6 addresses to your IPv4 VLANs, setup RA, and DHCPv6 to get full IPv6 functionality, and the bulk of the implementation work is then passed off to the other teams (firewall admins, server admins, desktop support, etc).

