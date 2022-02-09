<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>健康運動整合平台|管理</title>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript"
	src="<c:url value='/webjars/jquery/3.6.0/jquery.js'/>"></script>
<link href="${pageContext.request.contextPath}/css/mgstyles.css"
	rel="stylesheet" />
<script src="${pageContext.request.contextPath}/js/mgscripts.js"></script>
<link rel="stylesheet"
	href='<c:url value='/webjars/bootstrap/4.6.0/css/bootstrap.css' />' />
<script type="text/javascript"
	src="<c:url value='/webjars/bootstrap/4.6.0/js/bootstrap.bundle.js'/>"></script>
<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js"
	crossorigin="anonymous"></script>
<!-- 新增googlefont   -->
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet">
<!-- 新增css樣式 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/management_member_edit.css">

<!-- 編輯程式 -->
<script>
	var hasError = false;
	let fileDataURL = null;
	window.onload = function() {
		let showimg = document.getElementById("showimg");
		fileDataURL = document.getElementById("inputFileToLoad");
		inputFileToLoad.addEventListener('change', loadImageFileAsURL);
		let sendData = document.getElementById("sendData");
		let sendData1 = document.getElementById("sendData1");
		sendData.addEventListener('click', checkAndSendData);
		sendData1.addEventListener('mouseover', movein);
		sendData1.addEventListener('mouseout', moveout);
		sendData1.addEventListener('click', SendData1);

	}
	function SendData1() {
		category.value = "拉麵";
		names.value = "一蘭拉麵";
		weight.value = "一份";
		calorie.value = 561;
		carbohydrates.value = 63;
		fat.value = 23;
		protein.value = 19;
	}

	function moveout() {
		sendData1.style.backgroundColor = "rgba(255,255,255,0.2)";
		sendData1.style.color = "rgba(255,255,255,0.2)";
		sendData1.style.border = "2px solid rgba(255,255,255,0.2)";
	}

	function movein() {
		sendData1.style.backgroundColor = "green";

	}

	function checkAndSendData() {
		if (confirm("請問是否確定送出?????")) {

			hasError = false;
			let categoryvalue = document.getElementById("category").value;
			let namevalue = document.getElementById("names").value;
			let weightvalue = document.getElementById("weight").value;
			let calorievalue = document.getElementById("calorie").value;
			let carbohydratesvalue = document.getElementById("carbohydrates").value;
			let fatvalue = document.getElementById("fat").value;
			let proteinvalue = document.getElementById("protein").value;
			var div0 = document.getElementById('result0c');
			var div1 = document.getElementById('result1c');
			var div2 = document.getElementById('result2c');
			var div3 = document.getElementById('result3c');
			var div4 = document.getElementById('result4c');
			var div5 = document.getElementById('result5c');
			var div6 = document.getElementById('result6c');

			if (!categoryvalue) {
				setErrorFor(div0,
						"<i class='fas fa-exclamation-circle'></i> 請輸入類別");
			} else {
				div0.innerHTML = "";
			}
			if (!namevalue) {
				setErrorFor(div1,
						"<i class='fas fa-exclamation-circle'></i> 請輸入食物名");
			} else {
				div1.innerHTML = "";
			}
			if (!weightvalue) {
				setErrorFor(div2,
						"<i class='fas fa-exclamation-circle'></i> 請輸入份量");
			} else {
				div2.innerHTML = "";
			}
			if (!calorievalue) {
				setErrorFor(div3,
						"<i class='fas fa-exclamation-circle'></i> 請輸入卡洛里");
			} else {
				var objRegex = /^\d+$|(^-?\d\d*\.\d\d*$)|(^-?\.\d\d*$)/;
				if (!objRegex.test(calorievalue)) {
					setErrorFor(div3, "卡洛里必須是數值");
				} else {
					if (calorievalue >= 1000) {
						setErrorFor(div3, "這食物到底要多大");
					} else {
						div3.innerHTML = "";
					}
				}
			}
			if (!carbohydratesvalue) {
				setErrorFor(div4,
						"<i class='fas fa-exclamation-circle'></i> 請輸入碳水化合物");
			} else {
				var objRegex = /^\d+$|(^-?\d\d*\.\d\d*$)|(^-?\.\d\d*$)/;
				if (!objRegex.test(carbohydratesvalue)) {
					setErrorFor(div4, "碳水化合物必須是數值");
				} else {
					if (carbohydratesvalue >= 1000) {
						setErrorFor(div4, "碳水化合物多到有毒");
					} else {
						div4.innerHTML = "";
					}
				}
			}
			if (!fatvalue) {
				setErrorFor(div5,
						"<i class='fas fa-exclamation-circle'></i> 請輸入脂肪數");
			} else {
				var objRegex = /^\d+$|(^-?\d\d*\.\d\d*$)|(^-?\.\d\d*$)/;
				if (!objRegex.test(fatvalue)) {
					setErrorFor(div5, "脂肪必須是數值");
				} else {
					if (fatvalue >= 200) {
						setErrorFor(div5, "應該沒人想吃油");
					} else {
						div5.innerHTML = "";
					}
				}
			}

			if (!proteinvalue) {
				setErrorFor(div6,
						"<i class='fas fa-exclamation-circle'></i> 請輸入蛋白質數");
			} else {
				var objRegex = /^\d+$|(^-?\d\d*\.\d\d*$)|(^-?\.\d\d*$)/;
				if (!objRegex.test(proteinvalue)) {
					setErrorFor(div6, "蛋白質必須是數值");
				} else {
					if (proteinvalue >= 400) {
						setErrorFor(div6, "蛋白質沒那麼高歐");
					} else {
						div6.innerHTML = "";
					}
				}
			}
			loadImageFileAsURL();
			if (!fileDataURL) {
				console.log("no pic");
			}
			if (hasError) {
				return false;
			}
			// 下方為一個Javascript物件 一定要與後端對應
			console.log("category = " + categoryvalue, "name = " + namevalue,
					"weight = " + weightvalue, "calorie = " + calorievalue,
					"carbohydrates = " + carbohydratesvalue, "fat = "
							+ fatvalue, "protein =" + proteinvalue,
					"fileDataUrl = " + fileDataURL);
			let obj = {
				"category" : categoryvalue,
				"name" : namevalue,
				"weight" : weightvalue,
				"calorie" : calorievalue,
				"carbohydrates" : carbohydratesvalue,
				"fat" : fatvalue,
				"protein" : proteinvalue,
				"fileDataUrl" : fileDataURL
			}

			var xhr1 = new XMLHttpRequest();
			let objs = JSON.stringify(obj);
			let url = "<c:url value='/CenterBack/foodsave/go'  />";
			xhr1.open("POST", url, true);
			xhr1.setRequestHeader("Content-Type",
					"application/json; charset=UTF-8");
			xhr1.send(objs);
			xhr1.onreadystatechange = function() {
				if (xhr1.readyState == 4
						&& (xhr1.status == 200 || xhr1.status == 201)) {
					let result = xhr1.responseText;
					console.log("result == " + result);
					if (result != "") {
						alert(result);
						window.location.href = "<c:url value='/_01/showAllMembers' />";
					}
				}

				console.log("確定送出");
				return true;
			}
		} else {
			return false;
		}

	}

	function setErrorFor(input, message) {
		//input.innerHTML = "<font color='red' size='-1'>" + message + "</font>";
		input.innerHTML = "<font>" + message + "</font>";
		hasError = true;
	}

	function loadImageFileAsURL() {
		let filesSelected = document.getElementById("inputFileToLoad").files;
		let showimg = document.getElementById("showimg");
		if (filesSelected.length > 0) {
			let fileToLoad = filesSelected[0];
			let fileReader = new FileReader();
			fileReader.onload = function(fileLoadedEvent) {
				fileDataURL = fileLoadedEvent.target.result;
				showimg.src = fileLoadedEvent.target.result;
			};
			fileReader.readAsDataURL(fileToLoad);
			showimg.style.display = 'block';
			showimg.style.width = "180px";
			showimg.style.height = "130px";
		} else {
			fileDataURL = null;
			console.log("未選擇檔案");
		}
	}
</script>
</head>

<body>
	<div class="d-flex" id="wrapper">
		<%@include file="../../../mgsidebar.jsp"%>
		<!-- Page content wrapper-->
		<div id="page-content-wrapper" style="background-color: #F0F0F0;">
			<%@include file="../../../mgnavigation.jsp"%>
			<!-- Page content-->
			<div class="container-fluid">
				<!--請將內容寫在此處-->
				<div class="mbContent">

					<div class="Content">

						<h1>食物新增</h1>
						<div class="inputBox">
							<label for="category"> 類別 </label> <input type="text"
								name="category" id="category" class="input"> <span
								id="result0c" class="checkTextFalse"></span>
						</div>


						<div class="inputBox">
							<label for="names"> 食物名 </label> <input type="text" name="names"
								id="names" class="input"> <span id="result1c"
								class="checkTextFalse"></span>
						</div>

						<div class="inputBox">
							<label for="weight"> 幾份or幾g </label> <input type="text"
								name="weight" id="weight" class="input"> <span
								id="result2c" class="checkTextFalse"></span>
						</div>

						<div class="inputBox">
							<label for="calorie">卡洛里 </label> <input type="text"
								name="calorie" id="calorie" class="input"> <span
								id="result3c" class="checkTextFalse"></span>
						</div>
						<div class="inputBox">
							<label for="carbohydrates"> 碳水化合物 </label> <input type="text"
								name="carbohydrates" id="carbohydrates" class="input"> <span
								id="result4c" class="checkTextFalse"></span>
						</div>
						<div class="inputBox">
							<label for="fat"> 脂肪 </label> <input type="text" name="fat"
								id="fat" class="input"> <span id="result5c"
								class="checkTextFalse"></span>
						</div>
						<div class="inputBox">
							<label for="protein"> 蛋白质 </label> <input type="text"
								name="protein" id="protein" class="input"> <span
								id="result6c" class="checkTextFalse"></span>
						</div>
						<div class="form-group row" style='justify-content: center'>
							<label for="inputFileToLoad" class="col-sm-2 col-form-label">照片</label>
							<div class="col-sm-8">
								<input type="file" class="custom-file-input"
									id="inputFileToLoad" accept="image/jpeg, image/png"
									onchange="loadImageFileAsURL();" required> <label
									class="custom-file-label" for="inputFileToLoad"
									style='background-color: #FFF8D7;'>挑選檔案</label> <img
									id="showimg" src="" style="padding-top: 10px;" />
							</div>
						</div>

						<div class="div__photo">
							<img id="showimg" src="" alt="" />
						</div>
						<!-- 						<div id='resultMsg' class="resultMsg"></div> -->

						<button id="sendData" class="sureEditBtn">確認新增</button>


					</div>
					<button id="sendData1"
						style="width: 50px; height: 50px; background-color: rgba(255, 255, 255, 0.2); color: rgba(255, 255, 255, 0.2); border: 2px solid rgba(255, 255, 255, 0.2); border-radius: 10px;">一鍵</button>
				</div>


			</div>
		</div>
	</div>

</body>
</html>