---
layout: post
title: "Phased Service Moves"
date: 2014-12-05 18:52:24 -0600
description: "This evening I successfully moved a second set of services from service provider IP space to BGP IP space. The first phase of this project began over a year ago -- I turned up AS62758 in early December 2013 prior to the migration of a Learning Management System."
comments: false
categories: 
- Networking
- System Administration
- BGP
image:
  feature: https://ciscodude.net/static/blog-img/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
share: true
---
This evening I successfully moved a second set of services from service provider IP space to BGP IP space. The first phase of this project began over a year ago -- I turned up AS62758 in early December 2013 prior to the migration of a Learning Management System. With this second phase now complete, most externally offered services are now running on BGP IP addresses. I have two more remaining phases, to move the access NAT network, and to move a Student Information System. These remaining two phases will be happening over the next two weekends.

## Pre-Change Changes

*	Reduced TTL values on affected records a week before the change.
*	Pre-configured new firewall with new IP addresses, 1:1 NATs, and allow/deny rules.
*	Pre-configured PTR records.
*	Pre-modified SPF record to add new IP range.
*	Tested several of the port forwards with a simple Debian VM running an nginx server to display a success page.

## Changes

*	Changed affected VM's network from old to new network.
*	Made several cabling changes/additions.

## Testing

All testing was successful, which makes sense, as no changes needed to be made on the systems themselves, just firewall, and physical/virtual cabling changes.

