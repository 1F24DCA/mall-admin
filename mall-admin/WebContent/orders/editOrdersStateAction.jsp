<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
	System.out.println(session.getAttribute("loginAdminEmail")+"<-session.getAttribute(\"loginAdminEmail\")");
	if (session.getAttribute("loginAdminEmail") == null) {
		response.sendRedirect(request.getContextPath()+"/login.jsp?loginRequired=true");
		return;
	}
	
	request.setCharacterEncoding("UTF-8");
	System.out.println(request.getParameter("ordersId")+"<-request.getParameter(\"ordersId\")");
	System.out.println(request.getParameter("ordersState")+"<-request.getParameter(\"ordersState\")");
	
	Orders paramOrders = new Orders();
	paramOrders.setOrdersId(Integer.parseInt(request.getParameter("ordersId")));
	paramOrders.setOrdersState(request.getParameter("ordersState"));
	
	OrdersDao ordersDao = new OrdersDao();
	ordersDao.updateOrdersState(paramOrders);

	response.sendRedirect(request.getContextPath()+"/orders/ordersOne.jsp?ordersId="+paramOrders.getOrdersId());
%>