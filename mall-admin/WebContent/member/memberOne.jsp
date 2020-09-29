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
		<title>memberOne</title>
		
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
					<h1>회원 상세보기</h1>
				</div>
				
				<!-- 본문 -->
				<div class="card-body">
					<!-- 회원 출력 -->
					<table class="table table-striped">
						<tr>
							<th class="w-25 text-right">이메일</th>
							<td><%=member.getMemberEmail() %></td>
						</tr>
						
						<tr>
							<th class="w-25 text-right">이름</th>
							<td><%=member.getMemberName() %></td>
						</tr>
						
						<tr>
							<th class="w-25 text-right">가입한 날짜</th>
							<td><%=member.getMemberDate() %></td>
						</tr>
						
						<tr>
							<th class="w-25 text-right">탈퇴여부</th>
							<td><%=member.getDeletedBy() %></td>
						</tr>
					</table>
					
					<%
						if (member.getDeletedBy().equals("활동중")) {
					%>
							<hr>
							
							<!-- 회원 강퇴 -->
							<div class="row">
								<div class="col">
									<a class="btn btn-outline-danger btn-block" href="<%=request.getContextPath()%>/member/deleteMember.jsp?memberEmail=<%=member.getMemberEmail()%>">회원 강퇴</a>
								</div>
							</div>
					<%
						}
					%>
				</div>
			</div>
		</div>
	</body>
</html>