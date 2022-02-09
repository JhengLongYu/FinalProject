<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>food record</title>
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


<link href="${pageContext.request.contextPath}/css/styles.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/styles1.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&display=swap"
	rel="stylesheet">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/memberCenter.css">

<link rel="stylesheet" media="screen"
	href="${pageContext.request.contextPath}/css/health/assetssass.css" />
<link rel="stylesheet" media="all"
	href="${pageContext.request.contextPath}/css/health/awesome.css" />

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>



<script type="text/javascript">
	var foodlist123 = "";
	var be = "";
	var complete_day = "";
	window.onload = function() {
		foodlist123 = document.getElementById("foodlist123");
		if (!"${today1}") {
			window.location.href = "<c:url value='/healthCenter/record5588/' />"
					+ "${mbid}";
		}
		var foodlists = "${foodlist}";

		foodlist123.innerHTML = foodlist123s();

		

		let mbid = "${mbid}";
		console.log("mbid =" + mbid);
		console.log("today = " + "${today}");
		console.log("today1 =" + "${today1}");	
		console.log("week =" + "${week}");
		
		calorie2 = 2000-calorie1;
		carbohydrates2=150-carbohydrates1;
		fat2 = 30-fat1 ;
		protein2 =100-protein1;
		console.log("calorie2 =" + calorie2);
		console.log("carbohydrates2 =" + carbohydrates2 );
		console.log(" fat2 =" +  fat2 );
		console.log("protein2 =" + protein2);
		be = document.getElementById("be");
		complete_day = document.getElementById("complete_day");
		be.onclick = function (){
			if (calorie2 > 0){
				complete_day.innerHTML = "<span style='font-size: large;margin-right:300px;'>今天成功瞜</span><br><img style='margin-right:300px;width:600px;height:600px;' src='${pageContext.request.contextPath}/images/forHealth/forfood/Achievement-bro.png'>";
				
			}  else {
				complete_day.innerHTML = "<span style='font-size: large;margin-right:300px;'>稍稍失敗搂</span><br><img style='margin-right:300px;width:600px;height:600px;' src='${pageContext.request.contextPath}/images/forHealth/forfood/Feeling Blue-bro.png'>";
			}
		}
		
		let showimg = document.getElementById("showimg");
		//以mbid
		var xhr5 = new XMLHttpRequest();
		let url = "<c:url value='/memberManagement/' />" + "${mbid}";
		xhr5.open("GET", url);
		xhr5.send();
		xhr5.onreadystatechange = function() {
			if (xhr5.readyState == 4 && xhr5.status == 200) {
				//console.log(xhr.responseText);
			}
			var imageURL = "<c:url value='/getImage' />";
			showimg.src = imageURL + "?mbid=" + "${mbid}";
			showimg.style="";
		}
		
	}
	
	function remove(pkk) {
		var result = "";
		let url = "<c:url value='/healthCenter/food/recordc/remove/' />?pk="
				+ pkk;
		console.log(url);
		let xhr = new XMLHttpRequest();
		xhr.open("GET", url);
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
			myrefresh();	
			}
	}
}		
	
	function myrefresh()
	{
	window.location.reload();
	}
	
	var calorie1 = 0 ; 
	var carbohydrates1 = 0;
	var fat1 = 0 ;
	var protein1 = 0 ;
	var calorie2 = 0 ; 
	var carbohydrates2 = 0;
	var fat2 = 0 ;
	var protein2 = 0 ;
	function foodlist123s() {

		let segment = "<table class='table0' id='diary-table' style='font-size: 15px;'>";

		segment += "<colgroup>";
		segment += "<col class='col-1' />";
		segment += "<col class='col-2' />";
		segment += "<col class='col-2' />";
		segment += "<col class='col-2' />";
		segment += "<col class='col-2' />";
		segment += "<col class='col-2' />";
		segment += "<col class='col-2' />";
		segment += "<col class='col-8' />";
		segment += "</colgroup>";

		segment += "<tbody>";
		segment += "<tr class='meal_header'>";
		segment += "<td class='first alt'  >每日</td>";
		segment += "<td class='alt nutrient-column' style='width: 45px;'>量<div class='subtitle'>g</div></td>";
		segment += "<td class='alt nutrient-column' style='width: 45px;'>卡路里<div class='subtitle'>kcal</div></td>";
		segment += "<td class='alt nutrient-column' style='width: 45px;'>碳水化<div class='subtitle'>g</div></td>";

		segment += "<td class='alt nutrient-column' style='width: 45px;'>脂肪<div class='subtitle'>g</div></td>";
		segment += "<td class='alt nutrient-column' style='width: 45px;'>蛋白質<div class='subtitle'>g</div></td>";

		segment += "</tr>";

		<c:forEach var='food' items='${foodlist}'>
		calorie1 += ${food.calorie};
		carbohydrates1+=${food.carbohydrates};
		fat1 += ${food.fat} ;
		protein1 +=${food.protein};
		
		segment += "<tr>";
		segment += "<td class='first alt'>";
		segment += "<a class='js-show-edit-food' data-food-entry-id='9201578805' data-locale='zh-TW' href='#'>"
				+ "${food.category}  - ${food.name}  </a></td>";
		segment += "<td> ${food.weight} </td>";
		segment += "<td> ${food.calorie} </td>";
		segment += "<td>" + "<span class='macro-value'>"
				+ "${food.carbohydrates} </span></td>";
		segment += "<td>" + "<span class='macro-value'> ${food.fat}"
				+ "</span></td>";
		segment += "<td>" + "<span class='macro-value'> ${food.protein}"
				+ "</span></td>";
		segment += "<td class='delete'>";
		segment += "<a onclick='remove(${food.pkk})'>";
		segment += "<i class='icon-minus-sign'></i></a></td>"
		segment += "</td>";
		segment += "</tr>";

		</c:forEach>
        
		segment += "</tbody></table>";
		segment += "<table style='width: 700px;  margin-top: 50px;font-size: 12px;'>";
		segment += "<tbody style='border:1px solid white;'>";
		
		segment +=  "<tr class='total' style='width: 50px; border-bottom: 1px solid white;background-color:rgba(255, 209, 5, 0.1);'>";
		segment +=	"<th style='border-right: 1px solid white;'>每日比較</th>";
		segment +=	"<th style='border-right: 1px solid white;'>卡路里kcal</th>";
		segment +=	"<th style='border-right: 1px solid white;'>碳水化合物g</th>";
		segment +=	"<th style='border-right: 1px solid white;'>脂肪g</th>";
		segment +=	"<th >蛋白質g</th>";
		segment +=  "</tr>";
		segment +="<tr class='total' style='width: 50px;background-color:rgba(255, 209, 5, 0.1);'>";
		segment +="<td class='first' style='border:1px solid white ;'>總計</td>";
		segment +="<td style='border-right: 1px solid white;'>"+ calorie1 +"</td>";
		segment +="<td style='border-right: 1px solid white;'><span class='macro-value'>"+ carbohydrates1 +"</span></td>";
		segment +="<td style='border-right: 1px solid white;'><span class='macro-value'>"+ fat1 +"</span></td>";
		segment +="<td><span class='macro-value'>"+ protein1+"</span></td>";
		segment +="<td class='empty'></td>";
		segment +="</tr>";
		
		segment +="<tr class='total alt' style='background-color:rgba(255, 209, 5, 0.1);'>";
		segment +="<td class='first ' style='border:1px solid white ;'>您的每日目標</td>";
		segment +="<td style='border-right:1px solid white;'>2000</td>";
		segment +="<td style='border-right:1px solid white;'><span class='macro-value'>150</span></td>";
		segment +="<td style='border-right:1px solid white;'><span class='macro-value'>30</span></td>";
		segment +="<td ><span class='macro-value'>100</span></td>";
		segment +="<td class='empty'></td>";
		segment +="</tr>";
		
		segment +="<tr class='total remaining'style='background-color:rgba(255, 209, 5, 0.1);'>";
		segment +="<td class='first' style='border:1px solid white;'>還剩</td>";
		segment +="<td class='positive' style='border-right: 1px solid white;'>"+(2000-calorie1) +"</td>";
		segment +="<td class='positive' style='border-right: 1px solid white;'><span class='macro-value'>"+(150-carbohydrates1) +"</span></td>";
		segment +="<td class='positive' style='border-right: 1px solid white;'><span class='macro-value'>"+(30-fat1) +"</span></td>";
		segment +="<td class='positive' ><span class='macro-value'>"+(100-protein1) +"</span></td>";
		segment +="<td class='empty'></td>";
		segment +="</tr>";
	    
		segment += "</tbody></table>";

		segment += "<div id='complete_day' style='margin-right:500px;'>";
		segment += "<span class='day_incomplete_message'  >";
		segment += "<a id='be' class='button complete-this-day-button' style='margin-right:235px;' >完成此輸入項目</a>";
		segment += "</span></div>";

		return segment;
	}
	
</script>
<style type="text/css">
.fancybox-ie6 #fancybox-bg-w, .fancybox-ie6 #fancybox-bg-e,
	.fancybox-ie6 #fancybox-left, .fancybox-ie6 #fancybox-right,
	#fancybox-hide-sel-frame {
	height: expression(this.parentNode.clientHeight + "px");
}

/* line 7833, /home/app/app/assets/stylesheets/sass/style.scss */
#fancybox-loading.fancybox-ie6 {
	position: absolute;
	margin-top: 0;
	top: expression(( -20 + ( document.documentElement.clientHeight ?  
		 document.documentElement.clientHeight/ 2 :  
		 document.body.clientHeight/ 2)+ ( ignoreMe= document.documentElement.scrollTop?
		
		
		 document.documentElement.scrollTop:
		 document.body.scrollTop))+ 'px');
}

#mainNav {
	height: 110px;
	background-color: #212529;
}
</style>
</head>
<body style="padding-bottom: 0px;">
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
				</a> <a href="<c:url value='/healthCentercheck'  />" class="switchBtn">
					<span class="switchText"> bmi&bmr </span>
				</a> <a href="<c:url value="/healthCenter/record2/"/>"
					class="switchBtn info_here"> <span class="switchText">每日飲食</span>
				</a> <a href="<c:url value='/healthCenter/foods' />" class="switchBtn">
					<span class="switchText"> findfood</span>
				</a> <a href="<c:url value='/healthCenter/consume/' />"
					class="switchBtn"> <span class="switchText"> 消耗卡路里</span>
				</a>

			</div>
			<div class="InfoBox">
				<div class="diary" style="width: 700px;text-align: center;">
					<h1>您的食品日記 :</h1>
					<div id="date_controls">
						<form class="date-controls-form" accept-charset="UTF-8"
							method="get">
							<input name="utf8" type="hidden" value="&#x2713;" /><input
								type="hidden" name="authenticity_token"
								value="t++7nyTS3Qm9L8jqVVC+Q78Ox8VcYxZJ+IpGlo1S20p1nCNVgCXcCIyz17x2bcfwh7lQJWodQF/bkcUo6r6pXA==" />
							<span class="date"> <a class="prev"
								href="<c:url value="/healthCenter/recordc"/>?date=${yesterday}&mbid=${mbid}">
									<i class="icon-caret-left"></i>
							</a> <c:choose>
									<c:when test="${ week =='MONDAY'}">
										<time>${today1}星期一</time>
									</c:when>
									<c:when test="${ week =='TUESDAY'}">
										<time>${today1}星期二</time>
									</c:when>
									<c:when test="${ week =='WEDNESDAY'}">
										<time>${today1}星期三</time>
									</c:when>
									<c:when test="${ week =='THURSDAY'}">
										<time>${today1}星期四</time>
									</c:when>
									<c:when test="${ week =='FRIDAY'}">
										<time>${today1}星期五</time>
									</c:when>
									<c:when test="${ week =='SATURDAY'}">
										<time>${today1}星期六</time>
									</c:when>
									<c:when test="${ week =='SUNDAY'}">
										<time>${today1}星期日</time>
									</c:when>
								</c:choose> <a class="next"
								href="<c:url value="/healthCenter/recordc"/>?date=${tomorrow}&mbid=${mbid}">
									<i class="icon-caret-right"></i>
							</a>
							</span> <input type="hidden" value="" name="hidden_date_selector"
								id="date_selector" /> <i class="icon-calendar"
								id="datepicker-trigger"></i>

							<script type="text/javascript">
								//<![CDATA[
								$("#today").datepicker(
										{
											showButtonPanel : true,
											currentText : "Today:"
													+ $.datepicker.formatDate(
															'MM dd, yy',
															new Date())
										});
								$(function() {

									$("#datepicker-trigger").click(function() {
										$("#date_selector").datepicker("show");
									});

									function change_diary_date(new_date) {

										var new_url = '<c:url value="/healthCenter/recordc"/>';
										new_url += (new_url.indexOf('?') == -1) ? '?'
												: '&';
										new_url += 'date=' + new_date
												+ "&mbid=${mbid}";
										location = new_url;
									}

									$("#datepicker-trigger").click(function() {
										$("#date_selector").datepicker("show");
									});
									$("#date_selector").datepicker(
											{
												defaultDate : $(
														"#date_selector").attr(
														"value"),
												dateFormat : 'yy-mm-dd',
												monthNames : [ "一月", "二月",
														"三月", "四月", "五月", "六月",
														"七月", "八月", "九月", "十月",
														"十一月", "十二月" ],
												dayNames : [ "星期日", "星期一",
														"星期二", "星期三", "星期四",
														"星期五", "星期六" ],
												dayNamesMin : [ "日", "一", "二",
														"三", "四", "五", "六" ],
												onSelect : change_diary_date,
												startDate : new Date()
											});
								});
								//]]>
							</script>

						</form>
					</div>
				</div>

				<div class="food_container container" id="foodlist123" align="left"></div>
				<!-- 				notes-v2 -->
			</div>
		</div>

	</div>

</body>
</html>