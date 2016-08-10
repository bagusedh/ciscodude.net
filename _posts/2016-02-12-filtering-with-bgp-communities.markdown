---
layout: post
image:
  feature: https://ciscodude.net/static/blog-img/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
title: "Filtering with BGP Communities"
date: 2016-02-12 19:45:57 -0600
comments: false
share: true
description: "Otherwise known as Filtering BGP Advertisements Using BGP Communities For Fun and Profit but that made the layout terrible."
categories: 
- Networking
- ISP
- BGP
- Cisco
- System Administration
---
Otherwise known as Filtering BGP Advertisements Using BGP Communities For Fun and Profit but that made the layout terrible. 

Filtering BGP advertisements using communities is a simple and effective way to control your advertisements. This can prevent common BGP route leaks with AS-PATHs that look like SOMEAS LEAKER-TRANSIT1 LEAKER LEAKER-TRANSIT2 SOMEPEER LEAKER-CUSTOMER when filtering transit sessions with prefix-list alone.

Before you can begin filtering using BGP communities, there are a few things you need to know and plan out.

### What Are BGP Communities?

A BGP community is a group of destinations that share a common property. That common property is a path attribute that is included in BGP update messages. This information is somewhat like a GMail label, multiple communities can be attached to a particular route. By using these communities you can perform actions on the whole group without having to list each member in a prefix-list for example. You can use community attributes to trigger routing policy decisions, such as whether to accept a route or not, and if you do accept it, what preference you give it, and whether you advertise it upstream or to your peering partners.

BGP communities look like an AS number, ex: `65001` and `2000`. BGP Extended communities look like two ASNs separated with a :, ex: `174:70` and `15290:75`.

### How do you want to label routes, and influence your routing policy?

It may help to look at some examples of BGP communities supported by various providers when creating your own. Many ISPs publish their list of BGP Communities in their IRR AS record. 

ex: `whois -h whois.radb.net AS174` and `whois -h whois.radb.net AS15290` (look in the remarks section, or [here](/bgp/communities/as174.txt) and [here](/bgp/communities/as15290.txt) for archived copies).

These published communities follow this format:

`<TheirASN>:<Number>`

It would seem to me that the number ranges used in the `<Number>` portion of the community should be partitioned out in a local way, ex:

Number Range | Actions
------------ | -------
1 - 9        | Originated, Customer Originated, Peer, and Transit routes
50 - 200     | Localpref Modifiers (50 thru 200 in increments of 5 or 10)
300 - 500    | Limit advertisements to upstreams, peers, and customers
666          | Blackhole
3000 - 3010  | Control insertion of own prepends

### Example Routing Policy, Communities and Cisco Config

ASN: **65001**

#### Routing Policy

Route Source      | Localpref
----------------- | ---------
Transit           | 60
Peering           | 70
Peering Backup    | 65
Customer Preferred | 110
Customer Primary  | 100
Customer Backup   | 90
Customer Fallback | 50

#### BGP Communities

BGP Community | Actions/Meaning
------------- | ---------------
65001:1       | Learned via Transit
65001:2       | Learned via IX/Open Peering
65001:3       | Learned via Customers
65001:4       | Learned via Self
65001:100     | Set Localpref = 100 (Customer Primary Link/Default)
65001:110     | Set Localpref = 110 (Customer Preferred Link)
65001:90      | Set Localpref = 90 (Customer Backup Link)
65001:50      | Set Localpref = 50 (Customer Failback Link)
65001:65      | Set Localpref = 65 (Peering Backup Link)
65001:300     | Do not send routes to BGP customers or peers **CAREFUL**
65001:301     | Do not send routes to upstreams/transits
65001:302     | Do not send routes to IX peering
65001:303     | Do not send routes to Customers **CAREFUL**
65001:304     | Only send routes to downstreams/customers
65001:666     | Blackhole
65001:3001    | Prepend AS65001 1x
65001:3002    | Prepend AS65001 2x
65001:3003    | Prepend AS65001 3x
65001:3004    | Prepend AS65001 4x

#### Example Partial Cisco Config w/ Route-Maps

{% highlight config %}
router bgp 65001
  no synchronization
  bgp log-neighbor-changes
  ! neighbor 192.0.2.1 CUSTOMER
  neighbor 192.0.2.1 remote-as 65002
  neighbor 192.0.2.1 next-hop-self
  neighbor 192.0.2.1 send-community
  neighbor 192.0.2.1 prefix-list BGP-65002-in
  neighbor 192.0.2.1 route-map PEER-65002-in in
  !neighbor 192.0.2.1 route-map PEER-65002-out out
  ! neighbor 192.0.2.2 TRANSIT
  neighbor 192.0.2.2 remote-as 65003
  neighbor 192.0.2.2 next-hop-self
  neighbor 192.0.2.2 send-community
  neighbor 192.0.2.2 prefix-list BGP-65003-in
  neighbor 192.0.2.2 route-map PEER-65003-in in
  neighbor 192.0.2.2 route-map PEER-65003-out out
  no auto-summary

ip bgp-community new-format

ip prefix-list BGP-65002-in seq 10 permit 192.0.2.0/24
ip prefix-list ALL seq 10 permit 0.0.0.0/0 le 24

ip community-list 1 permit 65001:1
ip community-list 2 permit 65001:2
ip community-list 3 permit 65001:3
ip community-list 4 permit 65001:4
ip community-list 10 permit 65001:100
ip community-list 11 permit 65001:110
ip community-list 9 permit 65001:90
ip community-list 5 permit 65001:50
ip community-list 6 permit 65001:666
ip community-list 20 permit 65001:300
ip community-list 21 permit 65001:301
ip community-list 22 permit 65001:302
ip community-list 23 permit 65001:303
ip community-list 24 permit 65001:304
ip community-list 30 permit 65001:3000
ip community-list 31 permit 65001:3001
ip community-list 32 permit 65001:3002
ip community-list 23 permit 65001:3003
ip community-list 34 permit 65001:3004

route-map PEER-65002-in permit 10
  match ip address prefix-list BGP-65002-in
  set community 65001:3 additive
  continue

route-map PEER-65002-in permit 100
  match community 10
  set local-preference 100

route-map PEER-65002-in permit 110
  match community 11
  set local-preference 110

route-map PEER-65002-in permit 120
  match community 9
  set local-preference 90

route-map PEER-65002-in permit 130
  match community 5
  set local-preference 50


route-map PEER-65003-in permit 10
  match ip address prefix-list ALL
  set community 65001:1 additive
  continue

route-map PEER-65003-in permit 20
  match community 23
  set local-preference 100


route-map PEER-65003-out deny 10
  match community 1

route-map PEER-65003-out deny 20
  match community 2

route-map PEER-65003-out permit 30
  match community 3
  continue

route-map PEER-65003-out permit 40
  match community 4
  continue

route-map PEER-65003-out permit 110
  match community 21
  set as-path prepend 65001

route-map PEER-65003-out permit 120
  match community 22
  set as-path prepend 65001 65001

route-map PEER-65003-out permit 130
  match community 23
  set as-path prepend 65001 65001 65001

route-map PEER-65003-out permit 140
  match community 24
  set as-path prepend 65001 65001 65001 65001
{% endhighlight %}

