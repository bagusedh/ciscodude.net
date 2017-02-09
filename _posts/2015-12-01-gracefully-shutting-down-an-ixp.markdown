---
layout: post
title: "Gracefully Shutting Down An IXP"
author: Jonathan Stewart
author_site: http://www.mbix.ca/
date: 2015-12-01 18:11:38 -0600
comments: false
share: true
description: "This post is a guest blog by MBIX Network Administrator Jonathan Stewart. This post was brought to you by a real situation at MBIX."
categories: 
- Networking
- ISP
- Cisco
- BGP
- System Administration
---
This post is a guest blog by [Manitoba Internet Exchange Network Administrator, Jonathan Stewart](http://www.mbix.ca/). This post was brought to you by a real situation at MBIX.

## How to gracefully shutdown BGP on Layer 2 ##

When you want to exert precise layer 3 control, but you only run a layer 2 service.

## First the setup ##

You run an IXP where many members--who are ISPs you don't control--are exchanging traffic.

You need to perform some maintenance, like upgrading the switch OS, without a second supervisor. This will definitely cause an outage for your members.

It's easy to shut off the route servers, and stop most of the traffic.  It's the direct peering, done without asking or telling the IXP, that's hard to shutdown.  If a router is connected to the exchange via a switch, that router won't notice that MBIX is down for 180 seconds, a real impact on an average user.

The solution?  Layer 2 ACLs on your Cisco Nexus 7004.

## Think about the traffic ##

Remember when I said your members are exchanging traffic? Well, they're doing 2 things. 

Primarily, they're exchanging user IP data--video streams, websites, and cat photos--at high performance and low latency, just as you hoped.

The members' routers, however, are directly exchanging a small amount of really critical data--BGP updates.

The BGP data exchanged is really important, because it's via BGP that the routers are learning that they can send data over the IXP.

BGP data is exchanged in two ways across the IXP:

* Via the two route-servers
* Via direct peering, where ISP A's router forms a direct neighbor with ISP B

The route servers are under our control, and we can shut down all the BGP sessions gracefully there. 

The direct peering session are harder to influence.  The BGP packets move through the IXP switch, but since you're a layer 2 service, you don't take any part in the BGP conversation.

## Maintenance begins ##

For any service-impacting maintenance, you'd like it to impact your members as little as possible, so you take a couple of important actions:

* You email everyone, alerting them to the maintenance window and outage
* You shut down the route servers, so routes are withdrawn and traffic stops flowing

You can still see a problem: ISPs who are peered directly keep sending BGP and user data. They'll keep doing it until the switch shuts down, and if their router is connected via a switch, BGP could take 180 seconds to timeout the routes. 

## Nexus Hacking ##

Our Nexus 7004 has a SUP2 supervisor and runs NX-OS 6.2(6), so you can implement a Layer 2, VLAN-based ACL, to interrupt our peers' BGP packets, causing sessions to die, and user data to stop flowing.

Create a VLAN ACL:

First, create an access-list to match BGP packets.  On v4 and v6. 'eq bgp' means TCP port 179, the BGP port.

{% highlight config %}
ip access-list BGP-v4
  10 permit tcp any any eq bgp

ipv6 access-list BGP-v6
  10 permit tcp any any eq bgp
{% endhighlight %}

Then, create an access-map to define the action, what to take the action on (match):

{% highlight config %}
vlan access-map BGP-DROP 10
  match ip address BGP-v4
  match ipv6 address BGP-v6
  action drop
  statistics per-entry
{% endhighlight %}

Finally, apply the action to a VLAN:

{% highlight config %}
vlan filter BGP-DROP vlan-list 666 
{% endhighlight %}

## Show commands ##

{% highlight text %}
# show ip access-lists [BGP-v4]
# show ipv6 access-lists [BGP-v6]
# show vlan access-map [BGP-DROP]
# show vlan filter [ vlan 666 | access-map BGP-DROP]
{% endhighlight %}

## Results ##

After applying the vlan filter, you can see the traffic on the IXP switch drop to the slightest of trickles. Switch is now ready for upgrade. Execute upgrade.

