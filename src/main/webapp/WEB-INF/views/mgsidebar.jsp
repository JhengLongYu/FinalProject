<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <!-- Sidebar-->
            <div class="border-end"  id="sidebar-wrapper" style="background-color: #FFDC35;">
                <div class="sidebar-heading border-bottom " style='color: #495057;'>Come Better</div>
                <div class="list-group list-group-flush">
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" style='background-color: #FFDC35;'href="<c:url value='/memberManagement' />">會員管理</a>
           
                    <div class="dropdown">
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" style='background-color: #FFDC35;'href="#!"
                    id="dropdownMenuButtonArticle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">健康中心</a>
            			<div class="dropdown-menu" aria-labelledby="dropdownMenuButtonArticle">
    						<a class="dropdown-item" href="<c:url value='/_01/showAllMembers' />">食物新增</a>
    						<a class="dropdown-item" href="<c:url value='/_01/CenterBack/Allsports'/>">運動新增</a>
  						</div>
					</div>
                    
                    <div class="dropdown">
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" style='background-color: #FFDC35;'href="#!"
                    id="dropdownMenuButtonArticle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">論壇管理</a>
            			<div class="dropdown-menu" aria-labelledby="dropdownMenuButtonArticle">
    						<a class="dropdown-item" href="<c:url value='/article/articleManagement'/>">文章管理</a>
    						<a class="dropdown-item" href="<c:url value='/tag/tagmanagement'/>">標籤管理</a>
    						<a class="dropdown-item" href="<c:url value='/carousel/carouselManagement'/>">輪播管理</a>
  						</div>
					</div>
                    
  
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" style='background-color: #FFDC35;'href="<c:url value='/findproductForm' />">商城產品</a>

                    <a class="list-group-item list-group-item-action list-group-item-light p-3" style='background-color: #FFDC35;'href="<c:url value='/ordersManagement' />">商城訂單</a>

                    <div class="dropdown">
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" style='background-color: #FFDC35;'href="" 
                    id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">諮詢</a>
  						<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
   							<a class="dropdown-item" href="<c:url value='/consultion/allinstructors'/>">講師</a>
    						<a class="dropdown-item" href="<c:url value='/consultion/mglistPage'/>">預約清單</a>
  						</div>
					</div>
               
                </div>
            </div>