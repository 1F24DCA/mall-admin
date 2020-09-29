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
		<title>deleteProduct</title>
		
		<!-- 부트스트랩 사용 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	</head>
	
	<%
		request.setCharacterEncoding("UTF-8");
		System.out.println(request.getParameter("productId")+"<-request.getParameter(\"productId\")");
		
		Product paramProduct = new Product();
		paramProduct.setProductId(Integer.parseInt(request.getParameter("productId")));
		
		ProductDao productDao = new ProductDao();
		Product product = productDao.selectProductOne(paramProduct);
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
					<h1>상품 삭제</h1>
				</div>
				
				<!-- 본문 -->
				<div class="card-body">
					<form method="post" action="<%=request.getContextPath()%>/product/deleteProductAction.jsp">
						<input type="hidden" name="productId" value="<%=product.getProductId() %>">
						
						<p>정말로 <%=product.getProductName() %>을(를) 삭제하시겠습니까?</p>
						<p>삭제된 내용은 복구할 수 없습니다!</p>
						
						<hr>
						
						<div class="form-group">
							<button class="btn btn-outline-danger btn-block" type="submit">상품 삭제</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</body>
</html>