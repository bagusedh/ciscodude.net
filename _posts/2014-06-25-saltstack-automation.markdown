---
layout: post
title: "SaltStack Automation"
date: 2014-06-25 23:55:19 -0500
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
I've been hearing about SaltStack for some time now, and have taken a peek at it, but never set it up. This week I changed that and set up a salt-master and several (OK, 10) salt-minions to take commands from the master. 8 local Debian Linux VMs, 1 Remote FreeBSD VM, and 1 remote Debian Linux VM.

Getting starting with SaltStack is really easy. Essentially the process is as follows:

*	On master and minion:
	*	Add/enable salt repo to your package environment
*	On master
	*	install salt-master package
	*	edit /etc/salt/master and enable IPv6 if your environment has IPv6
*	On minion
	*	install salt-minion package
	*	edit /etc/salt/minion and edit the master: line (and enable IPv6)
	*	restart salt-minion service
	*	run `>salt-call --local key.finger`
	*	run `cat /etc/salt/pki/minion/minion.pub`
*	On master
	*	run `salt-key -L` to list keys
	*	run `salt-key -p &lt;unaccepted-minion.host.name&gt;`
*	Compare the output of the pubkey from the minion with the master's printout, and then accept it on the master by running salt-key -A which will prompt you for each unaccepted key.
*	On master
	*	run `salt '*' test.ping`, you should get output like the following:

{% highlight text %}
# salt '*.ciscodude.net' test.ping
jake.ciscodude.net:
    True
ns0.ciscodude.net:
    True
ciscodude.net:
    True
dev.ciscodude.net:
    True
...
{% endhighlight %}

This is your basic salt-minion/master set up. You can run commands on the minion like follows:

{% highlight text %}
# salt -G 'roles:*dns' cmd.run 'uname -a'
jake.ciscodude.net:
    Linux jake 3.2.0-4-amd64 #1 SMP Debian 3.2.57-3+deb7u2 x86_64 GNU/Linux
ns0.ciscodude.net:
    Linux ns0 3.2.0-4-amd64 #1 SMP Debian 3.2.57-3+deb7u2 x86_64 GNU/Linux
meagan.ciscodude.net:
    FreeBSD meagan.ciscodude.int 10.0-RELEASE-p3 FreeBSD 10.0-RELEASE-p3 #0: Tue May 13 18:31:10 UTC 2014     root@amd64-builder.daemonology.net:/usr/obj/usr/src/sys/GENERIC  amd64
ns2.henchman21.net:
    Linux ns2.henchman21.net 3.2.0-4-amd64 #1 SMP Debian 3.2.41-2+deb7u2 x86_64 GNU/Linux
{% endhighlight %}

SaltStack also has integration with apt-get on Debian, so a command like `salt -G os:debian pkg.refresh_db` followed by `salt -G os:debian pkg.upgrade` will run apt-get update followed by apt-get dist-upgrade on all of my Debian minions. There is also fine grained control to see which packages are available for upgrade.

Also, since SaltStack is written in Python, everything available thru CLI is also available via Python:

{% highlight python %}
#!/usr/bin/env python

import salt.client

local = salt.client.LocalClient()
returns = local.cmd_batch('*.ciscodude.net', 'cmd.run', ['uptime'])

for i in returns:
  print i
{% endhighlight %}

Which, when run will give output like follows:

{% highlight text %}
# ./info.uptime.py
{'ciscodude.net': ' 00:33:01 up 4 days,  1:09,  1 user,  load average: 0.00, 0.01, 0.05'}
{'ns0.ciscodude.net': ' 00:32:54 up 4 days,  1:07,  0 users,  load average: 0.00, 0.01, 0.05'}
{'meagan.ciscodude.net': '12:33AM  up 25 days,  4:37, 0 users, load averages: 0.11, 0.12, 0.14'}
{'jake.ciscodude.net': ' 00:32:54 up 4 days,  1:07,  0 users,  load average: 0.00, 0.01, 0.05'}
{% endhighlight %}

