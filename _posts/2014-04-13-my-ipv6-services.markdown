---
layout: post
title: "My IPv6 Services"
date: 2014-04-13 17:16:40 -0500
comments: false
categories:
- Networking
- Cisco
- IPv6
- Nerd Projects
- Virtualization
- System Administration
image:
  feature: https://ciscodude.net/images/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
---
I've had CiscoDude.net and its associated services IPv6 enabled over native IPv6 for the past year. Before that some services were IPv6 enabled over a HE.net tunnel.

Web services are the easiest I'd say, and were the first I implemented.

## Web Services

Web services are pretty easy to IPv6 enable. NGINX makes configuration especially simple with multiple listen lines:

{% highlight nginx %}
	# HTTPS server
	server {
		listen			443 ssl spdy;
		listen			[::]:443 ssl spdy;
		server_name		ciscodude.net;
{% endhighlight %}

Apache is similarly simple to configure. IPv4-in-IPv6 mapped addresses can make recognizing addresses a pain in your web applications sometimes. Complications have been fairly minimal, mainly with sessions that store the IP address. Privacy addressing, and switching between IPv6/v4 and back has caused occasional issues.

## Email

I run a typical Postfix/Dovecot system with Spamassassin and friends for mail. I have A and AAAA records for my mail server. The only complications I've had so far are:

*	Auto configured addresses don't get revdns, and so auto configured addresses need to be disabled for mail servers (and servers in general, when source address matters for ACLs, QoS, etc)
*	Greylisting: when things fail over from IPv6 to IPv4, mail takes longer to get delivered.
*	Spam filtering is heavily built around IPv4 at the moment.

## Jabber/XMPP

I run [Prosody](https://prosody.im/) for XMPP services. Prosody is very simple compared with many other XMPP servers, and has had IPv6 support since 0.9.x (w/ Lua Socket 3.0).

## DNS

### Recursive

Both of my internal DNS recursors are dual-stacked.

### DNS64/NAT64

My network is not setup for IPv6 only access at the moment, I will be adding DNS64/NAT64 in the next few months to begin testing one translation method. Apparently my Cisco ASA 5505 running firmware 9.0/9.1 should be able to do NAT64/DNS64 w/ AAAA synthesis.

### Authoritative

At the moment only one of my nameservers is dual-stacked, the rest are only IPv4 enabled.

{% highlight text %}
| => check-soa -i ciscodude.net
ns1.henchcdn.com.
	206.220.196.222: OK: 2014040601 (4 ms)
	2604:4280:0:1::53: OK: 2014040601 (5 ms)
ns2.henchman21.net.
	107.170.63.61: OK: 2014040601 (73 ms)
ns3.hcdn.pw.
	206.220.199.250: OK: 2014040601 (6 ms)
{% endhighlight %}
