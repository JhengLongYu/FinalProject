<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>健康運動整合平台|新增講師類別</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="<c:url value='/webjars/jquery/3.6.0/jquery.js'/>"></script>        
<link href="${pageContext.request.contextPath}/css/mgstyles.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/js/mgscripts.js"></script>
<link rel="stylesheet" href='<c:url value='/webjars/bootstrap/4.6.0/css/bootstrap.css'/>'/>
<script type="text/javascript" src="<c:url value='/webjars/bootstrap/4.6.0/js/bootstrap.bundle.js'/>"></script>
<link href="${pageContext.request.contextPath}/css/consultion2.css"
	rel="stylesheet" />
<script>
var hasError = false;
let dataArea;
let resultArea;
let amount;
window.onload = function(){
	dataArea=document.getElementById("dataArea");
// 	resultArea=document.getElementById("result");
	document.getElementById("sendTypeData").addEventListener("click", sendTypeData);
	findAllInsType();
}

	function sendTypeData() {
		let instructorType = document.getElementById("instructorType");
		hasError = false;
		if (!instructorType.value) {
			setErrorFor(resultArea, "請輸入類別名稱");
		} else {
// 			resultArea.innerHTML = "";
		}
		if (hasError) {
			return false;
		}

		var insType = {
			"typeName" : instructorType.value,
		}
		jsonInsType = JSON.stringify(insType);

		let xhr = new XMLHttpRequest();
		xhr.open("POST", "<c:url value='/consultion/addInsType'/>", true);
		xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
		xhr.send(jsonInsType);
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				let result = JSON.parse(xhr.responseText);
				if (result.success) {
					// 				resultArea.innerHTML =result.success;
					console.log(result.success)
					findAllInsType();
				} else {
					// 				resultArea.innerHTML =result.fail;
					console.log(result.fail)
				}
				instructorType.value = "";
			}
		}
	}
	function setErrorFor(input, message) {
		input.innerHTML = "<font color='red' size='-2'>" + message + "</font>";
		hasError = true;
	}
	function findAllInsType() {
		let xhr1 = new XMLHttpRequest();
		xhr1.open("GET", "<c:url value='/consultion/findAllInsType'/>", true);
		xhr1.send();
		xhr1.onreadystatechange = function() {
			if (xhr1.readyState == 4 && xhr1.status == 200) {
				dataArea.innerHTML = processInsTypesData(xhr1.responseText);

			}
		}
	}

function processInsTypesData(jsonString){
	let insTypes= JSON.parse(jsonString);
	let segment = "<table class='table table-hover'>";
	
	for(let n =0; n<insTypes.length;n++){
		let insType=insTypes[n];
// 		let deletelink ="<a class='btn btn-danger' onclick=deletedata("+insType.typeId+") >刪除</a> ";
		let deletelink ="<i class='fas fa-trash-alt' onclick=deletedata("+insType.typeId+")></i>"

		segment+="<tr>";
		segment +="<td>"+insType.typeId+"</td>";
		segment +="<td>"+insType.typeName+"</td>";
		typeAmount(insType.typeId);
		let amountdiv="amountdiv"+insType.typeId;
		console.log("amount"+amount);
		segment +="<td><span id='"+amountdiv+"'></span></td>";
		segment +="<td>"+deletelink+"</td>";
		segment +="</tr>";
	}
	segment += "</table>";
	return segment;
}
function deletedata(typeId){
	if(confirm("請問是否確定刪除?")){
		let xhr2 = new XMLHttpRequest();
		url="<c:url value='/consultion/deleteInsType'/>?typeId="+typeId;
		xhr2.open("GET",url,true);
		xhr2.send();
		xhr2.onreadystatechange = function(){
			if (xhr2.readyState == 4 && xhr2.status == 200){
				let delresult =JSON.parse(xhr2.responseText);
				if (delresult.fail) {
			 		alert(delresult.fail);
		  		}else if (delresult.success) {
		  			alert(delresult.success);
		  		}
				findAllInsType()
			}
		}
		} else {
			return false;
		}
}

function typeAmount(typeNo){
	let xhr3 = new XMLHttpRequest();
	let url3="<c:url value='/consultion/CountAmount/'/>"+typeNo;
	xhr3.open("GET",url3,true);
	xhr3.send();
	xhr3.onreadystatechange = function(){
		if (xhr3.readyState == 4 && xhr3.status == 200){
			let amount=xhr3.responseText;
			let thediv="amountdiv"+typeNo;
			document.getElementById(thediv).innerHTML=amount;
			
		}
	}
}
</script>
</head>
<body>
	 <div class="d-flex" id="wrapper">
	  <%@include file="../mgsidebar.jsp"%>
            <!-- Page content wrapper-->
            <div id="page-content-wrapper"  style="background-color: 	#F0F0F0;">
            <%@include file="../mgnavigation.jsp"%>
                <!-- Page content-->
                
                <div class="container-fluid" >
                   
  						
  						<a style='color:#555;margin-left:850px;margin-bottom:0'href="<c:url value='/consultion/allinstructors'/>"><i class="fas fa-table me-1"></i>講師列表</a>	
					<a href="<c:url value='/consultion/addInstructorForm'/>"><i class="fas fa-user-plus"></i></a>
  						<div class="container" style="margin-top:10px">
 						<div class="card mb-4" >
  							<div class="card-header" style="background-color:#FFED97;text-align:center">
								<i class="fas fa-table me-1"></i>講師類別列表
								<i class="fas fa-plus" data-toggle="modal" data-target="#myModal"></i>
    						</div>
    					<div class="card-body">
       						  <table class="table table-hover">
    								<thead>
     									<tr>
       									 	<th>類別編號</th>
        									<th>類別名稱</th>
        									<th>人數</th>
        									<th></th>
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
 <!-- The Modal -->
  <div class="modal" id="myModal">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">新增類別</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          <div class="form-row" style='margin:10px 0'>
     						 	<input type="text" class="form-control" id="instructorType" placeholder="類別"> 
  						</div>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
        <button id="sendTypeData"type="button" class=" btn btn-outline-success" data-dismiss="modal">新增</button>
          <button type="button" class="btn btn-danger" data-dismiss="modal">取消</button>
        </div>
        
      </div>
    </div>
  </div>        
        
        
</body>
</html>