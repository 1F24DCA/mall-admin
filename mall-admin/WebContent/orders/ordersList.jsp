<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<%@ page import="commons.*" %>
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
		<title>ordersList</title>
		
		<!-- 부트스트랩 사용 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	</head>
	
	<%
		final String THIS_PAGE = request.getContextPath()+"/orders/ordersList.jsp";
	
		request.setCharacterEncoding("UTF-8");
		System.out.println(request.getParameter("currentPage")+"<-request.getParameter(\"currentPage\")");
		System.out.println(request.getParameter("searchOrdersState")+"<-request.getParameter(\"searchOrdersState\")");
		
		ListPage listPage = new ListPage();
		listPage.setCurrentPage(1);
		listPage.setRowPerPage(10);
		listPage.setNaviAmount(5);
		if (request.getParameter("currentPage") != null) {
			listPage.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
		}
		
		String searchProductName = "";
		if (request.getParameter("searchProductName") != null) {
			searchProductName = request.getParameter("searchProductName");
		}
		
		String searchMemberEmail = "";
		if (request.getParameter("searchMemberEmail") != null) {
			searchMemberEmail = request.getParameter("searchMemberEmail");
		}
		
		String searchOrdersState = "";
		if (request.getParameter("searchOrdersState") != null) {
			searchOrdersState = request.getParameter("searchOrdersState");
		}
		
		OrdersAndProduct paramOAP = new OrdersAndProduct();
		paramOAP.setOrders(new Orders());
		paramOAP.setProduct(new Product());
		paramOAP.getProduct().setProductName(searchProductName);
		paramOAP.getOrders().setMemberEmail(searchMemberEmail);
		paramOAP.getOrders().setOrdersState(searchOrdersState);
		
		OrdersDao ordersDao = new OrdersDao();
		ArrayList<OrdersAndProduct> list = ordersDao.selectOrdersListWithPageDescAndSearch(listPage, paramOAP);
		listPage.setTotalRow(ordersDao.selectOrdersCountWithSearch(paramOAP));
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
					<h1>주문 목록</h1>
				</div>
				
				<!-- 본문 -->
				<div class="card-body">
					<!-- 주문 상태 검색 -->
					<form method="post" action="<%=THIS_PAGE%>">
						<div class="row">
							<!-- 상품 이름으로 주문 검색 -->
							<div class="col-3">
								<div class="form-group">
									<input class="form-control" type="text" name="searchProductName" placeholder="상품 이름으로 주문 검색" value="<%=searchProductName%>">
								</div>
							</div>
							
							<!-- 이메일로 주문 검색 -->
							<div class="col-3">
								<div class="form-group">
									<input class="form-control" type="text" name="searchMemberEmail" placeholder="이메일로 주문 검색" value="<%=searchMemberEmail%>">
								</div>
							</div>
							
							<!-- 주문 상태로 주문 검색 -->
							<div class="col-3">
								<div class="form-group">
									<select class="form-control" name="searchOrdersState">
										<%
											OrdersAndProduct paramOAPSearchAllOrdersState = new OrdersAndProduct();
											paramOAPSearchAllOrdersState.setOrders(new Orders());
											paramOAPSearchAllOrdersState.setProduct(new Product());
											paramOAPSearchAllOrdersState.getProduct().setProductName(searchProductName);
											paramOAPSearchAllOrdersState.getOrders().setMemberEmail(searchMemberEmail);
											paramOAPSearchAllOrdersState.getOrders().setOrdersState("");
											
											int countAllOrdersState = ordersDao.selectOrdersCountWithSearch(paramOAPSearchAllOrdersState);
										%>
										<option value="">전체 상태 (<%=countAllOrdersState %>)</option>
										<%
											ArrayList<String> ordersStateList = ordersDao.selectOrdersStateListExist();
											for (String ordersState : ordersStateList) {
												OrdersAndProduct paramOAPSearchOrdersState = new OrdersAndProduct();
												paramOAPSearchOrdersState.setOrders(new Orders());
												paramOAPSearchOrdersState.setProduct(new Product());
												paramOAPSearchOrdersState.getProduct().setProductName(searchProductName);
												paramOAPSearchOrdersState.getOrders().setMemberEmail(searchMemberEmail);
												paramOAPSearchOrdersState.getOrders().setOrdersState(ordersState);
												
												int count = ordersDao.selectOrdersCountWithSearch(paramOAPSearchOrdersState);
												
												// 검색한 카테고리와 일치하면 해당 항목을 선택함
												if (searchOrdersState.equals(ordersState)) {
										%>
													<option value="<%=ordersState%>" selected="selected"><%=ordersState %> (<%=count %>)</option>
										<%
												} else {
										%>
													<option value="<%=ordersState%>"><%=ordersState %> (<%=count %>)</option>
										<%
												}
											}
										%>
									</select>
								</div>
							</div>
							
							<div class="col-3">
								<div class="form-group">
									<button class="btn btn-outline-primary btn-block" type="submit">검색</button>
								</div>
							</div>
						</div>
					</form>
					
					<!-- 리스트 출력 -->
					<table class="table">
						<thead>
							<tr>
								<th>주문한 날짜</th>
								<th>상품 이름</th>
								<th>고객 이메일</th>
								<th>상태</th>
								<th>&nbsp;</th>
							</tr>
						</thead>
						<tbody>
							<%
								if (list.size() == 0) {
							%>
									<tr class="table-secondary">
										<td colspan="5" style="text-align: center">주문 내역 없음</td>
									</tr>
							<%
								}
								
								for (OrdersAndProduct oap : list) {
									String tableRowClasses = "";
									if (oap.getOrders().getOrdersState().equals("결제완료")) {
										tableRowClasses = "table-primary";
									} else if (oap.getOrders().getOrdersState().equals("배송준비중")) {
										tableRowClasses = "table-warning";
									} else if (oap.getOrders().getOrdersState().equals("배송완료")) {
										tableRowClasses = "table-success";
									} else if (oap.getOrders().getOrdersState().equals("주문취소")) {
										tableRowClasses = "table-danger";
									}
							%>
									<tr class="<%=tableRowClasses%>">
										<td><%=oap.getOrders().getOrdersDate().replace(".0", "") %></td>
										<td><%=oap.getProduct().getProductName() %></td>
										<td><%=oap.getOrders().getMemberEmail() %></td>
										<td><%=oap.getOrders().getOrdersState() %></td>
										<td><a href="<%=request.getContextPath()%>/orders/ordersOne.jsp?ordersId=<%=oap.getOrders().getOrdersId()%>">상세보기</a></td>
									</tr>
							<%
								}
							%>
						</tbody>
					</table>
					<hr>
					<div class="row">
						<div class="col-12">
							<%
								String naviPrevClasses = "";
								if (!listPage.isFirstNaviPage()) {
									naviPrevClasses = BootstrapConst.PAGE_ITEM_DEFAULT_CLASSES;
								} else {
									naviPrevClasses = BootstrapConst.PAGE_ITEM_DISABLED_CLASSES;
								}
			
								String naviNextClasses = "";
								if (!listPage.isLastNaviPage()) {
									naviNextClasses = BootstrapConst.PAGE_ITEM_DEFAULT_CLASSES;
								} else {
									naviNextClasses = BootstrapConst.PAGE_ITEM_DISABLED_CLASSES;
								}
								
								String naviFirstLink = "";
								String naviPrevLink = "";
								String naviNextLink = "";
								String naviLastLink = "";
								if (searchProductName.equals("") && searchMemberEmail.equals("") && searchOrdersState.equals("")) {
									naviFirstLink = THIS_PAGE;
									naviPrevLink = THIS_PAGE+"?currentPage="+(listPage.getNaviStartPage()-1);
									naviNextLink = THIS_PAGE+"?currentPage="+(listPage.getNaviEndPage()+1);
									naviLastLink = THIS_PAGE+"?currentPage="+(listPage.getNaviLastPage());
								} else if (!searchProductName.equals("") && searchMemberEmail.equals("") && searchOrdersState.equals("")) {
									naviFirstLink = THIS_PAGE+"?searchProductName="+searchProductName;
									naviPrevLink = THIS_PAGE+"?currentPage="+(listPage.getNaviStartPage()-1)+"&searchProductName="+searchProductName;
									naviNextLink = THIS_PAGE+"?currentPage="+(listPage.getNaviEndPage()+1)+"&searchProductName="+searchProductName;
									naviLastLink = THIS_PAGE+"?currentPage="+(listPage.getNaviLastPage())+"&searchProductName="+searchProductName;
								} else if (searchProductName.equals("") && !searchMemberEmail.equals("") && searchOrdersState.equals("")) {
									naviFirstLink = THIS_PAGE+"?searchMemberEmail="+searchMemberEmail;
									naviPrevLink = THIS_PAGE+"?currentPage="+(listPage.getNaviStartPage()-1)+"&searchMemberEmail="+searchMemberEmail;
									naviNextLink = THIS_PAGE+"?currentPage="+(listPage.getNaviEndPage()+1)+"&searchMemberEmail="+searchMemberEmail;
									naviLastLink = THIS_PAGE+"?currentPage="+(listPage.getNaviLastPage())+"&searchMemberEmail="+searchMemberEmail;
								} else if (searchProductName.equals("") && searchMemberEmail.equals("") && !searchOrdersState.equals("")) {
									naviFirstLink = THIS_PAGE+"?searchOrdersState="+searchOrdersState;
									naviPrevLink = THIS_PAGE+"?currentPage="+(listPage.getNaviStartPage()-1)+"&searchOrdersState="+searchOrdersState;
									naviNextLink = THIS_PAGE+"?currentPage="+(listPage.getNaviEndPage()+1)+"&searchOrdersState="+searchOrdersState;
									naviLastLink = THIS_PAGE+"?currentPage="+(listPage.getNaviLastPage())+"&searchOrdersState="+searchOrdersState;
								} else if (!searchProductName.equals("") && !searchMemberEmail.equals("") && searchOrdersState.equals("")) {
									naviFirstLink = THIS_PAGE+"?searchProductName="+searchProductName+"&searchMemberEmail="+searchMemberEmail;
									naviPrevLink = THIS_PAGE+"?currentPage="+(listPage.getNaviStartPage()-1)+"&searchProductName="+searchProductName+"&searchMemberEmail="+searchMemberEmail;
									naviNextLink = THIS_PAGE+"?currentPage="+(listPage.getNaviEndPage()+1)+"&searchProductName="+searchProductName+"&searchMemberEmail="+searchMemberEmail;
									naviLastLink = THIS_PAGE+"?currentPage="+(listPage.getNaviLastPage())+"&searchProductName="+searchProductName+"&searchMemberEmail="+searchMemberEmail;
								} else if (!searchProductName.equals("") && searchMemberEmail.equals("") && !searchOrdersState.equals("")) {
									naviFirstLink = THIS_PAGE+"?searchProductName="+searchProductName+"&searchOrdersState="+searchOrdersState;
									naviPrevLink = THIS_PAGE+"?currentPage="+(listPage.getNaviStartPage()-1)+"&searchProductName="+searchProductName+"&searchOrdersState="+searchOrdersState;
									naviNextLink = THIS_PAGE+"?currentPage="+(listPage.getNaviEndPage()+1)+"&searchProductName="+searchProductName+"&searchOrdersState="+searchOrdersState;
									naviLastLink = THIS_PAGE+"?currentPage="+(listPage.getNaviLastPage())+"&searchProductName="+searchProductName+"&searchOrdersState="+searchOrdersState;
								} else if (searchProductName.equals("") && !searchMemberEmail.equals("") && !searchOrdersState.equals("")) {
									naviFirstLink = THIS_PAGE+"?searchMemberEmail="+searchMemberEmail+"&searchOrdersState="+searchOrdersState;
									naviPrevLink = THIS_PAGE+"?currentPage="+(listPage.getNaviStartPage()-1)+"&searchMemberEmail="+searchMemberEmail+"&searchOrdersState="+searchOrdersState;
									naviNextLink = THIS_PAGE+"?currentPage="+(listPage.getNaviEndPage()+1)+"&searchMemberEmail="+searchMemberEmail+"&searchOrdersState="+searchOrdersState;
									naviLastLink = THIS_PAGE+"?currentPage="+(listPage.getNaviLastPage())+"&searchMemberEmail="+searchMemberEmail+"&searchOrdersState="+searchOrdersState;
								} else if (!searchProductName.equals("") && !searchMemberEmail.equals("") && !searchOrdersState.equals("")) {
									naviFirstLink = THIS_PAGE+"?searchProductName="+searchProductName+"&searchMemberEmail="+searchMemberEmail+"&searchOrdersState="+searchOrdersState;
									naviPrevLink = THIS_PAGE+"?currentPage="+(listPage.getNaviStartPage()-1)+"&searchProductName="+searchProductName+"&searchMemberEmail="+searchMemberEmail+"&searchOrdersState="+searchOrdersState;
									naviNextLink = THIS_PAGE+"?currentPage="+(listPage.getNaviEndPage()+1)+"&searchProductName="+searchProductName+"&searchMemberEmail="+searchMemberEmail+"&searchOrdersState="+searchOrdersState;
									naviLastLink = THIS_PAGE+"?currentPage="+(listPage.getNaviLastPage())+"&searchProductName="+searchProductName+"&searchMemberEmail="+searchMemberEmail+"&searchOrdersState="+searchOrdersState;
								}
							%>
							
							<ul class="pagination">
								<li class="<%=naviPrevClasses%>">
									<a class="page-link" href="<%=naviFirstLink%>">처음으로</a>
								</li>
								<li class="<%=naviPrevClasses%>">
									<a class="page-link" href="<%=naviPrevLink%>">이전</a>
								</li>
								
								<%
									for (int naviPage : listPage.getNaviPageList()) {
										String naviPageClasses = "";
										if (naviPage != listPage.getCurrentPage()) {
											naviPageClasses = BootstrapConst.PAGE_ITEM_DEFAULT_CLASSES;
										} else {
											naviPageClasses = BootstrapConst.PAGE_ITEM_ACTIVE_CLASSES;
										}
				
										String naviPageLink = "";
										if (searchProductName.equals("") && searchMemberEmail.equals("") && searchOrdersState.equals("")) {
											naviPageLink = THIS_PAGE+"?currentPage="+naviPage;
										} else if (!searchProductName.equals("") && searchMemberEmail.equals("") && searchOrdersState.equals("")) {
											naviPageLink = THIS_PAGE+"?currentPage="+naviPage+"&searchProductName="+searchProductName;
										} else if (searchProductName.equals("") && !searchMemberEmail.equals("") && searchOrdersState.equals("")) {
											naviPageLink = THIS_PAGE+"?currentPage="+naviPage+"&searchMemberEmail="+searchMemberEmail;
										} else if (searchProductName.equals("") && searchMemberEmail.equals("") && !searchOrdersState.equals("")) {
											naviPageLink = THIS_PAGE+"?currentPage="+naviPage+"&searchOrdersState="+searchOrdersState;
										} else if (!searchProductName.equals("") && !searchMemberEmail.equals("") && searchOrdersState.equals("")) {
											naviPageLink = THIS_PAGE+"?currentPage="+naviPage+"&searchProductName="+searchProductName+"&searchMemberEmail="+searchMemberEmail;
										} else if (!searchProductName.equals("") && searchMemberEmail.equals("") && !searchOrdersState.equals("")) {
											naviPageLink = THIS_PAGE+"?currentPage="+naviPage+"&searchProductName="+searchProductName+"&searchOrdersState="+searchOrdersState;
										} else if (searchProductName.equals("") && !searchMemberEmail.equals("") && !searchOrdersState.equals("")) {
											naviPageLink = THIS_PAGE+"?currentPage="+naviPage+"&searchMemberEmail="+searchMemberEmail+"&searchOrdersState="+searchOrdersState;
										} else if (!searchProductName.equals("") && !searchMemberEmail.equals("") && !searchOrdersState.equals("")) {
											naviPageLink = THIS_PAGE+"?currentPage="+naviPage+"&searchProductName="+searchProductName+"&searchMemberEmail="+searchMemberEmail+"&searchOrdersState="+searchOrdersState;
										}
								%>
										<li class="<%=naviPageClasses%>">
											<a class="page-link" href="<%=naviPageLink%>"><%=naviPage %></a>
										</li>
								<%
									}
								%>
								
								<li class="<%=naviNextClasses%>">
									<a class="page-link" href="<%=naviNextLink%>">다음</a>
								</li>
								<li class="<%=naviNextClasses%>">
									<a class="page-link" href="<%=naviLastLink%>">마지막으로</a>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>