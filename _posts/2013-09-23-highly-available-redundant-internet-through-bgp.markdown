---
layout: post
image:
  feature: https://ciscodude.net/static/blog-img/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
title: "Highly-Available, Redundant Internet Through BGP"
date: 2013-09-23 21:30:38 -0600
comments: false
categories:
- Networking
- ISP
- BGP
---
The Internet is fast becoming one of the, if not <strong>the</strong> most important communication tools for business. We rely on Internet communication for emails, phone calls, video conferencing, as well as virtual services offered over the Internet. Many organizations have two (or more) Internet connections but are not set up to automatically fail over to another connection should one fail. This process is not instant, and would need quite a lot of time to move things over in the event of a significant outage on the primary connection.

<!--more-->

The Issue
=========

There are several methods to utilize multiple internet connections and fail over in the event of a failure. This blog post will deal most specifically with BGP after laying out the basic methods.

1.	Manual switch over.
	*	Pros
		*	Does not cost anything
	*	Cons
		*	Needs human intervention
		*	Time consuming
		*	Prone to error, causing further downtime
2.	Dual/Multi-wan Firewall(s).
	*	Pros
		*	Low-cost to no-cost, many organizations already have this
		*	Works with commodity internet connections
	*	Cons
		*	Failure detection can result in false positives
		*	If failure detection is pinging 8.8.8.8 (Google) and provider A loses connectivity to that part of the Internet the connection can potentially switch over to backup.
		*	Failure detection also cannot detect all possible scenarios
		*	Depending on implementation, can leave connections totally idle
		*	Complex to impossible to implement and troubleshoot Highly Available services
3.	Multiple routers and BGP.
	*	Pros
		*	100% network up-time is actually achievable
		*	Ability to fail-over without needing to use a different IP address
		*	Vastly simplifies troubleshooting. Leaves routing to the routers where its handled best, and fire-walling at the firewall where its handled best
		*	With a complete routing view it is possible to avoid some of the complex failure scenarios from the Firewall redundancy solution
		*	Failure of a single Internet provider is automatically handled
		*	Specific Internet destinations becoming unreachable over any provider are automatically handled as well
		*	Better control over Internet when things do go wrong
		*	Ability to utilize more than one Internet connection actively
		*	Paths are picked based on shortest number of ISPs/Networks to go through using BGP algorithms
	*	Cons
		*	Needs larger more expensive routers to implement properly
		*	Needs Internet providers who are able/willing to talk BGP

The Solution
============

BGP gives an organization the ability to send and receive traffic through one or more connections from a provider independent IP address space. It handles finding the shortest path to a given Internet destination as well as informing the rest of the global Internet how to reach their provider independent IP address space.

What is BGP Anyway?
-------------------

Border Gateway Protocol (BGP) is the Internet routing protocol which is used to make core routing decisions on the Internet; it involves a table of IP networks or "prefixes" which designate network reach-ability among autonomous systems (AS). An autonomous system or AS is used to group a network or group of networks together on the internet, under a single administrative control. Shaw for instance is AS6327, MTS is AS15290, Google is AS15169. This can represent an Internet Service Provider, a backbone carrier, a large educational institute like a university, a large enterprise like Royal Bank of Canada, or a company with heavy reliance on Internet.

Some examples of different sized organizations running BGP in Winnipeg:

+	Standard Aero
+	Palliser Furniture
+	Ducks Unlimited
+	Monarch Industries
+	MERLIN
+	University of Manitoba
+	Epic Information Systems
+	Daemon Defense Systems
+	Manitoba Hydro &amp; Manitoba Hydro Telecom
+	Ceridian
+	Postmedia Network (old CanWest media empire: National Post, Vancouver Sun, Calgary Herald, Edmonton Journal, Regina Leader Post, Saskatoon StarPhoenix, Ottawa Citizen, Montreal Gazette, and Canada.com)

Some examples of organizations not running BGP which may be a little surprising:

+	Frontier School Division
+	Red River College
+	Broadband Communications North
+	University of Winnipeg
+	City of Winnipeg

To be continued in Part 2 at some point.
