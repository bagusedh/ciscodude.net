---
layout: post
title: "Strange SNMP SetRequest Traffic"
date: 2014-09-15 17:25:28 -0500
comments: false
description: "The Internet Storm Center had an interesting diary entry up today which I was able to independently confirm quite easily in under 5 minutes. Watching the traffic for a longer period of time became rather interesting."
categories:
- Networking
- ISP
- Security
- Network Monitoring
- System Administration
external_url: https://isc.sans.edu/diary/Google+DNS+Server+IP+Address+Spoofed+for+SNMP+reflective+Attacks/18647
image:
  feature: https://ciscodude.net/static/blog-img/foggy-morning.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
share: true
---
The [Internet Storm Center](https://isc.sans.edu/) had an [interesting diary entry](https://isc.sans.edu/diary/Google+DNS+Server+IP+Address+Spoofed+for+SNMP+reflective+Attacks/18647) up today which I was able to independently confirm quite easily in under 5 minutes. Watching the traffic for a longer period of time became rather interesting.

Here is a packet capture across a ~45 minute period:

	16:29:26.372067 IP 8.8.8.8.47074 > 206.x.193.76.161:  C=private SetRequest(43) ip.ipDefaultTTL.0=1 ip.ipForwarding.0=2
	16:29:26.372067 IP 8.8.8.8.47074 > 206.x.193.76.161:  C=private SetRequest(43) ip.ipDefaultTTL.0=1 ip.ipForwarding.0=2
	16:29:31.562062 IP 8.8.8.8.47074 > 206.x.194.76.161:  C=private SetRequest(43) ip.ipDefaultTTL.0=1 ip.ipForwarding.0=2
	16:29:35.961901 IP 8.8.8.8.47074 > 206.x.195.76.161:  C=private SetRequest(43) ip.ipDefaultTTL.0=1 ip.ipForwarding.0=2
	16:29:40.362582 IP 8.8.8.8.47074 > 206.x.196.76.161:  C=private SetRequest(43) ip.ipDefaultTTL.0=1 ip.ipForwarding.0=2
	16:29:44.753627 IP 8.8.8.8.47074 > 206.x.197.76.161:  C=private SetRequest(43) ip.ipDefaultTTL.0=1 ip.ipForwarding.0=2
	16:29:49.154980 IP 8.8.8.8.47074 > 206.x.198.76.161:  C=private SetRequest(43) ip.ipDefaultTTL.0=1 ip.ipForwarding.0=2
	16:29:53.552159 IP 8.8.8.8.47074 > 206.x.199.76.161:  C=private SetRequest(43) ip.ipDefaultTTL.0=1 ip.ipForwarding.0=2
	16:36:59.704566 IP 8.8.8.8.47074 > 192.x.40.77.161:  C=private SetRequest(43) ip.ipDefaultTTL.0=1 ip.ipForwarding.0=2
	16:37:04.134728 IP 8.8.8.8.47074 > 192.x.41.77.161:  C=private SetRequest(43) ip.ipDefaultTTL.0=1 ip.ipForwarding.0=2
	16:48:26.427724 IP 8.8.8.8.47074 > 206.x.193.77.161:  C=private SetRequest(43) ip.ipDefaultTTL.0=1 ip.ipForwarding.0=2
	16:48:30.859399 IP 8.8.8.8.47074 > 206.x.194.77.161:  C=private SetRequest(43) ip.ipDefaultTTL.0=1 ip.ipForwarding.0=2
	16:48:35.291609 IP 8.8.8.8.47074 > 206.x.195.77.161:  C=private SetRequest(43) ip.ipDefaultTTL.0=1 ip.ipForwarding.0=2
	16:48:39.745337 IP 8.8.8.8.47074 > 206.x.196.77.161:  C=private SetRequest(43) ip.ipDefaultTTL.0=1 ip.ipForwarding.0=2
	16:48:44.177500 IP 8.8.8.8.47074 > 206.x.197.77.161:  C=private SetRequest(43) ip.ipDefaultTTL.0=1 ip.ipForwarding.0=2
	16:48:48.636009 IP 8.8.8.8.47074 > 206.x.198.77.161:  C=private SetRequest(43) ip.ipDefaultTTL.0=1 ip.ipForwarding.0=2
	16:48:53.100007 IP 8.8.8.8.47074 > 206.x.199.77.161:  C=private SetRequest(43) ip.ipDefaultTTL.0=1 ip.ipForwarding.0=2
	16:55:59.904746 IP 8.8.8.8.47074 > 192.x.40.78.161:  C=private SetRequest(43) ip.ipDefaultTTL.0=1 ip.ipForwarding.0=2
	16:56:04.332222 IP 8.8.8.8.47074 > 192.x.41.78.161:  C=private SetRequest(43) ip.ipDefaultTTL.0=1 ip.ipForwarding.0=2
	17:07:27.078063 IP 8.8.8.8.47074 > 206.x.193.78.161:  C=private SetRequest(43) ip.ipDefaultTTL.0=1 ip.ipForwarding.0=2
	17:07:31.500423 IP 8.8.8.8.47074 > 206.x.194.78.161:  C=private SetRequest(43) ip.ipDefaultTTL.0=1 ip.ipForwarding.0=2
	17:07:35.932614 IP 8.8.8.8.47074 > 206.x.195.78.161:  C=private SetRequest(43) ip.ipDefaultTTL.0=1 ip.ipForwarding.0=2
	17:07:40.394272 IP 8.8.8.8.47074 > 206.x.196.78.161:  C=private SetRequest(43) ip.ipDefaultTTL.0=1 ip.ipForwarding.0=2
	17:07:44.822148 IP 8.8.8.8.47074 > 206.x.197.78.161:  C=private SetRequest(43) ip.ipDefaultTTL.0=1 ip.ipForwarding.0=2
	17:07:49.249753 IP 8.8.8.8.47074 > 206.x.198.78.161:  C=private SetRequest(43) ip.ipDefaultTTL.0=1 ip.ipForwarding.0=2
	17:07:53.699591 IP 8.8.8.8.47074 > 206.x.199.78.161:  C=private SetRequest(43) ip.ipDefaultTTL.0=1 ip.ipForwarding.0=2
	17:15:00.562361 IP 8.8.8.8.47074 > 192.x.40.79.161:  C=private SetRequest(43) ip.ipDefaultTTL.0=1 ip.ipForwarding.0=2
	17:15:04.988591 IP 8.8.8.8.47074 > 192.x.41.79.161:  C=private SetRequest(43) ip.ipDefaultTTL.0=1 ip.ipForwarding.0=2

## Observations

The forged source port of 47074 is the same as in the diary entry.

Given that these scans are of two IP ranges which are somewhat far apart numerically, it is interesting that the scans appear to be very sequential in nature (x.x.z.y), and incrementing the z variable to target /16 sized nets? This would make sense from a targeting/attacking CPE devices perspective as many large ISPs have huge blocks this size for their customers.
