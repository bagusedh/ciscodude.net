---
layout: post
title: "IP Quail API"
date: 2014-09-14 03:03:05 -0500
comments: false
description: "While I've been supporting making requests to ipquail.com with useragent curl and responding with only plaintext, I don't have a formal API for the site. Being inspired by the recent Arin on the Road talks on their Whois-RWS and Reg-RWS systems, I sat out to start to write an API for ipquail.com"
categories:
- Anycast
- Nerd Projects
- CLI
- API
- IPv6
- Programming
- System Administration
image:
  feature: https://ciscodude.net/static/blog-img/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
share: true
---
While I've been supporting making requests to ipquail.com with useragent curl and responding with only plaintext, I don't have a formal API for the site. Being inspired by the recent [Arin on the Road](/2014/09/12/arin-on-the-road/) talks on their Whois-RWS and Reg-RWS systems, I set out to start to write an API for ipquail.com. 

I chose to write it using Python/Flask, and deploy it using uWSGI/nginx. Several hours later, I now have [code up on Github](https://github.com/henchman21/ipquail-api), and a functioning beta version online which returns the remote_addr of the client, JSONified.

This is the output so far:

	curl -i http://6.ipquail.com/ip/api/v1.0/remote_addr
	HTTP/1.1 200 OK
	Server: nginx/1.6.2
	Date: Wed, 24 Sep 2014 05:46:56 GMT
	Content-Type: application/json
	Transfer-Encoding: chunked
	Connection: keep-alive
	Vary: Accept-Encoding
	Access-Control-Allow-Origin: *
	Access-Control-Allow-Methods: GET
	Access-Control-Allow-Headers: X-Requested-With,Accept,Content-Type,Origin

	{
		"ip": "2604:4280:d00d:202:79f2:da92:6e9:c7c3"
	}

## API Documentation (for now)

> GET http://4.ipquail.com/ip/api/v1.0/remote_addr

Gets the current IPv4 address.

> GET http://6.ipquail.com/ip/api/v1.0/remote_addr

Gets the current IPv6 address.

** Update 2014-09-24:** This has been updated with the production URLs, headers, and documentation. You'll notice if you read the [ipquail/README.md](https://github.com/henchman21/ipquail/blob/master/README.md) that I actually generate the production API responses using simple HTML/SSI and some header fakery. :-)
