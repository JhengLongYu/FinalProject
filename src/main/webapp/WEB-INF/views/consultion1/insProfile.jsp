<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>健康運動整合平台|講師個人頁面</title>
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&display=swap" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/styles1.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/insprofile.css" rel="stylesheet" />

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/scripts.js"></script>
<script type="text/javascript" src="<c:url value='/webjars/jquery/3.6.0/jquery.js'/>"></script>

<link rel="stylesheet" href='<c:url value='/webjars/bootstrap/4.6.0/css/bootstrap.css'/>'/>
<script type="text/javascript" src="<c:url value='/webjars/bootstrap/4.6.0/js/bootstrap.bundle.js'/>"></script>
<script>
let instructorId='${instructorId}';
window.onload= function(){
	let dataArea = document.getElementById("dataArea");
	findById();
}
function findById(){
	let xhr = new XMLHttpRequest();
	let url ="<c:url value='/consultion/findbyInsId'/>?instructorId="+instructorId;
	xhr.open("GET",url,true);
	xhr.send();
	xhr.onreadystatechange = function(){
		if (xhr.readyState == 4 && xhr.status == 200){
			dataArea.innerHTML = processInstructorData(xhr.responseText);
		}
	}
}

function processInstructorData(jsonString){
	let instructor= JSON.parse(jsonString);
	//取照片
	var imageURL = "<c:url value='/consultion/getCoverImage' />"+ "?instructorId="  
	+instructor.instructorId;
	coverImg.src=imageURL;
	//取title
	let title=document.getElementById("title");
	title.innerText=instructor.type+" "+instructor.instructorName;
	//取詳細資訊
	let segment="<p class='lead'>"+instructor.brief+"</p>";
	segment+="<h2>經歷</h2>";
	segment+="<ul>";
	segment+="<li>"+instructor.experience1+"</li>";
	segment+="<li>"+instructor.experience2+"</li>";
	segment+="</ul>";
	segment+="<h2>專業領域</h2>";
	segment+="<ul>";
	segment+="<li>"+instructor.speciality1+"</li>";
	segment+="<li>"+instructor.speciality2+"</li>";
	segment+="</ul>";
	segment+="<h2>證照</h2>";
	segment+="<ul>";
	segment+="<li>"+instructor.certification1+"</li>";
	segment+="<li>"+instructor.certification2+"</li>";
	segment+="</ul>";
	return segment;
}
</script>
</head>
<body id="page-top">
<%@include file="../navigation.jsp"%>
  <!-- Header - set the background image for the header in the line below-->
        <header class="py-5 bg-image-full" style="background-image: url(${pageContext.request.contextPath}/images/healthcare-background.jpg); height:300px;">
            <div class="text-center my-5" style="width: 200px; margin-left: 880px;">

                    <img id="coverImg" class="img-fluid rounded-circle mb-4" src="" style="width:150px; height:150px;" />
                    <h1 class="text-white fs-3 fw-bolder" id="title"></h1>
            </div>
        </header>
        <!-- Content section-->
        <section class="py-5">
            <div class="container my-5">
                <div class="row justify-content-center">
                    <div class="col-lg-6" id="dataArea">
                        
                    </div>
                </div>
            </div>
        </section>



</body>
</html>