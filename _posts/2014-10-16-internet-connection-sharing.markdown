---
layout: post
title: "Internet Connection Sharing"
date: 2014-10-16 13:43:23 -0500
comments: false
description: "Longer Title: Internet Connection Sharing, Tracking down Rogue DHCP Servers, and why DHCP Snooping should always be enabled on a network."
categories:
- Security
- CLI
- Networking
- Network Monitoring
- System Administration
- Troubleshooting
share: true
---
I should start this off by saying that I contemplated much longer titles for this article, but kept it short for URL uniformity. The longer/longest version was: Internet Connection Sharing, Tracking Down Rogue DHCP Servers, and why DHCP Snooping should always be enabled on a network.

This problem began about two weeks ago. A report came in that a machine had stopped working suddenly in the afternoon, and that they had pulled an address of 192.168.137.252/24 which was not used anywhere on the network. Unfortunately the MAC address of the DHCP server/gateway was not recorded. At this point I began running arpwatch on several VLANs, looking for bogon ARPs. We also increased the duration of DHCP lease, one of two redundant DHCP servers had a lease time of 10m instead of 7d, causing a lot of unnecessary DHCP REQUEST activity. During the next week the office was almost empty due to an off-site event, and no hits came up for foreign IP addresses that matched the range which had caused the problem. 

Finally two weeks later, late this morning, an arpwatch hit came up for the IP address we had seen earlier, 192.168.137.1, the default gateway that the system had reported at the time of problems. We finally had a MAC address to track down.

I tracked down the MAC address to a port, and through the CDP advertisement of the phone discovered the location of the issue, and the identity of the machine owner. Upon closer investigation, it turned out that the user had both wireless and wired ports enabled, and had "Sharing" enabled on the wireless side, causing the machine to become a NAT router on the wired segment.

## Lessons Learned

ALWAYS USE DHCP SNOOPING WHEN AVAILABLE.

Seriously, just do it. It will make your life easier.

DHCP Snooping ensures that DHCP requests are only allowed into a switch/VLAN on particular ports, your uplinks for example. This prevents end user ports from answering DHCP REQUESTs potentially faster than your intended DHCP server (especially if you use ip helper to use a central, redundant DHCP service).

