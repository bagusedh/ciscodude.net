---
layout: post
title: "HA Authoritative DNS w/ dnsdist"
date: 2016-08-13 02:10:38 -0500
comments: false
share: true
description: "I ran into an obscure limitation in PowerDNS 4.0 authoritative server recently. I have one nameserver which also acts as a slave to two other sets of zones with are transfered using AXFR. Some of those zones are DNSSEC enabled, and PowerDNS is only able to handle DNSSEC on the first backend loaded. This was causing several forward and reverse zones to fail to serve the DNSSEC records along with the queried records, and DNSSEC validation to partially fail."
categories: 
- Networking
- Nerd Projects
- CLI
- IPv6
---
I ran into an obscure limitation in PowerDNS 4.0 authoritative server recently. I have one nameserver which also acts as a slave to two other sets of zones with are transfered using AXFR. Some of those zones are DNSSEC enabled, and PowerDNS is only able to handle DNSSEC on the first backend loaded. This was causing several forward and reverse zones to fail to serve the DNSSEC records along with the queried records, and DNSSEC validation to partially fail.

My solution, to use dnsdist to serve my slave zones from a bind instance listening to localhost (on port 5302), and my own zones from PowerDNS listening on localhost (port 5301). While I was in there adding that configuration, I thought why not also send queries for these zones to their primary nameserver in the event of my own backend being down? So I added ns1 for fudo and Skullspace to the backend list. This lets me perform maintenance without dropping queries, and the cost of some extra latency for requests during maintenance. 

### Front and Back Ends

*	1x dnsdist load balancer as resolver facing authoritative DNS server
*	1x PowerDNS authoritative backend on localhost
*	2x PowerDNS authoritative remote backends
*	1x Bind9 backend on localhost
*	1x NSD remote backend

### dnsdist Configuration

The config for dnsdist is very simple, below is the sample parts of the config that do the work:

{% highlight lua %}
-- Important to allow access from anywhere, this is an authoritative server we're frontending
setACL({"0.0.0.0/0", "::/0"})

-- Ciscodude Backends
newServer{address="127.0.0.1:5301", name="pdns", order=1, checkName="ciscodude.net."}
newServer{address="192.241.199.179", name="ns1", order=2, checkName="ciscodude.net."}
newServer{address="159.203.2.224", name="ns3", order=2, checkName="ciscodude.net."}

-- Skullspace Backends
newServer{address="127.0.0.1:5302", pool="sksp", name="sksp bind", order=1, checkName="skullspace.ca."}
newServer{address="208.81.6.229", pool="sksp", name="sksp ns1", order=2, checkName="skullspace.ca."}

-- Fudo Backends
newServer{address="127.0.0.1:5302", pool="fudo", name="fudo bind", order=1, checkName="fudo.org."}
newServer{address="208.81.1.141", pool="fudo", name="fudo ns1", order=2, checkName="fudo.org."}

-- LB Policy, goes thru in order in this case
setServerPolicy(firstAvailable)

-- Route some DNS requests to other backends, the rest fall thru to the ciscodude backends
addPoolRule({"skullspace.ca", "skull.space"}, "sksp")
addPoolRule({"fudo.org", "fudo.ca", "fudo.im", "fudo.ninja"}, "fudo")
{% endhighlight %}

### Experience so far

I haven't been running this setup for 24 hours yet even, however given my existing experiences with dnsdist, I expect that this will work extremely well. I've tested stopping a backend on purpose, and queries just fail over with the extra latency of a trip to the remote backend. 
