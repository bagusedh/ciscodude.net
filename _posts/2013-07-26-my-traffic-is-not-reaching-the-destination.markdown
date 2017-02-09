---
layout: post
title: "\"My Traffic Is Not Reaching The Destination\""
date: 2013-07-26 12:49:00 -0600
comments: false
categories:
- Networking
- ISP
- System Administration
---
I ran into a very interesting issue this week troubleshooting a UDP stream that a client was trying to stream from one side of the continent to the other. The client informed me that they would be testing a 200 megabit stream from a remote site over the Internet to a location in Winnipeg. This was to be a test for an event several weeks later if successful.

<!--more-->

The client turned up the stream and I was immediately notified of massive bandwidth usage on the network. Things appeared to be working from my perspective. Then came the report from the client ... traffic was not reaching the end destination. Closer inspection of the traffic graphs corroborated this, traffic was reaching the CPE router, but was not going out the clients port on to them. Other traffic was going out the client port, just not this specific traffic. Firmware bugs were suspected, so the router was updated to the latest available stable firmware, and still the problem persisted.

At last I thought to myself, what is so special about these packets that they aren't arriving? Are they malformed in some way? I captured 100 packets from source to destination, at the edge of the network I control. A quick scp, and several minutes waiting for the non-native Wireshark to load on my mac, and I was looking at the packets in Wireshark. The packets were under 1000 bytes long, appeared to be properly formed, but Wireshark pointed out that the TTL value was "only 2". Only 2? But this is at least 3+ hops away from the client, 2 hops away was the CPE router. I then captured traffic between the CPE router and the UDP stream source, and had my questions answered. A steady stream of ICMP messages back, informing the source that the TTL had expired in transit.

I then sent both packet captures on the client, and suggested they increase the TTL value by several, who responded several minutes later saying that had resolved the issue. Total time to resolve: under 4 business hours.
