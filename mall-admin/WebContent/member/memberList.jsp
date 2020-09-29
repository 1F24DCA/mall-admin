<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<%@ page import="commons.*" %>
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
		<title>memberList</title>
		
		<!-- 부트스트랩 사용 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	</head>
	
	<%
		final String THIS_PAGE = request.getContextPath()+"/member/memberList.jsp";
	
		request.setCharacterEncoding("UTF-8");
		System.out.println(request.getParameter("currentPage")+"<-request.getParameter(\"currentPage\")");
		System.out.println(request.getParameter("searchMemberName")+"<-request.getParameter(\"searchMemberName\")");
		
		ListPage listPage = new ListPage();
		listPage.setCurrentPage(1);
		listPage.setRowPerPage(10);
		listPage.setNaviAmount(5);
		if (request.getParameter("currentPage") != null) {
			listPage.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
		}
		
		String searchMemberEmailOrName = "";
		if (request.getParameter("searchMemberEmailOrName") != null) {
			searchMemberEmailOrName = request.getParameter("searchMemberEmailOrName");
		}
	
		MemberDao memberDao = new MemberDao();
		ArrayList<Member> list = null;
		if (searchMemberEmailOrName.equals("")) {
			list = memberDao.selectMemberListWithPage(listPage);
			listPage.setTotalRow(memberDao.selectMemberCount());
		} else {
			Member paramMember = new Member();
			paramMember.setMemberEmail(searchMemberEmailOrName);
			paramMember.setMemberName(searchMemberEmailOrName);
			
			list = memberDao.selectMemberListWithPageSearchByMemberName(listPage, paramMember);
			listPage.setTotalRow(memberDao.selectMemberCountSearchByMemberName(paramMember));
		}
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
					<h1>회원 목록</h1>
				</div>
				
				<!-- 본문 -->
				<div class="card-body">
					<!-- 회원 검색 -->
					<form method="post" action="<%=THIS_PAGE%>">
						<div class="row">
							<div class="col-9">
								<div class="form-group">
									<input class="form-control" type="text" name="searchMemberEmailOrName" placeholder="이메일 혹은 이름으로 회원 검색" value="<%=searchMemberEmailOrName%>">
								</div>
							</div>
							
							<div class="col-3">
								<div class="form-group">
									<button class="btn btn-outline-primary btn-block" type="submit">검색</button>
								</div>
							</div>
						</div>
					</form>
					
					<!-- 리스트 출력 -->
					<table class="table">
						<thead>
							<tr>
								<th>이메일</th>
								<th>이름</th>
								<th>탈퇴여부</th>
								<th>&nbsp;</th>
							</tr>
						</thead>
						
						<tbody>
							<%
								if (list.size() == 0) {
							%>
									<tr class="table-secondary">
										<td colspan="5" style="text-align: center">회원 없음</td>
									</tr>
							<%
								}
								
								for (Member m : list) {
									String tableRowClasses = "";
									if (m.getDeletedBy().equals("강퇴")) {
										tableRowClasses = "table-danger";
									} else if (m.getDeletedBy().equals("탈퇴")) {
										tableRowClasses = "table-secondary";
									} else {
										tableRowClasses = "table-success";
									}
							%>
									<tr class="<%=tableRowClasses%>">
										<td><%=m.getMemberEmail() %></td>
										<td><%=m.getMemberName() %></td>
										<td><%=m.getDeletedBy() %></td>
										<td><a href="<%=request.getContextPath()%>/member/memberOne.jsp?memberEmail=<%=m.getMemberEmail()%>">상세보기</a></td>
									</tr>
							<%
								}
							%>
						</tbody>
					</table>
					
					<hr>
					
					<!-- 페이지 네비게이션 및 상품 추가 -->
					<div class="row">
						<!-- 페이지 네비게이션 -->
						<div class="col">
							<%
								String naviPrevClasses = "";
								if (!listPage.isFirstNaviPage()) {
									naviPrevClasses = BootstrapConst.PAGE_ITEM_DEFAULT_CLASSES;
								} else {
									naviPrevClasses = BootstrapConst.PAGE_ITEM_DISABLED_CLASSES;
								}
			
								String naviNextClasses = "";
								if (!listPage.isLastNaviPage()) {
									naviNextClasses = BootstrapConst.PAGE_ITEM_DEFAULT_CLASSES;
								} else {
									naviNextClasses = BootstrapConst.PAGE_ITEM_DISABLED_CLASSES;
								}
								
								String naviFirstLink = "";
								String naviPrevLink = "";
								String naviNextLink = "";
								String naviLastLink = "";
								if (searchMemberEmailOrName.equals("")) {
									naviFirstLink = THIS_PAGE;
									naviPrevLink = THIS_PAGE+"?currentPage="+(listPage.getNaviStartPage()-1);
									naviNextLink = THIS_PAGE+"?currentPage="+(listPage.getNaviEndPage()+1);
									naviLastLink = THIS_PAGE+"?currentPage="+(listPage.getNaviLastPage());
								} else {
									naviFirstLink = THIS_PAGE+"?searchMemberEmailOrName="+searchMemberEmailOrName;
									naviPrevLink = THIS_PAGE+"?currentPage="+(listPage.getNaviStartPage()-1)+"&searchMemberEmailOrName="+searchMemberEmailOrName;
									naviNextLink = THIS_PAGE+"?currentPage="+(listPage.getNaviEndPage()+1)+"&searchMemberEmailOrName="+searchMemberEmailOrName;
									naviLastLink = THIS_PAGE+"?currentPage="+(listPage.getNaviLastPage())+"&searchMemberEmailOrName="+searchMemberEmailOrName;
								}
							%>
							
							<ul class="pagination">
								<li class="<%=naviPrevClasses%>">
									<a class="page-link" href="<%=naviFirstLink%>">처음으로</a>
								</li>
								<li class="<%=naviPrevClasses%>">
									<a class="page-link" href="<%=naviPrevLink%>">이전</a>
								</li>
								
								<%
									for (int naviPage : listPage.getNaviPageList()) {
										String naviPageClasses = "";
										if (naviPage != listPage.getCurrentPage()) {
											naviPageClasses = BootstrapConst.PAGE_ITEM_DEFAULT_CLASSES;
										} else {
											naviPageClasses = BootstrapConst.PAGE_ITEM_ACTIVE_CLASSES;
										}
				
										String naviPageLink = "";
										if (searchMemberEmailOrName.equals("")) {
											naviPageLink = THIS_PAGE+"?currentPage="+naviPage;
										} else {
											naviPageLink = THIS_PAGE+"?currentPage="+naviPage+"&searchMemberEmailOrName="+searchMemberEmailOrName;
										}
								%>
										<li class="<%=naviPageClasses%>">
											<a class="page-link" href="<%=naviPageLink%>"><%=naviPage %></a>
										</li>
								<%
									}
								%>
								
								<li class="<%=naviNextClasses%>">
									<a class="page-link" href="<%=naviNextLink%>">다음</a>
								</li>
								<li class="<%=naviNextClasses%>">
									<a class="page-link" href="<%=naviLastLink%>">마지막으로</a>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>