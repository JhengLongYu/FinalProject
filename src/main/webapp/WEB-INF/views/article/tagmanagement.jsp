<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>健康運動整合平台|論壇管理</title>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript"
	src="<c:url value='/webjars/jquery/3.6.0/jquery.js'/>"></script>
<link href="${pageContext.request.contextPath}/css/mgstyles.css"
	rel="stylesheet" />
<script src="${pageContext.request.contextPath}/js/mgscripts.js"></script>
<link rel="stylesheet"
	href='<c:url value='/webjars/bootstrap/4.6.0/css/bootstrap.css'/>' />
<script type="text/javascript"
	src="<c:url value='/webjars/bootstrap/4.6.0/js/bootstrap.bundle.js'/>"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">	
<script>
	window.onload = function() {
		let tagArea = document.getElementById("tagArea");
		findAllTag();
	}
	
	function findAllTag() {
		let xhr = new XMLHttpRequest();
		xhr.open("GET", "<c:url value='/tag/findAll'/>", true);
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				tagArea.innerHTML = showTagData(xhr.responseText);
			}
		}
	}
	function showTagData(jsonString) {		//標籤管理
		let tags = JSON.parse(jsonString);
		let segment = "<table class='table'>";
		segment += "<thead><tr><th>標籤名</th><th>文章數</th><th>創立時間</th><th>操作</th></tr></thead>";
		segment += "<tbody>";
		for (let n = 0; n < tags.length; n++) {
			let tag = tags[n];

			segment += "<tr>";
			segment += "<td>" + tag.tag_name + "</td>";
			segment += "<td>" + tag.art_num + "</td>";
			segment += "<td>" + tag.tag_create_time+ "</td>";
			
			let deletelink = "<button class='btn btn-danger btn-sm' onclick=deleteData(" + tag.tag_id + ")><i class='bi bi-trash'></i></button>";
			
			let editlink = "<button class='btn btn-primary btn-sm me-2' data-bs-toggle='modal' data-bs-target='#exampleModal" + tag.tag_id + "'><i class='bi bi-pencil-square'></i></button>";		
			editlink += "<div class='modal fade' id='exampleModal" + tag.tag_id + "' tabindex='-1' aria-labelledby='exampleModalLabel" + tag.tag_id + "' aria-hidden='true'>";
			editlink += "<div class='modal-dialog'><div class='modal-content'><div class='modal-header'>";
            editlink += "<h5 class='modal-title' id='exampleModalLabel" + tag.tag_id + "'>修改標籤名稱</h5>";
		    editlink += "<button type='button' class='btn-close' data-bs-dismiss='modal' aria-label='Close'></button></div>";
			editlink += "<div class='modal-body'><div class='row mb-3'><label for='inputBeforeTagName" + tag.tag_id + "' class='col-sm-4 col-form-label'>修改前標籤名：</label>";
			editlink +=	"<div class='col-sm-8'><input type='text' class='form-control' id='inputBeforeTagName" + tag.tag_id + "' value='" + tag.tag_name + "' readonly></div></div><div class='row mb-3'>";
			editlink +=	"<label for='inputAfterTagName" + tag.tag_id + "' class='col-sm-4 col-form-label'>修改後標籤名：</label>";
			editlink +=	"<div class='col-sm-8'><input type='text' class='form-control' id='inputAfterTagName" + tag.tag_id + "'></div></div></div>";
			editlink +=	"<div class='modal-footer'><button class='btn btn-primary' data-bs-dismiss='modal' onclick=updateData(" + tag.tag_id + ")>確定</button><button type='button' class='btn btn-danger' data-bs-dismiss='modal'>取消</button>";  
			editlink +=	"</div></div></div></div>";
		
		
		
		segment += "<td>" + editlink + deletelink + "</td></tr>";
		}
		segment += "</tbody>";
		segment += "</table>";
		return segment;
	}
	
	function deleteData(delId) {
		if (confirm("請問是否確定刪除?")) {
			let xhr2 = new XMLHttpRequest();
			url = "<c:url value='/tag/delete'/>?tag_id=" + delId;
			xhr2.open("GET", url, true);
			xhr2.send();
			xhr2.onreadystatechange = function() {
				if (xhr2.readyState == 4 && xhr2.status == 200) {
					let delresult = JSON.parse(xhr2.responseText);
					if (delresult.fail) {
						alert("刪除失敗");
					} else if (delresult.success) {
						alert("刪除成功");
					}
					findAllTag();
				}

			}
		} else {
			return false;
		}
	}
	
	function updateData(Id) {
		let inputAfterTagNameVal = document.getElementById("inputAfterTagName"+Id).value;
		let xhr3 = new XMLHttpRequest();
		xhr3.open("POST", "<c:url value='/tag/update'/>", true);
		var jsonUpdate = {
				"tag_id": Id, 					
				"tag_name": inputAfterTagNameVal 	
	   		}
		xhr3.setRequestHeader("Content-Type", "application/json");
   		xhr3.send(JSON.stringify(jsonUpdate));
   		xhr3.onreadystatechange = function() {
			if (xhr3.readyState == 4 && xhr3.status == 200) {
				let updateresult = JSON.parse(xhr3.responseText);
			/* 	if (updateresult.fail) {
					alert("更新失敗");
				} else if (updateresult.success) {
					alert("更新成功");
				}  */
				findAllTag();
			}
		}
   	}
	
	function tagNew() {
		let tagNameInputVal = document.getElementById("tagNameInput").value;
		let xhr4 = new XMLHttpRequest();
		url = "<c:url value='/tag/add'/>?tag_name=" + tagNameInputVal;
		xhr4.open("GET", url , true);
		xhr4.send();
		xhr4.onreadystatechange = function() {
			if (xhr4.readyState == 4 && xhr4.status == 200) {
				let addResult = JSON.parse(xhr4.responseText);
				if (addResult.fail) {
					alert("新增失敗");
				} else if (addResult.success) {
					alert("新增成功");
				}
				findAllTag();
			}
		}	
	}

</script>
</head>
<body>
	<div class="d-flex" id="wrapper">
		<%@include file="../mgsidebar.jsp"%>
		<!-- Page content wrapper-->
		<div id="page-content-wrapper" style="background-color: #F0F0F0;">
			<%@include file="../mgnavigation.jsp"%>
			
			<!-- Page content-->
			<div class="container-fluid position-relative" class="position-relative">
				<div class="container" id="dataArea">
					<button class='btn btn-success btn-sm' data-bs-toggle="modal"
						data-bs-target="#tagNewModal" style="position: absolute; top: 10px; right: 90px;"><i class="bi bi-plus-lg"></i></button>

					<div class="modal fade" id="tagNewModal" tabindex="-1"
						aria-labelledby="tagNewModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="tagNewModalLabel">新增標籤種類</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<div class="row my-4">
										<label for="tagNameInput" class="col-sm-4 col-form-label">新增標籤名稱：</label>
										<div class="col-sm-8">
											<input type="text" class="form-control" id="tagNameInput">
										</div>
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-primary" data-bs-dismiss="modal" onclick=tagNew()>確定</button>
									<button type="button" class="btn btn-danger" data-bs-dismiss="modal">取消</button>
								</div>
							</div>
						</div>
					</div>
					<div id="tagArea">&nbsp;</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>