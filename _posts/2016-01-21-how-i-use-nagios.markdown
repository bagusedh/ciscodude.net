---
layout: post
image:
  feature: https://ciscodude.net/images/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
title: "How I Use Nagios"
date: 2016-01-21 10:34:28 -0600
comments: false
share: true
description: "I have been using Nagios extensively to monitor infrastructure that I am interested in for about 10 years now, and each time I build a new system I version the configuration. I am up to Generation 4 now."
categories: 
- Networking
- Nagios
- IPv6
- Nerd Projects
- Network Monitoring
- System Administration
---
I have been using Nagios extensively to monitor infrastructure that I am interested in for about 10 years now, and each time I build a net-new Nagios monitoring system I version the configuration. I am up to Generation 4 now which includes:

*	Approx 75 hosts at the moment
*	Approx 130 service checks
*	Service checks for:
	*	Generic TCP services (Tor ORPorts for example)
	*	Ping checks (v4 and v6)
	*	HTTP/HTTPS service checks (include cert expiry)
	*	Other TCP services like SMTP, SMTPS, IMAP, IMAPS, POP3, and POP3S
	*	NRPE-based host checks like total processes and disk space
	*	DNS service checks (are all masters serving all zones they are supposed to be)
	*	XMPP server checks
*	Custom Alerts:
	*	SMS alerts on certain hosts using [nagios-twilio](https://github.com/bfg/nagios-twilio)
	*	Email alerts include the output of `mtr --show-ips --report --report-wide --aslookup -4 <host>`

## OS and Packages

Previously I've always run the Debian-included packages for Nagios, however those packages are stuck at Nagios v3.x and v4 has some improvements that I've been wanting to use for a long time. Recently when moving my main Nagios system to [DigitalOcean](https://www.digitalocean.com/?refcode=f6432a6e1354) I chose to build Nagios from source instead of using the Debian packages.

## Managing Configs

I have stored all of my Nagios configurations in git for several years now. Before they were stored in git I stored them in subversion which I was able to convert over to a git repo. This makes it really easy to replicate any changes (commits) over to other Nagios systems. 

I manage the contents of `/etc/nagios3` on Debian, which includes `conf.d` where all of my custom config is stored. Now that I'm using a custom-compiled version I instead manage `/usr/local/nagios/etc` in git.

