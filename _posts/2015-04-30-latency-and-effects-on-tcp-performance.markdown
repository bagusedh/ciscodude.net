---
layout: post
title: "Latency and Effects on TCP Performance"
date: 2015-04-30 15:23:29 -0500
comments: false
share: true
description: "Have you ever used a download manager to download multiple threads, in order to max out or more fully utilize your connection? This is the effect of a small TCP receive window. How does latency factor into this?"
categories: 
- Security
- CLI
- Networking
- Network Monitoring
- System Administration
- Troubleshooting
---
Have you ever used a download manager to download multiple threads, in order to max out or more fully utilize your connection? This is the effect of a small TCP receive window. How does latency factor into this?

## Bandwidth Delay Product

Given the bandwidth rate of 5 Mbit of a bottleneck link between two networks, a round-trip-time time of 90ms, and a (default) receive window (RWIN) of 16k, what do you get? The answer is a Bandwidth Delay Product (BDP) of 1.46 Mbit/sec. 

**BDP  = RWIN * 8 * RTT**

## Long Fat Networks

A network with a large amount of bandwidth, and also high latency is called a **Long Fat Network** or **LFN** for short. To fill a 5 Mbit pipe with 90ms latency, the calculation is as follows:

**BDP  = 57 * 8 * 90**

## TCP Receive Window

An important consideration is the TCP receive window. This is the number of bytes (in multiple packets) which can be received without needing to acknowledge each individually. The latency of the acknowledgements, combined with a limited TCP receive window is what limits TCP per-thread performance. Years ago people noticed this, and started using download managers which would download multiple threads to get around the per-thread limitations imposed by the Bandwidth Delay Product. As time went on network and Internet speeds increased, Operating Systems increased their default TCP receive windows to match the connection speeds of the day -- rather like a game of whack-a-mole. 

Eventually OSs started to implement TCP receive window auto-scaling to dynamically select a window size. This dynamically selects an optimal value by sending larger and larger un-acknowledged chunks of data until a predefined maximum window size is reached, or optimal performance is reached.

## Additional Resources

I found the [TCP Throughput Calculator](https://www.switch.ch/network/tools/tcp_throughput/) at switch.ch helpful to calculate the above values. I also found the following blogs and articles useful:

*	[How to Calculate TCP throughput for long distance WAN links](http://bradhedlund.com/2008/12/19/how-to-calculate-tcp-throughput-for-long-distance-links/)
*	[Bandwidth Delay Product](http://en.wikipedia.org/wiki/Bandwidth-delay_product)
*	[Effects of latency and packet loss on TCP throughput](http://filipv.net/2013/06/19/effects-of-latency-and-packet-loss-on-tcp-throughput/) - This article diagrams the above concepts very well.

