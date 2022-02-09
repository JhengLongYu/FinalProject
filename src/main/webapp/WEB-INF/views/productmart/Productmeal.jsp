<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.*,org.eeit131.group5.model.Product"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<style>

.mb-5 {
    margin-bottom: 5rem!important;
}
@media (min-width: 769px)
.col-md-4 {
    -ms-flex: 0 0 25%;
    flex: 0 0 25%;
    max-width: 25%;
}
.iconlist-wrapper {
    padding-top: 30px;
  padding-left:70px;
  height:50px;
}
element.style {
}
@media screen and (max-width: 990px)
main .inner {
    padding: 15px;
}
@media screen and (max-width: 1366px)
.inner {
    max-width: 600px;
  
}
.inner {
    margin: 0 auto;
    max-width: 1200px;
    padding: 0 px;
    position: ;
    width: 80%;

}
 * { 
     -webkit-box-sizing: border-box; 
     -moz-box-sizing: border-box; 
     box-sizing: border-box; 
     } 
user agent stylesheet
div {
    display: block;
}
body {
    background-color: #fff;
    font-family: Futura,'Noto Sans TC',"微軟正黑體",sans-serif;
    -webkit-font-smoothing: auto;
}
body, html {
    font-family: khula,Arial,"微軟正黑體",sans-serif;
    font-size: 14px;
    width: 100%;
    min-height: 100vh;
    min-height: 100%;
    line-height: 20px;
    margin: 0;
    -webkit-font-smoothing: antialiased;
}
html {
    font-family: sans-serif;
    -ms-text-size-adjust: 100%;
    -webkit-text-size-adjust: 100%;
}
::-webkit-scrollbar {
    width: 8px;
    height: 8px;
}
::-webkit-scrollbar-thumb {
    background-color: #d6d6d6;
    border-radius: 6px;
}
::-webkit-scrollbar-track-piece {
    border-radius: 6px;
    background-color: #eee;
}
element.style {
}
.icon-list {
    display: flex;
    list-style: none;
    margin: 0;
    overflow: auto;
    padding: 0;
    scrollbar-width: none;
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
user agent stylesheet
ul {
    display: block;
    list-style-type: disc;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    padding-inline-start: 40px;
}
body {
    background-color: #fff;
    font-family: Futura,'Noto Sans TC',"微軟正黑體",sans-serif;
    -webkit-font-smoothing: auto;
}
body, html {
    font-family: khula,Arial,"微軟正黑體",sans-serif;
    font-size: 14px;
    width: 100%;
    min-height: 100vh;
    min-height: 100%;
    line-height: 20px;
    margin: 0;
    -webkit-font-smoothing: antialiased;
}
html {
    font-family: sans-serif;
    -ms-text-size-adjust: 100%;
    -webkit-text-size-adjust: 100%;
}
.icon-list::-webkit-scrollbar {
    height: 0;
    width: 0;
}
::-webkit-scrollbar {
    width: 8px;
    height: 8px;
}
::-webkit-scrollbar-thumb {
    background-color: #d6d6d6;
    border-radius: 6px;
}
::-webkit-scrollbar-track-piece {
    border-radius: 6px;
    background-color: #eee;
}
.icon-list-item {
    display: block;
    flex: 0 0 22.5%;
    max-width: 17.5%;
    width: 22.5%;
}

* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
user agent stylesheet
li {
    display: list-item;
    text-align: -webkit-match-parent;
}
.icon-list-link {
    display: block;
    transition: all .25s ease;
}
a {
    background-color: transparent;
    display: inline-block;
    text-decoration: none;
    cursor: pointer;
    color: #333;
}

* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
user agent stylesheet
a:-webkit-any-link {
    color: -webkit-link;
    cursor: pointer;
    text-decoration: underline;
}.icon-list-img {
    display: block;
    margin: 0 auto;
    width: 50px;
}
img {
    border: 0;
    max-height: 100%;
    max-width: 100%;
    vertical-align: inherit;
}

* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}media (min-width: 661px)
.icon-list-string {
    margin-top: 10px;
    padding-left: 10px;
    padding-right: 10px;
    font-size: 13px;
    
    
}

.icon-list-string {
    display: block;
    margin-top: 5px;
    padding: 0 5px;
    text-align: center;
    color:black;
    
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}

/* Product */

@media (min-width: 768px)
.cmp-product_panel_list .cmp-product_panel_list__list .cmp-product_panel_list__items .cmp-product_panel_list__item {
    width: 150px;
    min-height: 27pc;
    margin-left: 6px;
    margin-bottom: 30px;
    display:inline;
}
ol li, ul li {
    margin-left: 0;
    list-style-type: none;
    
}
*, :after, :before {
    -webkit-box-sizing: inherit;
    box-sizing: inherit;
    
}
user agent stylesheet
div {
    
    text-align: -webkit-match-parent;
}
.cmp-product_list .cmp-product_list__items .cmp-product_list__item .cmp-product_panel {
    width: px;
    height: auto;
    display: inline;
}

.cmp-product_panel, .cmp-product_panel:hover {
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
}
.cmp-product_panel {
    width: 300px;
    min-height: 300px; 
    position: relative;
    border: 1px solid transparent;
   
}
*, :after, :before {
    -webkit-box-sizing: inherit;
    box-sizing: inherit;
}
user agent stylesheet
div {
    display: inline;
}

.cmp-product_panel .cmp-product_panel__inner {
    position: relative;
    width:249px;
    height:349px;
}
*, :after, :before {
    -webkit-box-sizing: inherit;
    box-sizing: inherit;
}

user agent stylesheet
div {
    display: inline;
}


.cmp-product_panel .cmp-product_panel__info .cmp-product_panel__title {
    font-size: 1em;
    line-height: 35px;
    font-weight: 400;
}
.cmp-product_panel .cmp-product_panel__info .cmp-product_panel__code {
    font-size: 18px;
    line-height: 21.6px;
    font-weight: 600;
    margin-top: 4px;
    overflow: hidden;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 2;
    height: 2.7pc;
}
.cmp-product_panel .cmp-product_panel__info .cmp-product_panel__price {
    line-height: 1.2;
    margin-top: 10px;
}
*, :after, :before {
    -webkit-box-sizing: inherit;
    box-sizing: inherit;
}
user agent stylesheet
div {
    display: inline;
}

.cmp-product_list .cmp-product_list__items .cmp-product_list__item .cmp-product_panel__thumb {
    height: 282px;
}

.cmp-product_panel .cmp-product_panel__thumb {
    position: relative;
    height: 250px;
    width:250px;
    background: #f7f8fa;

}
*, :after, :before {
    -webkit-box-sizing: inherit;
    box-sizing: inherit;
}
user agent stylesheet
div {
    display: inline;
}

.cmp-product_panel .cmp-product_panel__thumb .cmp-product_panel__img {
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-align: center;
    -ms-flex-align: center;
    align-items: center;
    -webkit-box-pack: center;
    -ms-flex-pack: center;
    justify-content: center;
    height: 100%;
    border-radius:8px;
}

*, :after, :before {
    -webkit-box-sizing: inherit;
    box-sizing: inherit;
}
user agent stylesheet
div {
    display: inline;
}


.cmp-product_panel .cmp-product_panel__info .cmp-product_panel__price .cmp-product_panel__price-label {
    font-size: 8px;
    font-weight: 200;
    min-height: 10px;
}

*, :after, :before {
    -webkit-box-sizing: inherit;
    box-sizing: inherit;
}
user agent stylesheet
div {
    display: inline;
}

.cmp-product_panel .cmp-product_panel__info .cmp-product_panel__price .cmp-product_panel__price-txt {
    font-size: 14px;
}

*, :after, :before {
    -webkit-box-sizing: inherit;
    box-sizing: inherit;
}

</style>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>人氣商品</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="images/favicon.ico" />
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
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath}/css/styles.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/styles1.css"
	rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/css/styles2.css"
	rel="stylesheet" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/fontawesome.min.css">
	
<!--Boostrap CDN-->
<!-- <link rel="stylesheet" -->
<!-- 	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js"
	crossorigin="anonymous"></script>
<!-- Bootstrap core JS-->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="js/scripts.js"></script>
<!--SB Forms JS-->
<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
<!--jQuery-->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
let AddCartArea;
let memberId = "${mbid}";
	window.onload = function() {
		let category = "${category}";
		console.log(category);
		let dataArea = document.getElementById("dataArea");
		let xhr = new XMLHttpRequest();
		let url = "<c:url value='/category1?category="+category+"' />"
		xhr.open("GET", url);
		xhr.send();
			xhr.onreadystatechange = function(){
				if (xhr.readyState == 4 && xhr.status == 200){
					dataArea.innerHTML = processMemberData(xhr.responseText);
				}
			}
	}
	function additemincart(itemId) {
		console.log(itemId);
		let xhr1 = new XMLHttpRequest();
		xhr1.open("POST", "<c:url value='/additemInCart' />");

		let addCart = {
			"memberId" : memberId,
			"itemId" : itemId
		}
		xhr1.setRequestHeader("Content-Type", "application/json");
		xhr1.send(JSON.stringify(addCart));
		xhr1.onreadystatechange = function() {
			if (xhr1.readyState == 4 && xhr1.status == 200) {
				result = JSON.parse(xhr1.responseText);
				if (result.fail) {
					alert(result.fail);
				} else {
					alert(result.success);
				}
			}
		}
	}

	function updateShoppingCartsitem(itemupdate) {
		let xhr2 = new XMLHttpRequest();
		let url2 = "<c:url value='/updateShoppingCartsitem'  />";
		console.log(url2);
		xhr2.open("PUT", url2);
		xhr2.setRequestHeader("Content-Type", "application/json");
		xhr2.send(JSON.stringify(itemupdate));
	}
	function processMemberData(jsonString) {
		let products = JSON.parse(jsonString);
		var imageURL = "<c:url value='/product/getPicture'/>";
		
		let segment = "";

		for (let n = 0; n < products.length; n++) {
			let product = products[n];
			
           
			segment += "<div class='col-md-4 mb-5' >";
			segment += "<div class='cmp-product_panel'>";
			segment += "<div class='cmp-product_panel__inner'>";
			segment += "<div class='cmp-product_panel__thumb'>";
			segment += "<img class='cmp-product_panel__img' "+"src='" + imageURL + "?id=" 
					+ product.id + "'>";
			segment += "</div>";
			
			segment += "<div class='cmp-product_panel__info-main'>";
			segment += "<div class='cmp-product_panel__title' style='font-size:19px'>" + product.name + "</div>";
			segment += "<div class='cmp-product_panel__code' style='font-size:6px'>" + product.category +"</div>";
// 			segment += "<h2 class='cmp-product_panel__price-label'>"11"</h2>";
            segment += "<div>"+"<button onclick='additemincart(" + product.id
			+ ")' style='position: absolute;bottom:0.5;border:none;background-color:transparent;padding-left:210px'><img src='${pageContext.request.contextPath}/images/shoppingcart.png' style=width:40px;height:40px;></button>"+"</div>";
			segment += "<div class='cmp-product_panel__price-label'>" + "售價" + "</div>";
			segment += "<div class='cmp-product_panel__price-txt' style='font-size:16px'>" + "NT$"
			+ product.price  + "</div>";
// 			segment += "<button onclick='additemincart(" + product.id
// 			+ ")' style='border:none;background-color:transparent;padding-bottom:10px;padding-left:200px'><img src='${pageContext.request.contextPath}/images/shoppingcart.png' style=width:40px;height:40px;></button>";
	
			
			segment += "</div>";		
// 			segment += "<button onclick='additemincart(" + product.id
// 					+ ")' style='border:none;background-color:transparent;padding-left:180px'><img src='${pageContext.request.contextPath}/images/shoppingcart.png' style=width:40px;height:40px;></button>";
			segment += "</div>";
			segment += "</div>";
			segment += "</div>";
			segment += "</div>";

		}
		
		return segment;
	}
</script>

</head>
<body id="page-top">
	<%@include file="../navigation88.jsp"%>
	<div class="navbg"></div>
	<div class="container">


<section class="iconlist-wrapper">
<div class="inner">
<ul class="icon-list">
<li class="icon-list-item">
<a class="icon-list-link HITS_BT" style="text-decoration: none" hid="7" hdid="10" href="<c:url value='/productmart' />">
<i class="icon-list-img fas fa-dumpster"style="width:50px;height:50px"></i>
<span class="icon-list-string">商品總覽</span>
</a>
</li>
<li class="icon-list-item">
<a class="icon-list-link HITS_BT" style="text-decoration: none" hid="15" hdid="10" href="<c:url value='/category/meal' />">
<i class="icon-list-img fas fa-utensils"style="width:50px;height:50px"></i>
<span class="icon-list-string">健康餐盒</span>
</a>
</li>
<li class="icon-list-item">
<a class="icon-list-link HITS_BT" style="text-decoration: none" hid="3" hdid="10" href="<c:url value='/category/fitness' />">
<i class="icon-list-img fas fa-dumbbell" style="width:50px;height:50px"></i>
<span class="icon-list-string">健身器材</span>
</a>
</li>
<li class="icon-list-item">
<a class="icon-list-link HITS_BT" style="text-decoration: none" hid="18" hdid="10" href="<c:url value='/category/healthy' />">
<i class="icon-list-img fas fa-capsules" style="width:50px;height:50px"></i>
<span class="icon-list-string">運動補充</span>
</a>
</li>
<li class="icon-list-item">
<a class="icon-list-link HITS_BT" style="text-decoration: none" hid="18" hdid="10" href= "<c:url value='/category/point' />">
<i class="icon-list-img fas fa-coins" style="width:50px;height:50px"></i>
<span class="icon-list-string">諮詢點數</span>
</a>
</li>

</ul>
</div>
</section>
		<div class="row gx-4 gx-lg-5 container" id='dataArea'></div>
	</div>


</body>

</html>