---
layout: post
image:
  feature: https://ciscodude.net/images/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
title: "An MX Record, Finally!"
date: 2013-01-11 10:32:00 -0600
comments: false
categories:
- Nerd Projects
- Networking
- System Administration
---
Its been a while since I had an MX record, half due to connectivity, half due to lack of yet another email address. I like running Postfix/Dovecot, but most of the "recipes" I've followed and run lately have just been way too raw for my liking and frankly left a bad taste in my mouth about running my own email system in general. Unfortunately, Google stopped offering Apps for free, so I no longer had that option to fall to if I wanted. I recently found this option called [iRedMail](http://www.iredmail.org/) which is very polished, and very full featured, even in the non-pro version.

<!--more-->

It has ClamAV, policyd, DKIM support, and [EXCELLENT documentation](http://www.iredmail.org/install_iredmail_on_freebsd.html). It works with your choice of OS, and uses whatever packaging system you are working with, providing an experience administration that will fit right into your existing skill set. No need to learn how to maintain someone elses idea of a system, with their own weird file paths, program locations, packaging etc.

To be fair, I only installed the software 2 days ago and don't have any long term administering/updating/maintaining it yet, but so far it seems very promising, and done the way I would like to see a system done. I will update this post if that experience changes over time.
