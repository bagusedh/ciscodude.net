---
layout: post
image:
  feature: https://ciscodude.net/static/blog-img/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
title: "Monitoring Onions"
date: 2015-11-29 02:17:21 -0600
comments: false
share: true
description: "One of the first questions I had when Facebook launched their onion was 'I wonder how stable it is?'."
categories: 
- Nerd Projects
- System Administration
- Networking
- CLI
- Network Monitoring
- Programming
- Troubleshooting
- Privacy
---
One of the first questions I had when Facebook [launched their onion](https://www.facebook.com/notes/protect-the-graph/making-connections-to-facebook-more-secure/1526085754298237) was "I wonder how stable it is?". Tonight with some help from torsocks I am now monitoring availability of several onions, and trending all Nagios perfdata outputs from `check_http`, `check_ssh`, and `check_tcp`. 

I've written a set of instructions and sample configurations for monitoring Tor hidden services (onions) using Nagios and put them in a public Github [repository](https://github.com/coldhakca/monion). check_commands for everything you need to monitor http, ssh, and other more generic tcp services on your onions is in the repo.

The process I went through to get working monitoring of onions was fairly simple, initially I was going to use proxychains, however torsocks turned out to be simpler. Basically I ran `torsocks check_http -H onion; echo $?` to check that torsocks passed the exit codes through, confirmed that it did, and then wrote out a set of check_commands and put them in my nagios configuration by simply copying the regular check and prepending it with `/usr/bin/torsocks`. 

{% img /static/blog-img/2015-11-29-onion-perfdata.png %}

The load performance of Facebook's https onion site after about an hour.
