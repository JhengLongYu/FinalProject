<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Montserrat">
<!-- Favicon-->
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/images/favicon.ico" />
<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js"
	crossorigin="anonymous"></script>
<!-- Font Awesome icons (free version) 要改根目錄-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css" />
<link
	href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700"
	rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath}/css/styles.css"
	rel="stylesheet" />
<script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<!-- 圖表的 -->
<script src="https://code.highcharts.com/highcharts.js"></script>
<title>BMI</title>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', () => {
	let idfrom = "${mbid}";
	console.log(idfrom);
	var x = [];//X軸
	var y = [];//Y軸
	var xtext = [];//X軸TEXT
	let url = "<c:url value='/healthCenter/bmi/'  />" + idfrom;
	    $.ajax({  
	        url: url,  
	        type: 'GET',
	        async: true,
	        dataType: "json",
	        success: function(data) {
	        	var json = eval(data);
	        	console.log(json);
	        	var nameArray = new Array();
				var numberArray = new Array();
				console.log(data[0].bmi);
	        	for(var i in data){
	        		 nameArray[i]=data[i].daytime;
	        		 numberArray[i]=data[i].bmi;
	        	}
	        	column(nameArray,numberArray);
// 	         	options.series.setData(nameArray);
// 	         	options.series.setData(numberArray);
	        	
// 	         	Highcharts.chart('container', options);       
	       },
	       error:function(data){
	    	   alert('fail');
	       } 
//	     data: JSON.stringify({
//	         ParamName1: 'data.daytime',
//	         ParamName2: 'data.bmi'
//	     })
	    });  
function column(nameArray,numberArray) {
var options =  {
		 chart:{
	            type:'column',
	            zoomType:'x'
	        },
	        tooltip:{
	            animation:false,
	            backgroundColor: '#333333',
	            borderColor:'red',
	            borderRadius:'20',
	            style:{
	                color : '#ffffff'
	            }
	        },
	        credits:{
	            //enabled:false
	            text:'回健康首頁',
	            href:'https://www.youtube.com/',
	            position:{
	                align:'center'
	            },
	            style:{
	                fontSize:"15px",
	                color:"green"
	            }
	        },
	        title:{
	            text:'YOUR BMI'
	        },
	        yAxis:{
	            title:{
	                text:'BMI指數'
	            }
	        },
	        xAxis: { 
	        	categories:nameArray,
	            type:"datetime", 
	                labels: {
	                    format: '{value:%Y-%b-%e}'
	                  }
	        },
	        series:[{
	                   name: '您的bmi為:',
	                   data:numberArray
	               }]
	        };
Highcharts.chart('container', options); 
	    }

});



</script>


</head>
<body>


	<%@include file="../navigation1.jsp"%>
	<header style="padding-bottom: 100px; background-color: black;">
		<div></div>

	</header>


	<div id="container"
		style="margin-left: 200px; margin-top: 40px; height: 700px"></div>




	<script>
		// Accordion
		function myAccFunc() {
			var x = document.getElementById("demoAcc");
			if (x.className.indexOf("w3-show") == -1) {
				x.className += " w3-show";
			} else {
				x.className = x.className.replace(" w3-show", "");
			}
		}

		// Click on the "Jeans" link on page load to open the accordion for demo purposes
		document.getElementById("myBtn").click();

		// Open and close sidebar
		function w3_open() {
			document.getElementById("mySidebar").style.display = "block";
			document.getElementById("myOverlay").style.display = "block";
		}

		function w3_close() {
			document.getElementById("mySidebar").style.display = "none";
			document.getElementById("myOverlay").style.display = "none";
		}
	</script>
</body>
</html>