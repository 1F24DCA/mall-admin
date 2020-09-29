<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
	if (session.getAttribute("loginAdminEmail") == null) {
		System.out.println("로그인 필요");
		
		response.sendRedirect("/mall-admin/login.jsp?loginRequired=true");
		
		return;
	}
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>editOrdersState</title>
		
		<!-- 부트스트랩 사용 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	</head>
	
	<%
		request.setCharacterEncoding("UTF-8");
		System.out.println(request.getParameter("productId")+"<-request.getParameter(\"productId\")");
		
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
					<h1>주문 상태 수정</h1>
				</div>
				
				<!-- 본문 -->
				<div class="card-body">
					<form method="post" action="<%=request.getContextPath()%>/orders/editOrdersStateAction.jsp">
						<input type="hidden" name="ordersId" value="<%=oap.getOrders().getOrdersId()%>">
						
						<div class="form-group">
							<label>주문한 날짜:</label>
							<input class="form-control" type="text" name="ordersDate" value="<%=oap.getOrders().getOrdersDate()%>" disabled="disabled">
						</div>
						
						<div class="form-group">
							<label>상품 이름:</label>
							<input class="form-control" type="text" name="productName" value="<%=oap.getProduct().getProductName()%>" disabled="disabled">
						</div>
						
						<div class="form-group">
							<label>주문한 갯수:</label>
							<input class="form-control" type="text" name="ordersAmount" value="<%=oap.getOrders().getOrdersAmount()%>" disabled="disabled">
						</div>
						
						<div class="form-group">
							<label>결제한 금액:</label>
							<input class="form-control" type="text" name="ordersPrice" value="<%=oap.getOrders().getOrdersPrice()%>" disabled="disabled">
						</div>
						
						<div class="form-group">
							<label>주문자 이메일:</label>
							<input class="form-control" type="text" name="memberEmail" value="<%=oap.getOrders().getMemberEmail()%>" disabled="disabled">
						</div>
						
						<div class="form-group">
							<label>배송지:</label>
							<input class="form-control" type="text" name="ordersAddr" value="<%=oap.getOrders().getOrdersAddr()%>" disabled="disabled">
						</div>
						
						<div class="form-group">
							<label>상태:</label>
							<select id="ordersState" class="form-control" name="ordersState">
								<%
									ArrayList<String> ordersStateList = ordersDao.selectOrdersStateListAll();
									for (String state : ordersStateList) {
										if (state.equals(oap.getOrders().getOrdersState())) {
								%>
											<option value="<%=state%>" selected="selected"><%=state %></option>	
								<%
										} else {
								%>
											<option value="<%=state%>"><%=state %></option>	
								<%
										}
									}
								%>
							</select>
						</div>
						
						<hr>
						
						<div class="form-group">
							<button class="btn btn-outline-primary btn-block" type="submit">상태 수정</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</body>
</html>