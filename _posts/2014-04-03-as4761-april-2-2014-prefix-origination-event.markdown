---
layout: post
title: "AS4761 April 2 2014 Prefix Origination Event"
date: 2014-04-03 22:10:14 -0500
comments: false
categories: 
- Networking
- ISP
- Security
- Network Monitoring
- BGP
- System Administration
image:
  feature: https://ciscodude.net/static/blog-img/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
---
Yesterday afternoon, starting at 2:05PM local time, I received several notices about our prefixes being hijacked -- announced by an ASN other than our own. The particular ASN that was advertising the prefixes in question was AS4761, Indosat, an Indonesian satellite Internet provider.

Luckily, the affects of the hijacking were not global for most prefixes, and no reports from customers came in. BGPmon Reports however flowed in for almost 3 hours of different prefixes of ours being hijacked -- eventually including all of our IPv4 prefixes. Others -- like Chevron (from the Renesys linked blog) -- were not so lucky, as the Indonesian advertisement was shorter than some of their own prepended paths.

The screenshot of the alert from [BGPmon.net](http://www.bgpmon.net/). Based on this, it would appear that reachability problems would have been limited to Thailand, and perhaps surrounding areas.

{% img /static/blog-img/as4761-hijack-notice.png %}

From the various reports that came in on Twitter and NANOG, it seems that a maintenance window gone bad, and one un-filtered BGP upstream was the cause of the event. AS4651 (THAI-GATEWAY The Communications Authority of Thailand(CAT),TH) learned the 320-400k routes from their customer, Indosat, and then passed it on to the rest of their customers. One of their customers, Aware Corporation (also in Thailand), operates a BGPmon peermon node, and [was very helpful](http://mailman.nanog.org/pipermail/nanog/2014-April/065947.html) in providing much information, and pointing everyone in the right direction on NANOG.

Several other blogs about this specific event, written by two respectable BGP monitoring places:

*	[http://www.renesys.com/2014/04/indonesia-hijacks-world/](http://www.renesys.com/2014/04/indonesia-hijacks-world/)
*	[http://www.bgpmon.net/hijack-event-today-by-indosat/](http://www.bgpmon.net/hijack-event-today-by-indosat/)

And a blog about when this exact same situation happened before in 2011:

*	[http://www.bgpmon.net/hijack-by-as4761-indosat-a-quick-report/](http://www.bgpmon.net/hijack-by-as4761-indosat-a-quick-report/)

