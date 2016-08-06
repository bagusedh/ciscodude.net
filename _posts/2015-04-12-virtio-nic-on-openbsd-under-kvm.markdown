---
layout: post
title: "virtio NIC on OpenBSD under KVM"
date: 2015-04-12 22:14:01 -0500
comments: false
share: true
external_url: http://blather.michaelwlucas.com/archives/2083
description: "I've been running ciscodude.net at a new location for about a month now. My setup is a little different than it was previously. Instead of a 2nd physical server in front of my VM host as firewall/ACLs, I've now got a virtual machine doing the same thing. The setup is the same other than that, OpenBSD firewall in front of Linux service VMs."
categories:
- Networking
- IPv6
- Nerd Projects
- Network Monitoring
- System Administration
image:
  feature: https://ciscodude.net/images/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
---
I've been running ciscodude.net at a new location for about a month now. My setup is a little different than it was previously. Instead of a 2nd physical server in front of my VM host as firewall/ACLs, I've now got a virtual machine doing the same thing. The setup is the same other than that, OpenBSD firewall in front of Linux service VMs. 

An issue which has occasionally popped up is that the internal side NIC of the firewall VM (which is a [vio(4)](http://www.openbsd.org/cgi-bin/man.cgi/OpenBSD-current/man4/vio.4?query=vio) interface) stops having access to its network. A quick `ifconfig down; ifconfig up` fixes it for a while. I mentioned the issue to a colleague of mine, and he said there was a magic flag that was known to fix this issue. I found [this blog post](http://blather.michaelwlucas.com/archives/2083) entitled "virtio NIC on OpenBSD 5.5-current" which documented how to set the flag on a `/bsd.rd` for an in-place upgrade. My needs were slightly different, to fix the running kernel's flag. Instead of running `config -ef /bsd.rd` I ran `config -ef /bsd`:

{% highlight text %}
# config -ef /bsd
OpenBSD 5.6 (GENERIC) #310: Fri Aug  8 00:14:24 MDT 2014
    deraadt@amd64.openbsd.org:/usr/src/sys/arch/amd64/compile/GENERIC
Enter 'help' for information
ukc> find vio
204 vio* at virtio* flags 0x0
ukc> change 204
204 vio* at virtio* flags 0x0
change [n] y
flags [2] ? 2
204 vio* changed
204 vio* at virtio* flags 0x2
ukc> quit
Saving modified kernel.
{% endhighlight %}

When you reboot you will see the following in `dmesg`:

{% highlight text %}
$ dmesg | grep vio0
vio0 at virtio2: address c6:82:da:26:a6:5b
vio0 at virtio2: address c6:82:da:26:a6:5b
vio0 at virtio2: RingEventIdx disabled by UKC: address c6:82:da:26:a6:5b
{% endhighlight %}

This confirms that you've got the flag activated.

I will update this if I notice anything peculiar.
