---
layout: post
title: "Implementing BCP38"
date: 2013-03-29 21:41:00 -0600
comments: false
categories:
- Security
- ISP
- System Administration
---
Unless your network admin has had his/her head in sand hill for the past few years, filtering spoofed traffic from leaving one's own network is something that should be of concern. Luckily back in 2000 some NANOG members wrote up a spec, [RFC2827](http://tools.ietf.org/html/rfc2827.html) which was adopted as [BCP38](http://tools.ietf.org/html/bcp38).


So what exactly is BCP38? BCP38 is: Network Ingress Filtering: Defeating Denial of Service Attacks which employ IP Source Address Spoofing. In short, ensuring your customers do not send traffic from IP addresses which they are not entitled to receive return traffic for. A pretty simple concept. Amazingly, many/most ISPs do not prevent the sourcing of traffic from just any old bogus address.

A simple sample:

{% highlight config %}
interface vlan99
 ip address 192.0.2.1 255.255.255.0
 ip access-group vl99_out in
 ip helper-address x.x.x.x

ip access-list extended vl99_out
 permit udp host 0.0.0.0 host 255.255.255.255 eq bootps
 deny   ip any 10.0.0.0 0.255.255.255 log
 deny   ip any 127.0.0.0 0.255.255.255 log
 deny   ip any 169.254.0.0 0.0.255.255 log
 deny   ip any 172.16.0.0 0.15.255.255 log
 deny   ip any 192.0.2.0 0.0.0.255 log
 deny   ip any 192.168.0.0 0.0.255.255 log
 deny   ip any 198.18.0.0 0.1.255.255 log
 deny   ip any 198.51.100.0 0.0.0.255 log
 deny   ip any 203.0.113.0 0.0.0.255 log
 deny   ip any 240.0.0.0 15.255.255.255 log
 permit ip 192.0.2.0 0.0.0.255 any
 deny   ip any any log
{% endhighlight %}

So what does this example do? In the Vlan interface you see that the local address range is 192.0.2.0/24 and there is a DHCP helper running remotely. This ACL restricts traffic from entering the interface unless it is to a valid destination, from a valid local source, or a DHCP broadcast. It explicitly denies traffic to any ranges which should not be receiving traffic, preventing any junk which will not find a destination from even entering your network. Any packets denied are logged, to aid in troubleshooting dropped packet issues.

