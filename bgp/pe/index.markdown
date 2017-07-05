---
layout: page
title: "Prince Edward Island BGP/ASN Status"
comments: false
sharing: true
footer: false
description: "Current status today for all ASNs I could find that operate in Prince Edward Island, or are Prince Edward Island Companies."
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
Below is the status today for all ASNs I could find that operate in Prince Edward Island, or are Prince Edward Island Companies. I check the status of each ASN fairly often and update things as they change. Please [Contact Me](/contact/) if you have any updates.

### Icon Status Key

Icons are from a BGP advertisement perspective.

Icon | Meaning
---- | -------
{% img /static/blog-img/v4.png %} | IPv4 advertisement(s)
{% img /static/blog-img/nov4.png %} | IPv4 not advertised
{% img /static/blog-img/v6.png %} | IPv6 advertisement(s)
{% img /static/blog-img/nov6.png %} | IPv6 not advertised

## ASN Status Table

### Prince Edward Island ASNs

ASN | Name | v4 / v6 | BGP | BGP LG
--- | ---- | ------- | --- | ------
[AS691](https://stat.ripe.net/AS691) | University of P.E.I | {% img /static/blog-img/nov4.png %} {% img /static/blog-img/nov6.png %} | Inactive | [LG](http://lg.hextet.net/cgi-bin/bgplg?cmd=show+ip+bgp+source-as&req=691)
[AS7860](https://stat.ripe.net/AS7860) | University of Prince Edward Island | {% img /static/blog-img/v4.png %} {% img /static/blog-img/v6.png %} | Active | [LG](http://lg.hextet.net/cgi-bin/bgplg?cmd=show+ip+bgp+source-as&req=7860)
[AS7950](https://stat.ripe.net/AS7950) | Holland College | {% img /static/blog-img/nov4.png %} {% img /static/blog-img/nov6.png %} | Inactive | [LG](http://lg.hextet.net/cgi-bin/bgplg?cmd=show+ip+bgp+source-as&req=7950)
[AS18814](https://stat.ripe.net/AS18814) | Atlantic Technology Centre Inc | {% img /static/blog-img/v4.png %} {% img /static/blog-img/nov6.png %} | Active | [LG](http://lg.hextet.net/cgi-bin/bgplg?cmd=show+ip+bgp+source-as&req=18814)
[AS33040](https://stat.ripe.net/AS33040) | ISN Wireless | {% img /static/blog-img/v4.png %} {% img /static/blog-img/nov6.png %} | Active | [LG](http://lg.hextet.net/cgi-bin/bgplg?cmd=show+ip+bgp+source-as&req=33040)

### Statistics

* Total ASNS: 5
* Active ASNs: 3 or 60.00%
  * Dualstack IPv4+IPv6: 1 or 20.00%
  * IPv6 Advertised: 1 or 20.00%
  * IPv6 only: 0 or 0.00%
  * IPv4 only: 2 or 40.00%

Graph showing the [growth of Prince Edward Island ASNs](/bgp/pe/asns/), using chart.js.

### Update History

**2017-03-29:** Page being generated instead of manually maintained.
