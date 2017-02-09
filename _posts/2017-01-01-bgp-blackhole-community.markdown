---
layout: post
title: "BGP BLACKHOLE Community"
date: 2017-01-01 18:25:44 -0500
comments: false
share: true
description: "DDoS attacks continue to be a wide-spread problem on the internet. Their size has grown over the past few years to where BGP Blackholing to reduce collateral damage has become widespread."
categories: 
- Networking
- Network Monitoring
- Nerd Projects
- ISP
- CLI
- BGP
- Security
- Troubleshooting
- System Administration
---
DDoS attacks continue to be a wide-spread problem on the internet. Their size has grown over the past few years to where BGP Blackholing to reduce collateral damage has become widespread.

As more and more networks built support for BGP Blackholing -- each with their own BGP community -- it became clear that there was a need for a standardized "well known" community for BGP Blackholing. From this need was born [RFC 7999: BLACKHOLE Community](https://tools.ietf.org/html/rfc7999). This reserves `65535:666` as the well known, BLACKHOLE. This should reduce the complexities for downstream networks implementing blackholing with their upstreams, as well as reducing confusion in documentation through the use of a single BGP community.

I operate two ASNs which operate primarily on Mikrotik routers for BGP. This article is about implementing BGP BLACKHOLE on one of those networks.

## Implementing BGP BLACKHOLE in an Autonomous System running Mikrotik RouterOS

Implementing BLACKHOLE in an autonomous system using Mikrotik BGP was fairly simple:

1.	Originate a /32 route with `65535:666` BGP Community attached, and allow it to be exported into the rest of the system. This is handled through [FastNetMon](https://github.com/pavel-odintsov/fastnetmon) and `fastnetmon_mikrotik.php`. It could also be handled by using ExaBGP, or GoBGP, which are both also supported by FastNetMon.
1.	Build route policy around received routes which have the `65535:666` BGP Community attached. This sets type of route as `blackhole` instead of `unicast` causing the traffic to get dropped.
1.	Export /32 routes with provider BGP Blackhole communities attached (`6969:666` is Hurricane Electric's for example).

### Mikrotik BGP Routing Policy

Implementing BGP blackholing when /32 routes contain the BLACKHOLE community is easy. By matching the BGP BLACKHOLE community, `prefix-length=32`, and protocol BGP, and then using `set-type=blackhole` the route type is changed to blackhole, and traffic to the IP address is dropped automatically.

The second part of the BGP routing policy includes letting select /32 routes out to upstreams, this is accomplished by allowing `prefix-length=32` when combined with the BLACKHOLE community. Of course there is a default deny at the end of the `UPSTREAM-OUT` policy.

{% highlight config %}
/routing filter
add action=accept bgp-communities=65535:666 chain=internal-in prefix-length=32 protocol=bgp set-type=blackhole append-bgp-communities=6939:666

add action=accept chain=UPSTREAM-OUT comment="advertise x.x.61.0/24" prefix=x.x.61.0/24 protocol=bgp
add action=accept chain=UPSTREAM-OUT comment="advertise x.x.62.0/24" prefix=x.x.62.0/24 protocol=bgp
add action=accept bgp-communities=65535:666 chain=UPSTREAM-OUT comment="advertise x.x.61.0/24 Blackholes" prefix=x.x.61.0/24 prefix-length=32 protocol=bgp
add action=accept bgp-communities=65535:666 chain=UPSTREAM-OUT comment="advertise x.x.62.0/24 Blackholes" prefix=x.x.62.0/24 prefix-length=32 protocol=bgp
add action=discard chain=UPSTREAM-OUT comment="discard everything else" protocol=bgp
{% endhighlight %}

### RouterOS API

I have been inserting routes into the system using the `fastnetmon_mikrotik.php` plugin for FastNetMon. Due to operating a 32-bit ASN, I am unable to make my own locally significant BGP communities (`39xxxx:666` isn't valid, the first part needs to be a 16-bit number which makes the maximum 65535), so having a well known number that I could use without risking collision was quite handy. I quickly added a change to add the BGP community `65535:666` to routes blackholed, and made a [pull request with FastNetMon](https://github.com/pavel-odintsov/fastnetmon/pull/621).

### Drawbacks

Mikrotik's routing updates are slow under RouterOS 6.x (but rumored to be faster under 7.x when that comes out), particularly when routes are withdrawn. This can cause the API calls to remove routes to timeout on a router with LOTS of routes (full BGP routes). I found it helpful to inject routes on routers with a default+local routes only where the add or remove could be completed much more quickly.
