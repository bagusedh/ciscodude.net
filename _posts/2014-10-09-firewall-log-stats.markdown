---
layout: post
title: "Firewall Log Stats"
date: 2014-10-09 21:40:00 -0500
comments: false
description: "I run an OpenBSD system as a packet filter in front of my various virtual machines at my colo. I've got a default `block drop in log all` rule which drops and logs all un-handled traffic. I've been rotating the logs around, but not doing anything more than troubleshooting with the logs. I often watch the live pflog scroll by, investigating the occasional IP of interest."
categories:
- System Administration
- CLI
- Security
- Network Monitoring
- Nerd Projects
- Networking
image:
  feature: https://ciscodude.net/static/blog-img/foggy-morning.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
share: true
---
I run an OpenBSD system as a packet filter in front of my various virtual machines at my colo. I've got a default `block drop in log all` rule which drops and logs all un-handled traffic. I've been rotating the logs around, but not doing anything more than troubleshooting with the logs. I often watch the live pflog scroll by, investigating the occasional IP of interest.

This often involves doing a whois on the IP space, as well as a GeoIP lookup. This can be repetitive, and sometimes after a few hours worth of copy/paste/lookup/etc I feel like a robot. So I set out to gather some stats on my firewall logs. I googled for "openbsd pflog stats", which gave me the [OpenBSD PF FAQ on logging](http://www.openbsd.org/faq/pf/logging.html), and then an article about [Monitoring PF](http://prefetch.net/articles/monitoringpf.html) which suggested using fwanalog. I tried fwanalog out, and was unhappy with the complexity, and the lack of output results. Things just seemed broken after sitting abandoned for so long. 

I went back to my Google search, and on the 5th hit, found a [nice Perl script, Pantz PFlog Stats](http://www.pantz.org/software/pf/pantzpfblockstats.html), which had simple, but informative output. This script had also sat for a while, and hadn't been updated in years, however it ran without error, and immediately produced a nice summary of blocked packets. The code was well documented, and the script was easily extensible. I've hacked on many Perl scripts before, I actually started code hacking on Perl.

I set out with a few goals in mind:

*	Update the script's external links
	*	web-based IP whois which supports all geographic regions (not just ARIN region)
*	Add GeoIP support, using the free DB from Maxmind.

I have accomplished both goals, and have put the result of my hacking up on Github, at [github.com/tbaschak/Pantz-PFlog-Stats](https://github.com/tbaschak/Pantz-PFlog-Stats). 

- - - 

You can see some sample output generated at the time this blog was published [here](/fwlogstats/).

