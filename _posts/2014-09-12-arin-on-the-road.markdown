---
layout: post
title: "ARIN on the Road"
date: 2014-09-12 10:45:41 -0500
comments: false
description: "I attended the ARIN on the Road event held yesterday (2014-09-11) in Winnipeg. The event was fairly well attended, although there were some Manitoba ASNs who were not represented in the room."
categories:
- Networking
- IPv6
- Nerd Projects
- ISP
- System Administration
- Security
- BGP
- Programming
image:
  feature: https://ciscodude.net/images/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
external_url: https://www.arin.net/participate/meetings/on-the-road/presentations/winnipeg_2014.pdf
share: true
---
I attended the ARIN on the Road event held yesterday (2014-09-11) in Winnipeg. The event was fairly well attended, although there were some notable [Local ASNs](/bgp/mb/) who were not represented in the room.

Personal highlights of the event:

>	Beers with John Sweeting, ARIN Advisory Council Chair

>	Lunch with Andy Newton, Chief Engineer

I had the pleasure of having Andy Newton sit at our (highly technical) table at lunch. It was nice to get some near-one-on-one time with the Chief Engineer of ARIN.

>	Everything mentioned IPv6, including a live v6 demo

IPv6 was not a back-burner item, IPv6 was front and centre in every talk. 

>	Interacting with ARIN in a programmatic way: RESTful Web Services

Andy Newton gave an excellent talk on interacting with ARIN in a programmatic way via their RESTful Web Services (RWS). He also showed stats on how many requests they answer, and via what method. Their RWS is the way that the majority of requests are now answered.

Some take away items I need to look into further and implement:

*	I really need to start using their RESTful services, perhaps even finding a CLI whois client that uses Whois-RWS!
*	I need to investigate DNSSEC
*	Once I get my own ASN/IP space, I need to investigate RPKI

[Slides from the event](https://www.arin.net/participate/meetings/on-the-road/presentations/winnipeg_2014.pdf)
