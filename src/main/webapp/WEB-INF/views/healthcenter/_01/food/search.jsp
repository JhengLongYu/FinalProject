<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://web-assets.myfitnesspal.com/fonts/neue-plak-ua.css"
	crossorigin="true" />
<link href="${pageContext.request.contextPath}/css/health.css"
	rel="stylesheet" />
<title data-react-helmet="true">food計算機</title>
<meta data-react-helmet="true" name="description" content="food" />
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Montserrat">
<!-- Favicon-->
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/images/favicon.ico" />
<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js"
	crossorigin="anonymous"></script>
<!-- Font Awesome icons (free version) 要改根目錄-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css" />
<link
	href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700"
	rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath}/css/styles.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/styles1.css"
	rel="stylesheet" />
<script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/memberCenter.css">

<style type="text/css">
#mainNav {

  background-color: #212529;
}

</style>
</head>
<body>
	<script>
		var hasError = false;
		window._pxAppId = 'PXeeB95Fw0';
		window.onload = function() {
			console.log("就入");
			var sendData = document.getElementById("sendData");

			sendData.onclick = function() {
				if (confirm("請問是否確定送出?????")) {
					var eatValue = document.getElementById("eat").value;
					if (!eatValue) {

					}

					return true;
				} else {
					return false;
				}

			}
			let showimg = document.getElementById("showimg");
			//以mbid
			var xhr2 = new XMLHttpRequest();
			let url = "<c:url value='/memberManagement/' />" + "${mbid}";
			xhr2.open("GET", url);
			xhr2.send();
			xhr2.onreadystatechange = function() {
				if (xhr2.readyState == 4 && xhr2.status == 200) {
					//console.log(xhr.responseText);
				}
				var imageURL = "<c:url value='/getImage' />";
				showimg.src = imageURL + "?mbid=" + "${mbid}";
				showimg.style="";
			}
		}
	</script>
	<%@include file="../../../navigation.jsp"%>

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

		<div id="app">
			<div class="MFPApp-3IaDG ">
				<div>
					<div style="background-color: #FFFFFF">
						<div class="jss14">
							<div class="jss3" style="margin-left: 200px;">
								<div class="jss4">
									<section class="jss10" style="padding-bottom: 20px;">
										<div class="jss54 ">

											<form action="<c:url value='/healthCenter/food/all/' />"
												method="get">
												<input type="search" placeholder="          搜尋食品" maxLength="45"
													class="jss58 jss57" value="" name="eat" />
												<button type="submit" id="sendData">
													<svg xmlns="http://www.w3.org/2000/svg"
														xmlns:xlink="http://www.w3.org/1999/xlink" width="24"
														height="24" viewBox="0 0 24 24">
                                                    <defs>
                                                     <rect id="b"
															width="652" height="56" rx="4"></rect>
                                                    </defs>
                                                    <g fill="none"
															fill-rule="evenodd">
                                                        <g
															transform="translate(-16 -16)">
                                                            <use
															fill="#4C4C4C" filter="url(#a)" xlink:href="#b"></use>
                                                            <use
															fill="#FFF" xlink:href="#b"></use>
                                                        </g>
                                                        <path
															fill="#4C4C4C" fill-rule="nonzero"
															d="M16.27 15.094h-.201l-.385-.37a8.88 8.88 0 0 0 2.155-5.805A8.92 8.92 0 0 0 8.919 0 8.92 8.92 0 0 0 0 8.92a8.92 8.92 0 0 0 8.92 8.919c2.209 0 4.24-.81 5.804-2.155l.37.385v.2c0 .566.225 1.108.626 1.508l5.212 5.202a1.447 1.447 0 1 0 2.047-2.047l-5.202-5.212a2.13 2.13 0 0 0-1.508-.626zm-7.35 0A6.167 6.167 0 0 1 2.743 8.92 6.167 6.167 0 0 1 8.92 2.744a6.167 6.167 0 0 1 6.175 6.175 6.167 6.167 0 0 1-6.175 6.175z">
                                                        </path>
                                                    </g>
                                                </svg>
												</button>
											</form>
										</div>
									</section>
									<div class="jss60">
										<img class="jss62" alt="Food Search"
											src="${pageContext.request.contextPath}/images/forHealth/rachel.jpg"
											style="padding-bottom: 10px;" />
										<h5 class="MuiTypography-root jss61 MuiTypography-h5">食品了解</h5>
										<span class="MuiTypography-root jss73 jss63">瞭解您吃的食物中含有多少價值，並使用它計算您一天的需求。</span>
									</div>
								</div>
								<div class="jss13">
									<div class="blogsCards-1NwdX gutters-263pb"></div>
								</div>
								<div class="jss5">
									<div id="mfp-desktop-halfpage-1"></div>
									<div id="mfp-desktop-med-rec-1"></div>
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