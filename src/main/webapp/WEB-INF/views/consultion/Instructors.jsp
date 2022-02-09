<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>健康運動整合平台|講師資訊</title>
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
<!-- <link rel="stylesheet" href="path/to/bootstrap/css/bootstrap.min.css"> -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/fontawesome.min.css">
<!-- DateTimepicker -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.min.css" rel="external nofollow" >
<script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.zh-CN.js"></script>


<script>
window.onload = function(){
	let dataArea = document.getElementById("dataArea");
	findAll();
	let sendData =document.getElementById("sendData");
// 	sendData.addEventListener('click', checkAndSendData);
}
function findAll(){
	let xhr = new XMLHttpRequest();
	xhr.open("GET","<c:url value='/consultion/findAll'/>",true);
	xhr.send();
	xhr.onreadystatechange = function(){
		if (xhr.readyState == 4 && xhr.status == 200){
			dataArea.innerHTML = processInstructorData(xhr.responseText);
		}
		
	}
}
function processInstructorData(jsonString){
	let instructors= JSON.parse(jsonString);
	var imageURL = "<c:url value='/consultion/getCoverImage' />";
	let segment = "<table class='table table-hover'>";
	
	for(let n =0; n<instructors.length;n++){
		let instructor = instructors[n];
		
		segment+="<tr>";
		let link = "<a href='" + "<c:url value='/consultion/editInstructorForm' />?instructorId=" + instructor.instructorId + "'>" + instructor.instructorId + "</a>";
		let aprovLinkId ="approvedlink"+instructor.instructorId;
		let approvedlink ="<button id='"+aprovLinkId+"'class='btn btn-success btn-sm' onclick=statuschange("+instructor.instructorId+","+"'已審核') >審核通過</button> ";
		if(instructor.insStatus==='已審核'){
			approvedlink="<button id='"+aprovLinkId+
			"'class='btn btn-success btn-sm' style='border: 1px solid #999999;background-color: #cccccc; color: #666666;'onclick=statuschange("+instructor.instructorId+","+"'黑名單')>取消資格</button> ";
		}
		let deletelink ="<i class='fas fa-trash-alt' onclick=Deletedata("+instructor.instructorId+")></i>"

		segment +="<td>"+link+"</td>";
		segment +="<td>"+instructor.instructorName+"</td>";
		segment +="<td>"+instructor.memberId+"</td>";
		segment +="<td>"+instructor.type+"</td>";
// 		segment +="<td>"+instructor.brief+"</td>";
// 		segment +="<td>"+instructor.experience1+"<br>"+instructor.experience2+"</td>";
		segment +="<td>"+instructor.speciality1+"<br>"+instructor.speciality2+"</td>";
// 		segment +="<td>"+instructor.certification1+"<br>"+instructor.certification2+"</td>";
		picURL=imageURL + "?instructorId="  +  instructor.instructorId;
		segment +="<td><img id='ins"+instructor.instructorId+"' width='40' height='48' "+ " src='"+picURL+"'></td>"
		segment +="<td>"+instructor.insStatus+"</td>";
		segment +="<td><div>"+approvedlink+"</div></td>";
		segment +="<td>"+deletelink+"</td>";
		segment +="</tr>";
	}
	return segment;
}
function statuschange(insId, newStatus){
	var instructor = {
			"instructorId": insId,
			"insStatus": newStatus,
	}
	jsonInstructor = JSON.stringify(instructor);
	let xhr3 = new XMLHttpRequest();
	url="<c:url value='/consultion/updateStatus'/>";
	
	xhr3.open("PUT",url,true);
	xhr3.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
	xhr3.send(jsonInstructor);
	xhr3.onreadystatechange = function(){
		if (xhr3.readyState == 4 && xhr3.status == 200){
			let delresult =JSON.parse(xhr3.responseText);
			if (delresult.fail) {
		 		alert(delresult.fail);
	  		}else if (delresult.success) {
	  			alert(delresult.success);
	  		}
			findAll();
		}
	}
}
function Deletedata(deId){
	if(confirm("請問是否確定刪除?")){
		let xhr2 = new XMLHttpRequest();
		url="<c:url value='/consultion/delete'/>?instructorId="+deId;
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

// function checkAndSendData(){
// 	let instructorId=document.getElementById("instructorId").value;
// 	let startTime=$("#startTime").val();
// 	let duration=$("#duration").val();
// 	let eStartTime=startTime.substring(0,startTime.lastIndexOf(":"))+":00";
// // 	let eEndTime=endTime.substring(0,endTime.lastIndexOf(":"))+":00";
// 	console.log("instructorName"+instructorId);
// 	console.log("eStartTime"+eStartTime);
// 	console.log("duration"+duration);
	
// 	var insSchedule = {
// 			"instructorId": instructorId,
// 			"startTime": eStartTime,
// 			"duration": duration
// 	}
// 	jsonInsSchedule = JSON.stringify(insSchedule);
// 	var xhr = new XMLHttpRequest();
// 	xhr.open("POST","<c:url value='/consultion/addSchedule'/>", true);
// 	xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
// 	xhr.send(jsonInsSchedule);
// 	xhr.onreadystatechange = function (){
// 		if(xhr.readyState == 4 && xhr.status == 200 ){
// 			let result=JSON.parse(xhr.responseText);
// 			if(result.success){
// 				alert(result.success);
// 			}else{
// 				alert(fail);
// 			}
// 		}
// 	}	
// }

</script>
</head>
<body>
	 <div class="d-flex" id="wrapper">
	  <%@include file="../mgsidebar.jsp"%>
            <!-- Page content wrapper-->
            <div id="page-content-wrapper"  style="background-color: 	#F0F0F0;">
            <%@include file="../mgnavigation.jsp"%>
                <!-- Page content-->
                
                <div class="container-fluid" >
<!--                  <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#myModal">新增可諮詢時段</button> -->
					<a style='color:#555;margin-left:850px;margin-bottom:0'href="<c:url value='/consultion/addInstructorTypePage'/>"><i class="fas fa-table me-1"></i>講師類別列表</a>
					<div class="container" style="margin-top:10px;">
 						<div class="card mb-4" >
  							<div class="card-header" style="background-color:#FFED97;text-align:center">
								<a style='color:#555;'href="<c:url value='/consultion/allinstructors'/>"><i class="fas fa-table me-1"></i>講師列表</a>
								<a href="<c:url value='/consultion/addInstructorForm'/>"><i class="fas fa-user-plus"></i></a>
    						</div>
    					<div class="card-body">
       						  <table class="table table-hover">
    								<thead>
     									<tr>
       									 	<th>編號</th>
        									<th>講師姓名</th>
        									<th>會員編號</th>
        									<th>類別</th>
<!--         									<th>簡介</th> -->
<!--         									<th>經歷</th> -->
        									<th>專業領域</th>
<!--         									<th>證照</th> -->
        									<th>照片</th>
        									<th>狀態</th>
        									<th>審核</th>
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
        
 <!-- The Modal --> 
<!--   <div class="modal" id="myModal" > -->
<!--     <div class="modal-dialog"> -->
<!--       <div class="modal-content" > -->
      
<!--         Modal Header -->
<!--         <div class="modal-header"> -->
<!--           <h4 class="modal-title">新增講師可諮詢時段</h4> -->
<!--           <button type="button" class="close manuallyclose" id="xClose"data-dismiss="modal">&times;</button> -->
          
        
<!--         </div> -->
        
<!--         Modal body -->
<!--         <div class="modal-body"> -->
<!--        		 <div class="form-group"> -->
<!--   				<label for="instructorId">講師編號</label> -->
<!--   				<input  id="instructorId"  style='background-color:#FFF8D7;' name="instructorId" type="text" class="form-control" > -->
<!-- 				<span id='result1c' style="height: 10px;"></span> -->
<!-- 			</div> -->
<!-- 			<div class="form-group"> -->
<!-- 				<label for="startTime" >諮詢開始時段</label> -->
<!--   				<div style=''class="input-group date form_datetime " data-date="1979-09-16T05:25:07Z" data-date-format="dd MM yyyy - HH:ii p" data-link-field="startTime"> -->
                   	
<!--                    	<input style='border-radius:4px;background-color:#FFF8D7'class="form-control" size="16" type="text" value="" readonly placeholder="請選擇"> -->
<!--                   	<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span> -->
<!-- 					<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span> -->
<!--                	</div> -->
<!-- 				<input type="hidden" id="startTime" value="" /><br/> -->
<!-- 			</div> -->
<!--              <div class="form-group"> -->
<!--   				<label for="duration">時數</label> -->
<!--   					<select  id="duration" style='background-color:#FFF8D7;' class="form-control" aria-label="Default select example"> -->
<!--   						<option selected>請選擇</option> -->
<!--   						<option >1</option> -->
<!--   						<option >2</option> -->
<!--   						<option >3</option> -->
<!--   						<option >4</option> -->
<!-- 					</select> -->
<!-- 					<span id='result2c' style="height: 10px;"></span> -->
<!-- 			</div> -->
			
<!--         </div> -->
        
<!--         Modal footer -->
<!--         <div class="modal-footer"> -->
<!--        	 <a id="sendData" type="button" class="btn btn-success" data-dismiss="modal" >確定</a> -->
<!--        	 <span id='resultMsg' style="height: 18px; font-weight: bold;"></span> -->
<!--           <button type="button" class="manuallyclose btn btn-danger" id="cancleClose" data-dismiss="modal">取消</button> -->
<!--         </div> -->
        
<!--       </div> -->
<!--     </div> -->
<!--   </div>        -->
  <script type="text/javascript">
    $('.form_datetime').datetimepicker({
        language:  'zh-CN',
        format:'mm月dd日 - P h:ii',
        pickerPosition:'bottom-left',
		autoclose: 1,
		todayHighlight: 1,
		forceParse: 0,
        showMeridian: 1,
        startDate:new Date(),
        minuteStep:60,
        hoursDisabled: '0,1,2,3,4,5,6,22,23'
        
    });
	
</script>        
</body>
</html>