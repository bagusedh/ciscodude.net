---
layout: page
title: "Manitoban BGP Growth"
comments: false
sharing: true
footer: false
description: ""
lastmodified: 2017-03-29 18:54:54 +0000
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
		labels : [1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017],
		datasets : [
			{
				label: "MB ASNs Assigned",
				fillColor : "rgba(151,187,205,0.7)",
				strokeColor : "rgba(151,187,205,1)",
				pointColor : "rgba(151,187,205,1)",
				pointStrokeColor : "#fff",
				pointHighlightFill : "#fff",
				pointHighlightStroke : "rgba(151,187,205,1)",
				data : [2,2,4,4,7,12,13,14,16,20,21,25,27,29,29,33,35,48,56,68,76,78]
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
