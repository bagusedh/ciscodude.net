---
layout: post
title: "Deploying a Host-Specific Fail2Ban Config with SaltStack"
date: 2014-08-16 12:54:56 -0500
comments: false
categories: 
- Nerd Projects
- Network Monitoring
- CLI
- Programming
- Virtualization
- SaltStack
- System Administration
image:
  feature: https://ciscodude.net/images/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
share: true
---
Let me start this off by saying in this particular example, this is the wrong way to solve the problem. I should be learning more about fail2ban, and deploying files in the action.d and filter.d directories, however this is a really quick and dirty solution to the problem, and shows off jinja templating in SaltStack.

This solution builds on my previous post, [Deploying Fail2ban Using SaltStack](/2014/08/03/deploying-fail2ban-using-saltstack/). You may wish to familiarize yourself with this post first.

In this particular case I wanted to deploy a different jail.local to my mail server, which would watch my dovecot and postfix files for auth failures as well as SSH.

{% gist 56009937fb7782f69f0a %}

This enforces the fail2ban policy suggested on the iRedMail wiki, 
[Addition/Harden.iRedMail.with.Fail2ban](http://www.iredmail.org/wiki/index.php?title=Addition/Harden.iRedMail.with.Fail2ban). I have also downloaded the latest master filter.d files as suggested, and put them into `/srv/salt/settings/fail2ban/mail/filter.d`, and required them as well. 

I will be converting this from requiring ID, to being based on a role: grain in the near future. This will allow me to roll out mail server protection to new mail servers.

