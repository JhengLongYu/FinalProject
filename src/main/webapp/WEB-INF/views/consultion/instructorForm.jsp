<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>健康運動整合平台|新增講師</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js" crossorigin="anonymous"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="<c:url value='/webjars/jquery/3.6.0/jquery.js'/>"></script>        
<link href="${pageContext.request.contextPath}/css/mgstyles.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/js/mgscripts.js"></script>
<link rel="stylesheet" href='<c:url value='/webjars/bootstrap/4.6.0/css/bootstrap.css'/>'/>
<script type="text/javascript" src="<c:url value='/webjars/bootstrap/4.6.0/js/bootstrap.bundle.js'/>"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/fontawesome.min.css">
<script>
var hasError = false;
let fileDataURL = null;
window.onload = function(){
	let dataArea = document.getElementById("dataArea");
	findAlltype();
	var sendData =document.getElementById("sendData");
	fileDataURL = document.getElementById("inputFileToLoad");
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
			let select = document.getElementById('type');
			for(let i=0; i<alltypes.length;i++){
				let alltype=alltypes[i];
				let opt = document.createElement('option');
				opt.value = alltype.typeName;
			    opt.innerHTML = alltype.typeName;
			    select.appendChild(opt);
				console.log(alltype);
			}
		}
	}
}

	function checkAndSendData(){
		hasError = false;
		var memberId=document.getElementById("memberId").value;
		var instructorName = document.getElementById("instructorName").value;
		var x=document.getElementById("type").selectedIndex;
		var y=document.getElementById("type").options;
		console.log(y[x].value);
		var type = y[x].value;
		
		var brief = document.getElementById("brief").value;
		var experience1 = document.getElementById("experience1").value;
		var experience2 = document.getElementById("experience2").value;
		var speciality1 = document.getElementById("speciality1").value;
		var speciality2 = document.getElementById("speciality2").value;
		var certification1 = document.getElementById("certification1").value;
		var certification2 = document.getElementById("certification2").value;
		var div0 = document.getElementById('result0c');
		var div1 = document.getElementById('result1c');
		var div2 = document.getElementById('result2c');
		var div3 = document.getElementById('result3c');
		var div4 = document.getElementById('result4c');
		var div5 = document.getElementById('result5c');
		var div6 = document.getElementById('result6c');
		var div7 = document.getElementById('result7c');
		var div8 = document.getElementById('result8c');
		var div9 = document.getElementById('result9c');
		var divResult = document.getElementById('resultMsg');
		if (!memberId){
			setErrorFor(div0, "請輸入會員編號");
   		} 	else {
      		div0.innerHTML = "";
   		}
		if (!instructorName){
			setErrorFor(div1, "請輸入講師名稱");
   		} 	else {
      		div1.innerHTML = "";
   		}
		if (x==0){
			setErrorFor(div2, "請輸入類別");
   		} 	else {
      		div2.innerHTML = "";
   		}
		if (!brief){
			setErrorFor(div3, "簡介為必填值");
   		} 	else {
      		div3.innerHTML = "";
   		}
		if (!experience1){
			setErrorFor(div4, "請輸入經歷");
   		} 	else {
      		div4.innerHTML = "";
   		}
		if (!experience2){
			setErrorFor(div5, "請輸入經歷");
   		} 	else {
      		div5.innerHTML = "";
   		}
		if (!speciality1){
			setErrorFor(div6, "請輸入專業領域");
   		} 	else {
      		div6.innerHTML = "";
   		}
		if (!speciality2){
			setErrorFor(div7, "請輸入專業領域");
   		} 	else {
      		div7.innerHTML = "";
   		}
		if (!certification1){
			setErrorFor(div8, "請輸入證照");
   		} 	else {
      		div8.innerHTML = "";
   		}
		if (!certification2){
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
		
		var instructor = {
				"memberId" : memberId,
				"instructorName": instructorName,
				"type": type,
				"brief": brief,
				"experience1": experience1,
				"experience2": experience2,
				"speciality1": speciality1,
				"speciality2": speciality2,
				"certification1": certification1,
				"certification2": certification2,
				"fileDataUrl":fileDataURL
				
		}
		
		jsonInstructor = JSON.stringify(instructor);
		var xhr1 = new XMLHttpRequest();
		xhr1.open("POST","<c:url value='/consultion/save'/>", true);
		xhr1.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
		xhr1.send(jsonInstructor);
		xhr1.onreadystatechange = function (){
			if(xhr1.readyState == 4 && xhr1.status == 200 ){
				if(xhr1.responseText!=null){
					divResult.innerHTML = "<font color='GREEN'>"
						+ "新增成功" + "</font>";
					document.getElementById("instructorName").value= "";
				 	document.getElementById("instructorName").value= "";
					document.getElementById("type").value= "";
					document.getElementById("brief").value= "";
		 		 	document.getElementById("experience1").value= "";
					document.getElementById("experience2").value= "";
					document.getElementById("speciality1").value= "";
				 	document.getElementById("speciality2").value= "";
					document.getElementById("certification1").value= "";
					document.getElementById("certification2").value= "";
					document.getElementById("inputFileToLoad").value="";
					fileDataURL = null;
					document.getElementById("showimg").src="";
					showimg.style.display = 'none';
					div1.innerHTML = "";
					div2.innerHTML = "";
					div3.innerHTML = "";
					div4.innerHTML = "";
					div5.innerHTML = "";
					div6.innerHTML = "";
					div7.innerHTML = "";
					div8.innerHTML = "";
					div9.innerHTML = "";
				}
				
			}else{
				divResult.innerHTML = "<font color='red' >"
						+ "新增失敗" + "</font>";
			}
		}
	}
	


function setErrorFor(input, message){
	input.innerHTML = "<font color='red' size='-2'>" + message + "</font>";
    hasError = true;
}
function loadImageFileAsURL(){
	let filesSelected = document.getElementById("inputFileToLoad").files;
	if (filesSelected.length > 0){
		 let fileToLoad = filesSelected[0];
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
		fileDataURL=null;
		console.log("未選擇檔案");
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
                
                <div class="container-fluid" >
				<a style='color:#555;margin-left:750px;margin-bottom:0'href="<c:url value='/consultion/allinstructors'/>"><i class="fas fa-table me-1"></i>講師列表</a>	
					<a style='color:#555;margin-bottom:0'href="<c:url value='/consultion/addInstructorTypePage'/>"><i class="fas fa-table me-1"></i>講師類別列表</a>	
					<div class="container" style="margin-top:10px;"> 
   						<div class="card mb-4" >
  							<div class="card-header" style="background-color:#FFED97;text-align:center;">
								<i class="fas fa-table me-1"></i>新增講師
    						</div>
    					<div class="card-body" >
       						  <div style='width:800px;margin:10px auto; padding:10px;background-color:white; '>	
                   		<div class="form-group row"  style='justify-content:center'>
    						<label for="memberId" class="col-sm-2 col-form-label">會員編號</label>
    						<div class="col-sm-8">
     						 	<input type="text" class="form-control" id="memberId" placeholder="memberId" style='background-color:#FFF8D7'>
    							<span id='result0c' style="height: 10px;"></span>
    						</div>
  						</div>
                   		<div class="form-group row"  style='justify-content:center'>
    						<label for="instructorName" class="col-sm-2 col-form-label">講師名稱</label>
    						<div class="col-sm-8">
     						 	<input type="text" class="form-control" id="instructorName" placeholder="instructorName" style='background-color:#FFF8D7'>
    							<span id='result1c' style="height: 10px;"></span>
    						</div>
  						</div>
  						<div class="form-group row"  style='justify-content:center'>
    						<label for="type" class="col-sm-2 col-form-label">講師類別</label>
    						<div class="col-sm-8">
     						 	<select id="type" class="form-control" style='background-color:#FFF8D7'>
      							  <option selected>請選擇...</option>
    						    </select>
    							<span id='result2c' style="height: 10px;"></span>
    						</div>
  						</div>
  						<div class="form-group row"  style='justify-content:center'>
    						<label for="brief" class="col-sm-2 col-form-label">簡介</label>
    						<div class="col-sm-8">
     						 	<textarea class="form-control" id="brief" placeholder="最多55字" maxlength="50"style='background-color:#FFF8D7'></textarea>
    							<span id='result3c' style="height: 10px;"></span>
    						</div>
  						</div>
  						<div class="form-group row"  style='justify-content:center'>
    						<label for="experience1" class="col-sm-2 col-form-label">經歷</label>
    						<div class="col-sm-8" >
     						 	<input type="text" style="margin-top:5px;background-color:#FFF8D7" class="form-control" id="experience1" placeholder="experience1" >
    							<span id='result4c' style="margin-top:5px;height: 10px;"></span>
    							<input type="text"  style="margin-top:5px;background-color:#FFF8D7"class="form-control" id="experience2" placeholder="experience2" >
    							<span id='result5c' style="margin-top:5px;height: 10px;"></span>
    						</div>
  						</div>
  						<div class="form-group row"  style='justify-content:center'>
    						<label for="experience1" class="col-sm-2 col-form-label">專業領域</label>
    						<div class="col-sm-8" >
     						 	<input type="text" style="margin-top:5px;background-color:#FFF8D7" class="form-control" id="speciality1" placeholder="speciality1" >
    							<span id='result6c' style="margin-top:5px;height: 10px;" ></span>
    							<input type="text"  style="margin-top:5px;background-color:#FFF8D7"class="form-control" id="speciality2" placeholder="speciality2" >
    							<span id='result7c' style="margin-top:5px;height: 10px;" ></span>
    						</div>
  						</div>
  						<div class="form-group row"  style='justify-content:center'>
    						<label for="experience1" class="col-sm-2 col-form-label">證照</label>
    						<div class="col-sm-8" >
     						 	<input type="text" style="margin-top:5px;background-color:#FFF8D7" class="form-control" id="certification1" placeholder="certification1" >
    							<span id='result8c' style="margin-top:5px;height: 10px;" ></span>
    							<input type="text"  style="margin-top:5px;background-color:#FFF8D7"class="form-control" id="certification2" placeholder="certification2" >
    							<span id='result9c' style="margin-top:5px;height: 10px;" ></span>
    						</div>
  						</div>
  						 <div class="form-group row"  style='justify-content:center'>
  						 	 <label for="inputFileToLoad" class="col-sm-2 col-form-label">封面照</label>
  						 	 <div class="col-sm-8" >
  							  	<input type="file" class="custom-file-input" id="inputFileToLoad" accept="image/jpeg, image/png" onchange="loadImageFileAsURL();" required >
   							 	<label class="custom-file-label"  for="inputFileToLoad" style='background-color:#FFF8D7'>挑選檔案</label>
   							 	<img id="showimg" src="" />
   							 </div>
  						</div>
  						<div class="form-group row"  style='justify-content:center'>
  							<div class="col-sm-8" style='margin-left:auto'>
  								<button id='sendData' class="btn btn-success">送出</button>
  								<span id='resultMsg' style="height: 18px; font-weight: bold;"></span>
  							</div>
  						</div>
  					</div>
    				 </div>
					</div>               
                  </div>
                  
                 
					
						
					
					
					<div class="container" id="dataArea" align="center">
  						
                	</div>
					
                </div>
            </div>
        </div>
        
        
        
</body>
</html>