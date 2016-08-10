---
layout: post
title: "Leaking Routes"
date: 2014-05-04 11:53:20 -0500
comments: false
categories:
- Networking
- BGP
- Network Monitoring
- CLI
- System Administration
image:
  feature: https://ciscodude.net/static/blog-img/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
---
This week I noticed my traceroute from one AS I run to another had changed, it appeared that TeraGo was leaking one or more routes.

The traceroute:

{% highlight text %}
$ tcptraceroute -q1 ciscodude.net
Selected device eth0, address 10.xx.xx.5, port 36975 for outgoing packets
Tracing the path to ciscodude.net (206.220.195.237) on TCP port 80 (http), 30 hops max
 1  10.xx.xx.254  0.399 ms
 2  198.62.164.2  0.456 ms
 3  ra2nr-ge3-2-20.wp.bigpipeinc.com (66.244.208.1)  1.254 ms
 4  rc3sc-tge0-1-0-34.wp.shawcable.net (66.163.73.165)  1.694 ms
 5  rc2nr-hge0-19-0-0.wp.shawcable.net (66.163.73.197)  1.663 ms
 6  66.163.76.22  24.716 ms
 7  ra1fs-tge1-3.mt.shawcable.net (66.163.66.34)  22.460 ms
 8  rx0sh-terago.mt.bigpipeinc.com (66.244.223.206)  23.163 ms
 9  bvi1.asr01.tor151f.fibrenoire.ca (206.108.34.141)  22.915 ms
10  te0-2.mdr01.tor151f.fibrenoire.ca (68.67.63.185)  22.504 ms
11  131.gi0-1.cr1.360ptg.winnipeg.as14866.net (173.231.121.50)  46.706 ms
12  vl77.ar1.400wb.ywg.as14866.net (206.220.192.2)  46.430 ms
13  vl66.sw1.400wb.ywg.voinetworks.ca (206.220.199.217)  48.233 ms
14  vl59.sw1.134sm.ywg.voinetworks.ca (206.220.199.49)  66.890 ms
15  vl240.sw1.henchman21.net (206.220.199.131)  56.119 ms
16  vl198-l3-theo.ciscodude.net (206.220.198.171)  71.401 ms
17  ciscodude.net (206.220.195.237) [open]  77.420 ms
{% endhighlight %}

The hop in question is hop 8. TeraGo? That's strange, they used to be an AS14866 transit provider, I wonder if this is related. I confirmed that my route received at AS62758 had TeraGo in the AS-PATH (6327 20161 22652 14866), and contacted Fibrenoire. Since traceroutes to other IP ranges advertised by AS14866 did not go through TeraGo, I immediately suspected an old prefix-list had been merged into TeraGo's configuration.

A traceroute to another subnet:

{% highlight text %}
$ tcptraceroute -q1 192.69.40.1
Selected device eth0, address 10.xx.xx.5, port 60031 for outgoing packets
Tracing the path to 192.69.40.1 on TCP port 80 (http), 30 hops max
 1  10.xx.xx.254  0.376 ms
 2  198.62.164.2  0.424 ms
 3  ra2nr-ge3-2-20.wp.bigpipeinc.com (66.244.208.1)  1.056 ms
 4  66.163.73.161  1.863 ms
 5  66.163.75.117  17.385 ms
 6  10gigabitethernet4-1.core1.chi1.he.NET (206.223.119.37)  17.233 ms
 7  100ge13-1.core1.msp1.he.net (184.105.223.178)  25.297 ms
 8  10ge1-3.core1.ywg1.he.net (184.105.80.14)  33.167 ms
 9  voi-networks-inc.gigabitethernet2-23.core1.ywg1.he.net (216.66.78.250)  33.346 ms
10  vl77.ar1.400wb.ywg.as14866.net (206.220.192.2)  39.940 ms
11  1-0.premium-gige.winnipeg.voinetworks.net (192.69.40.1) [closed]  41.241 ms
{% endhighlight %}

Completely different path (6327 6939 14866). Shaw's nearest peering point with Hurricane is in Chicago. TeraGo is a Shaw transit customer. Hence, Shaw would localpref routes received via their customer, TeraGo, higher, and prefer the longer path.

The reverse path (from AS14866 to AS62758):

{% highlight text %}
$ traceroute -q1 198.62.164.30
traceroute to 198.62.164.30 (198.62.164.30), 64 hops max, 52 byte packets
traceroute to 198.62.164.30 (198.62.164.30), 64 hops max, 52 byte packets
 1  vl202-l3-theo (192.168.202.254)  4.338 ms
 2  vl218.sw1.henchman21.net (206.220.198.165)  2.763 ms
 3  vl240.sw1.134sm.ywg.voinetworks.ca (206.220.199.130)  7.811 ms
 4  vl59.sw1.400wb.ywg.voinetworks.ca (206.220.199.50)  19.485 ms
 5  vl66.ar1.400wb.ywg.as14866.net (206.220.199.218)  7.189 ms
 6  80.po-channel1.cr2.167lom.ywg.as14866.net (206.220.199.5)  12.016 ms
 7  ge2-23.core1.ywg1.he.net (216.66.78.249)  33.133 ms
 8  10ge1-6.core1.msp1.he.net (184.105.80.13)  92.778 ms
 9  100ge7-1.core1.chi1.he.net (184.105.223.177)  55.346 ms
10  *
11  66.163.75.118 (66.163.75.118)  55.439 ms
12  ra2nr-tge1-1.wp.shawcable.net (66.163.73.166)  69.597 ms
13  h72-2-15-250.bigpipeinc.com (72.2.15.250)  78.848 ms
14  198.62.164.30 (198.62.164.30)  63.208 ms
{% endhighlight %}

This issue has not yet been resolved by TeraGO NOC yet, this post will be updated as the situation unfolds.

** Update: **
Issue was not resolved by TeraGO, and instead TeraGO was depeered by FibreNoire.
