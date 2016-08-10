---
layout: post
image:
  feature: https://ciscodude.net/static/blog-img/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
external_url: http://wiki.mikrotik.com/wiki/Hairpin_NAT
title: "Mikrotik and Hairpin NAT"
date: 2016-01-01 21:25:50 -0600
comments: false
share: true
description: "I recently renamed my internal LAN domain name. For some crazy reason I'd thought .int was not a public TLD and didn't check at all before using that before the last time I renamed my internal LAN. I had no issues for several years, but I felt with the holidays it was time to move away from this invalid domain internally to something valid."
categories: 
- Nerd Projects
- Networking
- System Administration
- CLI
- Security
- Network Monitoring
- Troubleshooting
---
I recently renamed my internal LAN domain name. For some crazy reason I'd thought `.int` was not a public TLD and didn't check at all before using that before the last time I renamed my internal LAN. I had no issues for several years, but I felt with the holidays it was time to move away from this invalid domain internally to something valid.

I chose `ciscodude.co` this time and registered it. I have an internal hidden master which is only available over IPv6 from the external slaves. I need to build an automated process of maintaining an external and internal view.

While I'm using ciscodude.co internally, I still use ciscodude.net externally. I have several certificates for ciscodude.net include a wildcard certificate. Several A and CNAME records pointed to my external IP, and as I don't have views set up yet I'm still getting the external IP when requesting internally. As a result I need to perform a hairpin NAT to the reverse proxy that handles that hostname externally, internally.

{% highlight config %}
/ip firewall nat
add action=dst-nat chain=dstnat comment="revproxy port 80 for all inbound 80's on ipv4" \
    dst-port=80 in-interface=ShawBridge protocol=tcp to-addresses=192.168.203.26
add action=dst-nat chain=dstnat comment="revproxy port 443 for all inbound 443's on ipv4" \
    dst-port=443 in-interface=ShawBridge protocol=tcp to-addresses=192.168.203.26
add action=dst-nat chain=dstnat comment="revproxy port 80 for public IP from inside" \
    dst-address=24.x.x.x dst-port=80 protocol=tcp src-address=192.168.192.0/19 \
    to-addresses=192.168.203.26
add action=dst-nat chain=dstnat comment="revproxy port 443 for public IP from inside" \
    dst-address=24.x.x.x dst-port=443 protocol=tcp src-address=192.168.192.0/19 \
    to-addresses=192.168.203.26
add action=masquerade chain=srcnat comment="port 80 reverse proxy reverse nat rule" \
    dst-address=192.168.203.26 dst-port=80 out-interface=ether1-vlan192 protocol=tcp \
    src-address=192.168.192.0/19
add action=masquerade chain=srcnat comment="port 443 reverse proxy reverse nat rule" \
    dst-address=192.168.203.26 dst-port=443 out-interface=ether1-vlan192 protocol=tcp \
    src-address=192.168.192.0/19
{% endhighlight %}

Basically I'm treating the external IP address like a loopback instead of being bound to the external interface. This will require maintenance in case the Shaw IP changes, but that's not the end of the world for my internal access.
