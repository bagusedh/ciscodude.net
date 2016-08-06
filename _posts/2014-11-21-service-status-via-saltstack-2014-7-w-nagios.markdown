---
layout: post
title: "Service Status via SaltStack 2014.7 with Nagios"
date: 2014-11-21 23:14:59 -0600
comments: false
description: "One of the most exciting new features to me in SaltStack 2014.7 is the nagios module. This module supports remote execution of nagios-plugins on your minions. It can also execute pre-defined lists of checks and targets defined (and targeted) in a Pillar."
categories: 
- Nerd Projects
- Nagios
- Network Monitoring
- CLI
- Programming
- Virtualization
- SaltStack
- System Administration
image:
  feature: https://ciscodude.net/images/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
share: true
---
One of the most exciting new features to me in SaltStack 2014.7 is the [nagios module](http://docs.saltstack.com/en/latest/ref/modules/all/salt.modules.nagios.html). This module supports remote execution of nagios-plugins on your minions. It can also execute pre-defined lists of checks and targets defined (and targeted) in a Pillar. Jinja templating and Grains can of course be used as well, making for an extremely versatile monitoring and testing solution.

I haven't implemented anything crazy with it yet, but I am really seeing the power of this. A couple ideas off the top of my head:

* Service configuration best practices checklists
* Distributed connectivity tests
* Distributed latency reporting

I would like to build a very simple internal help desk service status page with no Nagios back-end requirement, perhaps even just running out of a `*/5 * * * * ...` cron with the JSON output from `salt --out=json -s -G roles:monitoring nagios.run_all_pillar nagios_test` redirected to a file in a web directory, then displayed to help desk techs via jQuery/HTML5 generated page with nice green/yellow/red statuses for each item monitored based on the return codes of the checks.

- - -

I have made a documentation [pull request](https://github.com/saltstack/salt/pull/18405) to SaltStack, their example pillar on the [nagios module](http://docs.saltstack.com/en/latest/ref/modules/all/salt.modules.nagios.html) docs doesn't fully work as exists in the docs right now.

** Update: ** My doc changes have been committed! I've got [one commit](https://github.com/saltstack/salt/commit/81fcbabdc647bca841a94fde265e9902b51e2d47) in SaltStack!

Below is a working simple sample nagios check Pillar and some output from when it is run.

/srv/salt/top.sls:
{% highlight yaml %}
base:
  '*':
    - nagios
{% endhighlight %}

/srv/pillar/nagios.sls:
{% highlight yaml %}
nagios_test:
  Ping_google:
    - check_icmp: 8.8.8.8
    - check_icmp: google.com
  Load:
    - check_load: -w 0.8 -c 1
  APT:
    - check_apt
{% endhighlight %}

This check Pillar can then be run with `salt nagios.\* nagios.run_pillar nagios_test`, and produces output like below:

{% highlight text %}
nagios.henchman21.net:
    ----------
    APT:
        ----------
        check_apt:
            APT OK: 0 packages available for upgrade (0 critical updates).
    Load:
        ----------
        check_load_-w0.8-c1:
            OK - load average: 0.09, 0.13, 0.13|load1=0.090;0.800;1.000;0; load5=0.130;0.800;1.000;0; load15=0.130;0.800;1.000;0;
    Ping_google:
        ----------
        check_icmp_8.8.8.8:
            OK - 8.8.8.8: rta 30.415ms, lost 0%|rta=30.415ms;200.000;500.000;0; pl=0%;40;80;; rtmax=30.718ms;;;; rtmin=30.226ms;;;;
        check_icmp_google.com:
            OK - google.com: rta 1.328ms, lost 0%|rta=1.328ms;200.000;500.000;0; pl=0%;40;80;; rtmax=1.425ms;;;; rtmin=1.247ms;;;;
{% endhighlight %}
