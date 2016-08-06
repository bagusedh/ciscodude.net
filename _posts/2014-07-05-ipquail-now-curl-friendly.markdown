---
layout: post
title: "ipquail now curl friendly"
date: 2014-07-05 13:56:04 -0500
comments: false
categories: 
- Anycast
- Nerd Projects
- CLI
- IPv6
- Programming
- SaltStack
- System Administration
image:
  feature: https://ciscodude.net/images/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
share: true
---
I've always liked how the site [ifconfig.me](http://ifconfig.me) (down today it seems) returns JUST the IP address from command line when accessed via CURL. Unfortunately it is not IPv6 enabled. This morning I set out to CLI-enable [ipquail.com](http://ipquail.com). The journey is documented in this short [commit history](https://github.com/henchman21/ipquail/compare/9a6d878dcf7a441911d16923c518afe033a421f7...c963a9efe970444109e44e71ffdbf479ed7a63cb).

{% highlight text %}
$ for i in www 4 6; do \
  echo -n "curl $i.ipquail.com => "
  curl $i.ipquail.com
  done
curl www.ipquail.com => 2604:4280:d000:11::5
curl 4.ipquail.com => 199.202.21.5
curl 6.ipquail.com => 2604:4280:d000:11::5
{% endhighlight %}

This can be used in scripts as well:

{% highlight bash %}
#!/bin/bash

IP4=`curl 4.ipquail.com 2>/dev/null`
IP6=`curl 6.ipquail.com 2>/dev/null`

echo "Your IP Address is $IP4"
echo "Your IPv6 Address is $IP6"
{% endhighlight %}

I deployed the new files to all Anycast nodes using SaltStack as [described in my previous post](/2014/07/01/anycast-administration-with-saltstack/).

**Note:** This only works if you are NOT changing the default curl user agent, if you are, you would need to specify curl as your user agent using the -A flag for curl.
