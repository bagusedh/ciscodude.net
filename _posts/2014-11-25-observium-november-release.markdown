---
layout: post
title: "Observium November Release"
date: 2014-11-25 16:44:39 -0600
comments: false
description: "Right along time with its six-month release schedule, Observium 0.14.11 has been released. "
categories: 
- Nerd Projects
- Networking
- ISP
- Cisco
- System Administration
image:
  feature: https://ciscodude.net/static/blog-img/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
share: true
---
Right along time with its six-month release schedule, Observium 0.14.11 has been released. 

Upgrading, as always, is simple. Backup your installation, and then unpack the new files over the old ones.

{% highlight bash %}
cd /opt
cp -r observium observium.bak
wget http://www.observium.org/observium-community-0.14.11.tar.gz
tar xzf observium-community-0.14.11.tar.gz
cd observium
./discovery.php -h none
{% endhighlight %}

A couple of things that are new this release:

* Alerting System (I haven't played with this yet, will be doing this shortly)
* Graphing of Cisco ASA IPv4 sessions (from CISCO-FIREWALL-MIB)
* Cambium Canopy support

Something which I wasn't fully aware of before, is that VMware ESXi has SNMP built in, its just not enabled out of the box (thank goodness, there's enough devices with default "public" communities out there). Its simply to enable, as long as you have console or SSH access to the ESXi system.

{% highlight bash %}
esxcli system snmp set -c public
esxcli system snmp set -l warning
esxcli system snmp set -e yes
{% endhighlight %}

