---
layout: post
noindex: true
title: "CVE-2014-6271 - ShellShock"
date: 2014-09-24 20:30:33 -0500
comments: false
description: "Today various sources announced CVE-2014-6271: 'bash: specially-crafted environment variables can be used to inject shell commands'. This is a serious risk on many Unix-like systems, as bash is a very popular shell, and included by default on many systems. It is used by both interactive users, as well as many wrapper scripts used in daily system operations."
categories:
- System Administration
- CLI
- Security
- Network Monitoring
- Virtualization
image:
  feature: https://ciscodude.net/static/blog-img/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
share: true
---
Today various sources announced CVE-2014-6271: "bash: specially-crafted environment variables can be used to inject shell commands". This is a serious risk on many Unix-like systems, as bash is a very popular shell, and included by default on many systems. It is used by both interactive users, as well as many wrapper scripts used in daily system operations. This bug is being referred to as "ShellShock" by many sources now, initially it was being referred to by some as "BashBleed". 

The description of this bug from [CVE-2014-6271](https://bugzilla.redhat.com/show_bug.cgi?id=CVE-2014-6271)

>	A flaw was found in the way Bash evaluated certain specially crafted environment variables. An attacker could use this flaw to override or bypass environment restrictions to execute shell commands. Certain services and applications allow remote unauthenticated attackers to provide environment variables, allowing them to exploit this issue.

Luckily for me, patching my own systems as well as verifying that they were patched was easily accomplished though Salt! Numerous tweets today had all that was required!

The first, to patch systems:

{% twitter oembed https://twitter.com/jacksoncage/status/514870167537725440 %}

And a second to verify that systems were patched:

{% twitter oembed https://twitter.com/DanGarthwaite/status/514839706207813633 %}

At the moment only my Raspbian system has a bash which is vulnerable to this bug. I will update this when I notice its been patched.

**Update**: It seems that the bugs [haven't been completely patched, yet](http://www.openwall.com/lists/oss-security/2014/09/25/3). I assume there may be several rounds of patches for this. 

**Update**: I have been continuing to run `salt -G os:debian pkg.install bash refresh=True` as each of the new CVE announcements happen. There [has been 6 so far](http://www.openwall.com/lists/oss-security/2014/10/02/28).

*	CVE-2014-6271 - original RCE found by Stephane. Fixed by bash43-025 and corresponding Sep 24 entries for other versions.
*	CVE-2014-7169 - file creation / token consumption bug found by Tavis. Fixed by bash43-026 & co (Sep 26).
*	CVE-2014-7186 - a probably no-sec-risk 10+ here-doc crash found by Florian and Todd. Fixed by bash43-028 & co (Oct 1).
*	CVE-2014-7187 - a non-crashing, probably no-sec-risk off-by-one found by Florian.  Fixed by bash43-028 & co (Oct 1).
*	CVE-2014-6277 - uninitialized memory issue, almost certainly RCE found by Michal Zalewski. No specific patch yet.
*	CVE-2014-6278 - command injection RCE found by Michal Zalewski. No specific patch yet.

- - -

Some other blogs and external information about this:

*	[Redhat Bugzilla: CVE-2014-5271](https://bugzilla.redhat.com/show_bug.cgi?id=CVE-2014-6271)
*	[Internet Storm Center: Attention *NIX admins, time to patch!](https://isc.sans.edu/forums/diary/Attention+NIX+admins+time+to+patch+/18703)
*	[Redhat Security Blog: Bash specially-crafted environment variables code injection attack](https://securityblog.redhat.com/2014/09/24/bash-specially-crafted-environment-variables-code-injection-attack/)
*	[CSO Online: Remote exploit vulnerability in bash CVE-2014-6271](http://www.csoonline.com/article/2687265/application-security/remote-exploit-in-bash-cve-2014-6271.html)
*	[The Akamai Blog: Environment Bashing](https://blogs.akamai.com/2014/09/environment-bashing.html)
*	[Cloudflare Blog: Bash vulnerability CVE-2014-6271 patched](https://blog.cloudflare.com/bash-vulnerability-cve-2014-6271-patched/)

