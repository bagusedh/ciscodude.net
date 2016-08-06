---
image:
  feature: https://ciscodude.net/images/snow-dust.jpg
  credit: Theo Baschak
  creditlink: https://www.flickr.com/photos/theodorebaschak/
layout: page
title: "Manitoban BGP Growth"
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
		labels : [1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016],
		datasets : [
			{
				label: "MB ASNs Assigned",
				fillColor : "rgba(151,187,205,0.7)",
				strokeColor : "rgba(151,187,205,1)",
				pointColor : "rgba(151,187,205,1)",
				pointStrokeColor : "#fff",
				pointHighlightFill : "#fff",
				pointHighlightStroke : "rgba(151,187,205,1)",
				data : [1,1,2,2,5,10,11,12,14,18,19,21,23,26,26,30,32,45,54,67,72]
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
