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
	System.out.println(request.getParameter("categoryId")+"<-request.getParameter(\"categoryId\")");
	System.out.println(request.getParameter("productName")+"<-request.getParameter(\"productName\")");
	System.out.println(request.getParameter("productPrice")+"<-request.getParameter(\"productPrice\")");
	System.out.println(request.getParameter("productContent")+"<-request.getParameter(\"productContent\")");
	System.out.println(request.getParameter("productSoldout")+"<-request.getParameter(\"productSoldout\")");
	
	Product paramProduct = new Product();
	paramProduct.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
	paramProduct.setProductName(request.getParameter("productName"));
	paramProduct.setProductPrice(Integer.parseInt(request.getParameter("productPrice")));
	paramProduct.setProductContent(request.getParameter("productContent"));
	paramProduct.setProductSoldout(request.getParameter("productSoldout"));
	
	ProductDao productDao = new ProductDao();
	productDao.insertProduct(paramProduct);
	
	response.sendRedirect(request.getContextPath()+"/product/productList.jsp");
%>