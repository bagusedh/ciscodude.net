---
layout: post
title: "Brocade ICX Basics"
date: 2014-07-10 19:25:13 -0500
comments: false
published: true
categories:
- Brocade
- Networking
- Nerd Projects
- CLI
share: true
---
I've been exposed to several different models of Brocade ICX switches lately, both the ICX6430 and the ICX6610. The ICX6430 is a low end gigabit-only, stackable layer2 access switch platform. While the ICX6610 is a feature rich gigabit/10gigabit stackable layer3 distribution/core switch platform (depending on the size of your network).

## VLANs

The biggest difference between Cisco Catalyst products, and Brocade ICX switches is the way VLANs are assigned to a port. On Cisco, this configuration is all done right on the port.

{% highlight config %}

vlan 100
  name data

vlan 110
  name voice

vlan 2000
  name SomeOtherVlan

interface GigabitEthernet 1/0/24
  description A TRUNK PORT
  switchport trunk encapsulation dot1q
  switchport mode trunk
  switchport trunk allowed vlan 100,110,2000

interface GigabitEthernet 1/0/1
  description A PHONE PORT
  switchport mode access
  switchport access vlan 100
  switchport voice vlan 110
  spanning-tree portfast

interface GigabitEthernet 1/0/2
  description AN ACCESS PORT
  switchport mode access
  switchport access vlan 100
  spanning-tree portfast

{% endhighlight %}

On Brocade this is done on on the VLAN:
{% highlight config %}

vlan 100 name data by port
  tagged ethe 1/1/1 ethe 1/1/24
  untagged ethe 1/1/2

vlan 110 name voice by port
  tagged ethe 1/1/1 ethe 1/1/24

vlan 2000 name SomeOtherVlan by port
  tagged ethe 1/1/24

interface ethernet 1/1/24
  port-name A TRUNK PORT

interface ethernet 1/1/1
  port-name A PHONE PORT
  dual-mode 100
  inline-power
  voice-vlan 110

interface ethernet 1/1/2
  port-name AN ACCESS PORT

{% endhighlight %}

The biggest gotcha for me is that a port cannot have both tagged and untagged VLANs assigned to it. A port is in one of the 3 following configuration modes:

*	access (one single untagged VLAN)
*	trunk (one or more tagged VLANs)
*	dual-mode (one or more tagged VLANs, with configuration on the port to say which VLAN untagged traffic should be directed to)

### default-vlan-id

Brocade ICX switches (and perhaps others) have a concept which is somewhat foreign -- "Default VLAN ID".

At first I struggled with how the default VLAN ID worked, and what it was for. After experimenting and reading many documents, I discovered that all ports are assigned by default (untagged) to the default VLAN ID. Out of the box, all 24 ports would be in the same VLAN, and be able to talk to each other, like you'd expect from a switch. This is much the same as how all ports as default in VLAN 1 on Cisco. 

Where this is different however is that ports are members of the default-vlan-id by NOT being part of other VLANs. This is handy, you can specify the default VLAN as a "dead VLAN" which isn't part of your network to blackhole unknown machines.

### dual-mode

Dual-mode is the term Brocade uses for what Cisco calls "switchport trunk native vlan xxx". This is used to direct un-tagged traffic into a specific VLAN. This is handy when you've got a phone and an end user on the same port.
