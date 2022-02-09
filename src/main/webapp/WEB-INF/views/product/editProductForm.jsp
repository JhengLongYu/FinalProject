<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath}/css/mgstyles.css" rel="stylesheet" />
<link rel='stylesheet' href="<c:url value='/css/style.css' />"
	type="text/css" />
<title>商品列表 | 後台-修改商品</title>
<script>
	let sid = "${idid}";
	let pk = 0;
	let fileDataURL = null;
	let name = null;
	window.onload = function() {
		var divResult = document.getElementById('resultMsg');
		let id = document.getElementById("id");
		name = document.getElementById("name");
		console.log(name);
		let price = document.getElementById("price");
		let category = document.getElementById("category");
		let sendData = document.getElementById("sendData");
		let deleteData = document.getElementById("deleteData");
		fileDataURL = document.getElementById("inputFileToLoad");
		
		loadData();
		 
	    let showimg = document.getElementById("showimg");;
	    inputFileToLoad.addEventListener('change',loadImageFileAsURL);
	    
	    sendData.addEventListener('click', checkAndSendData);
	    deleteData.addEventListener('click', deleteDatabtn);
	}
	function loadData(){
		console.log(name);
		let xhr = new XMLHttpRequest();

		xhr.open("GET", "<c:url value='/ajax/member?id=' />" + sid);
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {

				let product = JSON.parse(xhr.responseText);		
				id.value = product.id;
				name.value = product.name;
				console.log(name);
				price.value = product.price;				
				if (product.category == "Meal") {
					document.getElementById("meal").selected = true;
				} else if (product.category == "Fitness") {
					document.getElementById("fitness").selected = true;
				} else if (product.category == "Healthy") {
					document.getElementById("healthy").selected = true;
				} else if (product.category == "Point") {
					document.getElementById("point").selected = true;
				}
			}
		}
			let imageURL = "<c:url value='/product/getPicture'/>";
			showimg.style.width='180px';
			showimg.style.height='180px';
			showimg.src=imageURL + "?id=" +sid;
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

		function checkAndSendData() {
			
			hasError = false;
            idVal = sid;
			let idValue = document.getElementById("id").value;
			let nameValue = document.getElementById("name").value;
			let priceValue = document.getElementById("price").value;
			var x = document.getElementById("category").selectedIndex;
			var y = document.getElementById("category").options;
			let categoryValue = y[x].value;
// 			console.log(categoryValue);
// 			let pictureValue = document.getElementById("picture").value;
loadImageFileAsURL();
			let obj = {
				"id" : idValue,
				"name" : nameValue,
				"price" : priceValue,
				"category" : categoryValue,
                "fileDataUrl" : fileDataURL
			};
			console.log("fileDataUrl" + fileDataURL);

			var xhr2 = new XMLHttpRequest();
			let url = "<c:url value='/product/update'  />" ;
			console.log(url);
			console.log(obj);
			xhr2.open("PUT", url);
			xhr2.setRequestHeader("Content-Type", "application/json");
			xhr2.send(JSON.stringify(obj));
			xhr2.onreadystatechange = function() {
				if (xhr2.readyState == 4 && xhr2.status == 200) {
					let result = JSON.parse(xhr2.responseText);
					if (result.fail) {
					  alert(result.fail);
					} else if (result.success) {
					  alert(result.success);
					}

				}
			}
		}
		function setErrorFor(input, message){
			input.innerHTML = "<font color='red' size='-2'>" + message + "</font>";
		    hasError = true;
		}

		
		function deleteDatabtn() {
			let idValue = document.getElementById("id").value;

			console.log(idValue);

			let xhr3 = new XMLHttpRequest();
			let url = "<c:url value='/deletes/'  />" +idValue;
			console.log(url);
			xhr3.open("DELETE", url);
			xhr3.setRequestHeader("Content-Type", "application/json");
			xhr3.send();
			xhr3.onreadystatechange = function() {
				if (xhr3.readyState == 4 && xhr3.status == 200) {
					let result = JSON.parse(xhr3.responseText);
					if (result.fail) {
						alert(result.fail);
					} else if (result.success) {
						alert(result.success);
					}

				}
			}
		}
		

	
</script>
<link rel='stylesheet' href="<c:url value='/css/style.css' />"
	type="text/css" />
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
<meta charset="UTF-8">

</head>
<body id="page-top">
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
    		<label for="memberId" class="col-sm-2 col-form-label">產品編號</label>
    		<div class="col-sm-8">
     		    <input type="text" class="form-control" id="id" disabled="disabled" style='background-color:#FFF8D7'>
    		    <span style="height: 10px;"></span>
    		</div>
      	</div>
      	
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
  			    <div class="col-sm-8" style='padding-left:215px'>
  			    <button id='sendData' class="btn" style="background-color: #ffc107">修改</button>
  			    <button id='deleteData' class="btn" style="background-color: #ffc107">刪除</button>
  			    <span id='resultMsg' style="height: 18px; font-weight: bold;"></span>
  			    </div>
  			</div>
			</div>	

	</div>
</div>
</div>
</div>
</body>
</html>