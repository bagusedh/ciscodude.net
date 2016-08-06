---
layout: post
title: "BGP Hijacking In News Again"
date: 2014-08-10 21:35:11 -0500
comments: false
categories: 
- Networking
- ISP
- Security
- Network Monitoring
- BGP
- System Administration
external_url: http://www.secureworks.com/cyber-threat-intelligence/threats/bgp-hijacking-for-cryptocurrency-profit/
image:
  feature: https://ciscodude.net/images/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
share: true
---
Its been 4 months since I last [wrote about global BGP hijacking](/2014/04/03/as4761-april-2-2014-prefix-origination-event/), when Indosat advertised 320k prefixes. This time The Dell SecureWorks Counter Threat Unit [has documented 51 hijacked more specific prefixes](http://www.secureworks.com/cyber-threat-intelligence/threats/bgp-hijacking-for-cryptocurrency-profit/) which were used along with overly trusting network code decisions in cryptocoin mining pool software (no TLS) to redirect miners to an alternate mining server running on a bogon route @ 206.223.224.225. 

The article doesn't mention the specific Canadian ISP which originated the hijacking, nor the upstream, but it is not hard to discover both through Ripe.net's ripestat service, [here is 54.214.242.0/24](https://stat.ripe.net/widget/bgplay#w.resource=54.214.242.0/24&w.ignoreReannouncements=true&w.starttime=1388538300&w.endtime=1401494700&w.instant=null&w.type=bgp) and its history from January 1 through May 31. 54.214.242.0/24 was the first, and most often hijacked network listed in [Appendix A](http://www.secureworks.com/cyber-threat-intelligence/threats/bgp-hijacking-for-cryptocurrency-profit/#appendix) of the SecureWorks article. 

206.223.224.0/24 is a BOGON/un-allocated prefix. One of AS21548's peers, AS6939, did not filter its connection, and subsequently, allowed the more specific /24's to propagate the internet, as well as accepting the BOGON, and propagating it. This route is still actively propagated from AS21548 via AS6939 at time of writing.

I took the list from [Appendix A](http://www.secureworks.com/cyber-threat-intelligence/threats/bgp-hijacking-for-cryptocurrency-profit/#appendix) and ran it through sort, awk, sort, and uniq to determine how many times each network was reported to been hijacked. I have posted this to a [gist](https://gist.github.com/tbaschak/670bd7914c615ef933c8).

I feel for Digital Ocean customers in [162.243.226.0/24](https://stat.ripe.net/widget/bgplay#w.resource=162.243.226.0/24&w.ignoreReannouncements=true&w.starttime=1388538300&w.endtime=1401494700&w.instant=null&w.type=bgp) and [162.243.142.0/24](https://stat.ripe.net/widget/bgplay#w.resource=162.243.142.0/24&w.ignoreReannouncements=true&w.starttime=1388538300&w.endtime=1401494700&w.instant=null&w.type=bgp), service would have been affected 14+ times for short blips. This would have been frustrating for both sides to troubleshoot to say the least, with short 10-15 minute hijackings. There were 9 prefixes in total from Digital Ocean hijacked.

- - -

**Update 2014-08-12:** BGPMon has an article up about the hijackings: [http://www.bgpmon.net/the-canadian-bitcoin-hijack/](http://www.bgpmon.net/the-canadian-bitcoin-hijack/)

