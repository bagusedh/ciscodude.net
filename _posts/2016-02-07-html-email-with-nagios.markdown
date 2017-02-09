---
layout: post
title: "HTML Email with Nagios"
external_url: http://engineering.voxer.com/2014/02/24/nagios-html-email-templates/
date: 2016-02-07 02:36:50 -0600
comments: false
share: true
description: "But can you make the alerts look nicer?"
categories: 
- Networking
- Nagios
- IPv6
- Nerd Projects
- Network Monitoring
- System Administration
---
"But can you make the alerts look nicer?"

I've always liked the simple, plain text, easily customized commands used for email and SMS alerting in Nagios. I recently set up SMS alerting using [nagios-twilio](https://github.com/bfg/nagios-twilio) and some custom alert commands. Knowing this, I knew it would be possible to add HTML formatted alerts, and easily too.

I did a quick google and found the following [blog post](http://engineering.voxer.com/2014/02/24/nagios-html-email-templates/) from Voxer, and [accompanying github project](https://github.com/Voxer/nagios-html-email). I've long been tempted by Etsy's HTML email generating NOW WITH CONTEXT, [nagios-herald](https://github.com/etsy/nagios-herald) which I discovered in this excellent blog [blog](https://codeascraft.com/2014/06/06/introducing-nagios-herald/) however I hadn't been running anything graphing perfdata up until recently.

## Installation

Installation of `nagios-html-email` was pretty straight forward:

{% highlight bash %}
sudo apt-get -y install npm
sudo npm install -g nagios-html-email
{% endhighlight %}

## Configuration

As the README states, you need the notification commands. I chose to add a new command instead of replacing the existing one.

{% highlight config %}
define command {
    command_name notify-service-by-email
    command_line nagios-html-email service http://nagios.example.com | sendmail -t
}
define command {
    command_name notify-host-by-email
    command_line nagios-html-email host http://nagios.example.com | sendmail -t
}
{% endhighlight %}

In my case, I had to replace `mailx` with `sendmail` because the emails were coming through with literal HTML code in them instead of being interpreted. I also had to edit the first line of the script at `/usr/local/bin/nagios-html-email` to change `node` to `nodejs`.

At this point I tested a few test notifications and was was quite pleased with the default notification template. I am going to run it for a while and see what I'd like to customize.

