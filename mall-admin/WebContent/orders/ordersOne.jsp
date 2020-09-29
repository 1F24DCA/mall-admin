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
		<title>ordersOne</title>
		
		<!-- 부트스트랩 사용 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	</head>
	
	<%
		request.setCharacterEncoding("UTF-8");
		System.out.println(request.getParameter("ordersId")+"<-request.getParameter(\"ordersId\")");
		
		Orders paramOrders = new Orders();
		paramOrders.setOrdersId(Integer.parseInt(request.getParameter("ordersId")));
		
		OrdersDao ordersDao = new OrdersDao();
		OrdersAndProduct oap = ordersDao.selectOrdersAndProductOne(paramOrders);
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
					<h1>주문 상세보기</h1>
				</div>
				
				<!-- 본문 -->
				<div class="card-body">
					<!-- 주문 내역 출력 -->
					<table class="table table-striped">
						<tr>
							<th>주문 번호</th>
							<td><%=oap.getOrders().getOrdersId() %></td>
						</tr>
						
						<tr>
							<th>주문한 날짜</th>
							<td><%=oap.getOrders().getOrdersDate() %></td>
						</tr>
						
						<tr>
							<th>상품 이름</th>
							<td><%=oap.getProduct().getProductName() %></td>
						</tr>
						
						<tr>
							<th>주문한 갯수</th>
							<td><%=oap.getOrders().getOrdersAmount() %></td>
						</tr>
						
						<tr>
							<th>결제한 금액</th>
							<td><%=oap.getOrders().getOrdersPrice() %></td>
						</tr>
						
						<tr>
							<th>주문자 이메일</th>
							<td><%=oap.getOrders().getMemberEmail() %></td>
						</tr>
						
						<tr>
							<th>배송지</th>
							<td><%=oap.getOrders().getOrdersAddr() %></td>
						</tr>
						
						<tr>
							<th>상태</th>
							<td><%=oap.getOrders().getOrdersState() %></td>
						</tr>
					</table>
					
					<hr>
					
					<!-- 주문 내역의 상태 수정 -->
					<div class="row">
						<div class="col-12">
							<a class="btn btn-outline-primary btn-block" href="<%=request.getContextPath()%>/orders/editOrdersState.jsp?ordersId=<%=oap.getOrders().getOrdersId()%>">상태 수정</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>