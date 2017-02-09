---
layout: post
title: "Does Everything Still Work?"
date: 2015-02-04 23:22:04 -0600
comments: false
description: "Does everything still work? This is a question often asked after changes in your environment."
categories: 
- IPv6
- Nerd Projects
- System Administration
- Networking
- CLI
- Network Monitoring
- Programming
- API
- Troubleshooting
share: true
---
Does everything still work? This is a question often asked after changes in your environment.

Whether its routing/switching changes, firewall rule set/policy changes, or software upgrades, having a pre-defined set of tests which should all pass makes it very easy to run whenever you need re-assurance that things are operating properly. It also makes it very easy to run before, after, or even during changes so the question of "but was it actually working before?" never comes up.

Inspired, and feeling very empowered by a blog post on [Test Driven Infrastructure](http://ertw.com/blog/2014/12/29/test-driven-infrastructure/) written by a Sean Walberg (a friend of mine from the local [Manitoba Unix Users Group](http://muug.mb.ca/)), I decided to make [Bash Automated Testing System](https://github.com/sstephenson/bats) test cases for the various web sites and services I run and support. In about an hour I had 27 tests in place, ranging from basic sanity checks, to 301 and 302 redirects, and even some page content which has to be generated properly to be successful.

A sample test file which tests various components of this domain:

{% highlight bash %}
#!/usr/bin/env bats

@test "Ciscodude: root domain" {
  run curl -i http://ciscodude.net/
  [[ $output =~ "301 Moved" ]]
  [[ $output =~ "Location: https://ciscodude.net/" ]]
}

@test "Ciscodude: www" {
  run curl -i http://www.ciscodude.net/
  [[ $output =~ "301 Moved" ]]
  [[ $output =~ "Location: https://ciscodude.net/" ]]
}

@test "Ciscodude: blog" {
  run curl -i http://blog.ciscodude.net/
  [[ $output =~ "301 Moved" ]]
  [[ $output =~ "Location: https://ciscodude.net/" ]]
}

@test "Ciscodude: https" {
  run curl https://ciscodude.net/
  [[ $output =~ "CiscoDude.net" ]]
}

@test "Ciscodude: https ping" {
  run curl https://ciscodude.net/ping/
  [[ $output =~ "OK" ]]
}
{% endhighlight %}

A few more tests like this and I'll have a pretty complete sanity check/test set for my services!
