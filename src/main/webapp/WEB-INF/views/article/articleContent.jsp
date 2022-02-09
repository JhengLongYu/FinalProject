<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>健康運動整合平台|文章內容</title>
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

<style>
		.img_head {
            position: relative;
            width: 35px;
            height: 35px;
            /*padding-top: 5px;*/
            border-radius: 2px;
        }

        .content_link {
            color: black;
            text-decoration: none
        }

        .m_over {
            margin-left: 175px;
        }


        .img_head {
            position: relative;
            width: 35px;
            height: 35px;
            /*padding-top: 5px;*/
            border-radius: 2px;
        }

        .custom-width {
            max-width: 1320px;
        }

        .m_over {
            margin-left: 175px;
        }

        .content_type {
            padding: 32px 80px;
        }

        .time_type {
            display: block;
            font-size: 13px;
            margin-bottom: 5px;
            color: #999999;
        }

        .reply_time {
            font-size: 13px;
            margin-bottom: 5px;
            color: #999999;
        }

        .reply_img {
            border-radius: 99em;
            float: left;
            margin-right: 12px;
        }

        .reply_text {
            width: calc(100% - 110px);
            line-height: 1.5;
            margin: 8px;
            padding: 8px;
        }

        .reply_btn {
            line-height: 1.5;
            padding: 8px 12px;
            width: 80px;
            height: auto;
        }
</style>
<script type="text/javascript">
let mbId="${mbid}";
window.onload = function () {
    let replyArea = document.getElementById("replyArea");
    let goodbtn = document.getElementById("good_btn");
    let likeNumArea = document.getElementById("likeNumArea");
	var likeStatus = 1;
	let collectbtn = document.getElementById("collect_btn");
    var collectStatus = 1;
    let authorArea = document.getElementById("authorArea");
    findAllComment();
    findAuthor();
    checkCollectStatus()
    
    <!-- 檢查收藏狀態 -->
    function checkCollectStatus(){
    	let xhr8 = new XMLHttpRequest();
        xhr8.open("POST", "<c:url value='/collect/checkCollect'/>", true);
    	var jsonUpdate = {
            "art_id": ${article.art_id}, 					
            "collect_user_id":mbId
		}
    	xhr8.setRequestHeader("Content-Type", "application/json");
    	xhr8.send(JSON.stringify(jsonUpdate));
    	xhr8.onreadystatechange = function() {
            if (xhr8.readyState == 4 && xhr8.status == 200) {
            	if(xhr8.responseText != ""){
            		let col = JSON.parse(xhr8.responseText);
	            	if(col != null){
	            		collectStatus = 0;
	            		collectbtn.style.webkitFilter = "grayscale(" + collectStatus +")";
	    	            collectbtn.removeEventListener("mouseover",mouseOverCol);
	    	            collectbtn.removeEventListener("mouseout",mouseOutCol);
	    	            document.getElementById("collectArea").innerHTML = "已收藏文章"
	            	}
            	}
            }
    	}
    }
    
	<!-- 按讚按鈕 -->
	goodbtn.addEventListener("mouseover",mouseOver);
	goodbtn.addEventListener("mouseout",mouseOut);
	goodbtn.addEventListener("click",mouseClick);
	
	<!-- 收藏按鈕 -->
	collectbtn.addEventListener("mouseover",mouseOverCol);
    collectbtn.addEventListener("mouseout",mouseOutCol);
    collectbtn.addEventListener("click",mouseClickCol);
	
	<!-- 留言回覆按鈕 -->
    document.getElementById("reply_btn").addEventListener("click", replyComment);
	
    
    <!-- 按讚按鈕 -->
    function mouseOver(){
		goodbtn.style.webkitFilter = "grayscale(0)";
	}

	function mouseOut(){
		goodbtn.style.webkitFilter = "grayscale(1)";
	}

	function mouseClick(){
		if(likeStatus == 1){
			likeStatus = 0;
			goodbtn.style.webkitFilter = "grayscale(" + likeStatus +")";
			goodbtn.removeEventListener("mouseover",mouseOver);
			goodbtn.removeEventListener("mouseout",mouseOut);
			let xhr2 = new XMLHttpRequest();
			url = "<c:url value='/article/articleContent/likeStatusAdd'/>?art_id=" + ${article.art_id};
			xhr2.open("GET", url, true);
			xhr2.send();
			xhr2.onreadystatechange = function() {
				if (xhr2.readyState == 4 && xhr2.status == 200) {
					likeNumArea.innerHTML = xhr2.responseText + "個人按讚";
				}
			}
		}else{
			likeStatus = 1;
			goodbtn.style.webkitFilter = "grayscale(" + likeStatus +")";
			goodbtn.addEventListener("mouseover",mouseOver);
			goodbtn.addEventListener("mouseout",mouseOut);
			let xhr3 = new XMLHttpRequest();
			url = "<c:url value='/article/articleContent/likeStatusReduce'/>?art_id=" + ${article.art_id};
			xhr3.open("GET", url, true);
			xhr3.send();
			xhr3.onreadystatechange = function() {
				if (xhr3.readyState == 4 && xhr3.status == 200) {
					likeNumArea.innerHTML = xhr3.responseText + "個人按讚";
				}
			}
		}
	 }
	
	<!-- 收藏按鈕 -->
	 function mouseOverCol(){
         collectbtn.style.webkitFilter = "grayscale(0)";
     }

     function mouseOutCol(){
         collectbtn.style.webkitFilter = "grayscale(1)";
     }

     function mouseClickCol(){
    	 if(mbId==""){
     		alert("請先登入帳號");
     		window.location.href = "<c:url value='/login' />";
     	 }else{
	        if(collectStatus == 1){
	            collectStatus = 0;
	            collectbtn.style.webkitFilter = "grayscale(" + collectStatus +")";
	            collectbtn.removeEventListener("mouseover",mouseOverCol);
	            collectbtn.removeEventListener("mouseout",mouseOutCol);
	            document.getElementById("collectArea").innerHTML = "已收藏文章"
	            let xhr5 = new XMLHttpRequest();
	        	xhr5.open("POST", "<c:url value='/collect/saveCollect'/>", true);
	        	var jsonUpdate = {
		            "art_id": ${article.art_id}, 					
		            "collect_user_id":mbId
				}
		        xhr5.setRequestHeader("Content-Type", "application/json");
		        xhr5.send(JSON.stringify(jsonUpdate));
		        xhr5.onreadystatechange = function() {
		            if (xhr5.readyState == 4 && xhr5.status == 200) {
		            }
		        }
	
	        }else{
	            collectStatus = 1;
	            collectbtn.style.webkitFilter = "grayscale(" + collectStatus +")";
	            collectbtn.addEventListener("mouseover",mouseOverCol);
	            collectbtn.addEventListener("mouseout",mouseOutCol);
	            document.getElementById("collectArea").innerHTML = "收藏文章"
	            let xhr7 = new XMLHttpRequest();
	            xhr7.open("POST", "<c:url value='/collect/deleteCollect'/>", true);
	        	var jsonUpdate = {
		            "art_id": ${article.art_id}, 					
		            "collect_user_id":mbId
				}
	        	xhr7.setRequestHeader("Content-Type", "application/json");
	        	xhr7.send(JSON.stringify(jsonUpdate));
	        	xhr7.onreadystatechange = function() {
		            if (xhr7.readyState == 4 && xhr7.status == 200) {
		            }
		        }
	        }
     	 }   
     }
    
    
    <!-- 留言回覆按鈕 -->
    function replyComment(){
        let text = document.getElementById("reply_text").value;
        document.getElementById("reply_text").value = "";
        if(mbId==""){
    		alert("請先登入帳號");
    		window.location.href = "<c:url value='/login' />";
    	}else{
        	let xhr = new XMLHttpRequest();
        	xhr.open("POST", "<c:url value='/comment/addComment'/>", true);
        	var jsonUpdate = {
	            "art_id" : ${article.art_id}, 					
	            "com_content" : text, 
	            "user_id" : mbId,
	            "com_state" : 0
			}
	        xhr.setRequestHeader("Content-Type", "application/json");
	        xhr.send(JSON.stringify(jsonUpdate));
	        xhr.onreadystatechange = function() {
	            if (xhr.readyState == 4 && xhr.status == 200) {
	            	replyArea.innerHTML = showAllReplyData(xhr.responseText);
	            }
	        }
    	}
    }
        
    <!-- 作者區 -->
    function findAuthor(){
    	let xhr6 = new XMLHttpRequest();
		url = "<c:url value='/article/articleContent/author'/>?art_user_id=" + ${article.art_user_id};
		xhr6.open("GET", url, true);
		xhr6.send();
		xhr6.onreadystatechange = function() {
			if (xhr6.readyState == 4 && xhr6.status == 200) {
				authorArea.innerHTML = showAuthorData(xhr6.responseText);
			}
		}
    }
    
    function showAuthorData(jsonString){
    	let map = JSON.parse(jsonString);
		let imageURL = "<c:url value='/getImage' />";
		let segment = "";
		segment += "<img src='" + imageURL + "?mbid=" + ${article.art_user_id} + "' style='width: 150px;height: 150px ;display:block; margin:auto; border-radius: 99em;'>";
		segment += "<h6 class='card-title' style='text-align:center; padding-top:20px'>" + map.mbname + "</h6>";
		segment += "<table class='table table-borderless'>";
		segment += "<tr align='center'><th>發文數</th><th>案讚數</th><th>瀏覽數</th></tr>";
		segment += "<tr align='center'><th>" + map.postNum + "</th><th>" + map.goodNum + "</th><th>" + map.viewNum + "</th></tr>";
		segment += "</table>";
		return segment;
    }
    
}

	<!-- 留言刪除按鈕 -->
	function deleteReply(comId){
		if (confirm("請問是否確定刪除此筆留言?")) {
			let xhr9 = new XMLHttpRequest();
			url = "<c:url value='/comment/deleteComment'/>?com_id=" + comId;
			xhr9.open("GET", url, true);
			xhr9.send();
			xhr9.onreadystatechange = function() {
				if (xhr9.readyState == 4 && xhr9.status == 200) {
					let delresult = JSON.parse(xhr9.responseText);
					if (delresult.fail) {
						alert("刪除失敗");
					} else if (delresult.success) {
						alert("刪除成功");
					}
					findAllComment();
				}
			}
		} else {
			return false;
		}
	}
	
	<!-- 留言區初始化 -->
    function findAllComment() {
		let xhr4 = new XMLHttpRequest();
		url = "<c:url value='/comment/commentFindAll'/>?art_id=" + ${article.art_id};
		xhr4.open("GET", url, true);
		xhr4.send();
		xhr4.onreadystatechange = function() {
			if (xhr4.readyState == 4 && xhr4.status == 200) {
				replyArea.innerHTML = showAllReplyData(xhr4.responseText);
			}
		}
	}
	
	function showAllReplyData(jsonString){
    	let coms = JSON.parse(jsonString);
    	let imageURL = "<c:url value='/getImage' />";
		let segment = "";
		for (let n = 0; n < coms.length; n++){
			let com = coms[n];
			segment += "<div class='card-body' style='position:relative'>";
			if(com.user_id == mbId){
				segment += "<button class='btn-close' style='position:absolute;top:5px;right:5px;' onclick=deleteReply(" + com.com_id + ") ></button>";	
			}
			segment += "<img src='" + imageURL + "?mbid=" + com.user_id + "' style='width: 40px;height: 40px' class='reply_img'>";
			segment += "<span style='font-weight: 800;'>" + com.mbname + "：</span>";
			segment += "<span class='reply_time'>" + com.com_create_time + "</span>";
			segment += "<p class='card-text'>" + com.com_content + "</p>";
			segment += "</div><hr style='margin: 0;'>";
		}			
		return segment;		
    }
</script>

</head>
<body id="page-top" style="background-color: #ecf0f5">
	<%@include file="../navigation.jsp"%>
	<div class="navbg"></div>
	<div class="container custom-width">
        <div class="row gx-3 gy-2">
            <div class="col-9 bg-body content_type">
                <h1>${article.art_title} </h1>
                <span class="time_type">發文者:${member.mbname}&nbsp;${article.art_create_time}</span>
                <hr>
                <P style="text-align: justify">${article.art_content}</P>
                <hr>
                <button type="button" style="border: none;background-color: #ffffff" class="ms-4">
                    <img  id="good_btn" src="${pageContext.request.contextPath}/images/goodfill.png" style="-webkit-filter:grayscale(1)">
                </button>
                <span id="likeNumArea">${article.art_like_num}個人按讚</span>
                <button type="button" style="border: none;background-color: #ffffff" class="ms-4">
                    <img  id="collect_btn" src="${pageContext.request.contextPath}/images/heart.png" style="-webkit-filter:grayscale(1)">
                </button>
                <span id="collectArea">收藏文章</span>
            </div>
            <!-- 右邊區域 -->
            
            <div class="col-3">
                <div class="card mb-3">
                    <div class="card-header" style="font-size:22px; text-align:center">關於作者</div>
                    <div class="card-body" id="authorArea">
                    </div>
                </div>
            </div>
            <!-- 留言區域 -->
            <div class="col-9 bg-body content_type" style="padding: 0">
                <div class="card">
                    <div class="card-header">留言區</div>
                    <div id=replyArea>
                    </div>
                </div>
            </div>
            <!-- 留言按鈕 -->
            <div class="col-9 bg-body content_type" style="padding: 0">
                <input type="text" class="reply_text" id="reply_text">
                <button type="button" class="btn btn-primary reply_btn" id="reply_btn">回覆</button>
            </div>
        </div>
    </div>
</body>
</html>