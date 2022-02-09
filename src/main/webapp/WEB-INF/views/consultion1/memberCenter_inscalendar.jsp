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
<title>健康運動整合平台 | 會員中心</title>
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

<!--連結Full Calendar-->
<link href='${pageContext.request.contextPath}/css/main.css' rel='stylesheet' />
<script src='${pageContext.request.contextPath}/js/main.js'></script>

<!--轉換成中文-->
<script src="${pageContext.request.contextPath}/js/locales-all.js"></script>

<!--連結css-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/calendarstyleIns.css">
<!-- DateTimepicker -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.min.css" rel="external nofollow" >
<script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.zh-CN.js"></script>

<script>
let mbId="${mbid}";
let insId="${insId}";
let reservation;
let data={items: []};
let datechosen=null;
window.onload = function(){
	let showimg = document.getElementById("showimg");
	let dataArea = document.getElementById("dataArea");
	loadData();
	calendar();
	
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
function calendar() {
	
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
      initialView: 'dayGridMonth',
      fixedWeekCount: false,
      locale:'zh-tw',
      height:500,
      navLinks:true,
      editable: true,
      headerToolbar:{
          left:'prev,next today',
          center:'title',
          right:'dayGridMonth,timeGridWeek,timeGridDay'
      },
   dateClick: function(info) {//滑鼠點選日期區塊
	   var now = new Date();
	   now.setDate(now.getDate()-1);
	   var theDay = new Date(info.dateStr);
	   datechosen=info.dateStr;
	   if(theDay < now){
 			console.log('無法對今天以前的日期新增諮詢=>'+theDay);
 			return;
 		}else{
 			console.log('新增諮詢=>'+datechosen);
	   $('.form_datetime').datetimepicker({
		    startView:'day',
		  	maxView:'day',
	        language:  'zh-CN',
	        format:'mm月dd日 - P h:ii',
	        pickerPosition:'bottom-left',
			autoclose: 1,
			todayHighlight: 1,
			forceParse: 0,
	        showMeridian: 1,
	        startDate:new Date(datechosen),
	        minuteStep:60,
	        hoursDisabled: '0,1,2,3,4,5,6,22,23'
	        
	    });
	   $("#myModal2").modal("show");
 		$('#myModal2').on('click', 'button.manuallyclose',  function (eventObject) {
 			$('#myModal2').modal('hide');
		});
 		document.getElementById("instructorId").value=insId;
 		
 		let sendData = document.getElementById("sendData");
 		sendData.onclick=function(){
 			$('#myModal2').modal('hide');
 			checkAndSendData();
 			console.log(document.getElementById("instructorId").value);
 			console.log(document.getElementById("startTime").value);
 			console.log(document.getElementById("duration2").value);
 		}
 		}
   },
//       events:data,
      
      eventSources: [{
              url: "<c:url value='/consultion/alleventsbyinsId/'/>"+insId, 
              type: 'GET',
              data: {
                  start: 'start',
                  end: 'end',
                  title: 'title',
              },
              error: function () {
                  alert('there was an error while fetching events!');
              },
              color: 'yellow',
              textColor: 'black',
              dataType: 'json',
          }],
          
        	    
      	eventClick: function(info) {
      		var today = new Date();
      		if(info.event.start<today){
      			console.log('無法對過去的事件做動作=='+info.event.start);
      			return;
      		}else{
//       			console.log("++++++scheduleNo="+info.event.extendedProps.scheduleNo)
//       		console.log("info.event.title"+info.event.title);
      		let eventTitle=info.event.title;
      		let reservationId=info.event.extendedProps.reservationId;
      		let date = new Date( Date.parse(info.event.start) );
      		let date2 = new Date( Date.parse(info.event.end) );
      		var milliseconds = (date2 - date);
      		var hours = milliseconds / (60000*60);
      			let scheduleNo=info.event.extendedProps.scheduleNo;
//       		console.log("scheduleNo="+info.event.extendedProps.scheduleNo);
      			if(info.event.extendedProps.scheduleNo!=""){
          			$("#myModal3").modal("show");
              		$('#myModal3').on('click', 'button.manuallyclose',  function (eventObject) {
              			$('#myModal3').modal('hide');
              			
           		});
          		}else{
          			console.log('講師不可以取消預約scheduleNo=='+scheduleNo);
          			return;
          		}
      			document.getElementById("startTime3").value=date.getFullYear()+"年"+(date.getMonth()+1)+"月"+date.getDate()+"日"+date.getHours()+"時"+date.getMinutes()+"分";
      			document.getElementById("duration3").value=hours;
//       			console.log("eventTitle"+eventTitle);
      			
      			let deleteInsSchedulebtn = document.getElementById("deleteInsSchedule");
      			deleteInsSchedulebtn.onclick=function(){
        			$('#myModal3').modal('hide');
        			deleteInsSchedule(scheduleNo);
        		}
      		

// //       	calendar.changeView('timeGridDay', info.event.start);
//       		calendar.changeView('list', info.event.start);
      		}
//       		
    	},
    	eventDidMount: function(info,element) {
    		var dataHoje = new Date();
    		
//     		console.log("info.event.start"+info.event.start);
    		if (info.event.start < dataHoje) {
    			if (info.event.title==='已被預約時段') {
    		    	info.el.style.background = "#E1C4C4";
    		  	}else{
    			 	 info.el.style.background = "#BEBEBE";
    		  	}
    		}else{
    			if (info.event.title==='已被預約時段') {
    		    	info.el.style.background = "#FF8F59";
    		  	}else{
    			 	 info.el.style.background = "#9AFF02";
    		  	}
    		}
//     		element.find('.fc-event-title').append("<br/>" + info.event.extendedProps.instructor); 
//     		console.log(info.event.extendedProps.instructorId)
//     	    var tooltip = new Tooltip(info.el, {
//     	      title: info.event.extendedProps.instructor,
//     	      placement: 'top',
//     	      trigger: 'hover',
//     	      container: 'body'
//     	    });
    	  }
       	
    });
    
    
    calendar.setOption('height', 450);
    calendar.render();
  
}


function checkAndSendData(){
	let instructorIdforadd=document.getElementById("instructorId").value;
	let startTime=$("#startTime").val();
	let duration=$("#duration2").val();
	let eStartTime=startTime.substring(0,startTime.lastIndexOf(":"))+":00";
// 	let eEndTime=endTime.substring(0,endTime.lastIndexOf(":"))+":00";
	console.log("instructorName"+instructorIdforadd);
	console.log("eStartTime"+eStartTime);
	console.log("duration"+duration);
	
	var insSchedule = {
			"instructorId": instructorIdforadd,
			"startTime": eStartTime,
			"duration": duration
	}
	jsonInsSchedule = JSON.stringify(insSchedule);
	var xhr = new XMLHttpRequest();
	xhr.open("POST","<c:url value='/consultion/addSchedule'/>", true);
	xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
	xhr.send(jsonInsSchedule);
	xhr.onreadystatechange = function (){
		if(xhr.readyState == 4 && xhr.status == 200 ){
			let result=JSON.parse(xhr.responseText);
			if(result.success){
				alert(result.success);
			}else{
				alert(fail);
			}
			calendar();
		}
	}	
}

function deleteInsSchedule(scheNo){
	let xhr3 = new XMLHttpRequest();
	url3="<c:url value='/consultion/deleteSchedule/'/>"+scheNo;
	xhr3.open("GET",url3,true);
	xhr3.send();
	xhr3.onreadystatechange = function(){
		if (xhr3.readyState == 4 && xhr3.status == 200){
			let delresult3 =JSON.parse(xhr3.responseText);
			if (delresult3.fail) {
		 		alert("刪除失敗");
	  		}else if (delresult3.success) {
	  			alert(delresult3.success);
	  			
	  		}
			calendar();
			
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

				<a href="<c:url value='/consultion/listPage/${mbid}'/>"class="switchBtn "> 
					<span class="switchText">諮詢明細 </span>
				</a>
				 <a href="<c:url value='/consultion/mbcalendar/${mbid}'/>"class="switchBtn "> 
				 <span class="switchText"> 諮詢月曆</span>
				</a>
				<a href="<c:url value='/consultion/mbfavoriteInsPage/${mbid}'/>"class="switchBtn"> 
				 <span class="switchText"> 最愛講師</span>
				</a>
				<c:if test="${insIdStatus}">
				 <a href="<c:url value='/consultion/InsListPage'/>"class="switchBtn"> 
				 <span class="switchText"> 被諮詢明細</span>
				</a>
				<a href="<c:url value='/consultion/InsSchedulePage'/>"class="switchBtn info_here"> 
				 <span class="switchText"> 講師月曆</span>
				</a>
				</c:if>
			</div>

			<div class="InfoBox">
<!-- 				<div class="container-fluid" > -->
                  <div class="containercalendaer" >
       				 <div id='calendar'></div>
       				 <div id="dataArea"></div>
<!--       			  </div> -->
                </div>
			</div>
		</div>

	</div>



  
  <!-- The Modal 2-->
  <div class="modal" id="myModal2" >
    <div class="modal-dialog">
      <div class="modal-content" >
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">新增講師可諮詢時段</h4>
          <button type="button" class="close manuallyclose" id="xClose"data-dismiss="modal">&times;</button>
          
        
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
       		 <div class="form-group">
  				<label for="instructorId">講師編號</label>
  				<input  readonly id="instructorId"  style='background-color:#FFF8D7;' name="instructorId" type="text" class="form-control" >
				<span id='result1c' style="height: 10px;"></span>
			</div>
			<div class="form-group">
				<label for="startTime" >諮詢開始時段</label>
  				<div style=''class="input-group date form_datetime " data-date="1979-09-16T05:25:07Z" data-date-format="dd MM yyyy - HH:ii p" data-link-field="startTime">
                   	
                   	<input style='border-radius:4px;background-color:#FFF8D7'class="form-control" size="16" type="text" value="" readonly placeholder="請選擇">
                  	<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
					<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
               	</div>
				<input type="hidden" id="startTime" value="" /><br/>
			</div>
             <div class="form-group">
  				<label for="duration2">時數</label>
  					<select  id="duration2" style='background-color:#FFF8D7;' class="form-control" aria-label="Default select example">
  						<option selected>請選擇</option>
  						<option >1</option>
  						<option >2</option>
  						<option >3</option>
  						<option >4</option>
					</select>
					<span id='result2c' style="height: 10px;"></span>
			</div>
			
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
       	 <a id="sendData" type="button" class="btn btn-success" data-dismiss="modal" >確定</a>
       	 <span id='resultMsg' style="height: 18px; font-weight: bold;"></span>
          <button type="button" class="manuallyclose btn btn-danger" id="cancleClose" data-dismiss="modal">取消</button>
        </div>
        
      </div>
    </div>
  </div> 
  
  
   <!-- The Modal 2-->
  <div class="modal" id="myModal3" >
    <div class="modal-dialog">
      <div class="modal-content" >
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">取消此諮詢時段</h4>
          <button type="button" class="close manuallyclose" id="xClose"data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
			<div class="form-group">
				<label for="startTime3" >諮詢開始時段</label>
				<input  readonly id="startTime3"  style='background-color:#FFF8D7;' name="startTime3" type="text" class="form-control" >

			</div>
             <div class="form-group">
  				<label for="duration3">時數</label>
  				<input  readonly id="duration3"  style='background-color:#FFF8D7;' name="duration3" type="text" class="form-control" >
  				
			</div>
			
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
       	 <a id="deleteInsSchedule" type="button" class="btn btn-success" data-dismiss="modal" >確定</a>
          <button type="button" class="manuallyclose btn btn-danger" id="cancleClose" data-dismiss="modal">取消</button>
        </div>
        
      </div>
    </div>
  </div>  
  
</body>

</html>