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
		<title>editProductPic</title>
		
		<!-- 부트스트랩 사용 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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
					<h1>카테고리 이미지 수정</h1>
				</div>
				
				<!-- 본문 -->
				<div class="card-body">
					<form method="post" action="<%=request.getContextPath()%>/category/editCategoryPicAction.jsp" enctype="multipart/form-data">
						<input type="hidden" name="categoryId" value="<%=category.getCategoryId()%>">
						
						<div class="form-group">
							<label>카테고리:</label>
							<input class="form-control" type="text" name="categoryName" value="<%=category.getCategoryName()%>" disabled="disabled">
						</div>
						
						<div class="form-group">
							<label>이미지:</label>
							<input class="rounded-lg border w-100 p-2" type="file" name="categoryPic">
						</div>
						
						<hr>
						
						<div class="form-group">
							<button class="btn btn-outline-primary btn-block" type="submit">이미지 수정</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</body>
</html>