<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
	System.out.println(session.getAttribute("loginAdminEmail")+"<-session.getAttribute(\"loginAdminEmail\")");
	if (session.getAttribute("loginAdminEmail") == null) {
		response.sendRedirect(request.getContextPath()+"/login.jsp?loginRequired=true");
		return;
	}
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>editCategory</title>
		
		<!-- 부트스트랩 사용 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script>
			$(document).ready(function() {
				console.log("document ready");
				
				$("#editCategorySubmit").click(function() {
					console.log("started add category");
					
					if ($("#editCategoryName").val() == "") {
						alert("카테고리 이름을 입력해주세요!");
						
						$("#editCategoryName").focus();
						return;
					}
					
					$("#editCategoryForm").submit();
				});
			});
		</script>
	</head>
	
	<%
		request.setCharacterEncoding("UTF-8");
		System.out.println(request.getParameter("categoryId")+"<-request.getParameter(\"categoryId\")");

		Category paramCategory = new Category();
		paramCategory.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
		
		CategoryDao categoryDao = new CategoryDao();
		Category category = categoryDao.selectCategoryOne(paramCategory);
	%>
	
	<body>
		<div class="container-xl">
			<!-- 메뉴 -->
			<div>
				<jsp:include page="/inc/menu.jsp"></jsp:include>
			</div>
			
			<!-- 내용 -->
			<div class="card">
				<!-- 제목 -->
				<div class="card-header">
					<h1>카테고리 수정</h1>
				</div>
				
				<!-- 본문 -->
				<div class="card-body">
					<form method="post" action="<%=request.getContextPath()%>/category/editCategoryAction.jsp" id="editCategoryForm">
						<input type="hidden" name="categoryId" value="<%=category.getCategoryId()%>">
						
						<div class="form-group">
							<label>카테고리 이름:</label>
							<input class="form-control" type="text" name="categoryName" value="<%=category.getCategoryName()%>" id="editCategoryName">
						</div>
						
						<hr>
						
						<div class="form-group">
							<button class="btn btn-outline-warning btn-block" type="button" id="editCategorySubmit">카테고리 수정</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</body>
</html>