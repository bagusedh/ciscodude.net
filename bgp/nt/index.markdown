---
layout: page
title: "Northwest Territories BGP/ASN Status"
comments: false
sharing: true
footer: false
description: "Current status today for all ASNs I could find that operate in Northwest Territories, or are Northwest Territories Companies."
lastmodified: 2017-06-07 14:52:25 +0000
categories:
- IPv6
- ISP
- Nerd Projects
- System Administration
- Networking
- BGP
- Network Monitoring
---
Below is the status today for all ASNs I could find that operate in Northwest Territories, or are Northwest Territories Companies. I check the status of each ASN fairly often and update things as they change. Please [Contact Me](/contact/) if you have any updates.

### Icon Status Key

Icons are from a BGP advertisement perspective.

Icon | Meaning
---- | -------
{% img /static/blog-img/v4.png %} | IPv4 advertisement(s)
{% img /static/blog-img/nov4.png %} | IPv4 not advertised
{% img /static/blog-img/v6.png %} | IPv6 advertisement(s)
{% img /static/blog-img/nov6.png %} | IPv6 not advertised

## ASN Status Table

### Northwest Territories ASNs

ASN | Name | v4 / v6 | BGP | BGP LG
--- | ---- | ------- | --- | ------
[AS13872](https://stat.ripe.net/AS13872) | Tamarack Computers Ltd. | {% img /static/blog-img/nov4.png %} {% img /static/blog-img/nov6.png %} | Inactive | [LG](http://lg.hextet.net/cgi-bin/bgplg?cmd=show+ip+bgp+source-as&req=13872)
[AS22684](https://stat.ripe.net/AS22684) | SSI Micro Ltd. | {% img /static/blog-img/v4.png %} {% img /static/blog-img/v6.png %} | Active | [LG](http://lg.hextet.net/cgi-bin/bgplg?cmd=show+ip+bgp+source-as&req=22684)
[AS33594](https://stat.ripe.net/AS33594) | Government of the Northwest Territories | {% img /static/blog-img/v4.png %} {% img /static/blog-img/nov6.png %} | Active | [LG](http://lg.hextet.net/cgi-bin/bgplg?cmd=show+ip+bgp+source-as&req=33594)
[AS54191](https://stat.ripe.net/AS54191) | Ice Wireless Inc. | {% img /static/blog-img/v4.png %} {% img /static/blog-img/nov6.png %} | Active | [LG](http://lg.hextet.net/cgi-bin/bgplg?cmd=show+ip+bgp+source-as&req=54191)

### Statistics

* Total ASNS: 4
* Active ASNs: 3 or 75.00%
  * Dualstack IPv4+IPv6: 1 or 25.00%
  * IPv6 Advertised: 1 or 25.00%
  * IPv6 only: 0 or 0.00%
  * IPv4 only: 2 or 50.00%

Graph showing the [growth of Northwest Territories ASNs](/bgp/nt/asns/), using chart.js.

### Update History

**2017-03-29:** Page being generated instead of manually maintained.
