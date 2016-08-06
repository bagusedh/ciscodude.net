---
layout: post
title: "OpenBSD 5.5 BGP Looking Glass"
date: 2014-05-14 21:51:51 -0500
comments: false
categories:
- Networking
- IPv6
- ISP
- BGP
- Nerd Projects
- Network Monitoring
- System Administration
image:
  feature: https://ciscodude.net/images/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
---
I've written about OpenBSD and BGP Looking Glasses [before](/2013/01/27/building-an-openbsd-bgp-looking-glass/). OpenBSD has since [removed apache from base](http://undeadly.org/cgi?action=article&sid=20140314080734&mode=flat), and replaced it with nginx. This is OK with me since I prefer the simplicity and raw performance of nginx (and its ability to proxy!). This is an update which applies to OpenBSD after nginx removal (applies to 5.5 and later). This article has also been independently verified to work using OpenBSD 5.6 as well.

Install your system as you choose, I did a fairly default [install as per the FAQ](http://www.openbsd.org/faq/faq4.html). My hardware in this case is virtual VMware hardware, 1 vCPU, 1GB vRAM, 16GB vHDD, and 1 vNIC connected to a network shared between both BGP routers.

The applicable configuration files:

{% highlight config %}
ntpd_flags=             # enabled during install
slowcgi_flags=
nginx_flags=
bgpd_flags=
{% endhighlight %}

`/etc/nginx/nginx.conf`

Uncomment this section:

{% highlight nginx %}
        # FastCGI to CGI wrapper server
        #
        location /cgi-bin/ {
            fastcgi_pass   unix:run/slowcgi.sock;
            fastcgi_split_path_info ^(/cgi-bin/[^/]+)(.*);
            fastcgi_param  PATH_INFO $fastcgi_path_info;
            include        fastcgi_params;
        }
{% endhighlight %}

and add the following if you want to serve the CGI as the index:

{% highlight nginx %}
        location / {
                index index.html;
                try_files $uri /cgi-bin/bgplg;
        }
{% endhighlight %}

`/etc/fstab`

`/var` will need to be mounted without the nosuid option present by default.

The following will need to be run to allow ping, ping6, traceroute, and traceroute6 to function and resolve domains in the chroot:

{% highlight bash %}
chmod 0555 /var/www/cgi-bin/bgplg
chmod 0555 /var/www/bin/bgpctl
mkdir /var/www/etc
cp /etc/resolv.conf /var/www/etc
chmod 4555 /var/www/bin/ping
chmod 4555 /var/www/bin/ping6
chmod 4555 /var/www/bin/traceroute
chmod 4555 /var/www/bin/traceroute6
{% endhighlight %}

The last stage is to configure your BGP peering sessions in `/etc/bgpd.conf`

{% highlight config %}
# global configuration
AS 65003
router-id x.x.x.195
fib-update no

# restricted socket for bgplg(8)
socket "/var/www/run/bgpd.rsock" restricted

neighbor 192.0.2.193 {
        remote-as       65003
        descr           BGP1
        announce none
}

neighbor 192.0.2.194 {
        remote-as       65003
        descr           BGP2
        announce none
}

neighbor 2001:DB8::193 {
        remote-as       65003
        descr           BGP1-v6
        announce none
}

neighbor 2001:DB8::194 {
        remote-as       65003
        descr           BGP2-v6
        announce none
}

# see all prefixes, since we want the visibility for a looking glass
allow from any
{% endhighlight %}

