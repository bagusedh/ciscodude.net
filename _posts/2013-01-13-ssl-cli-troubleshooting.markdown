---
layout: post
image:
  feature: https://ciscodude.net/images/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
title: "SSL CLI Troubleshooting"
date: 2013-01-13 01:52:00 -0600
comments: false
categories:
- Nerd Projects
- Networking
- IPv6
- CLI
- System Administration
---
This afternoon I setup nginx to act as a pop3/imap/smtp proxy w/ SSL. During the setup process it was necessary to test the services via CLI. While its fairly simple to test non-encrypted services, "telnet xx.yy.com 995" doesn't exactly work. You can even verify the SSL cert chain validity if you've got a chain available.


`openssl s_client -CAfile ca-certificates.crt -connect ciscodude.net:995`

[This](http://www.kutukupret.com/2012/08/31/nginx-as-imap4pop3-proxy-using-apache-as-auth-server-backend/) blog post from [KutuKupret](http://www.kutukupret.com) was very helpful in the process.
