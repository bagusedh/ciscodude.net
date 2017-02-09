---
layout: post
title: "Nagios Logs, Handy One-Liner"
date: 2015-09-05 18:25:11 -0500
external_url: http://geekpeek.net/nagios-log-convert-timestamp/
comments: false
share: true
description: "Nagios is an amazing network monitoring tool, and its logs are a greppable goldmine of information. Most of us aren't able to convert timestamps into local dates on the fly."
categories: 
- Nerd Projects
- Nagios
- Network Monitoring
- CLI
- Programming
- Networking
- System Administration
---
Nagios is an amazing network monitoring tool, and its logs are a greppable goldmine of information. Most of us aren't able to convert timestamps into local dates on the fly. [GeekPeek](http://geekpeek.net/nagios-log-convert-timestamp/) offers the following one-liner which you can add into a pipe to convert timestamps into human-readable format on the fly.

{% highlight bash %}
perl -pe 's/(\d+)/localtime($1)/e'
{% endhighlight %}

I've used variations on this to convert the timestamps of BGP advertisements in JSON objects outputted from exabgp. It is a very handy chunk of a one-liner to keep handy.
