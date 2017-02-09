---
layout: post
title: "First Brocade CLI Experiences"
date: 2014-01-09 18:57:33 -0600
comments: false
categories: 
- Brocade
- Networking
- ISP
- System Administration
---
I used Brocade equipment for the first time this week. Coming from primarily Cisco environments, but also having a little experience with HP Procurve (CLI and web-managed switches) and Dell web-managed switches, I was a little lost, but eventually found a few blogs with some base configs, and got used to the way of assigning VLANs to ports. 


The particular switch model I was working with was the [Brocade ICX 6430-24P](http://www.brocade.com/products/all/switches/product-details/icx-6430-and-6450-switches/index.page) switch. It had a base license, which is fairly comparable feature-wise with the Cisco Catalyst 2960S-24TS-L with the base license. Important items of feature set:

*	layer 2 only
*	management vlan
*	default-gateway
*	no routing

These switches are deployed as access layer switches, POE user facing ports with phones tagging VLAN. in Ciscoland the config snippet would look as follows:

{% highlight config %}
vlan 2
 name users

vlan 3
 name voice

vlan 4
 name management

 interface range gi1/0/1 - 22
  switchport mode access
  switchport access vlan 2
  switchport voice vlan 3
  spanning-tree portfast
{% endhighlight %}

On the these Brocade switches the same config snippet would be as follows:

{% highlight config %}
vlan 2 name users by port
 tagged ethe 1/1/1 to 1/1/22

vlan 3 name voice by port
 tagged ethe 1/1/1 to 1/1/22

vlan 4 name management by port
 tagged ethe 1/1/24
 management-vlan

interface ethernet 1/1/1 to 1/1/22
 dual-mode 2
 inline power
 voice 
{% endhighlight %}

Overall, after getting things going I'm fairly impressed. I'm definitely not disappointed. Observium discovered them, and discovers neighbours thru CDP &amp; FDP on them. I still need to verify that spanning-tree is running on them properly in all vlans that need to exist.
