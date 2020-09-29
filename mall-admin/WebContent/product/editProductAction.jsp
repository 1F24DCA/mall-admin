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
	System.out.println(request.getParameter("categoryId")+"<-request.getParameter(\"categoryId\")");
	System.out.println(request.getParameter("productName")+"<-request.getParameter(\"productName\")");
	System.out.println(request.getParameter("productPrice")+"<-request.getParameter(\"productPrice\")");
	System.out.println(request.getParameter("productContent")+"<-request.getParameter(\"productContent\")");
	
	Product paramProduct = new Product();
	paramProduct.setProductId(Integer.parseInt(request.getParameter("productId")));
	paramProduct.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
	paramProduct.setProductName(request.getParameter("productName"));
	paramProduct.setProductPrice(Integer.parseInt(request.getParameter("productPrice")));
	paramProduct.setProductContent(request.getParameter("productContent"));
	
	ProductDao productDao = new ProductDao();
	productDao.updateProduct(paramProduct);

	response.sendRedirect(request.getContextPath()+"/product/productOne.jsp?productId="+paramProduct.getProductId());
%>