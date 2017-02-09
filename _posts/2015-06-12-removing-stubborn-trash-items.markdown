---
layout: post
title: "Removing Stubborn Trash Items"
date: 2015-06-12 00:31:06 -0500
comments: false
share: true
description: "For one reason or another, I recently ended up with a draft blog post stuck in my OS X Yosemite Trash. I have no idea how this happened, but after reading 5 or 6 blogs and forum posts I was thoroughly frustrated with trying to find 'the Mac Way', and fired up the CLI:"
categories:
- CLI
- Nerd Projects
- System Administration
- Troubleshooting
- OS X
---
For one reason or another, I recently ended up with a draft blog post stuck in my OS X Yosemite Trash. I have no idea how this happened, but after reading 5 or 6 blogs and forum posts I was thoroughly frustrated with trying to find "the Mac Way", and fired up the CLI:

{% highlight bash %}
cd ~/.Trash
sudo chflags -R nouchg <filename>
sudo rm -f <filename>
echo w00t
{% endhighlight %}

Sometimes it is just best to follow your gut, in this case just using the CLI to resolve the issue.
