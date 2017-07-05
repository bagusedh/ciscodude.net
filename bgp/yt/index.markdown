---
layout: page
title: "Yukon Territory BGP/ASN Status"
comments: false
sharing: true
footer: false
description: "Current status today for all ASNs I could find that operate in Yukon Territory, or are Yukon Territory Companies."
lastmodified: 2017-07-05 23:35:01 +0000
categories:
- IPv6
- ISP
- Nerd Projects
- System Administration
- Networking
- BGP
- Network Monitoring
---
Below is the status today for all ASNs I could find that operate in Yukon Territory, or are Yukon Territory Companies. I check the status of each ASN fairly often and update things as they change. Please [Contact Me](/contact/) if you have any updates.

### Icon Status Key

Icons are from a BGP advertisement perspective.

Icon | Meaning
---- | -------
{% img /static/blog-img/v4.png %} | IPv4 advertisement(s)
{% img /static/blog-img/nov4.png %} | IPv4 not advertised
{% img /static/blog-img/v6.png %} | IPv6 advertisement(s)
{% img /static/blog-img/nov6.png %} | IPv6 not advertised

## ASN Status Table

### Yukon Territory ASNs

ASN | Name | v4 / v6 | BGP | BGP LG
--- | ---- | ------- | --- | ------
[AS6058](https://stat.ripe.net/AS6058) | Northwestel Inc. | {% img /static/blog-img/v4.png %} {% img /static/blog-img/nov6.png %} | Active | [LG](http://lg.hextet.net/cgi-bin/bgplg?cmd=show+ip+bgp+source-as&req=6058)
[AS7885](https://stat.ripe.net/AS7885) | Yukon College | {% img /static/blog-img/nov4.png %} {% img /static/blog-img/nov6.png %} | Inactive | [LG](http://lg.hextet.net/cgi-bin/bgplg?cmd=show+ip+bgp+source-as&req=7885)
[AS22573](https://stat.ripe.net/AS22573) | Northwestel Inc. | {% img /static/blog-img/v4.png %} {% img /static/blog-img/nov6.png %} | Active | [LG](http://lg.hextet.net/cgi-bin/bgplg?cmd=show+ip+bgp+source-as&req=22573)

### Statistics

* Total ASNS: 3
* Active ASNs: 2 or 66.67%
  * Dualstack IPv4+IPv6: 0 or 0.00%
  * IPv6 Advertised: 0 or 0.00%
  * IPv6 only: 0 or 0.00%
  * IPv4 only: 2 or 66.67%

Graph showing the [growth of Yukon Territory ASNs](/bgp/yt/asns/), using chart.js.

### Update History

**2017-03-29:** Page being generated instead of manually maintained.
