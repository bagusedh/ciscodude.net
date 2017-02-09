---
layout: page
title: "Canadian BGP Growth"
comments: false
sharing: true
footer: false
description: ""
categories:
- IPv6
- ISP
- Nerd Projects
- System Administration
- Networking
- BGP
- Network Monitoring
---
This is a chart of BGP growth (# of registered ASNs) in Canada by province.

{% raw %}
<script src="/static/vendor/Chart.min.js"></script>
<div style="width:90%">
	<div>
		<canvas id="canvas" height="300" width="600"></canvas>
	</div>
</div>

<script>
	var randomScalingFactor = function(){ return Math.round(Math.random()*100)};
	var lineChartData = {
		labels : [1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015],
		datasets : [
			{
				label: "MB ASNs Assigned",
				fillColor : "rgba(151,187,205,0.2)",
				strokeColor : "rgba(151,187,205,1)",
				pointColor : "rgba(151,187,205,1)",
				pointStrokeColor : "#fff",
				pointHighlightFill : "#fff",
				pointHighlightStroke : "rgba(151,187,205,1)",
				data : [0,0,1,1,2,2,5,10,11,12,14,18,19,21,23,26,26,30,32,45,54,66]
			},
			{
				label: "SK ASNs Assigned",
				fillColor : "rgba(161,227,136,0.2)",
				strokeColor : "rgba(161,227,136,1)",
				pointColor : "rgba(161,227,136,1)",
				pointStrokeColor : "#fff",
				pointHighlightFill : "#fff",
				pointHighlightStroke : "rgba(161,227,136,1)",
				data : [1,1,1,1,1,1,2,6,8,10,10,10,12,12,13,14,14,14,15,15,17,20]
			}
		]

	}

window.onload = function(){
	var ctx = document.getElementById("canvas").getContext("2d");
	window.myLine = new Chart(ctx).Line(lineChartData, {
		responsive: true,
		animation: true,
		animationEasing: "easeOutBounce",
		multiTooltipTemplate: "<%=datasetLabel%>: <%= value %>"
	});
}

</script>

{% endraw %}
