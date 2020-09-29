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
	System.out.println(request.getParameter("noticeId")+"<-request.getParameter(\"noticeId\")");
	System.out.println(request.getParameter("noticeTitle")+"<-request.getParameter(\"noticeTitle\")");
	System.out.println(request.getParameter("noticeContent")+"<-request.getParameter(\"noticeContent\")");
	
	Notice paramNotice = new Notice();
	paramNotice.setNoticeId(Integer.parseInt(request.getParameter("noticeId")));
	paramNotice.setNoticeTitle(request.getParameter("noticeTitle"));
	paramNotice.setNoticeContent(request.getParameter("noticeContent"));
	
	NoticeDao noticeDao = new NoticeDao();
	noticeDao.updateNotice(paramNotice);
	
	response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?noticeId="+paramNotice.getNoticeId());
%>