---
layout: post
title: "Sleep Talking"
date: 2015-02-10 11:10:17 -0600
comments: false
description: "This is a write up of an issue which I experienced on one of my networks. It is in response to When Good NICs Do Bad Things: A Blast of IPv6 Multicast Listener Discovery Queries posted on packetpushers.net."
external_url: http://packetpushers.net/good-nics-bad-things-blast-ipv6-multicast-listener-discovery-queries/
categories:
- Security
- IPv6
- CLI
- Networking
- Network Monitoring
- System Administration
- Troubleshooting
image:
  feature: https://ciscodude.net/static/blog-img/foggy-morning.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
share: true
---
This is a write up of an issue which I experienced on one of my networks. It is in response to [When Good NICs Do Bad Things: A Blast of IPv6 Multicast Listener Discovery Queries](http://packetpushers.net/good-nics-bad-things-blast-ipv6-multicast-listener-discovery-queries/) posted on [packetpushers.net](http://packetpushers.net/).

The problem started early on a Friday morning -- reports of dropped internal/external calls, as well as both LAN and internet outages. I wasn't in the office when the problem was happening, so I didn't get a packet capture of the event. Looking at my Observium graphs, it was soon obvious that some kind of Multicast packets were the culprit. This switch was seeing about 3300 packets/sec worth of Multicast packets.

<a href="/static/blog-img/2015-02-multicast.png"><img src="/static/blog-img/2015-02-multicast-thumb.png" /></a>

Our network normally does not have a lot of Multicast traffic, we aren't running IPv6 yet, and we don't have a lot of Apple machines/devices on our network. I setup my Mac Pro desktop to capture all traffic using tcpdump, and waited for it to happen again. I ran:

{% highlight bash %}
tcpdump -ni en1 -s65535 -G 3600 -w 'trace_%Y-%m-%d_%H:%M:%S.pcap'
{% endhighlight %}

Near the end of the day I was rewarded with a giant capture file when the next report came in, about 2:20PM. I tore into the capture file with Wireshark and quickly discovered 3 machines were flooding the network with IPv6 Multicast Listener Reports.

<a href="/static/blog-img/2015-02-wireshark-multicast.png"><img src="/static/blog-img/2015-02-wireshark-multicast-thumb.png" /></a>

Now that I finally had an idea what type of traffic we were seeing, I was able to search and while I didn't find anyone else who had multicast traffic to `ff02::1:ffbd:14b2` I discovered the above mentioned/linked blog which was exactly the same problem we were seeing. Machines with Intel I217-LM NICs would begin talking IPv6 when they were in S1 sleep, at fairly high PPS rates.

The fix of applying v19.0 (or v19.5, as this is the latest) on Monday seems to have resolved it -- at least so far. Why the problem chose to show itself 8 months after the systems were installed, I don't know, but this fix seems to have resolved it.

