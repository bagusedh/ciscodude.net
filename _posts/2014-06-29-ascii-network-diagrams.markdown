---
layout: post
title: "ASCII Network Diagrams"
date: 2014-06-29 22:04:16 -0500
comments: false
categories: 
- Networking
- Nerd Projects
- System Administration
image:
  feature: https://ciscodude.net/static/blog-img/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
share: true
---
I've often wondered if there is an easy way to generate ASCII network diagrams like those that appear in text RFC documents. This week I discovered [ASCIIFlow](http://asciiflow.com/).


ASCIIFlow is really simple to use, and lets you draw boxes, lines, and arrows (for network diagrams and flow charts) using your mouse right in the web browser. It also lets you save/open your text diagrams to/from Google Drive.

{% highlight text %}
+-----+    +-----+    +-----+
|Edge1|    |Edge2|    |Edge3|
+--+--+    +--+--+    +--+--+
   |          |          |   
   |       +--+--+       |   
   +-------+BGP1 +-------+   
           +--+--+           
              |              
           +--+--+           
           |VMH1 |           
           +-----+           
{% endhighlight %}
