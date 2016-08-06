---
layout: post
image:
  feature: https://ciscodude.net/images/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
title: "Starting an IXP"
date: 2013-05-29 18:43:00 -0600
comments: false
categories:
- Nerd Projects
- Networking
- IPv6
- BGP
---
I haven't been writing as many blog posts lately as I should, and this is partly because of the change in season, but also because I have been involved with starting the Winnipeg Internet Exchange (WpgIX).

<!--more-->

This has been an interesting journey. The idea of an Internet Exchange Point (IXP) has been around in many forms, through several generations and groups of interested parties. There are all kinds of benefits from connecting to an IXP, especially a local one. From decreased latency, additional BGP routes, cheaper/faster local peering, and generally an all around better Internet Experience for end users. For years TORIX, the Toronto Internet Exchange has been the only notable IXP in Canada. While this has not changed in terms of volume, there is a handful of IXP's now in various stages of existence. Some are very publicly in the planning stages, others forming more organically out of existing business connections. This is all great for the end users. Every time one network peers with another locally it prevents that traffic from needing to go to Toronto and back, back and forth across Canada, or through some incredibly long path all around North American before returning to, perhaps, the next door neighbour on a different ISP. For instance traffic from Shaw to MTS goes thru Calgary now. Traffic from the former Group Telecom IP space criss-crosses the country to connect to almost anyone else in Canada.

As a result of peering several local AS numbers, I now have < 3ms latency to my main VoIP provider! Although he hasn't enabled his IPv6 advertisements via WpgIX yet so that takes a crazy path to Southern California and back.

It has been a great experience. Working on new configs, labing them, running into issues, and finding creative solutions to solve them. We have run into Linux specific issues re: kernel and IPv6, spanning tree flapping, and an unfortunately timed power outage, among other things. All learning experiences.

This is the real thing. We have real production traffic flowing between real networks. It is fascinating to watch the IX grow, and interest build. Once enough AS's are peered locally then the content providers will be very anxious to drop in connections. We will more than likely see Winnipeg Google nodes, a Winnipeg Netflix node, and CDNs like Akamai will drop their reliance on the big Telcos to host their infrastructure and will instead peer it via an IXP to get the content closer to the end users.
