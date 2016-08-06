---
layout: post
image:
  feature: https://ciscodude.net/images/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
title: "BGP 101: Failover by Splitting Advertisements"
date: 2013-08-09 10:57:26 -0600
comments: false
categories:
- Networking
- ISP
- BGP
---
BGP is an awesome tool. There is many ways to accomplish the same result, all with their own pros and cons.

One of those things is inbound redundancy. Remembering that with BGP you don't have direct control, but only influence over your inbound paths via BGP advertisements, there are a few ways to accomplish redundancy.

<!--more-->

*	Prepending one path to be longer than the other.
*	Co-ordinated use of localpref.
*	Splitting ones advertisements.

Prepending is the simplest option. A peer is configured to have extra copies of the local AS number added to the path, and other locations on the internet see a longer AS-path via that connection. This can be overridden by any administrator by use of localpref and other local routing policies. Some providers limit the number of prepends, this can lessen the effectiveness of them.

Co-ordinating the use of localpref also works, usually thru the use of a BGP community. This is slightly more complex to setup, and requires the co-operation of the upstream. This may or may not be an issue.

The third option is to split up a an advertisement over one peer. So an IPv4 /21 would become 2x /22's, a /22 would become 2x /23's, and a /23 could become 2x /24. This results in a more specific route being present via one peer, and a less specific one via the second peer. By default un-tweaked routing will choose the more specific route. In the event of a failure on either peer the whole IP space is accessible via the other peer automatically. This can be over-ridden by local routing policy as well, but it does ensure that both paths are up, and isn't limited by configuration like number of prepends.
