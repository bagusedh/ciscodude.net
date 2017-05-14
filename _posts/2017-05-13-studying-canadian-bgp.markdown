---
layout: post
title: "Studying Canadian BGP"
date: 2017-05-13 13:36:23 -0500
comments: false
share: true
description: "Over the past four years I've been researching BGP routing in Canada. This has taken several forms as I learn what works and what doesn't work at all."
categories: 
- Networking
- ISP
- BGP
- Security
- Troubleshooting
- Network Operator Group
- System Administration
---
Over the past four or so years I've been researching BGP routing in Canada.

My first interest in studying Canadian BGP came as a result of studying historical BGP hijacks. I talk about this during my BSidesWpg 2013 talk:

{% youtube "https://www.youtube.com/watch?v=qvall1kyNIg" %}

The practica; applications of my study have taken several forms as I learn what works and what doesn't work (at all).

*	v1 - direct JSON from exabgp piped into curl to store in couchdb

I talk about what I'm calling v1 in my BSidesWpg 2015 talk:

{% youtube "https://www.youtube.com/watch?v=X1e7mPH8u6s" %}

*	v2 - JSON from exabgp piped into python where it is parsed and INSERTed into a mySQL table

Now that I have a database which contains the current status and number of prefixes advertised by each Canadian ASN I am able to automate the generation of various sections of my website.

Each provinces ASN status page ([MB](/bgp/mb/), [BC](/bgp/bc/), [ON](/bgp/on/), etc) is now fully generated (in markdown) from a DB instead of manually. There is no human interaction or editing in the process, so ASNs which operate in other provinces aren't manually corrected any longer. I've also removed the list of national/international ASNs operating in each province as that was not possible to automate.

Some human interaction was required. Several ASNs have their name in both official languages and as such they are extremely long. These are handled with a specific if line for each case that arises. 

As a side effect of the pages now being generated, the on-page BGP history is gone, and the history is now in git history instead. These generated BGP pages now have last modified dates at the bottom. This is done using a git pre-commit hook. 

I still need to automate the generation of the growth graphs, but that is part way there already and should be completed soon.
