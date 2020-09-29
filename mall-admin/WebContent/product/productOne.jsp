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
		<title>productOne</title>
		
		<!-- 부트스트랩 사용 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	</head>
	
	<%
		request.setCharacterEncoding("UTF-8");
		System.out.println(request.getParameter("productId")+"<-request.getParameter(\"productId\")");
		System.out.println(request.getParameter("editedProductSoldout")+"<-request.getParameter(\"editedProductSoldout\")");
		
		String messageClasses = "";
		String message = "";
		if (request.getParameter("editedProductSoldout") != null) {
			messageClasses = "btn btn-outline-success btn-block disabled";
			if (request.getParameter("editedProductSoldout").equals("Y")) {
				message = "성공적으로 상품의 판매여부를 \"품절\"로 바꿨습니다";
			} else {
				message = "성공적으로 상품의 판매여부를 \"판매중\"으로 바꿨습니다";
			}
		}
		
		Product paramProduct = new Product();
		paramProduct.setProductId(Integer.parseInt(request.getParameter("productId")));
		
		ProductDao productDao = new ProductDao();
		ProductAndCategory pac = productDao.selectProductAndCategoryOne(paramProduct);
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
					<h1>상품 상세보기</h1>
				</div>
				
				<!-- 본문 -->
				<div class="card-body">
					<!-- 상품 출력 -->
					<table class="table table-striped">
						<tr>
							<th class="w-25 text-right">상품 번호</th>
							<td><%=pac.getProduct().getProductId() %></td>
						</tr>
						
						<tr>
							<th class="w-25 text-right">카테고리</th>
							<td><%=pac.getCategory().getCategoryName() %></td>
						</tr>
						
						<tr>
							<th class="w-25 text-right">상품 이름</th>
							<td><%=pac.getProduct().getProductName() %></td>
						</tr>
						
						<tr>
							<th class="w-25 text-right">가격</th>
							<td><%=pac.getProduct().getProductPrice() %></td>
						</tr>
						
						<tr>
							<th class="w-25 text-right">설명</th>
							<td><%=pac.getProduct().getProductContent() %></td>
						</tr>
						
						<tr>
							<th class="w-25 text-right">판매여부</th>
							<%
								String soldoutText = "판매중";
								if (pac.getProduct().getProductSoldout().equals("Y")) {
									soldoutText = "품절";
								}
							%>
							<td><%=soldoutText %></td>
						</tr>
						
						<tr>
							<th class="w-25 text-right">이미지</th>
							<td><img class="border" src="/mall-admin/image/<%=pac.getProduct().getProductPic()%>"></td>
						</tr>
					</table>
					
					<hr>
					
					<!-- 상품 수정 및 삭제 -->
					<div class="row">
						<div class="col">
							<a class="btn btn-outline-primary btn-block" href="<%=request.getContextPath()%>/product/editProductSoldoutAction.jsp?productId=<%=pac.getProduct().getProductId()%>&productSoldout=<%=pac.getProduct().getProductSoldout()%>">
								판매여부 변경
							</a>
						</div>
						
						<div class="col">
							<a class="btn btn-outline-primary btn-block" href="<%=request.getContextPath()%>/product/editProductPic.jsp?productId=<%=pac.getProduct().getProductId()%>">
								이미지 변경
							</a>
						</div>
						
						<div class="col">
							<a class="btn btn-outline-warning btn-block" href="<%=request.getContextPath()%>/product/editProduct.jsp?productId=<%=pac.getProduct().getProductId()%>">수정</a>
						</div>
						
						<div class="col">
							<a class="btn btn-outline-danger btn-block" href="<%=request.getContextPath()%>/product/deleteProduct.jsp?productId=<%=pac.getProduct().getProductId()%>">삭제</a>
						</div>
					</div>
					
					<%
						if (!message.equals("")) {
					%>
							<hr>
							
							<span class="<%=messageClasses%>">
								<%=message %>
							</span>
					<%
						}
					%>
				</div>
			</div>
		</div>
	</body>
</html>