---
layout: post
title: "Manually Patching ESXi (5.5)"
date: 2014-06-19 15:30:59 -0500
comments: false
categories:
- Nerd Projects
- CLI
- Security
- Virtualization
- System Administration
external_url: http://www.v-front.de/2014/04/openssl-heartbleed-patches-for-esxi-55.html
image:
  feature: https://ciscodude.net/static/blog-img/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
share: true
---
I've been running the free version of ESXi in my basement for years, and have been well served by it. One of the things that is always somewhat of a pain is patching. I was always under the impression that to patch the free version of ESXi you needed to download the patches, and transfer them to a VMFS volume, then patch that bundle. A great blog [VMware Front Experience](http://www.v-front.de/) posted an [article about manually patching your ESXi 5.5 host](http://www.v-front.de/2014/04/openssl-heartbleed-patches-for-esxi-55.html) which is just fantastic.

They have also posted a blog about how to [patch the latest 5.5u1 bundle](http://www.v-front.de/2014/06/new-esxi-55-patch-fixes-nfs-bug-and.html).

{% highlight bash %}
# open firewall for outgoing http requests:
esxcli network firewall ruleset set -e true -r httpClient
# Install the ESXi-5.5.0-20140604001-standard Imageprofile from the VMware Online depot
esxcli software profile update -d https://hostupdate.vmware.com/software/VUM/PRODUCTION/main/vmw-depot-index.xml -p ESXi-5.5.0-20140604001-standard
# Reboot your host
reboot
{% endhighlight %}

This command can be modified for any new bundles, the KB lists the package name.

When you go to run this set of commands on a system, it will sit there for several minutes. Keep in mind the patch bundle is 300+MB, downloading it, installing it, etc. This all takes time. Especially on a slower internet connection. Using this command recently, on newly deployed VM hosts, saved several reboots (and much time) later on.
