<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css">	
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
<meta charset="UTF-8">
<title>商品列表 | 後台</title>

<script>
window.onload = function(){
	let dataArea = document.getElementById("dataArea");
	let xhr = new XMLHttpRequest();
	xhr.open("GET", "<c:url value='/findproducts' />");
	xhr.send();
	xhr.onreadystatechange = function(){
		if (xhr.readyState == 4 && xhr.status == 200){
			dataArea.innerHTML = processMemberData(xhr.responseText);
		}
	}
}

function processMemberData(jsonString){
	let products = JSON.parse(jsonString);
	let segment = "";
	var imageURL = "<c:url value='/product/getPicture'/>";
	$(document).ready(function() {
	    $('#example').DataTable();
	} );
	for(let n =0; n<products.length;n++){
		let product=products[n];
		let link = "<a href='" + "<c:url value='/editProductForm' />?id=" + product.id + "'>" + product.id + "</a>";
		segment += "<tr>";
		segment += "<td style='padding-top:30px;padding-left:20px'>"+ link +"</td>";
		segment += "<td style='padding-left:21px'><img class='rounded-circle' 'card-img-top' width='60' height='60' "+"src='" + imageURL + "?id=" 
			+ product.id + "'></td>";
		segment += "<td style='padding-top:30px;padding-left:20px'>" + product.name + "</td>";
		segment += "<td style='padding-top:30px;padding-left:20px'>" + product.price + "</td>";
		segment += "<td style='padding-top:30px;padding-left:20px'>" + product.category + "</td>";
		segment += "</tr>";	
	}
	return segment;
}


</script>
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- <script type="text/javascript" -->
<%-- 	src="<c:url value='/webjars/jquery/3.6.0/jquery.js'/>"></script> --%>

<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js" crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<link href="${pageContext.request.contextPath}/css/mgstyles.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/js/mgscripts.js"></script>
<link rel="stylesheet"
	href='<c:url value='/webjars/bootstrap/4.6.0/css/bootstrap.css' />' />
<script type="text/javascript"
	src="<c:url value='/webjars/bootstrap/4.6.0/js/bootstrap.bundle.js'/>"></script>
<link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&display=swap" rel="stylesheet">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/management_member.css">
</head>
<body id="page-top">
<div class="d-flex" id="wrapper">
	  <%@include file="../mgsidebar.jsp"%>
            <!-- Page content wrapper-->
            <div id="page-content-wrapper"  style="background-color: 	#F0F0F0;">
            <%@include file="../mgnavigation.jsp"%>
                <!-- Page content-->
					<div class="container" style="margin-top:5px">
<div align='center'>
<!-- <h style='font-size:3ex'>商品列表</h> -->
</div>
<!-- <div id='dataArea' align='center'> -->

<div class="container-fluid" >
                 <a class="btn btn-warning" href="<c:url value='/addForm' />">新增商品</a>
                
 <div class="card mb-4" >
  	<div class="card-header" style="background-color:#FFDC35">
		<i class="fas fa-table me-1"></i>商品列表
    </div>
    <div class="card-body" style="background-color:white">
         <table id="example" class="table table-hover">
    			<thead>
     			<tr>
       			 	<th>商品編號</th>
       			 	<th>商品圖片</th>
       			 	<th>商品名稱</th>
        			<th>商品價格</th>
        			<th>商品類別</th>
        			
      			</tr>
    		</thead>
    		<tbody id="dataArea">
    		 	
      
    		</tbody>
  		</table>
     </div>
</div>
</div>




</div>
</div>
</div>
</body>
</html>