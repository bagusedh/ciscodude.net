---
layout: post
title: "Unshortening with cURL"
date: 2014-08-12 21:47:34 -0500
comments: false
categories: 
- Nerd Projects
- Networking
- CLI
- System Administration
- Network Monitoring
image:
  feature: https://ciscodude.net/images/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
share: true
---
Sometimes you get a short URL for something and would like to know where it goes before clicking on it. cURL can help you determine this. This can be done with the following one-liner.

	curl -s -o /dev/null -I -w "%{url_effective}\n" -L $URL

This can be adapted into a simple, small shell script which gives the user a usage/help when 1 argument isn't given.

{% gist 1d32970cb0a56c21310c %}
