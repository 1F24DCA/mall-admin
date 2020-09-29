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
	System.out.println(request.getParameter("productId")+"<-request.getParameter(\"productId\")");
	
	Product paramProduct = new Product();
	paramProduct.setProductId(Integer.parseInt(request.getParameter("productId")));
	
	ProductDao productDao = new ProductDao();
	productDao.deleteProduct(paramProduct);
	
	response.sendRedirect(request.getContextPath()+"/product/productList.jsp");
%>