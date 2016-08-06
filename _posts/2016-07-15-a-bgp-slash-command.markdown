---
layout: post
image:
  feature: https://ciscodude.net/images/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
title: "A BGP Slash Command"
date: 2016-07-15 22:47:24 -0500
comments: false
share: true
description: "If you're using Slack then you should already know how easy it is to integrate almost anything into slack using its web APIs. If you're not already using Slack, what are you waiting for?"
categories: 
- Networking
- ISP
- BGP
- System Administration
- Network Monitoring
- Troubleshooting
- Programming
- API
- CLI
---
If you're using [Slack](https://slack.com/) then you should already know how easy it is to integrate almost anything into slack using its web APIs. If you're not already using Slack, what are you waiting for?

As a Slack user and a network administrator I often find myself leaving Slack to check a looking glass, or to whois something. A while back I [made an API](https://api.hextet.net/) that supplies various BGP related information back when given an IP address with the intention of making a Slack "Slash Command" first, and maybe a Slack App afterwards if I found it useful.

This turned out to be easier than I expected.

## Setting Up a `/bgp` Slash Command

1.	Go to your [Slash Commands](https://my.slack.com/services/new/slash-commands).
2.	Under Integration Settings enter the following:

{% highlight yaml %}
Command: /bgp
URL: "https://api.hextet.net/api/v1/bgp/"
Method: POST
Customize Name: bgp-lookup
Autocomplete:
  - [x] Show this command in the autocomplete list
  - Description: Do BGP Lookup on an IP
  - Usage Hint: [IPv4|v6 Address]
Descriptive Label: BGP Lookup
{% endhighlight %}

Thats is.

Now you can use `/bgp x.x.x.x` in your Slack channels and get BGP lookup info.

If this is handy I may make an app to provide this.
