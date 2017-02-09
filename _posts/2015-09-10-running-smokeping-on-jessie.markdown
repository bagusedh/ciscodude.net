---
layout: post
title: "Running Smokeping on Jessie"
date: 2015-09-10 18:47:25 -0500
external_url: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=760474
comments: false
share: true
description: "I recently went thru the process of upgrading most of my virtual machines from Debian Wheezy to Debian Jessie. One of the changes that affected quite a few things was the upgrade from Apache 2.2 to 2.4. One of the packages that is affected by this change is smokeping."
categories: 
- Nerd Projects
- System Administration
- Networking
- CLI
- Network Monitoring
- Programming
- Troubleshooting
---
I recently went thru the process of upgrading most of my virtual machines from Debian Wheezy to Debian Jessie. One of the changes that affected quite a few things was the upgrade from Apache 2.2 to 2.4. One of the packages that is affected by this change is smokeping. There is a [bug](https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=760474) filed which documents the workaround process required to get smokeping working under Debian Jessie.

The Debian Jessie Apache 2.4 package uses a /etc/apache2/conf-{available,enabled} directory structure instead of /etc/apache2/conf.d/ for extra configuration files. 

An OTRS system I upgraded today was also affected by this change, I had to re-symlink the otrs.conf file in conf-enabled.
