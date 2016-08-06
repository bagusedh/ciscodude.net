---
layout: post
title: "SaltStack, CouchDB, and Nagios"
date: 2014-12-21 16:58:58 -0600
comments: false
description: "Using SaltStack to run distributed monitoring checks is fun, but what is really awesome is writing the result of all those checks to CouchDB. Instead of returning the result of the check to the command line, or to the master even via programmatic method, you can use SaltStack's returners to have the output returned somewhere else."
categories: 
- Nerd Projects
- Nagios
- Network Monitoring
- CLI
- Programming
- Virtualization
- SaltStack
- System Administration
- IPv6
- BGP
image:
  feature: https://ciscodude.net/images/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
share: true
---
This is a second blog post in a related series, the first is located [here](/2014/11/21/service-status-via-saltstack-2014-7-w-nagios/).

Using SaltStack to run distributed monitoring checks is fun, but what is really awesome is writing the result of all those checks to CouchDB. Instead of returning the result of the check to the command line, or to the master even via programmatic method, you can use SaltStack's returners to have the output returned somewhere else. There is a [CouchDB returner](http://docs.saltstack.com/en/latest/ref/returners/all/salt.returners.couchdb_return.html) which works very nicely for storing the result of nagios and other network checks (network.traceroute for example). 

What I'm hoping to eventually end up with is a hybrid monitoring/alerting solution, which will provide more detailed alerts than a simple "host down", or "service down/timed out", something like [Blog Post on Sys Advent](http://sysadvent.blogspot.ca/2014/12/day-18-adding-context-to-alerts-with.html), but instead of showing history from one nagios instance, providing a short historic, global view from from various [DigitalOcean](https://www.digitalocean.com/?refcode=f6432a6e1354) and [Vultr](http://www.vultr.com/?ref=6807643) VPS's. Informative stuff like "Host (name) down, 4 of 7 locations reporting down at (timestamp)".

Over the holiday break I am going to invest more time in copying my nagios monitoring setup/configs to SaltStack Pillars, and begin to run all my checks globally, using `salt-call` via `cron` at various intervals for different Pillars. I will then need to write some code to:

*	provide a dashboard with live status updates including:
	*	this will include host/service status
	*	traceroute visualizations (scatterplots?) to show network disruptions/changes from BGP events
	*	latency as sparklines
*	send the highly customized email alerts (modular, so as able to be used to generate reports as well)
*	monitor CouchDB's _changes feed to tie the alerting into the data stream

Once I get these steps completed, I will work on packaging the resulting scripts into something which others can perhaps find useful as well. If I come up with a good name for this conglomeration, I'll register a domain for it, and start an organization on Github for it as well.

