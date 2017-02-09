---
layout: post
title: "Nagios and IPv6"
date: 2015-11-22 09:27:36 -0600
comments: false
share: true
description: "While I've had most of my services IPv6 enabled for quite a while, I have not set up monitoring of those services over IPv6 yet. This blog post is a summary of my experiences IPv6 enabling my nagios setup."
categories: 
- Networking
- Nagios
- IPv6
- Nerd Projects
- Network Monitoring
- System Administration
---
While I've had most of my services IPv6 enabled for quite a while, I have not set up monitoring of those services over IPv6 yet. This blog post is a summary of my experiences IPv6 enabling my nagios setup.

## Defining IPv4/v6 specific service checks

All of my servers run Debian and as such, my nagios config is a little Debian-centric. The nagios-plugins-contrib package defines some useful generic and IPv4 specific commands under `/etc/nagios-plugins/config`. For example, the file `/etc/nagios-plugins/config/mail.cfg` defines both `check_simap` as well as `check_simap_4` (explicit -4 on the command_line).

I found it useful to define IPv6 specific check commands as well, so for example I've created `check_simap_6` which is identical to `check_simap_4` except its got -6 instead of -4 to force v6 checking.

One interesting issue I came across is that the host check can only be performed over IPv4 OR IPv6. Your environment will one primary address family. If you have v4 for the primary check, and have a v6 only host, you'd need to define a custom check command for the host, or perhaps an IPv6-only host template which you could apply instead of `generic-host`.

## DNS Matters

To simplify checks, using dual-stacked hostnames is a MUST. By ensuring `address` is set to a dual-stacked host name we can use our checks which force -4 or -6 and ensure the check is happening over the proper address family.

### Custom Variables

For checks which I prefer to use a literal IPv4 or IPv6 address, I've defined IPv4 and IPv6 address variables. `_ADDRESS4` and `_ADDRESS6` which are usable as `$_HOSTADDRESS4$` and `$_HOSTADDRESS6$`. I am only using this for DNS server checks at the moment, so that if DNS fails for some reason I'll still be able to monitor my nameservers. 

An example of this:

{% highlight text %}
define host{
  use         generic-host
  host_name   nagios.ciscodude.net
  alias       nagios.ciscodude.net
  address     nagios.ciscodude.net
  _ADDRESS4   45.63.67.34
  _ADDRESS6   2001:19f0:5c00:960e::64
}
{% endhighlight %}

## IPv4-only Check Plugins

Encountered check plugins that are v4 only:

* `check_icmp` which I actually prefer to `check_ping`, however `check_ping` is v6 compatible (and has a -6 flag)

