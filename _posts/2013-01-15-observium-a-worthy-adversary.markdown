---
layout: post
noindex: true
title: "Observium, A Worthy Adversary!"
date: 2013-01-15 10:33:00 -0600
comments: false
categories:
- Nerd Projects
- Networking
- ISP
- System Administration
---
I've used Cacti for the past 10 years roughly, and it has served me well. It is fairly easy to make custom templates, custom data sources, etc. Lately it has been the bane of my existence though, due to a combination 64-bit counters not being the default (there is templates on the forums, but they are still not in the base product yet) and lack of automatic updates for new interfaces, although I admit this is perhaps due laziness/misconfiguration on my part. I recently saw mention of [Observium](http://www.observium.org/) on the NANOG mailing list, and thought I would demo it on my network at home. I can't really describe Observium any better than their opening 3 paragraphs on their website:

<!--more-->

> Observium is an autodiscovering PHP/MySQL/SNMP based network monitoring which includes support for a wide range of network hardware and operating systems including Cisco, Linux, FreeBSD, Juniper, Brocade, Foundry, HP and many more.

> Observium has grown out of a lack of easy to configure network monitoring platforms. It is intended to provide a more navigable interface to the health and performance of your network. Its design goals include collecting as much historical data about devices as possible, being completely autodiscovered with little or no manual intervention, and having a very intuitive interface.

> Observium is not intended to replace an up/down alerting system, but rather to complement it with an easy to manage, intuitive representation of historical and current performance statistics, configuration visualisation and syslog capture.

I've had it running on my home network for almost 24 hours now, and I am very impressed. What follows is a list of first impressions:

*	Like: I really like that Observium autodiscovers and graphs everything, AND makes it easy to sort/filter graphs when you go to view them. That has been one of my main annoyances with Cacti lately, I don't like to make graphs for interfaces before they're configured/up because sometimes it defines the max speed as 10 and clips above that. As well it updates interface descriptions each polling run.
*	Like: I don't even have to view graphs, I can view textual stats of which ports are doing bandwidth. This makes it very quick to load a page with a lot of very useful information.
*	Like: Total Device Traffic graphs. When you click on a device name and go to its overview page, it has a stacked graph of all ports. This way you can see how much bandwidth is going through your switch in total. Plus the graphs it makes are just cool.
*	Like: Device Logos. Observium puts a Cisco, or Mikrotik, or FreeBSD, or whatever logo beside your device once it knows what type of device it is.
*	Like: Mac/Arp tables. Negates the need to run netdisco, which is half abandoned, and very kludgy.

I am sure I will be writing more about this very handy tool in the future as I learn more about how to use it to its fullest.
