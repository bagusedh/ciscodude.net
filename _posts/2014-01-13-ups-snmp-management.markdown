---
layout: post
title: "UPS SNMP Management"
date: 2014-01-13 19:12:13 -0600
comments: false
categories: 
- Nagios
- Network Monitoring
- ISP
- Nerd Projects
- CLI
- System Administration
---
Having put an IP address on the management card of a APC Symmetra RM 12000 recently, I set out to setting up Nagios to monitor it today. I found a plugin called [check_apc.pl](http://exchange.nagios.org/directory/Plugins/Hardware/UPS/APC/check_apc-2Epl/details) which seemed to work fairly well. It was also quite nicely supported in Observium.

Downloading the plugin and executing it checked out OK:

{% highlight text %}
$ ./check_apc.pl -H 192.0.2.200 -C public
Symmetra RM 12000, reporting for duty
$ ./check_apc.pl -H 192.0.2.200 -C public -l status
OK: UPS is online (Runtime remaining: 29 minutes)|'Runtime Remaining'=29m;
$ ./check_apc.pl -H 192.0.2.200 -C public -l health
OK: Self test passed on 01/07/2014 (5 days ago)
$ ./check_apc.pl -H 192.0.2.200 -C public -l load
OK: Output load: 10% |load=10%;0;0;0
{% endhighlight %}

After adding a `check_command`, I added service checks to monitor the UPS host. After forcing a check, I was getting errors about "Service check did not exit properly". Going back to the check_apc.pl page on exchange.nagios.org, I read thru the comments. The second comment fixed the issue for me, apparently built in Perl in Nagios may not be 100% the same as the CLI. I added `/usr/bin/perl` in front of the check command and it immediately returned results like the CLI testing had.
