<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/images/favicon.ico" />
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css" />
<link
	href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700"
	rel="stylesheet" type="text/css" />
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet">
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath}/css/styles.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/styles1.css"
	rel="stylesheet" />
<!--Boostrap CDN-->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js"
	crossorigin="anonymous"></script>
<!-- Bootstrap core JS-->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="${pageContext.request.contextPath}/js/scripts.js"></script>
<script type="text/javascript"
	src="<c:url value='/webjars/jquery/3.6.0/jquery.js'/>"></script>
<!-- 圖表的 -->
<script src="https://code.highcharts.com/highcharts.js"></script>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/memberCenter.css">


<title>會員圖表專區</title>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', () => {
	
	let showimg = document.getElementById("showimg");
	//以mbid
	var xhr2 = new XMLHttpRequest();
	let url = "<c:url value='/memberManagement/' />" + "${mbid}";
	xhr2.open("GET", url);
	xhr2.send();
	xhr2.onreadystatechange = function() {
		if (xhr2.readyState == 4 && xhr2.status == 200) {
			//console.log(xhr.responseText);
		}
		var imageURL = "<c:url value='/getImage' />";
		showimg.src = imageURL + "?mbid=" + "${mbid}";
		showimg.style="";
	}
	
	let idfrom = "${mbid}";
	console.log(idfrom);
	var printing = document.getElementById("printing");
	var printing1 = document.getElementById("printing1");
	
	printing2();
    var printing3 = document.getElementById("printing2");
    printing3.addEventListener('click', printing2);
	//bmi
printing.onclick = function  () {
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
// 	            type:'column',
// 	            zoomType:'x'
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
	            enabled:false
	        },
	        title:{
	            text:'your BMI'
	        },
	        yAxis:{
	            title:{
	                text:'BMI指數'
	            }
	        },
	        xAxis: { 
	        	
	        	categories:nameArray,
	        	type:"datetime", 
// 	        	tickInterval: 10*24 * 3600 * 1000,
	        	dateTimeLabelFormats: {
	                minTickInterval: 24 * 3600 * 1000,
	                millisecond: '%Y-%b-%e'
	  },
	                labels: {
	                    format: '{value:%Y-%b-%e}'
	                  },
	        },
	        rangeSelector: {
	            enabled: false
	        },
	        series:[{
	                   name: '您的bmi值',
	                   data:numberArray
	               }]
	        };
	        Highcharts.chart('container', options); 
	    };
	    	
}
printing1.onclick = function  () {
	    //bmr
	    let url1 = "<c:url value='/healthCenter/bmr/'  />" + idfrom;
	    $.ajax({  
	        url: url1,  
	        type: 'GET',
	        async: true,
	        dataType: "json",
	        success: function(data) {
	        	var json = eval(data);
	        	console.log(json);
	        	var nameArray = new Array();
				var numberArray = new Array();
				console.log(data[0].bmr);
	        	for(var i in data){
	        		 nameArray[i]=data[i].daytime;
	        		 numberArray[i]=data[i].bmr;
	        	}
	        	column1(nameArray,numberArray);
// 	         	options.series.setData(nameArray);
// 	         	options.series.setData(numberArray);
	        	
// 	         	Highcharts.chart('container', options);       
	       },
	       error:function(data){
	    	   alert('fail');
	       } 

	    });  
function column1(nameArray,numberArray) {
var options1 =  {
		 chart:{   
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
	            enabled:false
// 	            text:'回健康首頁',
// 	            href:'https://www.youtube.com/',
// 	            position:{
// 	                align:'center'
// 	            },
// 	            style:{
// 	                fontSize:"15px",
// 	                color:"green"
// 	            }
	        },
	        title:{
	            text:'your BMR'
	        },
	        yAxis:{
	            title:{
	                text:'BMR指數'
	            }
	        },
	        xAxis: { 
	        	categories:nameArray,
	        	range: 1 * 30 * 24 * 3600 * 1000 ,
	            type:"datetime", 
	                labels: {
	                    format: '{value:%Y-%b-%e}'
	                  }
	        },
	        rangeSelector: {
	            enabled: false
	        },
	        series:[{
	                   name: '您的bmr值',
	                   data:numberArray
	               }]
	        };
Highcharts.chart('container', options1); 
	    };
}
 function printing2 () {

	    //kg
	    let url2 = "<c:url value='/healthCenter/kg/'  />" + idfrom;
	    $.ajax({  
	        url: url2,  
	        type: 'GET',
	        async: true,
	        dataType: "json",
	        success: function(data) {
	        	var json = eval(data);
	        	console.log(json);
	        	var nameArray = new Array();
				var numberArray = new Array();
				console.log("data[0].kg="+data[0].kg);
				console.log("aa ="+"${aa}" );
			
				let kg0 = 0; 
				let kgfinal =0 ;
	        	for(var i in data){
	        		 nameArray[i]=data[i].daytime;
	        		 numberArray[i]=data[i].kg;
// 	        		 let kgValue = document.getElementById("kg")
// 	        		 kgValue.value = data[i].kg+"kg";
	        		 $('#kg').html(data[i].kg+" kg");
	        		 kg0 = data[0].kg;
	        		 kgfinal = data[i].kg;
	        		 $('#checkfrom').html(data[i].checkfrom+" days");
	        	}
	        	
	        	let kg1 = kg0-kgfinal;
	        	console.log(kg1);
	        	if (kg1>0){
	        		let b = Math.abs(kg1)
	        		$('#kg1').html("少 "+b+" kg");
	        	}else if (kg1<0){
	        		let b = Math.abs(kg1);
	        		$('#kg1').html("加 "+b+" kg");
	        	}else{
	        		$('#kg1').html("0kg");
	        	}
	        	column3(nameArray,numberArray);
// 	         	options.series.setData(nameArray);
// 	         	options.series.setData(numberArray);
	        	
// 	         	Highcharts.chart('container', options);       
	       },
	       error:function(data){
	    	   alert('fail');
	       } 

	    });  
function column3(nameArray,numberArray) {
var options3 =  {
		 chart:{   
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
	            enabled:false
// 	            text:'回健康首頁',
// 	            href:'https://www.youtube.com/',
// 	            position:{
// 	                align:'center'
// 	            },
// 	            style:{
// 	                fontSize:"15px",
// 	                color:"green"
// 	            }
	        },
	        title:{
	            text:'your kg'
	        },
	        yAxis:{
	            title:{
	                text:'kg'
	            }
	        },
	        xAxis: { 
	        	categories:nameArray,
	        	range: 1 * 30 * 24 * 3600 * 1000 ,
	            type:"datetime", 
	                labels: {
	                    format: '{value:%Y-%b-%e}'
	                  }
	        },
	        rangeSelector: {
	            enabled: false
	        },
	        series:[{
	                   name: '您的kg值',
	                   data:numberArray
	               }]
	        };
         Highcharts.chart('container', options3); 
	    };
	     
}    

  
	    
});





</script>
</head>
<body>
	<%@include file="../../../navigation.jsp"%>

	<!-- Navigation-->
	<div class="navbg"></div>
	<!--content 請將以下div刪除改成自己的內容-->
	<div class="mainContent">
		<!-- 側邊欄 -->
		<div class="sideNav">
			<div class="memberImgBox">
				<img style="display: none;"
					src="${pageContext.request.contextPath}/images/member_0.png"
					id="showimg" alt="memberPhoto" class="memberImg">
			</div>
			<div class="memberHelloBox">
				<span class="hello_text">Hello！${user}</span>
			</div>
			<div class="line"></div>
			<div class="linkBox"></div>
			<a href="<c:url value='/memberCenter_editInfo'/>" class="link"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-01.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">會員資料</span>
			</a> <a href="<c:url value='/addMemberForm' />" class="link link_here">
				<img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-02.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">健康紀錄</span>
			</a> <a href="<c:url value='/articleCenter_editInfo'/>" class="link">
				<img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-03.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">文章收藏</span>
			</a> <a href="<c:url value='/findAllShoppingCartItem'/>" class="link">
				<img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-04.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">購物車</span>
			</a> <a href="<c:url value='/orderManagementByUser'/>" class="link">
				<img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-05.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">訂單查詢</span>
			</a> <a href="<c:url value='/consultion/listPage/${mbid}'/>" class="link">
				<img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-06.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">預約諮詢</span>
			</a>
		</div>


		<!-- 內容區塊 -->
		<div class="ContentBox">

			<div class="switchBtnBox">
				<a href="<c:url value='/addMemberForm' />" class="switchBtn "> <span
					class="switchText"> 基本資料 </span>
				</a> <a href="<c:url value='/healthCentercheck'  />"
					class="switchBtn info_here"> <span class="switchText">bmi&bmr </span>
				</a> <a href="<c:url value="/healthCenter/record2/"/>" class="switchBtn">
					<span class="switchText"> 每日飲食</span>
				</a> <a href="<c:url value='/healthCenter/foods' />" class="switchBtn">
					<span class="switchText"> findfood</span>
				</a> <a href="<c:url value='/healthCenter/consume/' />"
					class="switchBtn"> <span class="switchText"> 消耗卡路里</span>
				</a>

			</div>
			<div class="InfoBox">
				<div class="w3-row-padding w3-margin-bottom"
					style="margin-left: 20px; margin-top: 10px;">
					<div class="w3-quarter">
						<!-- 						     w3-text-white讓字變白 -->
						<div class="w3-container w3-silver  w3-padding-16">
							<div class="w3-left">
								<i class="fa fa-user w3-xxxlarge"></i>
							</div>
							<div class="w3-right">
								<div id='kg'
									style="padding-top: 10px; width:80px ;height: 80px; font-size: 20px; font-family: fantasy"></div>
							</div>
							<div class="w3-clear"></div>
							<h4>您目前的kg</h4>
						</div>
					</div>
					<div class="w3-quarter" style="margin-left: 50px;">
						<!-- 						     w3-text-white讓字變白 -->
						<div class="w3-container w3-silver w3-padding-16">
							<div class="w3-left">
								<i class="fa fa-user w3-xxxlarge"></i>
							</div>
							<div class="w3-right">
								<div id='kg1'
									style="padding-top: 10px; width:80px ;height: 80px; font-size: 20px; font-family: fantasy"></div>
							</div>
							<div class="w3-clear"></div>
							<h4>您比最初</h4>
						</div>
					</div>

					<div class="w3-quarter" style="margin-left: 50px;">
						<div class="w3-container w3-silver  w3-padding-16">
							<div class="w3-left">
								<i class="fa fa-folder  w3-xxxlarge"></i>
							</div>
							<div class="w3-right">
								<div id='checkfrom'
									style="padding-top: 10px;height: 80px; font-size: 20px; font-family: fantasy;"></div>
							</div>
							<div class="w3-clear"></div>
							<h4>累積簽到數</h4>
						</div>
					</div>
				</div>

				<div>
					<a id='printing' style="margin-left: 50px;"><img
						src="${pageContext.request.contextPath}/images/forHealth/bmisee.jpg"
						style="height: 100px; width: 110px" /></a> <a id='printing1'
						style="margin-left: 130px;"><img
						src="${pageContext.request.contextPath}/images/forHealth/bmrsee.jpg"
						style="height: 100px; width: 110px" /></a> <a id='printing2'
						style="margin-left: 130px;"><img
						src="${pageContext.request.contextPath}/images/forHealth/Pilates-pana.png"
						style="height: 100px; width: 100px" /></a>
				</div>
				<div id="container" style="height: 400px; width: 720px"></div>

				<!-- 	<br> -->
				<!-- 	<div id="container1" -->
				<!-- 		style="margin-left:  350px;  height: 500px"></div> -->
				<!--     <br> -->

				<!-- 	<div id="container2" -->
				<!-- 		style="margin-left: 350px;  height: 600px;"></div> -->


			</div>

		</div>
	</div>
</body>
</html>