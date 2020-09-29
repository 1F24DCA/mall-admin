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
	System.out.println(request.getParameter("productSoldout")+"<-request.getParameter(\"productSoldout\")");
	
	String editedProductSoldout = "";
	if (request.getParameter("productSoldout").equals("Y")) {
		editedProductSoldout = "N";
	} else {
		editedProductSoldout = "Y";
	}
	
	Product paramProduct = new Product();
	paramProduct.setProductId(Integer.parseInt(request.getParameter("productId")));
	paramProduct.setProductSoldout(editedProductSoldout);
	
	ProductDao productDao = new ProductDao();
	productDao.updateProductSoldout(paramProduct);
	
	response.sendRedirect(request.getContextPath()+"/product/productOne.jsp?productId="+paramProduct.getProductId()+"&editedProductSoldout="+editedProductSoldout);
%>