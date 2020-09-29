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
		<title>editNotice</title>
		
		<!-- 부트스트랩 사용 -->
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
					<h1>공지 수정</h1>
				</div>
				
				<!-- 본문 -->
				<div class="card-body">
					<form method="post" action="<%=request.getContextPath()%>/notice/editNoticeAction.jsp">
						<input type="hidden" name="noticeId" value="<%=notice.getNoticeId()%>">
						
						<div class="form-group">
							<label>공지 제목:</label>
							<input class="form-control" type="text" name="noticeTitle" value="<%=notice.getNoticeTitle()%>">
						</div>
						
						<div class="form-group">
							<label>공지 내용:</label>
							<textarea class="form-control" rows="5" cols="80" name="noticeContent"><%=notice.getNoticeContent() %></textarea>
						</div>
						
						<hr>
						
						<div class="form-group">
							<button class="btn btn-outline-warning btn-block" type="submit">공지 수정</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</body>
</html>