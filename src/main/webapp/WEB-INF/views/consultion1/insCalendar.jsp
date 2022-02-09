<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>健康運動整合平台|講師可諮詢時段</title>
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&display=swap" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/styles1.css" rel="stylesheet" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/scripts.js"></script>
<script type="text/javascript" src="<c:url value='/webjars/jquery/3.6.0/jquery.js'/>"></script>

<link rel="stylesheet" href='<c:url value='/webjars/bootstrap/4.6.0/css/bootstrap.css'/>'/>
<script type="text/javascript" src="<c:url value='/webjars/bootstrap/4.6.0/js/bootstrap.bundle.js'/>"></script>
<!--連結Full Calendar-->
<link href='${pageContext.request.contextPath}/css/main.css' rel='stylesheet' />
<script src='${pageContext.request.contextPath}/js/main.js'></script>

<!--轉換成中文-->
<script src="${pageContext.request.contextPath}/js/locales-all.js"></script>

<!--連結css-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/calendarstyle.css">

<script>
let mbId="${mbid}";
let insId="${insId}";
let instructorName=null;
let reservation;
let scheduleNo;
let data={items: []};
let dataArea;
window.onload = function(){
	dataArea = document.getElementById("dataArea");
	console.log("mbId"+mbId)
	calendar();
	nameCalendar()
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
//    console.log(info.dayEl);
//    },
//       events:data,
      
      eventSources: [{
              url: "<c:url value='/consultion/eventsbyinsId/'/>"+insId, 
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
        		$("#myModal").modal("show");
        		$('#myModal').on('click', 'button.manuallyclose',  function (eventObject) {
        			$('#myModal').modal('hide');
     		});
        		
        		document.getElementById("memberId").value=mbId;
        		instructorName=info.event.extendedProps.instructorName;
        		scheduleNo=info.event.extendedProps.scheduleNo;
        		document.getElementById("instructorName").value=instructorName;

        		
        			
        		let date = new Date( Date.parse(info.event.start) );
        		let date2 = new Date( Date.parse(info.event.end) );
        		document.getElementById("consultTime").value=date.getFullYear()+"年"+(date.getMonth()+1)+"月"+date.getDate()+"日"+date.getHours()+"時"+date.getMinutes()+"分";
        		
        		var milliseconds = (date2 - date);
        		var duration = milliseconds / (60000*60);
        		document.getElementById("duration").value=duration;
        		
        		let sendRsBtn = document.getElementById("addReservation");
        		sendRsBtn.onclick=function(){
        			$('#myModal').modal('hide');
        			addReservation(scheduleNo,instructorName);
        		}
      	},  
        	    
    	eventDidMount: function(info,element) {
//     		element.find('.fc-event-title').append("<br/>" + info.event.extendedProps.instructor); 
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

function addReservation(scheduleNo,instructorName){
	console.log(scheduleNo+"--"+instructorName);
	let xhr1 = new XMLHttpRequest();
	xhr1.open("POST","<c:url value='/consultion/addReservation'/>",true);
	var jsonReservation = {
		"memberId":mbId,
		"scheduleNo":scheduleNo,
	}
	xhr1.setRequestHeader("Content-Type", "application/json"); 
	xhr1.send(JSON.stringify(jsonReservation));
	xhr1.onreadystatechange = function(){
		if (xhr1.readyState == 4 && xhr1.status == 200){
			let result=JSON.parse(xhr1.responseText);
				if(result.success){
					calendar();
					alert(result.success);
					let xhr2 = new XMLHttpRequest();
					xhr2.open("POST","<c:url value='/consultion/send'/>",true);
// 					let msg="已成功和講師 "+instructorName+" 預約諮詢,感謝您的支持"
					var mailObj = {
						"mbId":mbId,
						"scheduleNo":scheduleNo,
						"action":'新增預約',
// 						"subject":"諮詢預約成功通知信",
// 						"message":msg
					}
					xhr2.setRequestHeader("Content-Type", "application/json"); 
					xhr2.send(JSON.stringify(mailObj));
					xhr2.onreadystatechange = function(){
						if (xhr2.readyState == 4 && xhr2.status == 200){
							let result2=JSON.parse(xhr2.responseText);
							console.log("寄信"+result2);
						}
					}
				}else if(result.fail){
					alert(result.fail);
				}
		}
	}
}
function nameCalendar(){
	let xhr3 = new XMLHttpRequest();
	let url ="<c:url value='/consultion/findbyInsId'/>?instructorId="+insId;
	xhr3.open("GET",url,true);
	xhr3.send();
	xhr3.onreadystatechange = function(){
		if (xhr3.readyState == 4 && xhr3.status == 200){
			let insResult=JSON.parse(xhr3.responseText);
			dataArea.innerHTML = "歡迎與"+insResult.type+" "+insResult.instructorName+" 預約諮詢";
			console.log(insResult);
		}
	}
}
</script>
</head>
<body id="page-top">
<div style='height:100px;background-color:black;'></div>
<%@include file="../navigation.jsp"%>
 <div class="container-fluid" >
	 <h3 id="dataArea" style="text-align:center;margin-top:5px;"></h3>
      <div class="containercalendaer"  style="margin-top:300px;">
      
       	 <div id='calendar'></div>
       				 
      </div>
      
 </div>

<!-- The Modal -->
  <div class="modal" id="myModal">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">新增預約諮詢</h4>
          <button type="button" class="close manuallyclose" id="xClose"data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
       		 <div class="form-group">
  				<label for="memberId">會員編號名稱:</label>
  				<input readonly id="memberId" name="memberId" type="text" class="form-control" readonly>
			</div>
			<div class="form-group">
  				<label for="pwd">講師名稱:</label>
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
       	 <a id="addReservation" type="button" class="btn btn-success" data-dismiss="modal" >確定</a>
          <button type="button" class="manuallyclose btn btn-danger" id="cancleClose" data-dismiss="modal">取消</button>
        </div>
        
      </div>
    </div>
  </div>

</body>
</html>