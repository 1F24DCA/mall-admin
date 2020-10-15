<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

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
		<title>addProduct</title>
		
		<!-- 부트스트랩 사용 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script>
			$(document).ready(function() {
				console.log("document ready");
				
				$("#addProductSubmit").click(function() {
					console.log("started add product");
					
					if ($("#addProductName").val() == "") {
						alert("상품 이름을 입력해주세요!");
						
						$("#addProductName").focus();
						return;
					} else if ($("#addProductPrice").val() == "") {
						alert("상품 가격을 입력해주세요!");
						
						$("#addProductPrice").focus();
						return;
					} else if ($("#addProductContent").val() == "") {
						alert("상품 설명을 입력해주세요!");
						
						$("#addProductContent").focus();
						return;
					} else if ($(".addProductSoldout:checked").val() == undefined) {
						alert("상품 판매여부를 선택해주세요!");
						
						$("#addProduct").focus();
						return;
					} else if ($("#addProductPic").val() == "") {
						alert("상품 이미지를 선택해주세요!");
						
						$("#addProductPic").focus();
						return;
					}
					
					$("#addProductForm").submit();
				});
			});
		</script>
	</head>
	
	<%
		CategoryDao categoryDao = new CategoryDao();
		ArrayList<Category> categoryList = categoryDao.selectCategoryList();
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
					<h1>상품 추가</h1>
				</div>
				
				<!-- 본문 -->
				<div class="card-body">
					<form method="post" action="<%=request.getContextPath()%>/product/addProductAction.jsp" enctype="multipart/form-data" id="addProductForm">
						<div class="form-group">
							<label>카테고리:</label>
							<select class="form-control" name="categoryId">
								<option value="">카테고리 선택</option>
								<%
									for (Category c : categoryList) {
								%>
										<option value="<%=c.getCategoryId()%>"><%=c.getCategoryName() %></option>
								<%
									}
								%>
							</select>
						</div>
						
						<div class="form-group">
							<label>상품 이름:</label>
							<input class="form-control" type="text" name="productName" id="addProductName">
						</div>
						
						<div class="form-group">
							<label>가격:</label>
							<input class="form-control" type="text" name="productPrice" id="addProductPrice">
						</div>
						
						<div class="form-group">
							<label>설명:</label>
							<textarea class="form-control" rows="5" cols="80" name="productContent" id="addProductContent"></textarea>
						</div>
						
						<div class="form-group">
							<div>
								<label>판매여부:</label>
							</div>
							
							<div class="form-check-inline">
								<label class="form-check-label">
									<input type="radio" class="addProductSoldout form-check-input" name="productSoldout" value="N">판매중
								</label>
							</div>
							
							<div class="form-check-inline">
								<label class="form-check-label">
									<input type="radio" class="addProductSoldout form-check-input" name="productSoldout" value="Y">품절
								</label>
							</div>
						</div>
						
						<div class="form-group">
							<label>이미지:</label>
							<input class="rounded-lg border w-100 p-2" type="file" name="productPic" id="addProductPic">
						</div>
						
						<hr>
						
						<div class="form-group">
							<button class="btn btn-outline-primary btn-block" type="button" id="addProductSubmit">상품 추가</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</body>
</html>