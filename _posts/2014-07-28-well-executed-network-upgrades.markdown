---
layout: post
title: "Well Executed Network Upgrades"
date: 2014-07-28 11:46:08 -0500
comments: false
categories: 
- Networking
- System Administration
- Virtualization
- Brocade
- Cisco
- Network Monitoring
share: true
---
This past weekend a colleague and I executed a successful core network change, from stacked Cisco 3750G's to Brocade ICX6610's. We have been planning this upgrade for the past six months, and the extensive planning and testing before hand paid off -- only three small things were missed, none of which were show stoppers.

### Planning

Our planning took top priority starting about two months ago. The plan we devised was to migrate our network from the Cisco to Brocade core, port-for-port. `Gi1/0/1` would become `Gi1/1/1`, `Gi2/0/14` would become `Gi2/1/14`. We chose to make no additional changes at all during the network change process, with the single exception being implementing VRRP at each core switch stack.

### Testing

Since our new network state would include both Cisco and Brocade switching equipment in it, real world inter-vendor operability testing was required. We built a lab network which consisted of 3xICX6610 stacked, connected to 3xICX6610 also stacked, with a 3750G and a 2960S both uplinked to each set of stacked ICX6610's. We tested spanning-tree failover scenarios, ran show commands and debugs, changed configurations, tested scenarios again, and in the end we had Rapid Spanning Tree functioning 100% as designed/desired between Cisco and Brocade. 

### Change Plan

Our change plan was to make room in the rack so that we could pre rack the new switches. We would leave the existing core switches, powered off, in the rack as a fail back plan. We planned to shut down all VMs with the exception of two which were needed, which were to be migrated to directly attached storage arrays for the duration of the changes. Notifications were sent out to all users, since the network was planned to be offline for up to 6 hours.

### Execution

When the time came to execute the changes, VMs were shut down, iSCSI storage was properly shut down, BGP sessions downed, and we began the process of moving the cables over, one port at a time. The physical cable moving process took approximately 30 minutes per stack. Several external nagios alerts along the way provided positive reinforcement during that process.

### Testing

After making the changes, core VMs were booted back up, and extensive testing was done to ensure that all network services and locations still functioned 100% correctly. It was immediately noted that WiFi SSIDs were not visible, we branched out our testing to let me focus on restoring WiFi service, while my colleague tested/checked off items from our change plan. We identified one mis-configured port, and eventually I identified that we had no DHCP forwarder on our management VLAN, which turns out was required for the WiFI access points to get provisioned. One additional port was identified as mis-configured (a simple untagged VLAN oops) during the testing.

### Post-Execution Fallout

No user reports of problems relating to network connectivity.

### Conclusion

I was very pleased with how well this change went. I am glad that we stuck our plan of making no functionality changes to the network, other than implementing VRRP. 

