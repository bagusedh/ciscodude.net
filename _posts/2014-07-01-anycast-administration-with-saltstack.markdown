---
layout: post
title: "Anycast Administration with SaltStack"
date: 2014-07-01 15:04:33 -0500
comments: false
categories: 
- Anycast
- Nerd Projects
- Networking
- IPv6
- Programming
- SaltStack
- CLI
- System Administration
image:
  feature: https://ciscodude.net/static/blog-img/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
share: true
---
I've been playing with SaltStack for a week or so now, and while I still haven't even scratched the surface of what it is capable of yet, I am certainly saving a pile of time using it already. I am now using it to maintain web directories on my anycast nodes (which I was already doing through git, this is just further automated now).


My process was originally log into each system over ssh, then git pull each web directory. My process is now to run the following command on my salt master:

{% highlight text %}
root@dev:~# salt -G roles:anycast cmd.run 'sh -c /home/theodore/gitupdate.sh'
h-186.wpg167lom.henchman21.net:
    Already up-to-date.
    From https://github.com/henchman21/ipquail
       6f97b23..9a6d878  master     -> origin/master
    Updating 6f97b23..9a6d878
    Fast-forward
     keybase.txt | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     1 file changed, 70 insertions(+)
     create mode 100644 keybase.txt
h-232.wpgsouth.henchman21.net:
    Already up-to-date.
    From https://github.com/henchman21/ipquail
       6f97b23..9a6d878  master     -> origin/master
    Updating 6f97b23..9a6d878
    Fast-forward
     keybase.txt | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     1 file changed, 70 insertions(+)
     create mode 100644 keybase.txt

{% endhighlight %}

The script /home/theodore/gitupdate.sh exists on each anycast node. It goes into each directory and does a git update as the appropriate user (sudo -u user -H cmd).

