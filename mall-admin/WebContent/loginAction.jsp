<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
	System.out.println(session.getAttribute("loginAdminEmail")+"<-session.getAttribute(\"loginAdminEmail\")");
	if (session.getAttribute("loginAdminEmail") != null) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}

	request.setCharacterEncoding("UTF-8");
	System.out.println(request.getParameter("adminEmail")+"<-request.getParameter(\"adminEmail\")");
//	System.out.println(request.getParameter("adminPw")+"<-request.getParameter(\"adminPw\")");
	
	Admin paramAdmin = new Admin();
	paramAdmin.setAdminEmail(request.getParameter("adminEmail"));
	paramAdmin.setAdminPw(request.getParameter("adminPw"));
	
	AdminDao adminDao = new AdminDao();
	Admin returnAdmin = adminDao.login(paramAdmin);
	
	System.out.println(returnAdmin+"<-returnAdmin");
	
	if (returnAdmin != null) {
		session.setAttribute("loginAdminEmail", returnAdmin.getAdminEmail());
		
		response.sendRedirect(request.getContextPath()+"/index.jsp");
	} else {
		response.sendRedirect(request.getContextPath()+"/login.jsp?loginFailed=true");
	}
%>