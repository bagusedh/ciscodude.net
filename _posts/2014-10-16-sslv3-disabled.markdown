---
layout: post
title: "SSLv3 Disabled"
date: 2014-10-16 09:29:53 -0500
comments: false
description: "In response to the recent POODLE vulnerability in SSLv3, I have disabled SSLv3 support in anything of mine which speaks SSL/TLS. All connections are running TLSv1.0, TLSv1.1, or TLSv1.2 now."
external_url: https://blog.cloudflare.com/sslv3-support-disabled-by-default-due-to-vulnerability/
categories: 
- Security
- SSL
- Networking
- Programming
- System Administration
- Network Monitoring
image:
  feature: https://ciscodude.net/images/foggy-morning.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
share: true
---
In response to the recent [POODLE](https://www.openssl.org/~bodo/ssl-poodle.pdf) vulnerability in SSLv3, I have disabled SSLv3 support in anything of mine which speaks SSL/TLS. All connections are running TLSv1.0, TLSv1.1, or TLSv1.2 now. I have also reviewed the [list of ciphers](https://wiki.mozilla.org/Security/Server_Side_TLS) in the mozilla wiki, and updated mine as needed.

I have been experimenting with turning off SSLv3 support periodically over the past year. At one point in the sprint, GoogleBot stopped visiting my site as it required SSLv3 at the time. This apparently changed in June of this year to include TLSv1.0 at least.

Now that I've disabled SSLv3 support, I'm experimenting with logging the combination of ssl_protocol/ssl_cipher. So far after a few minutes, it is `TLSv1.2/ECDHE-RSA-AES128-GCM-SHA256` for 100% of 9 requests logged. :-)


