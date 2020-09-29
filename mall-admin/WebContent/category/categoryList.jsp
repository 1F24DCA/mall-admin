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
		<title>categoryList</title>
		
		<!-- 부트스트랩 사용 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	</head>
	
	<%
		final String THIS_PAGE = request.getContextPath()+"/category/categoryList.jsp";
		
		request.setCharacterEncoding("UTF-8");
		System.out.println(request.getParameter("currentPage")+"<-request.getParameter(\"currentPage\")");
		System.out.println(request.getParameter("searchCategoryName")+"<-request.getParameter(\"searchCategoryName\")");
		
		ListPage listPage = new ListPage();
		listPage.setCurrentPage(1);
		listPage.setRowPerPage(10);
		listPage.setNaviAmount(5);
		if (request.getParameter("currentPage") != null) {
			listPage.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
		}
	
		String searchCategoryName = "";
		if (request.getParameter("searchCategoryName") != null) {
			searchCategoryName = request.getParameter("searchCategoryName");
		}
		
		CategoryDao categoryDao = new CategoryDao();
		ArrayList<Category> list = null;
		if (searchCategoryName.equals("")) {
			list = categoryDao.selectCategoryListWithPage(listPage);
			listPage.setTotalRow(categoryDao.selectCategoryCount());
		} else {
			Category paramCategory = new Category();
			paramCategory.setCategoryName(searchCategoryName);
			
			list = categoryDao.selectCategoryListWithPageSearchByCategoryName(listPage, paramCategory);
			listPage.setTotalRow(categoryDao.selectCategoryCountSearchByCategoryName(paramCategory));
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
					<h1>상품 카테고리</h1>
				</div>
				
				<!-- 본문 -->
				<div class="card-body">
					<!-- 카테고리 검색 -->
					<form method="post" action="<%=THIS_PAGE%>">
						<div class="row">
							<div class="col-9">
								<div class="form-group">
									<input class="form-control" type="text" name="searchCategoryName" placeholder="이름으로 카테고리 검색" value="<%=searchCategoryName%>">
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
								<th>&nbsp;</th>
								<th class="w-50">카테고리 이름</th>
								<th>&nbsp;</th>
								<th>&nbsp;</th>
								<th>&nbsp;</th>
							</tr>
						</thead>
						
						<tbody>
							<%
								if (list.size() == 0) {
							%>
									<tr class="table-secondary">
										<td colspan="4" style="text-align: center">카테고리 없음</td>
									</tr>
							<%
								}
							
								for (Category c : list) {
							%>
									<tr class="align-middle">
										<td><img class="border" src="<%=request.getContextPath()%>/image/<%=c.getCategoryPic()%>" style="width:24pt;height: 24pt;"></td>
										<td><%=c.getCategoryName() %></td>
										<td><a class="text-primary" href="<%=request.getContextPath()%>/category/editCategoryPic.jsp?categoryId=<%=c.getCategoryId()%>">이미지 수정</a></td>
										<td><a class="text-warning" href="<%=request.getContextPath()%>/category/editCategory.jsp?categoryId=<%=c.getCategoryId()%>">수정</a></td>
										<td><a class="text-danger" href="<%=request.getContextPath()%>/category/deleteCategory.jsp?categoryId=<%=c.getCategoryId()%>">삭제</a></td>
									</tr>
							<%
								}
							%>
						</tbody>
					</table>
					
					<hr>
					
					<!-- 페이지 네비게이션 및 카테고리 추가 -->
					<div class="row">
						<!-- 페이지 네비게이션 -->
						<div class="col-9">
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
								if (searchCategoryName.equals("")) {
									naviFirstLink = THIS_PAGE;
									naviPrevLink = THIS_PAGE+"?currentPage="+(listPage.getNaviStartPage()-1);
									naviNextLink = THIS_PAGE+"?currentPage="+(listPage.getNaviEndPage()+1);
									naviLastLink = THIS_PAGE+"?currentPage="+(listPage.getNaviLastPage());
								} else {
									naviFirstLink = THIS_PAGE+"?searchCategoryName="+searchCategoryName;
									naviPrevLink = THIS_PAGE+"?currentPage="+(listPage.getNaviStartPage()-1)+"&searchCategoryName="+searchCategoryName;
									naviNextLink = THIS_PAGE+"?currentPage="+(listPage.getNaviEndPage()+1)+"&searchCategoryName="+searchCategoryName;
									naviLastLink = THIS_PAGE+"?currentPage="+(listPage.getNaviLastPage())+"&searchCategoryName="+searchCategoryName;
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
										if (searchCategoryName.equals("")) {
											naviPageLink = THIS_PAGE+"?currentPage="+naviPage;
										} else {
											naviPageLink = THIS_PAGE+"?currentPage="+naviPage+"&searchCategoryName="+searchCategoryName;
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
						
						<!-- 카테고리 추가 -->
						<div class="col-3">
							<a class="btn btn-outline-primary btn-block" href="<%=request.getContextPath()%>/category/addCategory.jsp">추가</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>