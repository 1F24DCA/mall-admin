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
		<title>editProduct</title>
		
		<!-- 부트스트랩 사용 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script>
			$(document).ready(function() {
				console.log("document ready");
				
				$("#editProductSubmit").click(function() {
					console.log("started edit product");
					
					if ($("#editProductName").val() == "") {
						alert("상품 이름을 입력해주세요!");
						
						$("#editProductName").focus();
						return;
					} else if ($("#editProductPrice").val() == "") {
						alert("상품 가격을 입력해주세요!");
						
						$("#editProductPrice").focus();
						return;
					} else if ($("#editProductContent").val() == "") {
						alert("상품 설명을 입력해주세요!");
						
						$("#editProductContent").focus();
						return;
					}
					
					$("#editProductForm").submit();
				});
			});
		</script>
	</head>
	
	<%
		request.setCharacterEncoding("UTF-8");
		System.out.println(request.getParameter("productId")+"<-request.getParameter(\"productId\")");
		
		Product paramProduct = new Product();
		paramProduct.setProductId(Integer.parseInt(request.getParameter("productId")));
		
		ProductDao productDao = new ProductDao();
		Product product = productDao.selectProductOne(paramProduct);
		
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
					<h1>상품 수정</h1>
				</div>
				
				<!-- 본문 -->
				<div class="card-body">
					<form method="post" action="<%=request.getContextPath()%>/product/editProductAction.jsp" id="editProductForm">
						<input type="hidden" name="productId" value="<%=product.getProductId()%>">
						
						<div class="form-group">
							<label>카테고리:</label>
							<select class="form-control" name="categoryId">
								<option value="">카테고리 선택</option>
								<%
									for (Category c : categoryList) {
										if (product.getCategoryId() == c.getCategoryId()) {
								%>
											<option value="<%=c.getCategoryId()%>" selected="selected"><%=c.getCategoryName() %></option>	
								<%
										} else {
								%>
											<option value="<%=c.getCategoryId()%>"><%=c.getCategoryName() %></option>	
								<%
										}
									}
								%>
							</select>
						</div>
						
						<div class="form-group">
							<label>상품 이름:</label>
							<input class="form-control" type="text" name="productName" value="<%=product.getProductName()%>" id="editProductName">
						</div>
						
						<div class="form-group">
							<label>가격:</label>
							<input class="form-control" type="text" name="productPrice" value="<%=product.getProductPrice()%>" id="editProductPrice">
						</div>
						
						<div class="form-group">
							<label>설명:</label>
							<textarea class="form-control" rows="5" cols="80" name="productContent" id="editProductContent"><%=product.getProductContent() %></textarea>
						</div>
						
						<hr>
						
						<div class="form-group">
							<button class="btn btn-outline-warning btn-block" type="button" id="editProductSubmit">상품 수정</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</body>
</html>