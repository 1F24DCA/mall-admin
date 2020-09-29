<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
		<title>addNotice</title>
		
		<!-- 부트스트랩 사용 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	</head>
	
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
					<h1>공지 작성</h1>
				</div>
				
				<!-- 본문 -->
				<div class="card-body">
					<form method="post" action="<%=request.getContextPath()%>/notice/addNoticeAction.jsp">
						<div class="form-group">
							<label>공지 제목:</label>
							<input class="form-control" type="text" name="noticeTitle">
						</div>
						
						<div class="form-group">
							<label>공지 내용:</label>
							<textarea class="form-control" rows="5" cols="80" name="noticeContent"></textarea>
						</div>
						
						<hr>
						
						<div class="form-group">
							<button class="btn btn-outline-primary btn-block" type="submit">공지 작성</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</body>
</html>