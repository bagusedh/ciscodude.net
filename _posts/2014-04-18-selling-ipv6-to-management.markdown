---
layout: post
title: "Selling IPv6 to Management"
date: 2014-04-18 22:06:31 -0500
comments: false
categories: 
- Networking
- IPv6
- Nerd Projects
---
Why do we need IPv6? This is one of the first questions I am often asked when bringing up IPv6. The perception is often that since no functionality appears to be missing, that IPv6 isn't needed, at least not right now. 

Since the Internet has always been IPv4 as long as its been popularized, there is also no previous IP version migration history to refer to. It is all new, uncharted territory.

<!--more-->

I have [started writing a presentation](https://github.com/tbaschak/ipv6-mfnerc) which sets out to sell IPv6 to management. 

### The Internet is Critical to Daily Operations

The Internet is a critical service to many businesses. 

Things which (may) depend on Internet:

*	Cloud Based Services
*	Email
*	IP Phones
*	Security Systems
*	Payroll
*	Business Processes

### The Looming Problem: IPv4 Exhaustion

Unless you've had your head in the sand for the past few years, IPv4 Exhaustion is nearly upon us. If you are in RIPE or APNIC territory, IPv4 is exhausted.

### Implications of IPv4 Exhaustion

The effects of IPv4 Exhaustion may be felt in different ways. New service providers will have difficulty in obtaining sufficient IPV4 resources to give everyone a real public IP. This will result in more complex NATs and PATs. 

### IPv6: The Solution

IP version 6 is the next version of the Internet Protocol (IP). It promises enough addresses that everyone will be able to have all of their devices on the Internet. Fridges don't have IP networking standard in them yet, but many TV's have included it standard over the past few years. In a house of two people, I sometimes have upwards of 14 devices connected wirelessly. 

### IPv6 Deployment Risks

There are risks associated both with deploying IPv6, and not deploying IPv6.

#### Early Deployment

Being an early adopter always has its risks. Early hardware can have new implementation bugs. Specs change and mature over time. Money can be wasted on hardware which doesn't meet operational requirements when mainstream deployment occurs.

A benefit of early deployment, is that when mainstream deployment happens, you've already done it and have plenty of deployment and operational experience while everyone else tries to figure out the new IP version.

#### Now

We are just about at mainstream deployment of IPv6 now. Google is now seeing about 3% of their traffic over IPv6, although their Canadian traffic is only 0.6% IPv6. 

Risks to deploying IPv6 now include still being somewhat of an early adopter, although many of the standards have now been around for over 10 years now, and networking equipment has had several generations with varying levels of IPv6 support now. Many bugs have been worked out (and new ones continue to be as more people use IPv6).

Benefits to deploying now include being ready when the IP teeter totter start to get near to tipping into IPv6 favour.

#### Late Deployment

Those who deploy IPv6 late, after mainstream deployment, will likely have problems reaching business partners as everyone else gets IPv6 connectivity. They will also be playing catch-up, and have to learn everything that everyone else will already know in a hurry, resulting in rushed deployments. As IPv4 exhaustion becomes reality in all regions carrier side NATs will become necessary, and cause a further push for IPv6 to avoid problems associated with NATs.

### IPv6 Deployment Costs?

The costs of deploying IPv6 depend highly on the current state of the network. Network equipment purchased from major vendors in the last 3-5 years should have good IPv6 support because of many government branches requiring IPv6 support. Decisions may need to be made about out of cycle replacement of existing kit which doesn't have full IPv4/IPv6 feature parity. 

### Conclusions and Call for Action

I think businesses need to look at deploying IPv6 now. Locally, the biggest holdup to IPv6 deployment is often that IPv6 connectivity is not available from their ISP yet.

MTS, one of the local giant telecomc, can't/won't offer it to customers yet. Shaw, the other local telecom giant, may to BGP customers (TeraGo from Shaw, and Westman Communications from Shaw), but not to end users yet. 

Out of 41 ASNs in Manitoba, 37% have IPv6 prefixes announced.


#### Resources

*	[How Managers can Support their Engineers deploy IPv6](http://www.circleid.com/posts/20140305_how_managers_can_support_their_engineers_deploy_ipv6/)
*	[IPv6 Business Case for Engineers](http://techxcellence.net/2013/03/05/v6-business-case-for-engineers/)
*	[Step by Step Framework for Planning IPv6 Deployment](http://techxcellence.net/2013/01/28/step-by-step-framework-for-planning-ipv6-deployment/)
*	[Thinking Strategically about the Benefits of IPv6](http://www.circleid.com/posts/20140201_thinking_strategically_about_the_benefits_of_ipv6/)


