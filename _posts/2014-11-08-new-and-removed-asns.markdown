---
layout: post
title: "New and Removed ASNs"
date: 2014-11-08 22:22:30 -0600
comments: false
description: "As part of maintaining my list of Manitoban ASNs and their IPv6 status, I need to determine new Canadian, and specifically, Manitoban ASNs issued by ARIN. I had been doing this manually by reading through bgp.he.net/country/CA, but this was very time consuming, and very prone to error/being banned."
categories: 
- Nerd Projects
- System Administration
- Networking
- BGP
- ISP
- CLI
- Programming
share: true
---
As part of maintaining my list of [Manitoban ASNs and their IPv6 status](/bgp/mb/), I need to determine new Canadian, and specifically, Manitoban ASNs issued by ARIN. I had been doing this manually by reading through [bgp.he.net/country/CA](http://bgp.he.net/country/CA), but this was very time consuming, and very prone to error/being banned.

I've used [Blockfinder](https://github.com/ioerror/blockfinder/) before, but had never thought about scripting it. I wrote up a quick bash script to dump a list of Canadian ASNs, once a day.

{% highlight bash %}
#!/bin/bash

TODAY=`date "+%Y-%m-%d"`

case $OSTYPE in
  darwin*)  YESTERDAY=`date -v -1d "+%Y-%m-%d"` ;;
  linux*)   YESTERDAY=`date --date="yesterday" "+%Y-%m-%d"` ;;
  *bsd*)    YESTERDAY=`date -v -1d "+%Y-%m-%d"` ;;
  *)        echo "unknown: $OSTYPE" ;;
esac

cd ~/dev/github/blockfinder

./blockfinder -i > /dev/null
./blockfinder -v -t ca:asn > ca-asn-$TODAY.txt
/usr/bin/diff -u ca-asn-$YESTERDAY.txt ca-asn-$TODAY.txt |\
mail -s "[ASN-diffs] Canada $TODAY" `whoami`
{% endhighlight %}

Once a day now, I get an email which contains a body like follows:

{% highlight diff %}
--- ca-asn-2014-11-05.txt	2014-11-05 23:11:18.566958899 -0600
+++ ca-asn-2014-11-06.txt	2014-11-06 23:11:12.145513537 -0600
@@ -1436,3 +1436,4 @@
393653
393657
393659
+393686
{% endhighlight %}

I quickly discovered that blockfinder opens the TTY to discover terminal size to pretty print progress bars when downloading. This doesn't work in a cron job, and isn't needed either. I patched this functionality out with the patch included in the [Gist](https://gist.github.com/tbaschak/2c99aca271ae872c4a73).

I have also submitted a suggestion to ARIN that they provide a daily list of ASNs assigned/de-assigned much like their arin-issued list. This suggestion has been accepted as [2014-27](https://www.arin.net/participate/acsp/suggestions/2014-27.html). It sounds like they have agreed that providing a daily list of ASNs assigned, and de-assigned would be useful for the community as a whole, much like their [arin-issued](http://lists.arin.net/pipermail/arin-issued/) list does for IP addresses.

**Update 2015-06-23:** I've received an email from Mark Kosters, Chief Technology Officer at ARIN letting me know that my suggestion has been implemented and thanking me for participating in the Suggestion and Consultation process. Monday, [June 22nds report](http://lists.arin.net/pipermail/arin-issued/2015-June/002384.html) now lists new AS numbers issued!
