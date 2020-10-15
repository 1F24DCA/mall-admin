<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
		<title>addCategory</title>
		
		<!-- 부트스트랩 사용 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script>
			$(document).ready(function() {
				console.log("document ready");
				
				$("#addCategorySubmit").click(function() {
					console.log("started add category");
					
					if ($("#addCategoryName").val() == "") {
						alert("카테고리 이름을 입력해주세요!");
						
						$("#addCategoryName").focus();
						return;
					} else if ($("#addCategoryPic").val() == "") {
						alert("카테고리 이미지를 선택해주세요!");
						
						$("#addCategoryPic").focus();
						return;
					}
					
					$("#addCategoryForm").submit();
				});
			});
		</script>
	</head>
	
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
					<h1>카테고리 추가</h1>
				</div>
				
				<!-- 본문 -->
				<div class="card-body">
					<form method="post" action="<%=request.getContextPath()%>/category/addCategoryAction.jsp" enctype="multipart/form-data" id="addCategoryForm">
						<div class="form-group">
							<label>카테고리 이름:</label>
							<input class="form-control" type="text" name="categoryName" id="addCategoryName">
						</div>
						
						<div class="form-group">
							<label>이미지:</label>
							<input class="rounded-lg border w-100 p-2" type="file" name="categoryPic" id="addCategoryPic">
						</div>
						
						<hr>
						
						<div class="form-group">
							<button class="btn btn-outline-primary btn-block" type="button" id="addCategorySubmit">카테고리 추가</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</body>
</html>