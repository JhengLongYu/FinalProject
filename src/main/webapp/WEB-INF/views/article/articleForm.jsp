<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>健康運動整合平台|發表文章</title>
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/images/favicon.ico" />
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css" />
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&display=swap"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/styles.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/styles1.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/scripts.js"></script>
<script type="text/javascript"
	src="<c:url value='/webjars/jquery/3.6.0/jquery.js'/>"></script>

<link rel="stylesheet"
	href='<c:url value='/webjars/bootstrap/4.6.0/css/bootstrap.css'/>' />
<script type="text/javascript"
	src="<c:url value='/webjars/bootstrap/4.6.0/js/bootstrap.bundle.js'/>"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<script src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
<script>
	var hasError = false;
	let fileDataURL = null;
	let mbId="${mbid}";
	window.onload = function() {
		let dataArea = document.getElementById("dataArea");
		//	findAlltype();
		var sendData = document.getElementById("sendData");
		fileDataURL = document.getElementById("inputFileToLoad");
		//文章封面上傳
		inputFileToLoad.addEventListener('change', loadImageFileAsURL);
		
		// 檢查及送出
		sendData.addEventListener('click', checkAndSendData);
		
		//Tag 類別選單
		findALLTagOption();
		
		CKEDITOR.replace('articleText', {
			height:400,
			width:1000
		});
		
	}
	
	
	function findALLTagOption() {	//Tag 類別選單
		let selectElement = document.getElementById("articleTag");
		let articleTagData = [];
		let xhr3 = new XMLHttpRequest();
		xhr3.open("GET", "<c:url value='/tag/findAll'/>", true);
		xhr3.send();
		xhr3.onreadystatechange = function() {
			if (xhr3.readyState == 4 && xhr3.status == 200) {
				let tags = JSON.parse(xhr3.responseText);
				for (let i = 0; i < tags.length; i++){
					let tag = [tags[i].tag_name, tags[i].tag_id];
					articleTagData.push(tag);
				}
				for (let i = 0; i < articleTagData.length; i++) {
					let option = new Option(articleTagData[i][0], articleTagData[i][1]);
					selectElement.options[selectElement.options.length] = option;
				}
			}
		}
		
		selectElement.onchange = function(){
			var tagId = selectElement.options[ selectElement.selectedIndex ].value;
		}
		
	}

	function checkAndSendData() {
		hasError = false;
		var articleTitle = document.getElementById("articleTitle").value;
//		var x = document.getElementById("type").selectedIndex;
//		var y = document.getElementById("type").options;
//		console.log(y[x].value);
//		var type = y[x].value;
		var articleTag = document.getElementById("articleTag").value;
		var articleText = CKEDITOR.instances.articleText.getData();
		
		var div1 = document.getElementById('result1c');
//		var div2 = document.getElementById('result2c');
		var divResult = document.getElementById('resultMsg');

		if (!articleTitle) {
			setErrorFor(div1, "請輸入文章標題");
		} else {
			div1.innerHTML = "";
		}
//		if (x == 0) {
//			setErrorFor(div2, "請輸入類別");
//		} else {
//			div2.innerHTML = "";
//		}
		loadImageFileAsURL();
		if (!fileDataURL) {
			console.log("no pic" + fileDataURL);
		}
		if (hasError) {
			return false;
		}

		var article = {
			"art_user_id" : mbId,
			"art_title" : articleTitle,
			"tag_id" : articleTag,
			"art_content" : articleText,
			"fileDataUrl" : fileDataURL
		}

		jsonArticle = JSON.stringify(article);
		var xhr1 = new XMLHttpRequest();
		xhr1.open("POST", "<c:url value='/article/save'/>", true);
		xhr1.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
		xhr1.send(jsonArticle);
		xhr1.onreadystatechange = function() {
			if (xhr1.readyState == 4 && xhr1.status == 200) {
				alert("發文成功");
	     		window.location.href = "<c:url value='/articleForum' />";
			}
		}
	}

	function setErrorFor(input, message) {
		input.innerHTML = "<font color='red' size='-2'>" + message + "</font>";
		hasError = true;
	}
	
	function loadImageFileAsURL() {
		let filesSelected = document.getElementById("inputFileToLoad").files;
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
			showimg.style.height = "180px";
		} else {
			fileDataURL = null;
			console.log("未選擇檔案");
		}
	}
	
	//一鍵輸入功能
	function oneKeyInput(){
		let articleTitle = document.getElementById("articleTitle"); 
		let articleTag = document.getElementById("articleTag"); 
		let articleText = document.getElementById("articleText");
		//標題
		articleTitle.value = "居家運動 5 招 提升免疫力"; 
		//文章種類
		articleTag.value = 1;
		//內容
		let content = "";
		content += "在家健身不擔心群聚感染 專家分享不需器材的鍛鍊法近期疫情動盪，讓許多人減少外出來居家防疫，但在家的時間變多，卻都坐在沙發或躺在床上，想去健身房運動，卻擔心群聚會有風險，長期下來對身心健康也有影響。";
		content += "「在家」不該成為不運動的藉口，賀寶芙運動專家分享，在家的 5 個健身運動，養成規律運動健身，讓大家強健體魄更健康，讓情緒正向，充滿自信心。";
		content += "運動對於健康有許多好處，研究顯示，可以自然釋放腦內啡，加強正向情緒，也會使精神更愉悅。雖然工作忙碌、生活壓力大，只要透過規律運動、健康飲食與充足睡眠，身體也能提升對抗疾病的免疫力。";
		content += "但在家要如何開始運動呢？前奧運選手、賀寶芙全球運動表現與體適能副總裁 Samantha Clayton，特別分享 5 個在家能做的運動，不需要器具，每天只需每組做 10～12 次，重複 4 組，約 20 分鐘即可完成訓練。";
		content += "一、鍛練三頭肌（後手臂與肩膀）膝蓋微彎坐在地板上、將雙手置於身後，手指朝前，以手臂和腳支撐抬起臀部，彎曲手肘直到臀部接觸地板，然後推回到起始位置。想要更進階訓練，可以推舉時抬左腳，並伸出右臂。";
		content += "二、伏地挺身（鍛鍊全身肌群）手貼地且臉朝下，雙腳微開踩地，用手臂撐起身體，要注意縮腹防止臀部下垂。彎曲手肘維持 1 秒，胸壓向地，再回覆原始姿勢。";
		content += "三、單膝跪姿超人式（挑戰平衡、鍛鍊腹肌）四肢著地，手在肩正下方，膝蓋在臀正下方。保持背平坦。抬高右臂向前伸，左腿向後伸。再將左膝與右手肘往身體內縮互碰，做 10 下後換腳。";
		content += "四、深蹲（鍛鍊臀腿）雙腳打開比肩稍寬，重心置於腳跟，手掌向下伸直手臂與地平行。臀部向後坐，確保胸肩、背打直，眼睛直視前方，要注意掌握核心與站穩腳跟，盡可能將臀部低於膝蓋。";
		content += "五、弓箭步蹲（鍛鍊雙腿前後側）挺胸抬下巴縮腹，左腳向後跨一大步，後膝蓋向下蹲，前腳踏穩地面，將膝蓋往前抬高一秒，接著重複並換腳。想了解更多居家運動。";	
 		CKEDITOR.instances.articleText.setData(content);
	}

</script>

</head>
<body id="page-top" style="background-color: #ecf0f5">
	<%@include file="../navigation.jsp"%>
	<div class="navbg"></div>
	<!-- Page content-->

	<div class="container-fluid">
		<div
			style='width: 1200px; margin: 10px auto; padding: 10px; background-color: white;position:relative'>
			
			<button id="oneKeyInput" class="btn btn-warning" style="position:relative;top:0px;left:0px" onclick="oneKeyInput()"><i class='bi bi-pencil-square'></i></button>
			
			<div class="form-group row" style='justify-content: center'>
				<label for="articleTitle" class="col-sm-2 col-form-label">文章標題</label>
				<div class="col-sm-8">
					<input type="text" class="form-control" id="articleTitle"
						placeholder="請輸入文章標題" style='background-color: #FFF8D7'>
					<span id='result1c' style="height: 10px;"></span>
				</div>
			</div>
			
			<div class="form-group row" style='justify-content: center'>
				<label for="articleTag" class="col-sm-2 col-form-label">文章類別</label>
				<div class="col-sm-8">
					<select id="articleTag" class="form-control" style='background-color: #FFF8D7'>
					</select> <span id='result2c' style="height: 10px;"></span>
				</div>
			</div>
				
			<div class="form-group row" style='justify-content: center'>
				<label for="" class="col-sm-2 col-form-label">文章封面</label>
				<div class="col-sm-8">
					<input type="file" accept="image/jpeg, image/png" id="inputFileToLoad" 
					onchange="loadImageFileAsURL();">
					<img id="showimg" src="" />
				</div>
			</div>
			
			<!-- 文章內容 -->
			<div class="form-group row" style='justify-content: center'>
				<label for="" class="col-sm-2 col-form-label">文章內容</label>
				<div class="col-sm-8">
				</div>
			</div>
			<div class="form-group row" style='justify-content: center'>
				<textarea  class="col-sm-10" id="articleText"></textarea>
			</div>
			
			
			<div class="form-group row" style='justify-content: center'>
				<div class="d-grid gap-2 col-4 mx-auto mt-5">
					<button id='sendData' class="btn btn-warning">確定送出</button>
					<span id='resultMsg' style="height: 18px; font-weight: bold;"></span>
				</div>
			</div>
		</div>




		<div class="container" id="dataArea" align="center"></div>

	</div>


</body>
</html>