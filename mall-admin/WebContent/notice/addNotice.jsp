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
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script>
			$(document).ready(function() {
				console.log("document ready");
				
				$("#addNoticeSubmit").click(function() {
					console.log("started add notice");
					
					if ($("#addNoticeTitle").val() == "") {
						alert("공지 제목을 입력해주세요!");
						
						$("#addNoticeTitle").focus();
						return;
					} else if ($("#addNoticeContent").val() == "") {
						alert("공지 내용을 입력해주세요!");
						
						$("#addNoticeContent").focus();
						return;
					}
					
					$("#addNoticeForm").submit();
				});
			});
		</script>
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
					<form method="post" action="<%=request.getContextPath()%>/notice/addNoticeAction.jsp" id="addNoticeForm">
						<div class="form-group">
							<label>공지 제목:</label>
							<input class="form-control" type="text" name="noticeTitle" id="addNoticeTitle">
						</div>
						
						<div class="form-group">
							<label>공지 내용:</label>
							<textarea class="form-control" rows="5" cols="80" name="noticeContent" id="addNoticeContent"></textarea>
						</div>
						
						<hr>
						
						<div class="form-group">
							<button class="btn btn-outline-primary btn-block" type="button" id="addNoticeSubmit">공지 작성</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</body>
</html>