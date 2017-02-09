---
layout: post
title: "Deploying Fail2Ban using SaltStack"
date: 2014-08-03 20:46:10 -0500
comments: false
categories: 
- Nerd Projects
- Network Monitoring
- CLI
- IPv6
- Programming
- Virtualization
- SaltStack
- System Administration
share: true
---
One of the realities of having public facing SSH is the continual brute force attempts. I have 3 droplets at [DigitalOcean](https://www.digitalocean.com/?refcode=f6432a6e1354), SGP1 and NYC2 get hit much more often than LON1. I thought about deploying SSH ACLs through SaltStack, but because all my systems are keys only, instead I deployed fail2ban with a custom configuration file to watch the bots get banned and laugh maniacally.

The relevant parts of config were as follows:

top.sls:
{% highlight yaml %}
base:
  'os:debian':
    - match: grain
    - settings.ntp.debian
    - settings.minion.debian
    - settings.fail2ban.debian
{% endhighlight %}

settings/fail2ban/debian.sls:
{% highlight yaml %}
fail2ban:
  pkg:
    - installed
  service:
    - running
    - require:
      - pkg: fail2ban
    - watch:
      - file: /etc/fail2ban/jail.local

/etc/fail2ban/jail.local:
  file:
    - managed
    - source: salt://settings/fail2ban/jail.local
    - require:
      - pkg: fail2ban
{% endhighlight %}

This deploys a custom jail.local file, which is the recommended way for deploying fail2ban.

This makes it quite easy to change ban times globally, or based on other grains.
