---
layout: post
title: "ipquail-go"
date: 2015-12-14 00:04:24 -0600
comments: false
share: true
description: I've been waiting to add some features to ipquail.com for a while, but the way in which I was handling API endpoints at the moment needed to change before I could accommodate anything fancier -- at the moment I was using simple Server Side Includes ("SSI" in 90's Apache web server terminology) and some mime-type modifications to fake API endpoints. This needed to change.
categories: 
- Nerd Projects
- CLI
- API
- IPv6
- Programming
- System Administration
---
I've been waiting to add some features to [ipquail.com](http://ipquail.com) for a while, but the way in which I was handling API endpoints at the moment needed to change before I could accommodate anything fancier -- at the moment I was using simple Server Side Includes ("SSI" in 90's Apache web server terminology) and some mime-type modifications to fake API endpoints. This needed to change.

I'd seen some code for how to handle this type of request using [pilu/traffic](https://github.com/pilu/traffic), and thought "this should work" to myself. Several hours later I had pushed a new project to my github, [ipquail-go](https://github.com/tbaschak/ipquail-go) -- a go rewrite of [ipquail.com](http://ipquail.com).

The main functionality of the web application is handled thru the nginx configs mentioned in the [README.md](https://github.com/tbaschak/ipquail-go/blob/master/README.md). This basically sets up nginx to handle all files in the `ipquail/public` directory as the webroot, and then nginx passes a few more specific URLs (`/ip`, `/ptr`, and `/api/*`) on to the new Go backend.

The main() function in the backend sets up the 4 API endpoints which will be passed on to it, and which handlers will be taking care of each endpoint.

*	/ip - echos straight IP
*	/ptr - echos PTR if exists, "none" otherwise
*	/api/ip - echos { "ip": "<IP_STRING>" } w/ proper JSON headers
*	/api/ptr - echos { "ptr": "<PTR_STRING>" } w/ proper JSON headers

{% highlight go %}
func main() {
  router := traffic.New()

  // add a route for each page you add to the site
  // make sure you create a route handler for it
  router.Get("/ip", ipHandler)
  router.Get("/ptr", ptrHandler)
  router.Get("/api/ip", ipapiHandler)
  router.Get("/api/ptr", ptrapiHandler)
  router.Run()
}
{% endhighlight %}

An example handler, used to print just the IP that the request came from. Having request IP as a header other than Host lets IPv4/IPv6 termination be handled by nginx, and the backend just simply print it out.

{% highlight go %}
func ipHandler(w traffic.ResponseWriter, r *traffic.Request) {
  traffic.Logger().Print( r.Header.Get("X-Forwarded-For") ) 
  w.Header().Add("Content-type", "text/plain")
  w.WriteText( r.Header.Get("X-Forwarded-For") )
}
{% endhighlight %}

