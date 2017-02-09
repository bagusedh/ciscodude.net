---
layout: post
title: "Observium 0.14.4"
date: 2014-04-06 03:41:49 -0500
comments: true
categories: 
- Nerd Projects
- Networking
- ISP
- System Administration
---
I just noticed that [Observium](http://www.observium.org/wiki/Main_Page) released a new Community Edition release (0.14.4) on April 1. The changes (and additions!!!) mentioned in the [CHANGELOG](http://www.observium.org/wiki/Changelog) are numerous, and include several security fixes -- including for an SQL injection so it is important to upgrade your installation right away, especially if your installation is public-facing.

Upgrading, as always, is simple. Backup your installation, and then unpack the new files over the old ones

{% highlight bash %}
cd /opt
cp -r observium observium.bak
wget http://www.observium.org/observium-community-0.14.4.tar.gz
tar xzf observium-community-0.14.4.tar.gz
cd observium
./discovery.php -h none
{% endhighlight %}

** Update several hours later **:
I've been playing with observium for many hours now, sooo many things are fixed, improved, clearer, etc now. One of the things I am now using is the [Description Parser](http://www.observium.org/wiki/Interface_Description_Parsing), to label ports as Customer, Transit, Peering, Core, or Server. This also makes aggregate Transit, Peering, and Transit+Peering graphs! I have long missed my aggregate graphs from cacti, and this was available to use the whole time!

** Update several more hours later **:
The most recent release is 0.14.4p1 (6th April 2014)

