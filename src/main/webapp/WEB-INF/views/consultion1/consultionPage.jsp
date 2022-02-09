<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>健康運動整合平台|線上諮詢</title>
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&display=swap" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/styles1.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/consultion.css" rel="stylesheet" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/scripts.js"></script>
<script type="text/javascript" src="<c:url value='/webjars/jquery/3.6.0/jquery.js'/>"></script>

<link rel="stylesheet" href='<c:url value='/webjars/bootstrap/4.6.0/css/bootstrap.css'/>'/>
<script type="text/javascript" src="<c:url value='/webjars/bootstrap/4.6.0/js/bootstrap.bundle.js'/>"></script>

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- DateTimepicker -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.min.css" rel="external nofollow" >
<script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.zh-CN.js"></script>
<script>
let mbId="${mbid}";
let favInsArray=new Array();
let keyword;
window.onload = function(){
	checkfavorites();
	let dataArea = document.getElementById("dataArea");
	keyword= document.getElementById("keyword");
	document.getElementById("searchbar").addEventListener("click", search);
	setTimeout(() => {
		findAll();
	},500);
	
}
function findAll(){
	let xhr = new XMLHttpRequest();
	xhr.open("GET","<c:url value='/consultion/MbfindAll'/>",true);
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
	let segment="";
	for(let n =0; n<instructors.length;n++){
		let instructor = instructors[n];
		
		segment+="<div class='col-md-4 mb-5'>";
		segment+="<div class='card h-100'>";
		//照片
		segment+="<div class='card-body'>";
		segment+="<div>";
		
		segment +="<div style='display:flex;height:160px'>";
		segment	+="<img class='rounded-circle ' width='150' height='150' "+ " src='" + imageURL + "?instructorId="  
		+  instructor.instructorId + "'>";
		segment +="<div style='display:flex; flex-direction: column; margin-left:25px'>";
		segment	+="<h2 class='card-title'>"+instructor.instructorName+"</h2>";
		segment	+="<span style='margin:2px;border:5px solid #FFDC35;background-color:#FFDC35;border-radius:5px;color:white'>"+instructor.type+"</span>";
		
		segment+="<div style='margin:2px;display: flex;align-items: flex-start'>";
		//收藏icon
		let favdiv="favdiv"+instructor.instructorId;
		segment +="<span id='"+favdiv+"' style='display:flex' >";
		let favindex="favIns"+instructor.instructorId;
		let favIns="favIns"+instructor.instructorId;
		if(favInsArray!=null){
			let favindex=favInsArray.indexOf(instructor.instructorId);
			if(favindex>=0){
				segment +="<i  id='"+favIns+"' class='fas fa-heart fa-lg' onclick='addToFavorites("+instructor.instructorId+")'></i>";	
			}else{
				segment +="<i  id='"+favIns+"' class='far fa-heart fa-lg' onclick='addToFavorites("+instructor.instructorId+")'></i>";
			}
		}else{
			segment +="<i  id='"+favIns+"' class='far fa-heart fa-lg' onclick='addToFavorites("+instructor.instructorId+")'></i>";	
		}
		
		segment +="</span>";
		//收藏數量
		countFavorites(instructor.instructorId);
		let countdiv="countdiv"+instructor.instructorId;
		segment +="<span id='"+countdiv+"' style='padding:0 2px ;font-size:18px' >";
		segment +="</span>";
		segment +="</div>";
		
		segment +="</div>";
		
		
		
		//專長標籤
		segment +="</div>";
		segment +="<span style='border:2px solid #97CBFF;margin:0 5px;background-color:	#66B3FF;border-radius:5px;color:white;'>"+instructor.speciality1+"</span>";
		segment +="<span style='border:2px solid #97CBFF;margin:0 5px;background-color:	#66B3FF;border-radius:5px;color:white;'>"+instructor.speciality2+"</span>";

		segment +="</div>";
		segment +="</div>";
		//按鈕
		segment+="<div class='card-body' >";
		segment +="<p class='card-text' style='font-size: 14px;'>"+instructor.brief+"</p>";
		segment +="<table><tr>"
		
		segment +="<td><a class='btn btn-warning' href="+"<c:url value='/consultion/insProfile/' />"
					+instructor.instructorId +">"+"詳細資訊</a></td>";
		let href="<c:url value='/consultion/insCalendar/' />"+instructor.instructorId;
		segment +="<td><a class='btn btn-warning' href='" +href+"'>"+"即刻預約</a></td>";
		
		
		segment +="</tr></table>";
		segment +="</div>";
		
		segment +="</div>";
		segment +="</div>";
	}
	return segment;
}

function addToFavorites(insId){
	if(mbId==""){
		alert("請先登入帳號");
		window.location.href = "<c:url value='/login' />";
	}else{
		var favoriteIns = {
				"instructorId": insId,
				"memberId":mbId
		}
		jsonfavoriteIns = JSON.stringify(favoriteIns);
		let xhr1 = new XMLHttpRequest();
		let url1="<c:url value='/consultion/addToFavoriteIns'/>";
		xhr1.open("POST",url1,true);
		xhr1.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
		xhr1.send(jsonfavoriteIns);
		xhr1.onreadystatechange = function(){
			if (xhr1.readyState == 4 && xhr1.status == 200){
				let resultFav=JSON.parse(xhr1.responseText);
				let favIconId=document.getElementById("favIns"+insId);
				let favdivId=document.getElementById("favdiv"+insId);
				if(resultFav.success){
// 					alert(resultFav.success);
					favIconId.parentNode.removeChild(favIconId);
					favdivId.innerHTML="<i  id='favIns"+insId+"' class='fas fa-heart fa-lg' onclick='addToFavorites("+insId+")'></i>";
				}else{
// 					alert(resultFav.fail);
					favIconId.parentNode.removeChild(favIconId);
					favdivId.innerHTML="<i  id='favIns"+insId+"' class='far fa-heart fa-lg' onclick='addToFavorites("+insId+")'></i>"
				}
					countFavorites(insId);
				
			}
		}
	}
	
}

function checkfavorites(){
	if(mbId!=""){
		let xhr2 = new XMLHttpRequest();
		let url2="<c:url value='/consultion/mbfavoriteIns/'/>"+mbId;
		xhr2.open("GET",url2,true);
		xhr2.send();
		xhr2.onreadystatechange = function(){
			if (xhr2.readyState == 4 && xhr2.status == 200){
				let result2=JSON.parse(xhr2.responseText);
				for(let i=0;i<result2.length;i++){
					let favInsId=result2[i].instructorId;
					favInsArray.push(favInsId)
//	 				console.log(favInsArray);
				}
				
			}
		}
	}else{
		favInsArray=null;
	}
	
}

function countFavorites(insid){
	
	let xhr3 = new XMLHttpRequest();
	let url3="<c:url value='/consultion/countFavorites/'/>"+insid;
	xhr3.open("GET",url3,true);
	xhr3.send();
	xhr3.onreadystatechange = function(){
		if (xhr3.readyState == 4 && xhr3.status == 200){
			let result3=xhr3.responseText;
			
			let countdivId=document.getElementById("countdiv"+insid);
			countdivId.innerHTML=result3;
// 			console.log(countdivId);
		}
	}
}

function search(){
// 	let keywordVal=keyword.value;
// // 	console.log("keywordVal"+keywordVal);
// 	let xhr4 = new XMLHttpRequest();
// 	let url4 ="<c:url value='/consultion/findbyNameLike/'/>"+keywordVal;
// 	xhr4.open("GET",url4,true);
// 	xhr4.send();
// 	xhr4.onreadystatechange = function(){
// 		if (xhr4.readyState == 4 && xhr4.status == 200){
// 			let result4=xhr4.responseText;
// 			if(result4!=""){
// 				dataArea.innerHTML = processInstructorData(result4);
// // 				console.log(result4);
// 			}else{
// // 				document.getElementById("searchdiv").innerHTML +="<div style='margin:6px;color:	#FF0000'>查無此資料</div>";
// 				dataArea.innerHTML ="<div style='margin:6px;color:	#FF0000'>查無此資料,請重新查詢</div>";
// 			}
// 		}
// 	}
}
function keyup(keywordVal){
	console.log(keywordVal);
// 	let keywordVal=keyword.value;
// 	console.log("keywordVal"+keywordVal);
	let xhr4 = new XMLHttpRequest();
	let url4 ="<c:url value='/consultion/findbyNameLike/'/>"+keywordVal;
	xhr4.open("GET",url4,true);
	xhr4.send();
	xhr4.onreadystatechange = function(){
		if (xhr4.readyState == 4 && xhr4.status == 200){
			let result4=xhr4.responseText;
			if(result4!=""){
				dataArea.innerHTML = processInstructorData(result4);
// 				console.log(result4);
			}else{
// 				document.getElementById("searchdiv").innerHTML +="<div style='margin:6px;color:	#FF0000'>查無此資料</div>";
				dataArea.innerHTML ="<div style='margin:6px;color:	#FF0000;height:500px'>查無此資料,請重新查詢</div>";
			}
		}
	}
}
function findbytype(typeid){
	let xhr5 = new XMLHttpRequest();
	let url5="<c:url value='/consultion/findbyTypeId/'/>"+typeid;
	xhr5.open("GET",url5,true);
	xhr5.send();
	xhr5.onreadystatechange = function(){
		if (xhr5.readyState == 4 && xhr5.status == 200){
			let result5=xhr5.responseText;
			dataArea.innerHTML = processInstructorData(result5);
		}
	}
}

</script>
</head>
<body id="page-top">
<div style='height:100px;background-color:black;'></div>
<%@include file="../navigation.jsp"%>
 <!-- Page Content-->
        <div class="container px-4 px-lg-5">
            <!-- Heading Row-->
            <div class="row gx-4 gx-lg-5 align-items-center my-5">
                <div class="col-lg-7"><img class="img-fluid rounded mb-4 mb-lg-0" style="height:300px; width:400px;margin-left:120px"src="${pageContext.request.contextPath}/images/consult.jpg" alt="..." /></div>
                <div class="col-lg-5">
                    <h1 class="font-weight-light">與講師一對一諮詢</h1>
                    <p>參加者可以透過諮詢，從基因、體適能、身體組成評估，並且根據數據、目標、日常飲食、運動習慣、工作性質、生活現況等，來規劃一系列個人健康計畫。</p>
                </div>
            </div>
            <!-- Call to Action-->
            <div class="card text-white bg-warning my-5 py-4 text-center"style="height:80px;">
                <div class="card-body" style="padding:9px;"><p class="text-white m-0" >更多講師資訊</p></div>
            </div>
            <!-- search bar -->
            <div id='searchdiv'class="input-group rounded" style='margin:5px;width:600px;'>
  				<input id='keyword'type="search" class="form-control rounded" placeholder="Search" aria-label="Search"
 					   aria-describedby="search-addon" style='width:100px;' onkeyup="keyup(this.value)"/>
				  <span class="input-group-text border-0" id="searchbar">
   					 <i class="fas fa-search"></i>
  				</span>
  				<span  class="btn-group btn-group-sm" role="group" aria-label="Basic outlined example" style='margin-left:10px' id="searchbytype">
  					<button type="button" class="btn btn-outline-warning"  onclick='findbytype(1)'>營養師</button>
  					<button type="button" class="btn btn-outline-warning"  onclick='findbytype(2)'>體能教練</button>
  					<button type="button" class="btn btn-warning"  onclick='findAll()'>所有講師</button>
  				</span>
  				
			</div>
            
            <!-- Content Row-->
            <div class="row gx-4 gx-lg-5" id="dataArea">
            
                
               
            </div>
        </div>

<div>

</div>
</body>
</html>