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
		System.out.println(request.getParameter("searchMemberEmailOrMemberNameEither")+"<-request.getParameter(\"searchMemberEmailOrMemberNameEither\")");
		System.out.println(request.getParameter("searchDeletedBy")+"<-request.getParameter(\"searchDeletedBy\")");
		
		ListPage listPage = new ListPage();
		listPage.setCurrentPage(1);
		listPage.setRowPerPage(10);
		listPage.setNaviAmount(5);
		if (request.getParameter("currentPage") != null) {
			listPage.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
		}
		
		String searchMemberEmailOrMemberNameEither = "";
		if (request.getParameter("searchMemberEmailOrMemberNameEither") != null) {
			searchMemberEmailOrMemberNameEither = request.getParameter("searchMemberEmailOrMemberNameEither");
		}

		String searchDeletedBy = "";
		if (request.getParameter("searchDeletedBy") != null) {
			searchDeletedBy = request.getParameter("searchDeletedBy");
		}
		
		Member paramMember = new Member();
		paramMember.setMemberEmail(searchMemberEmailOrMemberNameEither);
		paramMember.setMemberName(searchMemberEmailOrMemberNameEither);
		paramMember.setDeletedBy(searchDeletedBy);
		
		MemberDao memberDao = new MemberDao();
		ArrayList<Member> list = memberDao.selectMemberListWithPageAndSearch(listPage, paramMember);
		listPage.setTotalRow(memberDao.selectMemberCountWithSearch(paramMember));
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
							<div class="col-6">
								<div class="form-group">
									<input class="form-control" type="text" name="searchMemberEmailOrMemberNameEither" placeholder="이메일 혹은 이름으로 회원 검색" value="<%=searchMemberEmailOrMemberNameEither%>">
								</div>
							</div>
							
							<div class="col-3">
								<div class="form-group">
									<select class="form-control" name="searchDeletedBy">
										<%
											Member paramMemberSearchAllDeletedBy = new Member();
											paramMemberSearchAllDeletedBy.setMemberEmail(searchMemberEmailOrMemberNameEither);
											paramMemberSearchAllDeletedBy.setMemberName(searchMemberEmailOrMemberNameEither);
											paramMemberSearchAllDeletedBy.setDeletedBy("");
											
											int countAllDeletedBy = memberDao.selectMemberCountWithSearch(paramMemberSearchAllDeletedBy);
										%>
										<option value="">전체 탈퇴여부 (<%=countAllDeletedBy %>)</option>
										<%
											ArrayList<String> deletedByList = memberDao.selectDeletedByListAll();
											for (String deletedBy : deletedByList) {
												Member paramMemberSearchDeletedBy = new Member();
												paramMemberSearchDeletedBy.setMemberEmail(searchMemberEmailOrMemberNameEither);
												paramMemberSearchDeletedBy.setMemberName(searchMemberEmailOrMemberNameEither);
												paramMemberSearchDeletedBy.setDeletedBy(deletedBy);
												
												int count = memberDao.selectMemberCountWithSearch(paramMemberSearchDeletedBy);
												
												if (searchDeletedBy.equals(deletedBy)) {
										%>
													<option value="<%=deletedBy%>" selected="selected"><%=deletedBy %> (<%=count %>)</option>
										<%
												} else {
										%>
													<option value="<%=deletedBy%>"><%=deletedBy %> (<%=count %>)</option>
										<%
												}
											}
										%>
									</select>
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
								if (searchMemberEmailOrMemberNameEither.equals("") && searchDeletedBy.equals("")) {
									naviFirstLink = THIS_PAGE;
									naviPrevLink = THIS_PAGE+"?currentPage="+(listPage.getNaviStartPage()-1);
									naviNextLink = THIS_PAGE+"?currentPage="+(listPage.getNaviEndPage()+1);
									naviLastLink = THIS_PAGE+"?currentPage="+(listPage.getNaviLastPage());
								} else if (!searchMemberEmailOrMemberNameEither.equals("") && searchDeletedBy.equals("")) {
									naviFirstLink = THIS_PAGE+"?searchMemberEmailOrMemberNameEither="+searchMemberEmailOrMemberNameEither;
									naviPrevLink = THIS_PAGE+"?currentPage="+(listPage.getNaviStartPage()-1)+"&searchMemberEmailOrMemberNameEither="+searchMemberEmailOrMemberNameEither;
									naviNextLink = THIS_PAGE+"?currentPage="+(listPage.getNaviEndPage()+1)+"&searchMemberEmailOrMemberNameEither="+searchMemberEmailOrMemberNameEither;
									naviLastLink = THIS_PAGE+"?currentPage="+(listPage.getNaviLastPage())+"&searchMemberEmailOrMemberNameEither="+searchMemberEmailOrMemberNameEither;
								} else if (searchMemberEmailOrMemberNameEither.equals("") && !searchDeletedBy.equals("")) {
									naviFirstLink = THIS_PAGE+"?searchDeletedBy="+searchDeletedBy;
									naviPrevLink = THIS_PAGE+"?currentPage="+(listPage.getNaviStartPage()-1)+"&searchDeletedBy="+searchDeletedBy;
									naviNextLink = THIS_PAGE+"?currentPage="+(listPage.getNaviEndPage()+1)+"&searchDeletedBy="+searchDeletedBy;
									naviLastLink = THIS_PAGE+"?currentPage="+(listPage.getNaviLastPage())+"&searchDeletedBy="+searchDeletedBy;
								} else if (!searchMemberEmailOrMemberNameEither.equals("") && !searchDeletedBy.equals("")) {
									naviFirstLink = THIS_PAGE+"?searchMemberEmailOrMemberNameEither="+searchMemberEmailOrMemberNameEither+"&searchDeletedBy="+searchDeletedBy;
									naviPrevLink = THIS_PAGE+"?currentPage="+(listPage.getNaviStartPage()-1)+"&searchMemberEmailOrMemberNameEither="+searchMemberEmailOrMemberNameEither+"&searchDeletedBy="+searchDeletedBy;
									naviNextLink = THIS_PAGE+"?currentPage="+(listPage.getNaviEndPage()+1)+"&searchMemberEmailOrMemberNameEither="+searchMemberEmailOrMemberNameEither+"&searchDeletedBy="+searchDeletedBy;
									naviLastLink = THIS_PAGE+"?currentPage="+(listPage.getNaviLastPage())+"&searchMemberEmailOrMemberNameEither="+searchMemberEmailOrMemberNameEither+"&searchDeletedBy="+searchDeletedBy;
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
										if (searchMemberEmailOrMemberNameEither.equals("") && searchDeletedBy.equals("")) {
											naviPageLink = THIS_PAGE+"?currentPage="+naviPage;
										} else if (!searchMemberEmailOrMemberNameEither.equals("") && searchDeletedBy.equals("")) {
											naviPageLink = THIS_PAGE+"?currentPage="+naviPage+"&searchMemberEmailOrMemberNameEither="+searchMemberEmailOrMemberNameEither;
										} else if (searchMemberEmailOrMemberNameEither.equals("") && !searchDeletedBy.equals("")) {
											naviPageLink = THIS_PAGE+"?currentPage="+naviPage+"&searchDeletedBy="+searchDeletedBy;
										} else if (!searchMemberEmailOrMemberNameEither.equals("") && !searchDeletedBy.equals("")) {
											naviPageLink = THIS_PAGE+"?currentPage="+naviPage+"&searchMemberEmailOrMemberNameEither="+searchMemberEmailOrMemberNameEither+"&searchDeletedBy="+searchDeletedBy;
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