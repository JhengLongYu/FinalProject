<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link href="${pageContext.request.contextPath}/css/mgstyles.css" rel="stylesheet" />
<script type="text/javascript" src="<c:url value='/webjars/jquery/3.6.0/jquery.js'/>"></script>
<script>
var hasError = false;
let fileDataURL = null;
window.onload = function(){
	let dataArea = document.getElementById("dataArea");
	

	var sendData =document.getElementById("sendData");
	fileDataURL = document.getElementById("inputFileToLoad");
	inputFileToLoad.addEventListener('change', loadImageFileAsURL);
	
	sendData.addEventListener('click', checkAndSendData);
}
	function checkAndSendData(){
		hasError = false;
		var name = document.getElementById("name").value;
		var price = document.getElementById("price").value;
		var category = document.getElementById("category").value;
// 		var picture = document.getElementById("picture").value;
		
		var div1 = document.getElementById('result1c');
		var div2 = document.getElementById('result2c');
		var div3 = document.getElementById('result3c');
		var divResult = document.getElementById('resultMsg');
		
		if (!name){
			setErrorFor(div1, "請輸入產品名稱");
   		} 	else {
      		div1.innerHTML = "";
   		}
		if (!price){
			setErrorFor(div2, "請輸入金額");
   		} 	else {
      		div2.innerHTML = "";
   		}
		if (!category){
			setErrorFor(div3, "請選擇產品類型");
   		} 	else {
      		div3.innerHTML = "";
   		}
		loadImageFileAsURL();
		if(!fileDataURL){
			console.log("no pic"+fileDataURL);
		}
		if (hasError){
	   		return false;
			}
		var product = {
				"name": name,
				"price": price,
				"category": category,
				"fileDataUrl":fileDataURL				
		}
		jsonProduct = JSON.stringify(product);
		console.log("fileDataUrl" + fileDataURL);
		var xhr1 = new XMLHttpRequest();
		xhr1.open("POST","<c:url value='/product/save'/>", true);
		xhr1.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
		console.log(fileDataURL);
		xhr1.send(jsonProduct);
		xhr1.onreadystatechange = function (){
			if(xhr1.readyState == 4 && xhr1.status == 200 ){
				result = JSON.parse(xhr1.responseText);
				if(xhr1.responseText!=null){
					alert("新增成功");
				 	document.getElementById("name").value= "";
					document.getElementById("price").value= "";
					document.getElementById("category").value= "";
					fileDataURL = null;
					document.getElementById("showimg").src="";
					showimg.style.display = 'none';
					div1.innerHTML = "";
					div2.innerHTML = "";
					div3.innerHTML = "";
				}
				
			else{
				alert("新增失敗");
			}
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
</script>
<script type="text/javascript"
	src="<c:url value='/webjars/jquery/3.6.0/jquery.js'/>"></script>
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />

<link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&display=swap" rel="stylesheet">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="${pageContext.request.contextPath}/css/mgstyles.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/js/mgscripts.js"></script>
<link rel="stylesheet"
	href='<c:url value='/webjars/bootstrap/4.6.0/css/bootstrap.css' />' />
<script type="text/javascript"
	src="<c:url value='/webjars/bootstrap/4.6.0/js/bootstrap.bundle.js'/>"></script>
<link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&display=swap" rel="stylesheet">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/management_member.css">
<meta charset="UTF-8">
<title>商品列表 | 後台-新增產品</title>
</head>
<body id="page-top" style="background-color:#FFA6FF;">
	 <div class="d-flex" id="wrapper">
	  <%@include file="../mgsidebar.jsp"%>
            <!-- Page content wrapper-->
            <div id="page-content-wrapper"  style="background-color: 	#F0F0F0;">
            <%@include file="../mgnavigation.jsp"%>
                <!-- Page content-->
					<div class="container" style="margin-top:5px">
     <div class="container-fluid" >
     <br>
                 <a class="btn btn-warning" href="<c:url value='/findproductForm'/>">產品列表</a>
                 <a class="btn btn-warning" href="<c:url value='/addForm'/>">新增產品</a>
                 <br><br>
                   <div style='width:800px;margin:10px auto; padding:10px;background-color:white; '>
                 
		<div id='resultMsg' style="height: 18px; font-weight: bold;"></div>
		<br>
		
     <div class="form-group row"  style='justify-content:center'>
    		<label for="memberId" class="col-sm-2 col-form-label">產品名稱</label>
    		<div class="col-sm-8">
     		<input type="text" class="form-control" id="name" placeholder="請輸入產品名稱" style='background-color:#FFF8D7'>
    		<span id='result1c' style="height: 10px;"></span>
    		</div>
  	</div>
  	<br>
  	     <div class="form-group row"  style='justify-content:center'>
    		<label for="memberId" class="col-sm-2 col-form-label">產品價格</label>
    		<div class="col-sm-8">
     		<input type="text" class="form-control" id="price" placeholder="請輸入產品價格" style='background-color:#FFF8D7'>
    		<span id='result2c' style="height: 10px;"></span>
    		</div>
  	</div>
  	<br>
  	     <div class="form-group row"  style='justify-content:center'>
    		<label for="memberId" class="col-sm-2 col-form-label">產品類型</label>
    		<div class="col-sm-8">
     		<select type="text" class="form-control" id="category" placeholder="請選擇產品類別" style='background-color:#FFF8D7'>
     			<option value="Meal" id="meal">健康餐盒</option>
				<option value="Fitness" id="fitness">健身器材</option>
				<option value="Healthy" id="healthy">運動補充</option>
				<option value="Point" id="point">諮詢點數</option>
			</select>
    		<span id='result3c' style="height: 10px;"></span>
    		</div>
  	</div>
  	<br>
  	     <div class="form-group row"  style='justify-content:center'>
  			 <label for="inputFileToLoad" class="col-sm-2 col-form-label">產品圖片</label>
  			 <div class="col-sm-8" >
  		    	<input type="file" class="custom-file-input" id="inputFileToLoad" accept="image/jpeg, image/png" onchange="loadImageFileAsURL();" required >
   				<label class="custom-file-label"  for="inputFileToLoad" style='background-color:#FFF8D7'>挑選檔案</label>
   				<img id="showimg" src="" />
   	 		 </div>
  		 </div>
  		 <br>
           	<div class="form-group row"  style='justify-content:center'>
  			    <div class="col-sm-8" style='padding-left:240px'>
  			    <button id='sendData' class="btn" style="background-color: #ffc107">新增</button>
  			    <span id='resultMsg' style="height: 18px; font-weight: bold;"></span>
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