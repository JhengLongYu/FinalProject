<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>健康運動整合平台|編輯講師</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js" crossorigin="anonymous"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="<c:url value='/webjars/jquery/3.6.0/jquery.js'/>"></script>        
<link href="${pageContext.request.contextPath}/css/mgstyles.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/js/mgscripts.js"></script>
<link rel="stylesheet" href='<c:url value='/webjars/bootstrap/4.6.0/css/bootstrap.css'/>'/>
<script type="text/javascript" src="<c:url value='/webjars/bootstrap/4.6.0/js/bootstrap.bundle.js'/>"></script>
<link href="${pageContext.request.contextPath}/css/consultion2.css"
	rel="stylesheet" />
<script>
let sid= "${instructorId}";
let fileDataURL=null;

window.onload = function(){
	findAlltype();
	let instructorName = document.getElementById("instructorName");
	let type = document.getElementById("type");
	let brief = document.getElementById("brief");
	let experience1 = document.getElementById("experience1");
	let experience2 = document.getElementById("experience2");
	let speciality1 = document.getElementById("speciality1");
	let speciality2 = document.getElementById("speciality2");
	let certification1 = document.getElementById("certification1");
	let certification2 = document.getElementById("certification2");
	let sendData =document.getElementById("sendData");
	fileDataURL = document.getElementById("inputFileToLoad");
	
	loadData();
	
	let showimg=document.getElementById("showimg");
	inputFileToLoad.addEventListener('change', loadImageFileAsURL);
	
	sendData.addEventListener('click', checkAndSendData);	
	}
function findAlltype(){
	let xhr3 = new XMLHttpRequest();
	xhr3.open("GET","<c:url value='/consultion/findAllInsType'/>",true);
	xhr3.send();
	xhr3.onreadystatechange = function(){
		if (xhr3.readyState == 4 && xhr3.status == 200){
			let alltypes=JSON.parse(xhr3.responseText);
			for(let i=0; i<alltypes.length;i++){
				let alltype=alltypes[i];
				let opt = document.createElement('option');
				opt.value = alltype.typeName;
			    opt.innerHTML = alltype.typeName;
			    type.appendChild(opt);
// 				console.log(alltype);
			}
		}
	}
}
function loadData(){
	var xhr = new XMLHttpRequest();
	xhr.open("GET","<c:url value='/consultion/findByInstructorid?instructorId='/>"+ sid, true);
	xhr.send();
	xhr.onreadystatechange = function (){
		if(xhr.readyState == 4 && xhr.status == 200 ){
			let instructor= JSON.parse(xhr.responseText);
			
			instructorName.value=instructor.instructorName;
			type.value=instructor.type;
			brief.value=instructor.brief;
			experience1.value=instructor.experience1;
			experience2.value=instructor.experience2;
			speciality1.value=instructor.speciality1;
			speciality2.value=instructor.speciality2;
			certification1.value=instructor.certification1;
			certification2.value=instructor.certification2;
			instructorId=instructor.instructorId;
		}	
	}
	let imageURL = "<c:url value='/consultion/getCoverImage' />";
	showimg.style.width='180px';
	showimg.style.height='180px';
	showimg.src=imageURL + "?instructorId=" +sid;
}

function loadImageFileAsURL(){
	let filesSelected = document.getElementById("inputFileToLoad").files;
	if (filesSelected.length > 0){
		 let fileToLoad = filesSelected[0];
		 console.log(fileToLoad);
	     let fileReader = new FileReader();
	     fileReader.onload = function(fileLoadedEvent) {
	        	fileDataURL = fileLoadedEvent.target.result;
	            showimg.src = fileLoadedEvent.target.result;
	        };
	    fileReader.readAsDataURL(fileToLoad);
	    showimg.style.display = 'block';
	 	showimg.style.width="180px";
	 	showimg.style.height="180px";
	}else{
		fileDataURL =null;
		console.log("未選擇檔案");
	}
}

function checkAndSendData(){
		
		hasError = false;
		instructorIdVal = sid;
		instructorNameVal = instructorName.value;
		typeVal = type.value;
		briefVal = brief.value;
		experience1Val = experience1.value;
		experience2Val = experience2.value;
		speciality1Val = speciality1.value;
		speciality2Val = speciality2.value;
		certification1Val = certification1.value;
		certification2Val = certification2.value;
		let div0 = document.getElementById('result0c');
		let div1 = document.getElementById('result1c');
		let div2 = document.getElementById('result2c');
		let div3 = document.getElementById('result3c');
		let div4 = document.getElementById('result4c');
		let div5 = document.getElementById('result5c');
		let div6 = document.getElementById('result6c');
		let div7 = document.getElementById('result7c');
		let div8 = document.getElementById('result8c');
		let div9 = document.getElementById('result9c');
		let divResult = document.getElementById('resultMsg');
		
		if (!instructorNameVal){
			setErrorFor(div1, "請輸入講師名稱");
   		} 	else {
      		div1.innerHTML = "";
   		}
		if (!typeVal){
			setErrorFor(div2, "請輸入類別");
   		} 	else {
      		div2.innerHTML = "";
   		}
		if (!briefVal){
			setErrorFor(div3, "簡介為必填值");
   		} 	else {
      		div3.innerHTML = "";
   		}
		if (!experience1Val){
			setErrorFor(div4, "請輸入經歷");
   		} 	else {
      		div4.innerHTML = "";
   		}
		if (!experience2Val){
			setErrorFor(div5, "請輸入經歷");
   		} 	else {
      		div5.innerHTML = "";
   		}
		if (!speciality1Val){
			setErrorFor(div6, "請輸入專業領域");
   		} 	else {
      		div6.innerHTML = "";
   		}
		if (!speciality2Val){
			setErrorFor(div7, "請輸入專業領域");
   		} 	else {
      		div7.innerHTML = "";
   		}
		if (!certification1Val){
			setErrorFor(div8, "請輸入證照");
   		} 	else {
      		div8.innerHTML = "";
   		}
		if (!certification2Val){
			setErrorFor(div9, "請輸入證照");
   		} 	else {
      		div9.innerHTML = "";
   		}
		loadImageFileAsURL();
		if(!fileDataURL){
			console.log("no pic"+fileDataURL);
		}
		if (hasError){
   		return false;
		}
		let jsonInstructor = {
				"instructorId": instructorIdVal,
				"instructorName": instructorNameVal,
				"type": typeVal,
				"brief": briefVal,
				"experience1": experience1Val,
				"experience2": experience2Val,
				"speciality1": speciality1Val,
				"speciality2": speciality2Val,
				"certification1": certification1Val,
				"certification2": certification2Val,
				"fileDataUrl":fileDataURL
		};
		var xhr1 = new XMLHttpRequest();
		let url="<c:url value='/consultion/update'/>";
		xhr1.open("PUT",url, true);
		xhr1.setRequestHeader("Content-Type", "application/json");
		xhr1.send(JSON.stringify(jsonInstructor));
		xhr1.onreadystatechange = function(){
			if (xhr1.readyState == 4 && xhr1.status == 200) {
				let result = JSON.parse(xhr1.responseText);
				if (result.fail) {
			 		divResult.innerHTML = "<font color='red' >"
						+ result.fail + "</font>";
		  		}else if (result.success) {
		  			divResult.innerHTML = "<font color='GREEN'>"
						+ result.success + "</font>";
		  		}
				


			}
		}
		
	
}

function setErrorFor(input, message){
	input.innerHTML = "<font color='red' size='-2'>" + message + "</font>";
    hasError = true;
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
                
                <div class="container-fluid" >
                <a style='color:#555;margin-left:750px;margin-bottom:0'href="<c:url value='/consultion/allinstructors'/>"><i class="fas fa-table me-1"></i>講師列表</a>	
					<a style='color:#555;margin-bottom:0'href="<c:url value='/consultion/addInstructorTypePage'/>"><i class="fas fa-table me-1"></i>講師類別列表</a>	
                <div class="container" style="margin-top:10px;">
                <div class="card mb-4" >
  							<div class="card-header" style="background-color:#FFED97;text-align:center;">
								<i class="fas fa-table me-1"></i>編輯講師
    						</div>
    					<div class="card-body">
       						 <div style='width:800px;margin:10px auto; padding:10px;background-color:white; '>	
                   		<div class="form-group row" style='justify-content:center'>
    						<label for="instructorName" class="col-sm-2 col-form-label">講師名稱</label>
    						<div class="col-sm-8">
     						 	<input type="text" class="form-control" id="instructorName" placeholder="instructorName" style='background-color:#FFF8D7'>
    							<span id='result1c' style="height: 10px;"></span>
    						</div>
  						</div>
  						<div class="form-group row" style='justify-content:center'>
    						<label for="type" class="col-sm-2 col-form-label">講師類別</label>
    						<div class="col-sm-8">
     						 	<select id="type" class="form-control" style='background-color:#FFF8D7'>
      							  <option selected>請選擇...</option>
    						    </select>
    							<span id='result2c' style="height: 10px;"></span>
    						</div>
  						</div>
  						<div class="form-group row" style='justify-content:center'>
    						<label for="brief" class="col-sm-2 col-form-label">簡介</label>
    						<div class="col-sm-8">
     						 	<textarea class="form-control" id="brief" placeholder="brief" style='background-color:#FFF8D7'></textarea>
    							<span id='result3c' style="height: 10px;"></span>
    						</div>
  						</div>
  						<div class="form-group row" style='justify-content:center'>
    						<label for="experience1" class="col-sm-2 col-form-label">經歷</label>
    						<div class="col-sm-8" >
     						 	<input type="text" style="margin-top:5px;background-color:#FFF8D7" class="form-control" id="experience1" placeholder="experience1">
    							<span id='result4c' style="margin-top:5px" style="height: 10px;"></span>
    							<input type="text"  style="margin-top:5px;background-color:#FFF8D7"class="form-control" id="experience2" placeholder="experience2">
    							<span id='result5c' style="margin-top:5px" style="height: 10px;"></span>
    						</div>
  						</div>
  						<div class="form-group row" style='justify-content:center'>
    						<label for="experience1" class="col-sm-2 col-form-label">專業領域</label>
    						<div class="col-sm-8" >
     						 	<input type="text" style="margin-top:5px;background-color:#FFF8D7" class="form-control" id="speciality1" placeholder="speciality1">
    							<span id='result6c' style="margin-top:5px;height: 10px;" ></span>
    							<input type="text"  style="margin-top:5px;background-color:#FFF8D7"class="form-control" id="speciality2" placeholder="speciality2">
    							<span id='result7c' style="margin-top:5px;height: 10px;" ></span>
    						</div>
  						</div>
  						<div class="form-group row" style='justify-content:center'>
    						<label for="experience1" class="col-sm-2 col-form-label">證照</label>
    						<div class="col-sm-8" >
     						 	<input type="text" style="margin-top:5px;background-color:#FFF8D7" class="form-control" id="certification1" placeholder="certification1">
    							<span id='result8c' style="margin-top:5px;height: 10px;" ></span>
    							<input type="text"  style="margin-top:5px;background-color:#FFF8D7"class="form-control" id="certification2" placeholder="certification2">
    							<span id='result9c' style="margin-top:5px;height: 10px;" ></span>
    						</div>
  						</div>
  						 <div class="form-group row" style='justify-content:center'>
  						 	 <label for="inputFileToLoad" class="col-sm-2 col-form-label">封面照</label>
  						 	 <div class="col-sm-8" >
  							  	<input type="file" class="custom-file-input" id="inputFileToLoad" accept="image/jpeg, image/png" onchange="loadImageFileAsURL();" required>
   							 	<label class="custom-file-label"  for="inputFileToLoad"  style='background-color:#FFF8D7'>挑選檔案</label>
   							 	<img id="showimg" src="" />
   							 </div>
  						</div>
  						<div class="form-group row" style='justify-content:center'>
  							<div class="col-sm-8" style='margin-left:auto'>
  								<button id='sendData' class="btn btn-success">送出</button>
  								<span id='resultMsg' style="height: 18px; font-weight: bold;"></span>
  							</div>
  						</div>
  					</div>
     					</div>
     					</div>
				</div>
                   
                   
                   
                </div>
            </div>
        </div>
        
        
        
</body>
</html>