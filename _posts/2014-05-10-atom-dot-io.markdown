---
layout: post
noindex: true
title: "Atom.io"
date: 2014-05-10 20:21:47 -0500
comments: false
categories:
- Nerd Projects
- Programming
- CLI
image:
  feature: https://ciscodude.net/static/blog-img/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
---
I've been a big fan of [Sublime Text](http://www.sublimetext.com/) for quite some time now, to the point where I've almost considered purchasing a license for it. Today I discovered [Atom](https://atom.io/), an open sourced editor by Github. Atom is visually quite similar to Sublime Text, from its file layout on the left, its command pallet, and its tabbed interface. I think Atom will replace Sublime Text as my regular text editor.

The color scheme is nice out of the box, a list of files on the left hand side, a dark grey window on the right. The editor itself is Markdown aware, showing small syntax highlights for various Markdown elements. It is also aware of git repos, showing the current branch, and number of changed lines in the bottom right, and the status of each file on the left based on color (grey, green, orange).

It also includes a binary optionally installed in `/usr/local/bin/atom` (on Mac anyways)

{% highlight text %}
Atom Editor v0.94.0

Usage: atom [options] [file ...]

Options:
  -d, --dev             Run in development mode.                                             [boolean]
  -f, --foreground      Keep the browser process in the foreground.                          [boolean]
  -h, --help            Print this usage message.                                            [boolean]
  -l, --log-file        Log all output to file.                                              [string]
  -n, --new-window      Open a new window.                                                   [boolean]
  -s, --spec-directory  Set the spec directory (default: Atom's spec directory).             [string]
  --safe                Do not load packages from ~/.atom/packages or ~/.atom/dev/packages.  [boolean]
  -t, --test            Run the specified specs and exit with error code on failures.        [boolean]
  -v, --version         Print the version.                                                   [boolean]
  -w, --wait            Wait for window to be closed before returning.                       [boolean]
{% endhighlight %}

**Update:** While Atom itself is cross platform, there are only OSX downloads at this point, Windows and Linux binaries are still coming.
