---
layout: post
date: 2016-05-07 15:25:22 -0500
comments: false
share: true
description: "I first came across dnsdist in a NANOG post in the discussion of exploitation of a BIND DOS bug last summer. Jared Mauch had recommended dnsdist to easily implement DNS backend diversity."
categories: 
- Networking
- Nerd Projects
- CLI
- IPv6
---
I first came across dnsdist in a NANOG post in the discussion of exploitation of a BIND DOS bug last summer. Jared Mauch had recommended dnsdist to easily implement DNS backend diversity. I was interested at the time. but wasn't doing enough DNS at the time to find time to play around with it.

> I recommend using DNSDIST to balance traffic at a protocol level as you can have implementation diversity on the backside. <br>Jared Mauch,
  [NANOG Mailing List Tue Aug 4 16:00:32 UTC 2015](https://mailman.nanog.org/pipermail/nanog/2015-August/078180.html)

## Fast Forward, 1.0.0

Recently, dnsdist 1.0.0 was released. Along with this release, [Bert Hubert](https://twitter.com/powerdns_bert) did a [presentation](https://www.powerdns.com/resources/2016%20UKNOF%20dnsdist%20bert%20hubert.pdf) at [UKNOF34](https://indico.uknof.org.uk/conferenceOtherViews.py?view=standard&confId=36#). I found this presentation on twitter a few days later, and within a few minutes I had installed and set up dnsdist on my remote nagios instance to cache and load balance requests across both of the v4, and both of the v6 Google public DNS servers.

## First Deployment

My first deployment of dnsdist was for my primary remote nagios instance. I run this out of [DigitalOcean](https://www.digitalocean.com/?refcode=f6432a6e1354) Toronto. Since I'm running on Debian, I added the [PowerDNS Repo](https://repo.powerdns.com/) and installed dnsdist using the standard `apt-get install dnsdist` command.

I followed the [introduction](http://dnsdist.org/introduction/) (mixing in some things from the above presentation slides) and a few minutes later I had whipped up a quick config, and was load balancing requests to Google DNS.

{% highlight lua %}
setLocal("127.0.0.1:53")
addACL("IP OF SYSTEM")
newServer{address="2001:4860:4860::8844"}
newServer{address="2001:4860:4860::8888"}
newServer{address="8.8.8.8"}
newServer{address="8.8.4.4"}
setServerPolicy(wrandom)
pc = newPacketCache(10000, 86400, 0, 60, 60)
getPool(""):setCache(pc)
{% endhighlight %}

I can see that after 2 days I've answered about 450,000 queries from the local system, and have only sent out about 11,000 to each of the 4 "backend servers" which is Google's DNS in this case. Average response time is 12ms, each of the backends have between 100 and 160ms latency.

The best part is that in the event of small DNS blips, I'm now cached locally at least while the TTLs hold out.
