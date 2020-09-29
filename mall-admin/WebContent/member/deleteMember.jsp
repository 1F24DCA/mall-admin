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
		<title>deleteMember</title>
		
		<!-- 부트스트랩 사용 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	</head>
	
	<%
		request.setCharacterEncoding("UTF-8");
		System.out.println(request.getParameter("memberEmail")+"<-request.getParameter(\"memberEmail\")");
		
		Member paramMember = new Member();
		paramMember.setMemberEmail(request.getParameter("memberEmail"));
		
		MemberDao memberDao = new MemberDao();
		Member member = memberDao.selectMemberOne(paramMember);
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
					<h1>회원 강퇴</h1>
				</div>
				
				<!-- 본문 -->
				<div class="card-body">
					<form method="post" action="<%=request.getContextPath()%>/member/deleteMemberAction.jsp">
						<input type="hidden" name="productId" value="<%=member.getMemberEmail() %>">
						
						<p>정말로 <%=member.getMemberName() %>님을 강퇴시키겠습니까?</p>
						<p>강퇴시킨 아이디는 복구할 수 없습니다!</p>
						
						<hr>
						
						<div class="form-group">
							<button class="btn btn-outline-danger btn-block" type="submit">회원 강퇴</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</body>
</html>