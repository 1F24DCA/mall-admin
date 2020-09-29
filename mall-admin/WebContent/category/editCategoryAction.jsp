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
	System.out.println(request.getParameter("categoryName")+"<-request.getParameter(\"categoryName\")");

	Category paramCategory = new Category();
	paramCategory.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
	paramCategory.setCategoryName(request.getParameter("categoryName"));
	
	CategoryDao categoryDao = new CategoryDao();
	categoryDao.updateCategory(paramCategory);
	
	response.sendRedirect(request.getContextPath()+"/category/categoryList.jsp");
%>