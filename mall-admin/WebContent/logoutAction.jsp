<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	session.invalidate();
	System.out.println("session.invalidate()");
	
	response.sendRedirect(request.getContextPath()+"/login.jsp?logout=true");
%>