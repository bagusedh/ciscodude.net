---
layout: post
title: "SSH Pubkeys with Cisco IOS 15"
date: 2015-05-31 19:56:09 -0500
external_url: https://supportforums.cisco.com/document/110946/ssh-using-public-key-authentication-ios-and-big-outputs
comments: false
share: true
description: "One of the new features of IOS 15 that I'm most excited about is the ability to use RSA public key authentication. This works on both switches and routers."
categories: 
- System Administration
- CLI
- Cisco
- Security
- Network Monitoring
- Nerd Projects
- Networking
---
One of the new features of IOS 15 that I'm most excited about is the ability to use RSA public key authentication. This works on both switches and routers. 

Configuring public key authentication is pretty straight forward, in configuration mode create a user, and then associate the key to the user.

{% highlight config %}
username test priv x secret supers3cr3tn0bdyw1llgue55
 
#You need to make sure this public key is trusted by our router.

ip ssh pubkey-chain
  username test
    key-string
      copy the entire public key as appears in id_rsa.pub 
      including ssh-rsa and username@hostname.
      please note that some IOS versions will accept 
      maximum 254 characters. You can paste multiple lines.
    exit
  exit
# Please also make sure that you generate 
# RSA keys on Server larger than 768 bits.
# You can also set SSHv2 on server side (although strictly 
# speaking it's not required if you're using SSH 1.99)
ip ssh version 2
{% endhighlight %}

The only gotcha really is that some devices (2960/3560 switches, not ASR1002X's) have a maximum line length and you need to split the public key string data into multiple lines no longer than 254 characters.

