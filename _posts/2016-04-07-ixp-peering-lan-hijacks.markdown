---
layout: post
image:
  feature: https://ciscodude.net/static/blog-img/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
title: "IXP Peering Lan Hijacks"
date: 2016-03-29 13:36:44 -0500
comments: false
share: true
description: "Earlier this month the local Internet Exchange I'm involved with received some reports of spam coming from the MBIX Peering LAN IP space."
categories: 
- Networking
- ISP
- BGP
- Security
- Troubleshooting
- Network Operator Group
- System Administration
---
Earlier this month the local Internet Exchange I'm involved with received some reports of spam coming from the MBIX Peering LAN IP space.

<script src="https://stat.ripe.net/widgets/widget_api.js"></script>

Normally an Internet Exchange's Peering LAN IP space is not announced to the world via BGP. Only participants who have a next-hop in that particular network need to know about its existence. 

Upon investigation it turns out that someone spun up this IP space via BGP somewhere and blasted out a bunch of spam from an IP that had "unassigned" reverse DNS.

AS-Paths Observed:

*	`9002 44050 131788`
*	`1299 44050 131788`

<div class="statwdgtauto"><script>ripestat.init("bgplay",{"ignoreReannouncements":"true","rrcs":"0,1,6,7,11,14","resource":"206.72.208.0/24","starttime":"2016-03-17T15:00:00","endtime":"2016-03-19T15:00:00","instant":"null","type":"bgp"},null,{"size": "medium","show_controls":"yes","disable":[]})</script></div>

<div class="statwdgtauto"><script>ripestat.init("bgp-update-activity",{"starttime":"2016-03-17T15:00:00","endtime":"2016-03-19T15:00:00","resource":"206.72.208.0/24"},null,{"size": "medium","show_controls":"yes","disable":[]})</script></div>

