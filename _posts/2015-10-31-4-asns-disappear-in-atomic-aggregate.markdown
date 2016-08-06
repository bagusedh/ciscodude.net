---
layout: post
image:
  feature: https://ciscodude.net/images/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
title: "4 ASNs Disappear in Atomic Aggregate"
date: 2015-10-31 12:31:44 -0500
comments: false
share: true
description: "On Sunday, September 13th, 2015 during the wee hours of the morning a change was made by AS7122 which silenced four Manitoban ASNs, and removed several other routes from the global routing table. Shortly after the start of their 1AM maintenance window AS7122 enabled BGP atomic aggregate on 205.200.0.0/16 and 207.161.0.0/16, causing AS21876, AS23001, AS32433, and AS54937 to disappear from the global routing table."
categories: 
- Networking
- ISP
- Security
- Network Monitoring
- BGP
- System Administration
---
On Sunday, September 13th, 2015 during the wee hours of the morning a change was made by AS7122 which silenced four Manitoban ASNs, and removed several other routes from the global routing table. Shortly after the start of their [1AM maintenance window](https://www.mts.ca/mts/support/service+bulletins/mts+internet+maintenance+windows) AS7122 enabled BGP atomic aggregate on 205.200.0.0/16 and 207.161.0.0/16, causing AS21876, AS23001, AS32433, and AS54937 to disappear from the global routing table.

<script src="//stat.ripe.net/widgets/widget_api.js"></script>

Below is an animation of the withdrawal of AS54937's 205.200.84.0/24 route as observed from RIPE's route collectors.

<div class="statwdgtauto"><script>ripestat.init("bgplay",{"unix_timestamps":"TRUE","ignoreReannouncements":"true","rrcs":"0,1,6,7,11,14","resource":"205.200.84.0/24","starttime":"1442124000","endtime":"1442131200","instant":"null","type":"bgp"},null,{"size": "fit","show_controls":"yes","disable":[]})</script></div>

Coincidentally, all four of these ASNs were single homed to 7122 and advertising /24 more specific routes of 7122's /16 advertisements.

<div class="statwdgtauto"><script>ripestat.init("asn-neighbours-history",{"resource":"AS21876","starttime":"2015-03-01","endtime":"2015-09-30T12:00"},null,{"size":"fit","disable":["controls"]})</script></div>

<div class="statwdgtauto"><script>ripestat.init("routing-history",{"min_peers":0,"resource":"AS21876","starttime":"2015-03-01"},null,{"size":"fit","disable":["controls"]})</script></div>

<div class="statwdgtauto"><script>ripestat.init("asn-neighbours-history",{"resource":"AS23001","starttime":"2015-03-01","endtime":"2015-09-30T12:00"},null,{"size":"fit","disable":["controls"]})</script></div>

<div class="statwdgtauto"><script>ripestat.init("routing-history",{"min_peers":0,"resource":"AS23001","starttime":"2015-03-01"},null,{"size":"fit","disable":["controls"]})</script></div>

<div class="statwdgtauto"><script>ripestat.init("asn-neighbours-history",{"resource":"AS32433","starttime":"2015-03-01","endtime":"2015-09-30T12:00"},null,{"size":"fit","disable":["controls"]})</script></div>

<div class="statwdgtauto"><script>ripestat.init("routing-history",{"min_peers":0,"resource":"AS32433","starttime":"2015-03-01"},null,{"size":"fit","disable":["controls"]})</script></div>

<div class="statwdgtauto"><script>ripestat.init("asn-neighbours-history",{"resource":"AS54937","starttime":"2015-03-01","endtime":"2015-09-30T12:00"},null,{"size":"fit","disable":["controls"]})</script></div>

<div class="statwdgtauto"><script>ripestat.init("routing-history",{"min_peers":0,"resource":"AS54937","starttime":"2015-03-01"},null,{"size":"fit","disable":["controls"]})</script></div>

Doing some deeper digging on an MTS customer's looking glass, I see that these routes are only suppressed to external peering peers. 

I wonder if it was intentional to suppress the above ASNs and routes? If it was intentional, was it an altruistic move to keep the global routing table size down?

I wonder what their reasoning was? Perhaps they only intended to summarize internal routes and clobbered customer routes accidentally in the process?

Do they have a plan to un-hide routes should these ASNs choose to become multihomed (again) at some point? Having only one upstream sending the specific route advertised will result in making it near impossible to utilize more than one connection effectively for inbound.


