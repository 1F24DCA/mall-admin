<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	System.out.println(session.getAttribute("loginAdminEmail")+"<-session.getAttribute(\"loginAdminEmail\")");
	if (session.getAttribute("loginAdminEmail") != null) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>login</title>
		
		<!-- 부트스트랩 사용 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	</head>
	
	<%
		request.setCharacterEncoding("UTF-8");
		System.out.println(request.getParameter("loginRequired")+"<-request.getParameter(\"loginRequired\")");
		System.out.println(request.getParameter("loginFailed")+"<-request.getParameter(\"loginFailed\")");
		System.out.println(request.getParameter("logout")+"<-request.getParameter(\"logout\")");
		
		String messageClasses = "";
		String message = "";
		if (request.getParameter("loginFailed") != null) {
			messageClasses = "btn btn-outline-danger btn-block disabled";
			message = "로그인에 실패했습니다";
		} else if (request.getParameter("loginRequired") != null) {
			messageClasses = "btn btn-outline-danger btn-block disabled";
			message = "로그인이 필요합니다";
		} else if (request.getParameter("logout") != null) {
			messageClasses = "btn btn-outline-success btn-block disabled";
			message = "성공적으로 로그아웃했습니다";
		}
	%>
	
	<body>
		<div class="container-xl">
			<p>
				<!-- 내용 -->
				<div class="card">
					<!-- 제목 -->
					<div class="card-header">
						<h1>관리자 로그인</h1>
					</div>
					
					<!-- 본문 -->
					<div class="card-body">
						<form method="post" action="<%=request.getContextPath()%>/loginAction.jsp">
							<div class="row">
								<div class="col">
									<div class="form-group">
										<label>관리자 E-mail:</label>
										<input class="form-control" type="text" name="adminEmail">
									</div>
								</div>
								
								<div class="col">
									<div class="form-group">
										<label>관리자 비밀번호:</label>
										<input class="form-control" type="password" name="adminPw">
									</div>
								</div>
							</div>
							
							<hr>
							
							<div class="form-group">
								<button class="btn btn-outline-primary btn-block" type="submit">로그인</button>
							</div>
							
							<%
								if (!message.equals("")) {
							%>
									<hr>
									
									<span class="<%=messageClasses%>">
										<%=message %>
									</span>
							<%
								}
							%>
						</form>
						
						<hr>
						
						<h5 class="text-secondary font-weight-lighter mb-3">개발자 도구</h5>
						<div class="row">
							<div class="col">
								<form method="post" action="<%=request.getContextPath()%>/loginAction.jsp">
									<input type="hidden" name="adminEmail" value="admin@goodee.com">
									<input type="hidden" name="adminPw" value="1234">
									
									<button class="btn btn-success btn-block" type="submit">ID: admin@goodee.com<br>PW: 1234<br>클릭하여 로그인</button>
								</form>
							</div>
							
							<div class="col">
								<form method="post" action="<%=request.getContextPath()%>/loginAction.jsp">
									<input type="hidden" name="adminEmail" value="goodee@goodee.com"">
									<input type="hidden" name="adminPw" value="1234">
									
									<button class="btn btn-success btn-block" type="submit">ID: goodee@goodee.com<br>PW: 1234<br>클릭하여 로그인</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</p>
		</div>
	</body>
</html>