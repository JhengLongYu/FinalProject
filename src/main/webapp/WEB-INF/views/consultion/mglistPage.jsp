<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>健康運動整合平台|諮詢明細</title>
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico" />

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js" crossorigin="anonymous"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="<c:url value='/webjars/jquery/3.6.0/jquery.js'/>"></script>        
<link href="${pageContext.request.contextPath}/css/mgstyles.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/js/mgscripts.js"></script>
<link rel="stylesheet" href='<c:url value='/webjars/bootstrap/4.6.0/css/bootstrap.css'/>'/>
<link href="${pageContext.request.contextPath}/css/consultion2.css"
	rel="stylesheet" />
<script type="text/javascript" src="<c:url value='/webjars/bootstrap/4.6.0/js/bootstrap.bundle.js'/>"></script>
<script>
window.onload = function(){
	let dataArea = document.getElementById("dataArea");
	let comingRt = document.getElementById("comingRt");
	findAll();
	findcomingRt();
	
}
function findAll(){
	let xhr = new XMLHttpRequest();
	xhr.open("GET","<c:url value='/consultion/findAllReservations'/>",true);
	xhr.send();
	xhr.onreadystatechange = function(){
		if (xhr.readyState == 4 && xhr.status == 200){
			dataArea.innerHTML = processReservationData(xhr.responseText);
		}
		
	}
}
function processReservationData(jsonString){
	let reservations= JSON.parse(jsonString);
	let segment="";
	for(let n =0; n<reservations.length;n++){
		let reservation=reservations[n];
		segment+="<tr>";
		segment+="<td>"+reservation.reservationId+"</td>";
		segment+="<td>("+reservation.memberId+") "+reservation.mbname+"</td>";
		segment+="<td>("+reservation.instructorId+") "+reservation.instructorName+"</td>";
		segment+="<td>"+reservation.consultTime+"</td>";
		segment+="<td>"+reservation.duration+"</td>";
		segment+="<td>"+reservation.status+"</td>";
// 		let deletelink ="<a class='btn btn-danger' onclick=deletedata("+reservation.reservationId+") >刪除</a> ";
// 		let deletelink ="<i class='fas fa-trash-alt' onclick=deletedata("+reservation.reservationId+")></i>";
// 		let conTime=new Date(reservation.consultTime);
// 		const datetime = new Date();
// 		if(conTime>datetime){
// 			segment+="<td>"+deletelink+"</td>";
// 		}{
// 			segment+="<td></td>";
// 		}
		

		segment+="</tr>";	
		
     
	}
	return segment;
}
function findcomingRt(){
	let xhr1 = new XMLHttpRequest();
	let url="<c:url value='/consultion/findAllComingRt'/>";
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
	for(let i =0; i<comingRts.length;i++){
		let comingRt=comingRts[i];
		segment1+="<tr>";
		segment1+="<td>"+comingRt.reservationId+"</td>";
		segment1+="<td>"+comingRt.roomCode+"</td>";
// 		segment1+="<td>"+comingRt.memberId+"</td>";
		segment1+="<td>("+comingRt.memberId+") "+comingRt.mbname+"</td>";
		segment1+="<td>("+comingRt.instructorId+") "+comingRt.instructorName+"</td>";
// 		segment1+="<td>"+comingRt.instructorId+"</td>";
		segment1+="<td>"+comingRt.consultTime+"</td>";
		segment1+="<td>"+comingRt.duration+"</td>";
		segment1+="<td>"+comingRt.status+"</td>";
		let chatlink ="<a class='btn btn-danger' onclick=chatlink("+comingRt.reservationId+") >視訊</a> ";
		segment1+="<td>"+chatlink+"</td>";
		segment1+="</tr>";	
     
	}
	return segment1;
	
}
function deletedata(reservationId){
	if(confirm("請問是否確定刪除?")){
	let xhr2 = new XMLHttpRequest();
	let url="<c:url value='/consultion/delete/'/>"+reservationId;
	xhr2.open("GET",url,true);
	xhr2.send();
	xhr2.onreadystatechange = function(){
		if (xhr2.readyState == 4 && xhr2.status == 200){
			let delresult =JSON.parse(xhr2.responseText);
			if (delresult.fail) {
		 		alert("刪除失敗成功");
	  		}else if (delresult.success) {
	  			alert("刪除成功");
	  		}
			findAll();
		}
	}
	}else{
		return false;
	}
}
</script>
</head>
<body>
	 <div class="d-flex" id="wrapper">
	  <%@include file="../mgsidebar.jsp"%>
            <!-- Page content wrapper-->
            <div id="page-content-wrapper"  style="background-color: 	#F0F0F0;">
            <%@include file="../mgnavigation.jsp"%>
                <!-- Page content-->
					<div class="container" style="margin-top:10px">
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
       			 	<th>會員編號</th>
        			<th>講師姓名</th>
        			<th>時段</th>
        			<th>時數</th>
        			<th>狀態</th>
        			<th></th>
      			</tr>
    		</thead>
    		<tbody id="comingRt">
    		 	
      
    		</tbody>
  		</table>
     </div>
</div>
</div>
 <div class="container" style="margin-top:10px">
 <div class="card mb-4">
  	<div class="card-header">
		<i class="fas fa-table me-1"></i>預約明細
    </div>
    <div class="card-body">
         <table class="table table-hover">
    		<thead>
     			<tr>
       			 	<th>預約號碼</th>
       			 	<th>會員姓名</th>
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
        
        
        
</body>
</html>