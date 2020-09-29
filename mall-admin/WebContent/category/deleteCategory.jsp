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
		<title>deleteCategory</title>
		
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
				<!-- 제목 시작 -->
				<div class="card-header">
					<h1>카테고리 삭제</h1>
				</div>
				
				<!-- 본문 시작 -->
				<div class="card-body">
					<form method="post" action="<%=request.getContextPath()%>/category/deleteCategoryAction.jsp">
						<input type="hidden" name="categoryId" value="<%=category.getCategoryId()%>">
						
						<p>정말로 <%=category.getCategoryName() %>을(를) 삭제하시겠습니까?</p>
						<p>삭제된 내용은 복구할 수 없습니다!</p>
						
						<hr>
						
						<div class="form-group">
							<button class="btn btn-outline-danger btn-block" type="submit">카테고리 삭제</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</body>
</html>