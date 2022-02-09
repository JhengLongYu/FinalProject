<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>健康運動整合平台 | 健康中心</title>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
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

<script>
	var hasError = false;

	window.onload = function() {

		var resultmbname = "";
		var alink = document.getElementById("accountCheck");
		var div = document.getElementById('result0c');
		var sendData = document.getElementById("sendData");
		var namevalue  = "" ;
		var healthCenter = "" ;
		
		if(age.value == ""){			
		var xhr3 = new XMLHttpRequest();
		let url3 = "<c:url value='/healthCenter/getmembervalue/' />?mbid=" + "${mbid}";
		xhr3.open("Get", url3, true);
		xhr3.send();
		xhr3.onreadystatechange = function() {
			if (xhr3.readyState == 4 && (xhr3.status == 200 || xhr3.status == 201)) {
					healthCenter = JSON.parse(xhr3.responseText);
					if(healthCenter.size != "null"){
					age.value = healthCenter.age;
					height.value = healthCenter.height;
					kg.value = healthCenter.kg;
					expect.value = healthCenter.expect;
					bloodpressure.value = healthCenter.bloodpressure;
					Heartbeat.value = healthCenter.heartbeat;
						if(healthCenter.checkform == 10 ){
							alert("簽到已滿十點 幫您+諮詢點數優");
							window.location.href = "<c:url value='/consultion/listPage/' />"+"${mbid}";
						}
					  }
					}	
			}
		}	
		
		var xhr = new XMLHttpRequest();
		let url = "<c:url value='/insertCenter/getname/' />?mbid=" + "${mbid}";
		console.log(url);
		xhr.open("Get", url, true);
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && (xhr.status == 200 || xhr.status == 201)) {
				resultmbname = xhr.responseText;
				console.log("resultmbname = " + resultmbname);
				
				namevalue = resultmbname;

			}
		}

		sendData.onclick = function() {
			if (confirm("請問是否確定送出?????")) {
				console.log("namevalue = " +namevalue);
				hasError = false;
				// 讀取欄位資料	  
				var idfrom = "${mbid}"
				var idfromValue = idfrom.toString();
				;//先寫死之後再從登入拿
				
				var ageValue = document.getElementById("age").value;
				var heightValue = document.getElementById("height").value;
				var kgValue = document.getElementById("kg").value;
				var expectValue = document.getElementById("expect").value;
				var bloodpressureValue = document
						.getElementById("bloodpressure").value;
				var heartbeatValue = document.getElementById("Heartbeat").value;
				var checkformValue = document.getElementById("checkform").value;
				var div0 = document.getElementById('result0c');
				var div1 = document.getElementById('result1c');
				var div2 = document.getElementById('result2c');
				var div3 = document.getElementById('result3c');
				var div4 = document.getElementById('result4c');
				var div5 = document.getElementById('result5c');
				var div6 = document.getElementById('result6c');
				var div7 = document.getElementById('result7c');
				var divResult = document.getElementById('resultMsg');
				
				if (!ageValue) {
					setErrorFor(div1, "請輸入年齡");
				} else {
					var objRegex = /^\d+$|(^-?\d\d*\.\d\d*$)|(^-?\.\d\d*$)/;
					if (!objRegex.test(heightValue)) {
						setErrorFor(div1, "年齡欄必須是數值");
					} else {
						if (ageValue >180) {
							setErrorFor(div1, "您的年齡接近神木搂");
						} else {
						div1.innerHTML = "";
						}
					}
				}
				if (!heightValue) {
					setErrorFor(div2, "請輸入身高");
				} else {
					var objRegex = /^\d+$|(^-?\d\d*\.\d\d*$)|(^-?\.\d\d*$)/;
					if (!objRegex.test(heightValue)) {
						setErrorFor(div2, "身高欄必須是數值");
					} else {
						if (heightValue >= 300) {
							setErrorFor(div2, "您的身高超越了人類的歷史");
						} else {
							div2.innerHTML = "";
						}
					}
				}
				if (!kgValue) {
					setErrorFor(div3, "請輸入體重");
				} else {
					var objRegex = /^\d+$|(^-?\d\d*\.\d\d*$)|(^-?\.\d\d*$)/;
					if (!objRegex.test(kgValue)) {
						setErrorFor(div3, "體重欄必須是整數");
					} else {
						if (kgValue >= 1000) {
							setErrorFor(div3, "您的體重超越了人類的歷史");
						} else {
							div3.innerHTML = "";
						}
					}
				}
				if (!expectValue) {
					setErrorFor(div4, "請輸入您的期許");
				} else {
					div4.innerHTML = "";
				}
				if (!bloodpressureValue) {
					setErrorFor(div5, "請輸入血壓");
				} else {
					var objRegex = /^\d+$|(^-?\d\d*\.\d\d*$)|(^-?\.\d\d*$)/;
					if (!objRegex.test(bloodpressureValue)) {
						setErrorFor(div5, "血壓必須是數值");
					} else {
						if (bloodpressureValue > 200) {
							setErrorFor(div5, "您的血壓超越極限了");
						} else {
							div5.innerHTML = "";
						}
					}
				}
				if (!heartbeatValue) {
					setErrorFor(div6, "請輸入心率");
				} else {
					var objRegex = /^\d+$|(^-?\d\d*\.\d\d*$)|(^-?\.\d\d*$)/;
					if (!objRegex.test(heartbeatValue)) {
						setErrorFor(div6, "心率必須是數值");
					} else {
						if (heartbeatValue > 200) {
							setErrorFor(div6, "您的心率超越極限了");
						} else {
							div6.innerHTML = "";
						}
					}
				}
				if (!checkformValue) {
					setErrorFor(div7, "記得簽到喔");
				} else {
					div7.innerHTML = "";
				}
				if (hasError) {
					return false;
				}
				var xhr1 = new XMLHttpRequest();
				xhr1.open("POST", "<c:url value='/insertCenter' />", true);
				// 下方為一個Javascript物件 一定要與後端對應
				
				var jsonMember = {
					"idfrom" : idfromValue,
					"age" : ageValue,
					"name" : namevalue,
					"height" : heightValue,
					"kg" : kgValue,
					"expect" : expectValue,
					"bloodpressure" : bloodpressureValue,
					"heartbeat" : heartbeatValue,
					"checkform" : checkformValue
				}
				xhr1.setRequestHeader("Content-Type", "application/json");
				xhr1.send(JSON.stringify(jsonMember));
				console.log(JSON.stringify(jsonMember));
				/*  
				JSON.stringify(jsonMember);  // 將JavaScript物件轉換為JSON字串
				    
				JSON.parse(jsonString);      // 將JSON字串轉換為JavaScript物件
				 */
				//      以下敘述錯誤  		
				// 					xhr1.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
				// 			   		xhr1.send("idfrom=" + idfromValue +"&name=" + nameValue + "&height=" + heightValue 
				// 			   				+ "&kg=" + kgValue+"&expect="+expectValue+"&bloodpressure="+bloodpressureValue
				// 			   				+"&heartbeat="+ heartbeatValue +"&checkform="+checkformValue);
				xhr1.onreadystatechange = function() {
					// 伺服器請求完成
					if (xhr1.readyState == 4
							&& (xhr1.status == 200 || xhr1.status == 201)) {
						result = JSON.parse(xhr1.responseText);
						if (result.fail) {
							alert(result.fail);
						} else if (result.success) {
							alert(result.success);
							
							div1.innerHTML = "";
							div2.innerHTML = "";
							div3.innerHTML = "";
							div4.innerHTML = "";
							div5.innerHTML = "";
							div6.innerHTML = "";
							div7.innerHTML = "";
						} else {
							
							if (result.ageError) {
								div1.innerHTML = "<font color='green' size='-2'>"
										+ result.ageError + "</font>";
							} else {
								div1.innerHTML = "";
							}
							if (result.heightError) {
								div2.innerHTML = "<font color='green' size='-2'>"
										+ result.heightError + "</font>";
							} else {
								div2.innerHTML = "";
							}
							if (result.kgError) {
								div3.innerHTML = "<font color='green' size='-2'>"
										+ result.kgError + "</font>";
							} else {
								div3.innerHTML = "";
							}
							if (result.expectError) {
								div4.innerHTML = "<font color='green' size='-2'>"
										+ result.expectError + "</font>";
							} else {
								div4.innerHTML = "";
							}
							if (result.bloodpressureError) {
								div5.innerHTML = "<font color='green' size='-2'>"
										+ result.bloodpressureError + "</font>";
							} else {
								div5.innerHTML = "";
							}
							if (result.heartbeatError) {
								div6.innerHTML = "<font color='green' size='-2'>"
										+ result.HeartbeatError + "</font>";
							} else {
								div6.innerHTML = "";
							}
							if (result.checkformError) {
								div7.innerHTML = "<font color='green' size='-2'>"
										+ result.checkformError + "</font>";
							} else {
								div7.innerHTML = "";
							}
						}
					}
				}
				console.log("確定送出");
				return true;
			} else {
				return false;
			}
		}

		function setErrorFor(input, message) {
			input.innerHTML = "<font color='red' size='-2'>" + message
					+ "</font>";
			hasError = true;
		}

		let showimg = document.getElementById("showimg");
		//以mbid
		var xhr5 = new XMLHttpRequest();
		let url2 = "<c:url value='/memberManagement/' />" + "${mbid}";
		xhr5.open("GET", url2);
		xhr5.send();
		xhr5.onreadystatechange = function() {
			if (xhr5.readyState == 4 && xhr5.status == 200) {
				//console.log(xhr.responseText);
			}
			var imageURL = "<c:url value='/getImage' />";
			showimg.src = imageURL + "?mbid=" + "${mbid}";
			showimg.style="";
		}
	}
</script>
</head>

<body id="page-top">
	<%@include file="../../navigation.jsp"%>

	<!-- Navigation-->

	<div class="navbg"></div>
	<!--content 請將以下div刪除改成自己的內容-->
	<div class="mainContent">
		<!-- 側邊欄 -->
		<div class="sideNav">
			<div class="memberImgBox">
				<img style="display: none;" src="${pageContext.request.contextPath}/images/member_0.png"
					id="showimg" alt="memberPhoto" class="memberImg">
			</div>
			<div class="memberHelloBox">
				<span class="hello_text">Hello！${user}</span>
			</div>
			<div class="line"></div>
			<div class="linkBox"></div>
			<a href="<c:url value='/memberCenter_editInfo'/>" class="link"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-01.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">會員資料</span>
			</a> <a href="<c:url value='/addMemberForm' />" class="link link_here">
				<img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-02.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">健康紀錄</span>
			</a> <a href="<c:url value='/articleCenter_editInfo'/>" class="link"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-03.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">文章收藏</span>
			</a> <a href="<c:url value='/findAllShoppingCartItem'/>" class="link"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-04.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">購物車</span>
			</a> <a href="<c:url value='/orderManagementByUser'/>" class="link"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-05.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">訂單查詢</span>
			</a> <a href="<c:url value='/consultion/listPage/${mbid}'/>" class="link"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-06.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">預約諮詢</span>
			</a>
		</div>

		<!-- 內容區塊 -->
		<div class="ContentBox">

			<div class="switchBtnBox">

				<a href="<c:url value='/addMemberForm' />"
					class="switchBtn info_here"> <span class="switchText"> 基本資料 </span>
				</a> <a href="<c:url value='/healthCentercheck'  />" class="switchBtn">
					<span class="switchText"> bmi&bmr </span>
				</a> <a href="<c:url value="/healthCenter/record2/"/>" class="switchBtn">
					<span class="switchText"> 每日飲食</span>
				</a> <a href="<c:url value='/healthCenter/foods' />" class="switchBtn">
					<span class="switchText"> findfood</span>
				</a> <a href="<c:url value='/healthCenter/consume/' />"
					class="switchBtn"> <span class="switchText"> 消耗卡路里</span>
				</a>

			</div>

			<div class="InfoBox">

				

				<div class="inputBox">
					<label for="age" class="labelText">年齡</label> <input id="age"
						type="text" class="input"> <span id='result1c'
						style="height: 10px;width='200';"></span>
				</div>
				<div class="inputBox">
					<label for="height" class="labelText">身高</label> <input id="height"
						type="text" class="input"> <span id='result2c'
						style="height: 10px;width='200';"></span>
				</div>

				<div class="inputBox">
					<label for="kg" class="labelText">體重</label> <input id="kg"
						type="text" class="input"> <span id='result3c'
						style="height: 10px;"></span>
				</div>

				<div class="inputBox">
					<label for="expect" class="labelText">期許</label> <input id="expect"
						type="text" class="input"> <span id='result4c'
						style="height: 10px;"></span>
				</div>

				<div class="inputBox">
					<label for="bloodpressure" class="labelText">血壓</label> <input
						id="bloodpressure" type="text" class="input"> <span
						id='result5c' style="height: 10px;"></span>
				</div>

				<div class="inputBox">
					<label for="Heartbeat" class="labelText">心率</label> <input
						id="Heartbeat" type="text" class="input"> <span
						id='result6c' style="height: 10px;"></span>
				</div>

				<div class="inputBox">
					<label for="checkform" class="labelText">簽到</label> <input 
						id="checkform" type="radio" class="input" value='1' style="width: 30px;height: 30px;"> <span
						id='result7c' style="height: 10px;"></span>
				</div>

				<div id='resultMsg' class="resultMsg"></div>
				<div class="submitBox">
					<button id="sendData" class="submitBtn">儲存變更</button>
				</div>
			</div>
		</div>

	</div>

</body>
</html>