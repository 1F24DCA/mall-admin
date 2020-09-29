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
		<title>noticeList</title>
		
		<!-- 부트스트랩 적용 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	</head>
	
	<%
		final String THIS_PAGE = request.getContextPath()+"/notice/noticeList.jsp";
		
		request.setCharacterEncoding("UTF-8");
		
		ListPage listPage = new ListPage();
		listPage.setCurrentPage(1);
		listPage.setRowPerPage(10);
		listPage.setNaviAmount(5);
		if (request.getParameter("currentPage") != null) {
			listPage.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
		}
	
		String searchNoticeTitle = "";
		if (request.getParameter("searchNoticeTitle") != null) {
			searchNoticeTitle = request.getParameter("searchNoticeTitle");
		}
		
		System.out.println(searchNoticeTitle+"<-searchNoticeTitle");
	
		NoticeDao noticeDao = new NoticeDao();
		ArrayList<Notice> list = null;
		if (searchNoticeTitle.equals("")) {
			list = noticeDao.selectNoticeListWithPageDesc(listPage);
			listPage.setTotalRow(noticeDao.selectNoticeCount());
		} else {
			Notice paramNotice = new Notice();
			paramNotice.setNoticeTitle(searchNoticeTitle);
			
			list = noticeDao.selectNoticeListWithPageDescSearchByNoticeTitle(listPage, paramNotice);
			listPage.setTotalRow(noticeDao.selectNoticeCountSearchByNoticeTitle(paramNotice));
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
					<h1>공지사항</h1>
				</div>
				
				<!-- 본문 -->
				<div class="card-body">
					<!-- 공지 검색 -->
					<form method="post" action="<%=THIS_PAGE%>">
						<div class="row">
							<div class="col-9">
								<div class="form-group">
									<input class="form-control" type="text" name="searchNoticeTitle" placeholder="제목으로 공지 검색" value="<%=searchNoticeTitle%>">
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
					<table class="table table-striped">
						<thead>
							<tr>
								<th>공지 번호</th>
								<th>공지 제목</th>
								<th>&nbsp;</th>
							</tr>
						</thead>
						<tbody>
							<%
								if (list.size() == 0) {
							%>
									<tr class="table-secondary">
										<td colspan="3" style="text-align: center">공지사항 없음</td>
									</tr>
							<%
								}
				
								for (Notice n : list) {
							%>
									<tr>
										<td><%=n.getNoticeId() %></td>
										<td><%=n.getNoticeTitle() %></td>
										<td><a href="<%=request.getContextPath()%>/notice/noticeOne.jsp?noticeId=<%=n.getNoticeId()%>">상세보기</a></td>
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
						<div class="col-9">
							<%
								String naviPrevClasses = null;
								if (!listPage.isFirstNaviPage()) {
									naviPrevClasses = BootstrapConst.PAGE_ITEM_DEFAULT_CLASSES;
								} else {
									naviPrevClasses = BootstrapConst.PAGE_ITEM_DISABLED_CLASSES;
								}
			
								String naviNextClasses = null;
								if (!listPage.isLastNaviPage()) {
									naviNextClasses = BootstrapConst.PAGE_ITEM_DEFAULT_CLASSES;
								} else {
									naviNextClasses = BootstrapConst.PAGE_ITEM_DISABLED_CLASSES;
								}
								
								String naviFirstLink = null;
								String naviPrevLink = null;
								String naviNextLink = null;
								String naviLastLink = null;
								if (searchNoticeTitle.equals("")) {
									naviFirstLink = THIS_PAGE;
									naviPrevLink = THIS_PAGE+"?currentPage="+(listPage.getNaviStartPage()-1);
									naviNextLink = THIS_PAGE+"?currentPage="+(listPage.getNaviEndPage()+1);
									naviLastLink = THIS_PAGE+"?currentPage="+(listPage.getNaviLastPage());
								} else {
									naviFirstLink = THIS_PAGE+"?searchNoticeTitle="+searchNoticeTitle;
									naviPrevLink = THIS_PAGE+"?currentPage="+(listPage.getNaviStartPage()-1)+"&searchNoticeTitle="+searchNoticeTitle;
									naviNextLink = THIS_PAGE+"?currentPage="+(listPage.getNaviEndPage()+1)+"&searchNoticeTitle="+searchNoticeTitle;
									naviLastLink = THIS_PAGE+"?currentPage="+(listPage.getNaviLastPage())+"&searchNoticeTitle="+searchNoticeTitle;
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
										String naviPageClasses = null;
										if (naviPage != listPage.getCurrentPage()) {
											naviPageClasses = BootstrapConst.PAGE_ITEM_DEFAULT_CLASSES;
										} else {
											naviPageClasses = BootstrapConst.PAGE_ITEM_ACTIVE_CLASSES;
										}
				
										String naviPageLink = null;
										if (searchNoticeTitle.equals("")) {
											naviPageLink = THIS_PAGE+"?currentPage="+naviPage;
										} else {
											naviPageLink = THIS_PAGE+"?currentPage="+naviPage+"&searchNoticeTitle="+searchNoticeTitle;
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
						
						<!-- 공지 작성 -->
						<div class="col-3">
							<a class="btn btn-outline-primary btn-block" href="<%=request.getContextPath()%>/notice/addNotice.jsp">작성</a>
						</div>
					</div>
				</div>
			<!-- 본문 끝 -->
			</div>
		<!-- 내용 끝 -->
		</div>
	</body>
</html>