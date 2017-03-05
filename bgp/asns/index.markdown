---
layout: nul
---
This is a chart of BGP growth (# of registered ASNs) in Canada by province.

<script src="/static/vendor/Chart.min.js"></script>
<div style="width:90%">
	<div>
		<canvas id="canvas" height="300" width="600"></canvas>
	</div>
</div>

<script>
	var randomScalingFactor = function(){ return Math.round(Math.random()*100)};
	var lineChartData = {
		labels : [1985, 1986, 1987, 1988, 1989, 1990, 1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017],
		datasets : [
			{
				label: "AB ASNs Assigned",
				fillColor : "rgba(255,0,0,0.2)",
				strokeColor : "rgba(255,0,0,1)",
				pointColor : "rgba(255,0,0,1)",
				pointStrokeColor : "#fff",
				pointHighlightFill : "#fff",
				pointHighlightStroke : "rgba(255,0,0,1)",
				data : [0,0,0,0,1,1,1,1,3,4,4,6,10,11,13,21,28,36,42,48,54,64,72,77,89,94,105,121,139,147,161,171,173]
			},
			{
				label: "BC ASNs Assigned",
				fillColor : "rgba(226, 87, 30,0.2)",
				strokeColor : "rgba(226, 87, 30,1)",
				pointColor : "rgba(226, 87, 30,1)",
				pointStrokeColor : "#fff",
				pointHighlightFill : "#fff",
				pointHighlightStroke : "rgba(226, 87, 30,1)",
				data : [0,0,0,0,1,1,1,1,2,5,7,12,15,17,20,30,35,43,47,50,54,60,68,78,89,99,108,130,151,171,178,191,195]
			},
			{
				label: "MB ASNs Assigned",
				fillColor : "rgba(255, 127, 0,0.2)",
				strokeColor : "rgba(255, 127, 0,1)",
				pointColor : "rgba(255, 127, 0,1)",
				pointStrokeColor : "#fff",
				pointHighlightFill : "#fff",
				pointHighlightStroke : "rgba(255, 127, 0,1)",
				data : [0,0,0,0,0,1,1,1,1,1,1,3,3,5,5,8,13,14,15,17,21,22,26,28,30,30,34,36,49,57,69,77,79]
			},
			{
				label: "NB ASNs Assigned",
				fillColor : "rgba(255, 255, 0,0.2)",
				strokeColor : "rgba(255, 255, 0,1)",
				pointColor : "rgba(255, 255, 0,1)",
				pointStrokeColor : "#fff",
				pointHighlightFill : "#fff",
				pointHighlightStroke : "rgba(255, 255, 0,1)",
				data : [0,0,0,0,0,1,1,1,1,1,1,1,2,2,3,4,4,6,8,10,12,14,17,19,19,19,20,21,21,23,25,27,27]
			},
			{
				label: "NL ASNs Assigned",
				fillColor : "rgba(0, 255, 0,0.2)",
				strokeColor : "rgba(0, 255, 0,1)",
				pointColor : "rgba(0, 255, 0,1)",
				pointStrokeColor : "#fff",
				pointHighlightFill : "#fff",
				pointHighlightStroke : "rgba(0, 255, 0,1)",
				data : [0,0,0,0,0,0,0,0,0,0,0,2,2,3,3,3,3,3,3,3,3,4,6,7,7,9,9,10,12,13,13,14,15]
			},
			{
				label: "NS ASNs Assigned",
				fillColor : "rgba(150, 191, 51,0.2)",
				strokeColor : "rgba(150, 191, 51,1)",
				pointColor : "rgba(150, 191, 51,1)",
				pointStrokeColor : "#fff",
				pointHighlightFill : "#fff",
				pointHighlightStroke : "rgba(150, 191, 51,1)",
				data : [1,1,1,1,1,2,2,2,2,2,3,4,4,7,7,7,9,9,11,12,14,15,17,17,18,21,23,27,27,28,31,32,32]
			},
			{
				label: "NT ASNs Assigned",
				fillColor : "rgba(0, 0, 255,0.2)",
				strokeColor : "rgba(0, 0, 255,1)",
				pointColor : "rgba(0, 0, 255,1)",
				pointStrokeColor : "#fff",
				pointHighlightFill : "#fff",
				pointHighlightStroke : "rgba(0, 0, 255,1)",
				data : [0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,2,2,2,2,3,3,3,3,3,3,4,4,4,4,4,4,4]
			},
			{
				label: "ON ASNs Assigned",
				fillColor : "rgba(75, 0, 130,0.2)",
				strokeColor : "rgba(75, 0, 130,1)",
				pointColor : "rgba(75, 0, 130,1)",
				pointStrokeColor : "#fff",
				pointHighlightFill : "#fff",
				pointHighlightStroke : "rgba(75, 0, 130,1)",
				data : [0,1,1,2,3,8,8,10,14,32,47,58,79,94,115,145,184,224,255,299,327,365,395,427,463,504,539,570,619,656,709,758,765]
			},
			{
				label: "PE ASNs Assigned",
				fillColor : "rgba(139, 0, 255,0.2)",
				strokeColor : "rgba(139, 0, 255,1)",
				pointColor : "rgba(139, 0, 255,1)",
				pointStrokeColor : "#fff",
				pointHighlightFill : "#fff",
				pointHighlightStroke : "rgba(139, 0, 255,1)",
				data : [0,0,0,0,0,1,1,1,1,1,1,1,3,3,3,3,3,3,3,3,3,3,3,4,4,5,5,5,5,5,5,5,5]
			},
			{
				label: "QC ASNs Assigned",
				fillColor : "rgba(221,187,205,0.2)",
				strokeColor : "rgba(221,187,205,1)",
				pointColor : "rgba(221,187,205,1)",
				pointStrokeColor : "#fff",
				pointHighlightFill : "#fff",
				pointHighlightStroke : "rgba(221,187,205,1)",
				data : [0,0,0,0,1,2,3,3,4,8,12,16,20,23,29,38,48,52,60,69,80,93,108,126,138,155,178,195,214,232,245,266,272]
			},
			{
				label: "SK ASNs Assigned",
				fillColor : "rgba(231,187,205,0.2)",
				strokeColor : "rgba(231,187,205,1)",
				pointColor : "rgba(231,187,205,1)",
				pointStrokeColor : "#fff",
				pointHighlightFill : "#fff",
				pointHighlightStroke : "rgba(231,187,205,1)",
				data : [0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,2,6,8,11,12,12,15,15,16,17,20,20,21,22,24,27,29,30]
			},
			{
				label: "YT ASNs Assigned",
				fillColor : "rgba(161,227,136,0.2)",
				strokeColor : "rgba(161,227,136,1)",
				pointColor : "rgba(161,227,136,1)",
				pointStrokeColor : "#fff",
				pointHighlightFill : "#fff",
				pointHighlightStroke : "rgba(161,227,136,1)",
				data : [0,0,0,0,0,0,0,0,0,0,1,1,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3]
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

