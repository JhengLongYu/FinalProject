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
<title>健康運動整合平台 | 會員中心-會員月曆</title>
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/calendarstyleMb.css">

<script>
let mbId="${mbid}";
let reservation;
let data={items: []};
window.onload = function(){
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
//    dateClick: function(info) {//滑鼠點選
//         info.dayEl.style.backgroundColor = 'gray';
//    },
//       events:data,
      
      eventSources: [{
              url: "<c:url value='/consultion/eventsbymbId/'/>"+mbId, 
              type: 'GET',
              data: {
                  start: 'start',
                  end: 'end',
                  title: 'title',
              },
              error: function () {
                  alert('there was an error while fetching events!');
              },
              color: 'green',
              textColor: 'black',
              dataType: 'json',
          }],
          
        	    
      	eventClick: function(info) {
      		$("#myModal").modal("show");
      		$('#myModal').on('click', 'button.manuallyclose',  function (eventObject) {
      			$('#myModal').modal('hide');
   		});
      		let instructorId=info.event.extendedProps.instructorId;
      		let reservationId=info.event.extendedProps.reservationId;
      		let str=info.event.title;
      		document.getElementById("memberId").value=mbId;
      		document.getElementById("instructorName").value=str.substr(str.lastIndexOf(":")+1);
      		
      		let date = new Date( Date.parse(info.event.start) );
      		let date2 = new Date( Date.parse(info.event.end) );
      		document.getElementById("consultTime").value=date.getFullYear()+"年"+(date.getMonth()+1)+"月"+date.getDate()+"日"+date.getHours()+"時"+date.getMinutes()+"分";
      		
      		var milliseconds = (date2 - date);
      		var hours = milliseconds / (60000*60);
      		document.getElementById("duration").value=hours;
      		console.log("duration"+milliseconds);
      		let deletebtn = document.getElementById("deleteReservation");
      		deletebtn.onclick=function(){
    			$('#myModal').modal('hide');
    			deleteReservation(reservationId);
    		}
//       		!!!	document.getElementById("deleteReservation").addEventListener("click", deleteReservation);

//       		console.log("instructorId"+info.event.extendedProps.instructorId)
// //       		calendar.changeView('timeGridDay', info.event.start);
//       		calendar.changeView('list', info.event.start);
    	},
    	eventDidMount: function(info,element) {
//     		element.find('.fc-event-title').append("<br/>" + info.event.extendedProps.instructor); 
    		console.log(info.event.extendedProps.instructorId)
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

function deleteReservation(reservationId){
	console.log("reservationId"+reservationId);
	
	
	let xhr2 = new XMLHttpRequest();
	url="<c:url value='/consultion/delete/'/>"+reservationId;
	xhr2.open("GET",url,true);
	xhr2.send();
	xhr2.onreadystatechange = function(){
		if (xhr2.readyState == 4 && xhr2.status == 200){
			let delresult =JSON.parse(xhr2.responseText);
			if (delresult.fail) {
		 		alert("刪除失敗成功");
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
				 <a href="<c:url value='/consultion/mbcalendar/${mbid}'/>"class="switchBtn info_here"> 
				 <span class="switchText"> 諮詢月曆</span>
				</a>
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
<!-- 				<div class="container-fluid" > -->
                  <div class="containercalendaer" >
       				 <div id='calendar'></div>
       				 <div id="dataArea"></div>
<!--       			  </div> -->
                </div>
			</div>
		</div>

	</div>



<!-- The Modal -->
  <div class="modal" id="myModal" >
    <div class="modal-dialog">
      <div class="modal-content" style="border:3px 	#AE0000 solid">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">取消預約諮詢</h4>
          <button type="button" class="close manuallyclose" id="xClose"data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
       		 <div class="form-group">
  				<label for="memberId">會員編號名稱:</label>
  				<input readonly id="memberId" name="memberId" type="text" class="form-control" readonly>
			</div>
			<div class="form-group">
  				<label for="instructorName">講師名稱:</label>
  				<input readonly id="instructorName" name="instructorName" type="text" class="form-control" >
			</div>
			<div class="form-group">
  				<label for="consultTime">諮詢時段:</label>
  				<input readonly id="consultTime" name="consultTime" type="text" class="form-control" >
			</div>
             <div class="form-group">
  				<label for="duration">時數</label>
  				<input readonly id="duration"name="duration" class="form-control">
    				
			</div>
			
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
       	 <a id="deleteReservation" type="button" class="btn btn-danger" data-dismiss="modal" >確定</a>
          <button type="button" class="manuallyclose btn btn-success" id="cancleClose" data-dismiss="modal">取消</button>
        </div>
        
      </div>
    </div>
  </div>
</body>

</html>