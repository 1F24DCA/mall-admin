<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
	System.out.println(session.getAttribute("loginAdminEmail")+"<-session.getAttribute(\"loginAdminEmail\")");
	if (session.getAttribute("loginAdminEmail") == null) {
		response.sendRedirect(request.getContextPath()+"/login.jsp?loginRequired=true");
		return;
	}
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>noticeOne</title>
		
		<!-- 부트스트랩 적용 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	</head>
	
	<%
		request.setCharacterEncoding("UTF-8");
		System.out.println(request.getParameter("noticeId")+"<-request.getParameter(\"noticeId\")");
		
		Notice paramNotice = new Notice();
		paramNotice.setNoticeId(Integer.parseInt(request.getParameter("noticeId")));
		
		NoticeDao noticeDao = new NoticeDao();
		Notice notice = noticeDao.selectNoticeOne(paramNotice);
	%>
	
	<body>
	<div class="container-xl">
		<!-- 메뉴 -->
		<div>
			<jsp:include page="/inc/menu.jsp"></jsp:include>
		</div>
		
		<!-- 내용 -->
		<div class="card">
			<!-- 제목 -->
			<div class="card-header">
				<h1>공지 상세보기</h1>
			</div>
			
			<!-- 본문 -->
			<div class="card-body">
				<!-- 공지 출력 -->
				<table class="table table-striped">
					<tr>
						<th class="w-25 text-right">공지 번호</th>
						<td><%=notice.getNoticeId() %></td>
					</tr>
					
					<tr>
						<th class="w-25 text-right">공지 제목</th>
						<td><%=notice.getNoticeTitle() %></td>
					</tr>
					
					<tr>
						<th class="w-25 text-right">공지 내용</th>
						<td><%=notice.getNoticeContent() %></td>
					</tr>
					
					<tr>
						<th class="w-25 text-right">공지한 날짜</th>
						<td><%=notice.getNoticeDate() %></td>
					</tr>
				</table>
				
				<hr>
				
				<!-- 공지 수정 및 삭제 -->
				<div class="row">
					<div class="col">
						<a class="btn btn-outline-warning btn-block" href="<%=request.getContextPath()%>/notice/editNotice.jsp?noticeId=<%=notice.getNoticeId()%>">수정</a>
					</div>
					
					<div class="col">
						<a class="btn btn-outline-danger btn-block" href="<%=request.getContextPath()%>/notice/deleteNotice.jsp?noticeId=<%=notice.getNoticeId()%>">삭제</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>