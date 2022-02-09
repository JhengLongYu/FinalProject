<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>健康運動整合平台 | 會員中心-諮詢明細</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/images/favicon.ico" />
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
<link href="${pageContext.request.contextPath}/css/consultion2.css"
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
<!--SB Forms JS-->
<!-- <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script> -->
<!-- 會員中心的樣式 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/memberCenter.css">

<script>
let mbId="${mbid}";
let insId="${insId}";
window.onload = function(){
	let dataArea = document.getElementById("dataArea");
	let comingRt = document.getElementById("comingRt");
	let rewardPointsArea=document.getElementById("rewardPointsArea");
	loadData();
	findAll();
	findcomingRt();
	findRewardPoints();
}
//個人圖片圖取
function loadData() {
	let xhr = new XMLHttpRequest();
	let url = "<c:url value='/memberManagement/' />" + mbId;
	xhr.open("GET", url);
	xhr.send();
	xhr.onreadystatechange = function() {
		let imageURL = "<c:url value='/getImage' />";
		showimg.src = imageURL + "?mbid=" + mbId;
		showimg.style ="";
	}
}
function findAll(){
		let xhr = new XMLHttpRequest();
		let url="<c:url value='/consultion/findbymbId/'/>"+mbId;
		xhr.open("GET",url,true);
		xhr.send();
		xhr.onreadystatechange = function(){
			if (xhr.readyState == 4 && xhr.status == 200){
				dataArea.innerHTML = processReservationData(xhr.responseText);
			}
		}

}

function processReservationData(jsonString){
	let reservations= JSON.parse(jsonString);
	console.log(reservations);
	let segment="";
	if(reservations.length>0){
		for(let n =0; n<reservations.length;n++){
			let reservation=reservations[n];
			let deletelink ="<i class='fas fa-trash-alt' onclick=deletedata("+reservation.reservationId+")></i>"
// 			let deletelink ="<a class='btn btn-danger' onclick=deletedata("+reservation.reservationId+") >刪除</a> ";
			segment+="<tr>";
			segment+="<td>"+reservation.reservationId+"</td>";
			segment+="<td>"+reservation.instructorName+"</td>";
			segment+="<td>"+reservation.consultTime+"</td>";
			segment+="<td>"+reservation.duration+"</td>";
			segment+="<td>"+reservation.status+"</td>";
			let conTime=new Date(reservation.consultTime);
			const datetime = new Date();
			if(conTime>datetime){
				segment+="<td>"+deletelink+"</td>";
			}else{
				segment+="<td></td>";
			}
			
			segment+="</tr>";	
		}
	}else{
		
		segment+="<tr> <td colspan='6'  align='center' valign='middle'>目前無任何諮詢</td></tr>";
	}
	
	return segment;
}
function findcomingRt(){
		let xhr1 = new XMLHttpRequest();
		let url="<c:url value='/consultion/findComingRt/'/>"+mbId;
		xhr1.open("GET",url,true);
		xhr1.send();
		xhr1.onreadystatechange = function(){
			if (xhr1.readyState == 4 && xhr1.status == 200){
				comingRt.innerHTML = comingRT(xhr1.responseText);
			}
		}
	
	
}
function comingRT(jsonString){
	let comingRts= JSON.parse(jsonString);
	let segment1="";
	if(comingRts.length>0){
		for(let i =0; i<comingRts.length;i++){
			let comingRt=comingRts[i];
			segment1+="<tr>";
			segment1+="<td>"+comingRt.reservationId+"</td>";
			segment1+="<td>"+comingRt.roomCode+"</td>";
			segment1+="<td>"+comingRt.instructorName+"</td>";
			
			segment1+="<td>"+comingRt.consultTime+"</td>";
			segment1+="<td>"+comingRt.duration+"</td>";
			segment1+="<td>"+comingRt.status+"</td>";
// 			let chatlink ="<a class='btn btn-danger' onclick=chatlink("+comingRt.reservationId+") >視訊</a> ";
			let chatlink ="<a href='https://healthchatroom.herokuapp.com/'><i class='fas fa-chalkboard-teacher fa-2x'></i></a>"
			
			segment1+="<td>"+chatlink+"</td>";
			segment1+="</tr>";	
	     
		}
	}else{
		
		segment1+="<tr> <td colspan='6'  align='center' valign='middle'>目前無一小時後即將開始的諮詢</td></tr>";
	}
	
	return segment1;
	
}

function deletedata(reservationId){
	if(confirm("請問是否確定刪除?")){
	let xhr2 = new XMLHttpRequest();
	let url2="<c:url value='/consultion/delete/'/>"+reservationId;
	xhr2.open("GET",url2,true);
	xhr2.send();
	xhr2.onreadystatechange = function(){
		if (xhr2.readyState == 4 && xhr2.status == 200){
			let delresult =JSON.parse(xhr2.responseText);
			if (delresult.fail) {
		 		alert("刪除失敗");
	  		}else {
	  			alert("刪除成功");
	  			let scheNo=delresult.scheduleNo;
	  			console.log("scheNo"+scheNo);
	  			let xhr4 = new XMLHttpRequest();
		 		xhr4.open("POST","<c:url value='/consultion/send'/>",true);
				var mailObj = {
					"mbId":mbId,
					"scheduleNo":scheNo,
					"action":'取消預約',
				}
				xhr4.setRequestHeader("Content-Type", "application/json"); 
				xhr4.send(JSON.stringify(mailObj));
				xhr4.onreadystatechange = function(){
					if (xhr4.readyState == 4 && xhr4.status == 200){
						let result4=JSON.parse(xhr4.responseText);
						if(result4.success){
							console.log(result4.success);
						}else{
							console.log(result4.fail);
						}
					}
				}
	  		}
			findAll();
		}
	}
	}else{
		return false;
	}
}

function findRewardPoints(){
	let xhr3 = new XMLHttpRequest();
	let url3="<c:url value='/consultion/rewardPointsFindbyMb/'/>"+mbId;
	xhr3.open("GET",url3,true);
	xhr3.send();
	xhr3.onreadystatechange = function(){
		if (xhr3.readyState == 4 && xhr3.status == 200){
			 let rewardPointsData=JSON.parse(xhr3.responseText);
			 rewardPointsArea.innerHTML = "諮詢點數: "+rewardPointsData.points;
		}
	}
}
</script>

</head>

<body id="page-top">
	<%@include file="../navigation.jsp"%>

	<!-- Navigation-->

	<div class="navbg"></div>
	<!--content 請將以下div刪除改成自己的內容-->
	<div class="mainContent">
		<!-- 側邊欄 -->
		<%@include file="../sidebar.jsp"%>

		<!-- 內容區塊 -->
		<div class="ContentBox">

			<div class="switchBtnBox">

				<a href="<c:url value='/consultion/listPage/${mbid}'/>"class="switchBtn info_here"> 
					<span class="switchText">諮詢明細 </span>
				</a>
				 <a href="<c:url value='/consultion/mbcalendar/${mbid}'/>"class="switchBtn"> 
				 <span class="switchText"> 諮詢月曆</span>
				
				  <a href="<c:url value='/consultion/mbfavoriteInsPage/${mbid}'/>"class="switchBtn"> 
				 <span class="switchText"> 最愛講師</span>
				</a>
				<c:if test="${insIdStatus}">
				 <a href="<c:url value='/consultion/InsListPage'/>"class="switchBtn"> 
				 <span class="switchText"> 被諮詢明細</span>
				</a>
				<a href="<c:url value='/consultion/InsSchedulePage'/>"class="switchBtn"> 
				 <span class="switchText"> 講師月曆</span>
				</a>
				</c:if>
			</div>

			<div class="InfoBox">
				<div id='rewardPointsArea'></div>
				<div style="margin-top:10px">
 					<div class="card mb-4" >
  						<div class="card-header" style="background-color:#FFDC35">
							<i class="fas fa-table me-1"></i>即將開始的諮詢
   						 </div>
    					<div class="card-body" style="background-color:#FFFF93">
        					 <table class="table table-hover">
    							<thead>
     								<tr>
       			 						<th>預約號碼</th>
       			 						<th>視訊代碼</th>
										<th>講師姓名</th>
        								<th>時段</th>
        								<th>時數</th>
        								<th>狀態</th>
        								<th>進入視訊</th>
      								</tr>
    							</thead>
    							<tbody id="comingRt">
    		 	
      
    							</tbody>
  							</table>
     					</div>
					 </div>
				</div>

				<div  style="margin-top:10px">
 					<div class="card mb-4">
  						<div class="card-header">
							<i class="fas fa-table me-1"></i>預約明細
    					</div>
   						 <div class="card-body">
       						  <table class="table table-hover">
    							<thead>
     								<tr>
       			 						<th>預約號碼</th>
										<th>講師姓名</th>
        								<th>時段</th>
        								<th>時數</th>
        								<th>狀態</th>
        								<th></th>
      								</tr>
    							</thead>
    							<tbody id="dataArea">
    		 	
      
    							</tbody>
  							</table>
     					</div>
					</div>
				</div>
			</div>
		</div>

	</div>




</body>

</html>