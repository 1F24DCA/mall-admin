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
	System.out.println(request.getParameter("memberEmail")+"<-request.getParameter(\"memberEmail\")");
	
	Member paramMember = new Member();
	paramMember.setMemberEmail(request.getParameter("memberEmail"));
	
	MemberDao memberDao = new MemberDao();
	memberDao.deleteMember(paramMember);
	
	response.sendRedirect(request.getContextPath()+"/member/memberList.jsp");
%>