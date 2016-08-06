---
layout: post
title: "Raspberry Pi DNS/DHCP Server"
date: 2014-05-22 00:34:32 -0500
comments: false
categories:
- Networking
- Nerd Projects
- Network Monitoring
- CLI
- Raspberry Pi
- System Administration
image:
  feature: https://ciscodude.net/images/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
---
I've been meaning to colocate most of my basement servers for some time, and some major power problems today have only given me further drive to get that accomplished this week. It may seem strange to use a server for DHCP, but I like the ability to be able to integrate DNS updates in with DHCP. Its the "enterprise" way to do it.

I set out to recreate fatbot, a VM which hosts authoritative DNS for an internal-only zone, and DHCP services for multiple subnets which my switches then use with `ip helper-address x.x.x.x` to provide DHCP relay on multiple VLANs from a centrally managed DHCP server.

{% highlight bash %}
apt-get update
dpkg -P wolfram-engine
apt-get install isc-dhcp-server bind9 vim-nox
apt-get upgrade
modprobe ipv6
echo ipv6 >> /etc/modules
{% endhighlight %}

I then installed my [favorite DNS script for vim, vim-scripts/UpdateDNSSerial](https://github.com/vim-scripts/UpdateDNSSerial), and made a [pull request](https://github.com/vim-scripts/UpdateDNSSerial/pull/1) to have it recognize both uppercase and lowercase Serial.

### dhcpd.conf ###

{% highlight config %}
option domain-name "ciscodude.int";
option domain-name-servers 192.168.203.13, 192.168.203.4;
option ntp-servers 206.220.197.10, 206.220.197.11;

option voip-tftp-server code 150 = ip-address;

default-lease-time 172800;
max-lease-time 172800;

# Use this to enble / disable dynamic dns updates globally.
ddns-update-style interim;

authoritative;

# Use this to send dhcp log messages to a different log file (you also
# have to hack syslog.conf to complete the redirection).
log-facility local7;

key "ddns-key.ciscodude" {
        algorithm hmac-md5;
        secret "secrethere==";
};
zone ciscodude.int. {
    primary 127.0.0.1;
    key ddns-key.ciscodude;
}
zone 203.168.192.in-addr.arpa. {
    primary 127.0.0.1;
    key ddns-key.ciscodude;
}
zone 200.168.192.in-addr.arpa. {
    primary 127.0.0.1;
    key ddns-key.ciscodude;
}
zone 202.168.192.in-addr.arpa. {
    primary 127.0.0.1;
    key ddns-key.ciscodude;
}

ping-check true;

# Server VLAN
shared-network server-vlan {
 subnet 192.168.203.0 netmask 255.255.255.0 {
  range 192.168.203.100 192.168.203.120;
  authoritative;
  ping-check true;
  option routers 192.168.203.1;
  option subnet-mask 255.255.255.0;
 }
}

# Data VLAN
shared-network data-vlan {
 subnet 192.168.200.0 netmask 255.255.255.0 {
  range 192.168.200.65 192.168.200.127;
  authoritative;
  ping-check true;
  option routers 192.168.200.1;
  option subnet-mask 255.255.255.0;
 }
}

# Wireless VLAN
shared-network wireless-vlan {
 subnet 192.168.202.0 netmask 255.255.255.0 {
  range 192.168.202.2 192.168.202.127;
  authoritative;
  ping-check true;
  option routers 192.168.202.1;
  option subnet-mask 255.255.255.0;
 }
}

... etc

{% endhighlight %}

### /etc/bind/named.conf ###

{% highlight config %}
include "/etc/bind/named.conf.options";
include "/etc/bind/named.conf.local";
{% endhighlight %}

### /etc/bind/named.conf.options ###

{% highlight config %}
options {
	directory "/var/cache/bind";
	auth-nxdomain no;    # conform to RFC1035
	listen-on-v6 { any; };
  allow-query { clients; };
  allow-recursion { none; };
};
{% endhighlight %}

### /etc/bind/named.conf.local ###

{% highlight config %}
acl clients {
        192.168.192.0/19;
        206.220.195.224/28;
        2604:4280:d00d::/48;
};
key "ddns-key.ciscodude" {
        algorithm hmac-md5;
        secret "secrethere==";
};
zone "ciscodude.int" {
        type master;
        file "/etc/bind/dynamic/ciscodude.int";
        allow-update {
                key "ddns-key.ciscodude";
        };
        allow-transfer {
                192.168.203.13; 2604:4280:d00d:203::13; 192.168.203.4; 2604:4280:d00d:203::4;
        };
        also-notify {
                192.168.203.13; 2604:4280:d00d:203::13; 192.168.203.4; 2604:4280:d00d:203::4;
        };
};
zone "193.168.192.in-addr.arpa" { type master; file "/etc/bind/dynamic/193.168.192.in-addr.arpa"; allow-update { key "ddns-key.ciscodude"; }; allow-transfer { 192.168.203.13; 2604:4280:d00d:203::13; 192.168.203.4; 2604:4280:d00d:203::4; }; also-notify { 192.168.203.13; 2604:4280:d00d:203::13; 192.168.203.4; 2604:4280:d00d:203::4; }; };

zone "194.168.192.in-addr.arpa" { type master; file "/etc/bind/dynamic/194.168.192.in-addr.arpa"; allow-update { key "ddns-key.ciscodude"; }; allow-transfer { 192.168.203.13; 2604:4280:d00d:203::13; 192.168.203.4; 2604:4280:d00d:203::4; }; also-notify { 192.168.203.13; 2604:4280:d00d:203::13; 192.168.203.4; 2604:4280:d00d:203::4; }; };

{% endhighlight %}
