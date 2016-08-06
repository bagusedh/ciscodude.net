---
layout: post
title: "Deploying a Nameserver at DigitalOcean in 2 minutes"
date: 2014-07-23 23:56:49 -0500
comments: false
categories: 
- Nerd Projects
- Network Monitoring
- CLI
- IPv6
- Virtualization
- SaltStack
- System Administration
image:
  feature: https://ciscodude.net/images/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
share: true
---
One of the great things about [DigitalOcean](https://www.digitalocean.com/?refcode=f6432a6e1354) is that you can spin up a new small sized Debian VM in under 55 seconds. All that remains is to log in, add the Salt Debian repo, add the salt signing key, and then run state.highstate on the Salt master. If somewhat scripted, this can easily be accomplished in under 65 seconds, resulting in a new Slave Nameserver deployed in (under) 2 minutes. I have used this to deploy slave nameservers at LON1, SGP1, and most recently, NYC3 (all the DigitalOcean regions with IPv6).

{% highlight bash %}
#!/bin/bash

APTLISTD = "/etc/apt/sources.list.d"
MINIOND = "/etc/salt/minion.d"
echo "# SaltStack" > $APTLISTD/saltstack.list
echo "deb http://debian.saltstack.com/debian wheezy-saltstack main" >> $APTLISTD/saltstack.list
wget -O- http://debian.saltstack.com/debian-salt-team-joehealy.gpg.key|apt-key add -

echo "# backports" > $APTLISTD/backports.list
echo "deb http://http.debian.net/debian wheezy-backports main" >> $APTLISTD/backports.list

apt-get update
apt-get install salt-minion

echo 'master: master.example.com' > $MINIOND/master.conf
#echo 'ipv6: true' > $MINIOND/ipv6.conf
cat <<EOM > /etc/salt/grains
roles:
  - monitoring
  - slavens
datacenter: $LOCATION
EOM
service salt-minion restart
{% endhighlight %}

The two roles specified in the grains get pushed up to the server, and can then be used for targeting.

{% highlight bash %}
#!/bin/bash

salt-key -L
salt-key -a $MINIONHOSTNAME
salt -G roles:slavens test.ping
salt -G roles:slavens test.version
salt -G roles:slavens state.highstate
{% endhighlight %}

