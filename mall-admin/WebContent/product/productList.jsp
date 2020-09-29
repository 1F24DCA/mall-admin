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
		<title>productList</title>
		
		<!-- 부트스트랩 사용 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	</head>
	
	<%
		final String THIS_PAGE = request.getContextPath()+"/product/productList.jsp";
	
		request.setCharacterEncoding("UTF-8");
		System.out.println(request.getParameter("currentPage")+"<-request.getParameter(\"currentPage\")");
		System.out.println(request.getParameter("searchCategoryId")+"<-request.getParameter(\"searchCategoryId\")");
		System.out.println(request.getParameter("searchProductName")+"<-request.getParameter(\"searchProductName\")");
		System.out.println(request.getParameter("searchProductSoldout")+"<-request.getParameter(\"searchProductSoldout\")");
		
		ListPage listPage = new ListPage();
		listPage.setCurrentPage(1);
		listPage.setRowPerPage(10);
		listPage.setNaviAmount(5);
		if (request.getParameter("currentPage") != null) {
			listPage.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
		}
		
		int searchCategoryId = -1;
		if (request.getParameter("searchCategoryId") != null) {
			searchCategoryId = Integer.parseInt(request.getParameter("searchCategoryId"));
		}
		
		String searchProductName = "";
		if (request.getParameter("searchProductName") != null) {
			searchProductName = request.getParameter("searchProductName");
		}
		
		String searchProductSoldout = "";
		if (request.getParameter("searchProductSoldout") != null) {
			searchProductSoldout = request.getParameter("searchProductSoldout");
		}
		
		Product paramProduct = new Product();
		paramProduct.setCategoryId(searchCategoryId);
		paramProduct.setProductName(searchProductName);
		paramProduct.setProductSoldout(searchProductSoldout);
	
		ProductDao productDao = new ProductDao();
		ArrayList<ProductAndCategory> list = productDao.selectProductListWithPageDescAndSearch(listPage, paramProduct);
		listPage.setTotalRow(productDao.selectProductCountWithSearch(paramProduct));
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
					<h1>상품 목록</h1>
				</div>
				
				<!-- 본문 -->
				<div class="card-body">
					<!-- 상품 검색 -->
					<form method="post" action="<%=THIS_PAGE%>">
						<div class="row">
							<div class="col-3">
								<!-- 카테고리로 상품 검색 -->
								<div class="form-group">
									<select class="form-control" name="searchCategoryId">
										<%
											Product paramProductSearchAllCategoryId = new Product();
											paramProductSearchAllCategoryId.setCategoryId(-1);
											paramProductSearchAllCategoryId.setProductName(searchProductName);
											paramProductSearchAllCategoryId.setProductSoldout(searchProductSoldout);
											
											int countAllCategoryId = productDao.selectProductCountWithSearch(paramProductSearchAllCategoryId);
										%>
										<option value="-1">전체 카테고리 (<%=countAllCategoryId %>)</option>
										<%
											CategoryDao categoryDao = new CategoryDao();
											ArrayList<Category> categoryList = categoryDao.selectCategoryList();
											for (Category c : categoryList) {
												Product paramProductSearchCategoryId = new Product();
												paramProductSearchCategoryId.setCategoryId(c.getCategoryId());
												paramProductSearchCategoryId.setProductName(searchProductName);
												paramProductSearchCategoryId.setProductSoldout(searchProductSoldout);
												
												int count = productDao.selectProductCountWithSearch(paramProductSearchCategoryId);
												
												// 검색한 카테고리와 일치하면 해당 항목을 선택함
												if (searchCategoryId == c.getCategoryId()) {
										%>
													<option value="<%=c.getCategoryId()%>" selected="selected"><%=c.getCategoryName() %> (<%=count %>)</option>
										<%
												} else {
										%>
													<option value="<%=c.getCategoryId()%>"><%=c.getCategoryName() %> (<%=count %>)</option>
										<%
												}
											}
										%>
									</select>
								</div>
							</div>
							
							<!-- 판매여부로 상품 검색 -->
							<div class="col-3">
								<div class="form-group">
									<select class="form-control" name="searchProductSoldout">
										<%
											Product paramProductSearchAllProductSoldout = new Product();
											paramProductSearchAllProductSoldout.setCategoryId(searchCategoryId);
											paramProductSearchAllProductSoldout.setProductName(searchProductName);
											paramProductSearchAllProductSoldout.setProductSoldout("");
											
											int countAllProductSoldout = productDao.selectProductCountWithSearch(paramProductSearchAllProductSoldout);
										%>
										<option value="">전체 제품 (<%=countAllProductSoldout %>)</option>
										<%
											ArrayList<String> productSoldoutListAll = new ArrayList<String>();
											productSoldoutListAll.add("N");
											productSoldoutListAll.add("Y");
											for (String productSoldout : productSoldoutListAll) {
												String productSoldoutName = "";
												if (productSoldout.equals("N")) {
													productSoldoutName = "판매중";
												} else if (productSoldout.equals("Y")) {
													productSoldoutName = "품절";
												}
												
												Product paramProductSearchProductSoldout = new Product();
												paramProductSearchProductSoldout.setCategoryId(searchCategoryId);
												paramProductSearchProductSoldout.setProductName(searchProductName);
												paramProductSearchProductSoldout.setProductSoldout(productSoldout);
												
												int count = productDao.selectProductCountWithSearch(paramProductSearchProductSoldout);
												
												if (searchProductSoldout.equals(productSoldout)) {
										%>
													<option value="<%=productSoldout%>" selected="selected"><%=productSoldoutName %> (<%=count %>)</option>
										<%
												} else {
										%>
													<option value="<%=productSoldout%>"><%=productSoldoutName %> (<%=count %>)</option>
										<%
												}
											}
										%>
									</select>
								</div>
							</div>
							
							<!-- 상품 이름으로 상품 검색 -->
							<div class="col-3">
								<div class="form-group">
									<input class="form-control" type="text" name="searchProductName" placeholder="이름으로 상품 검색" value="<%=searchProductName%>">
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
								<th>카테고리</th>
								<th>상품 이름</th>
								<th>가격</th>
								<th>판매여부</th>
								<th>&nbsp;</th>
							</tr>
						</thead>
						
						<tbody>
							<%
								if (list.size() == 0) {
							%>
									<tr class="table-secondary">
										<td colspan="5" style="text-align: center">상품 없음</td>
									</tr>
							<%
								}
								
								for (ProductAndCategory pac : list) {
									String tableRowClasses = null;
									String tableRowSoldoutText = null;
									if (pac.getProduct().getProductSoldout().equals("Y")) {
										tableRowClasses = "table-danger";
										tableRowSoldoutText = "품절";
									} else {
										tableRowClasses = "table-success";
										tableRowSoldoutText = "판매중";
									}
							%>
									<tr class="<%=tableRowClasses%>">
										<!-- <td><%=pac.getProduct().getProductId() %></td> -->
										<td><%=pac.getCategory().getCategoryName() %></td>
										<td><%=pac.getProduct().getProductName() %></td>
										<td><%=pac.getProduct().getProductPrice() %></td>
										<td><%=tableRowSoldoutText %></td>
										<td><a href="<%=request.getContextPath()%>/product/productOne.jsp?productId=<%=pac.getProduct().getProductId()%>">상세보기</a></td>
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
								if (searchCategoryId == -1 && searchProductName.equals("") && searchProductSoldout.equals("")) {
									naviFirstLink = THIS_PAGE;
									naviPrevLink = THIS_PAGE+"?currentPage="+(listPage.getNaviStartPage()-1);
									naviNextLink = THIS_PAGE+"?currentPage="+(listPage.getNaviEndPage()+1);
									naviLastLink = THIS_PAGE+"?currentPage="+(listPage.getNaviLastPage());
								} else if (searchCategoryId != -1 && searchProductName.equals("") && searchProductSoldout.equals("")) {
									naviFirstLink = THIS_PAGE+"?searchCategoryId="+searchCategoryId;
									naviPrevLink = THIS_PAGE+"?currentPage="+(listPage.getNaviStartPage()-1)+"&searchCategoryId="+searchCategoryId;
									naviNextLink = THIS_PAGE+"?currentPage="+(listPage.getNaviEndPage()+1)+"&searchCategoryId="+searchCategoryId;
									naviLastLink = THIS_PAGE+"?currentPage="+(listPage.getNaviLastPage())+"&searchCategoryId="+searchCategoryId;
								} else if (searchCategoryId == -1 && !searchProductName.equals("") && searchProductSoldout.equals("")) {
									naviFirstLink = THIS_PAGE+"?searchProductName="+searchProductName;
									naviPrevLink = THIS_PAGE+"?currentPage="+(listPage.getNaviStartPage()-1)+"&searchProductName="+searchProductName;
									naviNextLink = THIS_PAGE+"?currentPage="+(listPage.getNaviEndPage()+1)+"&searchProductName="+searchProductName;
									naviLastLink = THIS_PAGE+"?currentPage="+(listPage.getNaviLastPage())+"&searchProductName="+searchProductName;
								} else if (searchCategoryId == -1 && searchProductName.equals("") && !searchProductSoldout.equals("")) {
									naviFirstLink = THIS_PAGE+"?searchProductSoldout="+searchProductSoldout;
									naviPrevLink = THIS_PAGE+"?currentPage="+(listPage.getNaviStartPage()-1)+"&searchProductSoldout="+searchProductSoldout;
									naviNextLink = THIS_PAGE+"?currentPage="+(listPage.getNaviEndPage()+1)+"&searchProductSoldout="+searchProductSoldout;
									naviLastLink = THIS_PAGE+"?currentPage="+(listPage.getNaviLastPage())+"&searchProductSoldout="+searchProductSoldout;
								} else if (searchCategoryId != -1 && !searchProductName.equals("") && searchProductSoldout.equals("")) {
									naviFirstLink = THIS_PAGE+"?searchCategoryId="+searchCategoryId+"&searchProductName="+searchProductName;
									naviPrevLink = THIS_PAGE+"?currentPage="+(listPage.getNaviStartPage()-1)+"&searchCategoryId="+searchCategoryId+"&searchProductName="+searchProductName;
									naviNextLink = THIS_PAGE+"?currentPage="+(listPage.getNaviEndPage()+1)+"&searchCategoryId="+searchCategoryId+"&searchProductName="+searchProductName;
									naviLastLink = THIS_PAGE+"?currentPage="+(listPage.getNaviLastPage())+"&searchCategoryId="+searchCategoryId+"&searchProductName="+searchProductName;
								} else if (searchCategoryId != -1 && searchProductName.equals("") && !searchProductSoldout.equals("")) {
									naviFirstLink = THIS_PAGE+"?searchCategoryId="+searchCategoryId+"&searchProductSoldout="+searchProductSoldout;
									naviPrevLink = THIS_PAGE+"?currentPage="+(listPage.getNaviStartPage()-1)+"&searchCategoryId="+searchCategoryId+"&searchProductSoldout="+searchProductSoldout;
									naviNextLink = THIS_PAGE+"?currentPage="+(listPage.getNaviEndPage()+1)+"&searchCategoryId="+searchCategoryId+"&searchProductSoldout="+searchProductSoldout;
									naviLastLink = THIS_PAGE+"?currentPage="+(listPage.getNaviLastPage())+"&searchCategoryId="+searchCategoryId+"&searchProductSoldout="+searchProductSoldout;
								} else if (searchCategoryId == -1 && !searchProductName.equals("") && !searchProductSoldout.equals("")) {
									naviFirstLink = THIS_PAGE+"?searchProductName="+searchProductName+"&searchProductSoldout="+searchProductSoldout;
									naviPrevLink = THIS_PAGE+"?currentPage="+(listPage.getNaviStartPage()-1)+"&searchProductName="+searchProductName+"&searchProductSoldout="+searchProductSoldout;
									naviNextLink = THIS_PAGE+"?currentPage="+(listPage.getNaviEndPage()+1)+"&searchProductName="+searchProductName+"&searchProductSoldout="+searchProductSoldout;
									naviLastLink = THIS_PAGE+"?currentPage="+(listPage.getNaviLastPage())+"&searchProductName="+searchProductName+"&searchProductSoldout="+searchProductSoldout;
								} else if (searchCategoryId != -1 && !searchProductName.equals("") && !searchProductSoldout.equals("")) {
									naviFirstLink = THIS_PAGE+"?searchCategoryId="+searchCategoryId+"&searchProductName="+searchProductName+"&searchProductSoldout="+searchProductSoldout;
									naviPrevLink = THIS_PAGE+"?currentPage="+(listPage.getNaviStartPage()-1)+"&searchCategoryId="+searchCategoryId+"&searchProductName="+searchProductName+"&searchProductSoldout="+searchProductSoldout;
									naviNextLink = THIS_PAGE+"?currentPage="+(listPage.getNaviEndPage()+1)+"&searchCategoryId="+searchCategoryId+"&searchProductName="+searchProductName+"&searchProductSoldout="+searchProductSoldout;
									naviLastLink = THIS_PAGE+"?currentPage="+(listPage.getNaviLastPage())+"&searchCategoryId="+searchCategoryId+"&searchProductName="+searchProductName+"&searchProductSoldout="+searchProductSoldout;
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
										if (searchCategoryId == -1 && searchProductName.equals("") && searchProductSoldout.equals("")) {
											naviPageLink = THIS_PAGE+"?currentPage="+naviPage;
										} else if (searchCategoryId != -1 && searchProductName.equals("") && searchProductSoldout.equals("")) {
											naviPageLink = THIS_PAGE+"?currentPage="+naviPage+"&searchCategoryId="+searchCategoryId;
										} else if (searchCategoryId == -1 && !searchProductName.equals("") && searchProductSoldout.equals("")) {
											naviPageLink = THIS_PAGE+"?currentPage="+naviPage+"&searchProductName="+searchProductName;
										} else if (searchCategoryId == -1 && searchProductName.equals("") && !searchProductSoldout.equals("")) {
											naviPageLink = THIS_PAGE+"?currentPage="+naviPage+"&searchProductSoldout="+searchProductSoldout;
										} else if (searchCategoryId != -1 && !searchProductName.equals("") && searchProductSoldout.equals("")) {
											naviPageLink = THIS_PAGE+"?currentPage="+naviPage+"&searchCategoryId="+searchCategoryId+"&searchProductName="+searchProductName;
										} else if (searchCategoryId != -1 && searchProductName.equals("") && !searchProductSoldout.equals("")) {
											naviPageLink = THIS_PAGE+"?currentPage="+naviPage+"&searchCategoryId="+searchCategoryId+"&searchProductSoldout="+searchProductSoldout;
										} else if (searchCategoryId == -1 && !searchProductName.equals("") && !searchProductSoldout.equals("")) {
											naviPageLink = THIS_PAGE+"?currentPage="+naviPage+"&searchProductName="+searchProductName+"&searchProductSoldout="+searchProductSoldout;
										} else if (searchCategoryId != -1 && !searchProductName.equals("") && !searchProductSoldout.equals("")) {
											naviPageLink = THIS_PAGE+"?currentPage="+naviPage+"&searchCategoryId="+searchCategoryId+"&searchProductName="+searchProductName+"&searchProductSoldout="+searchProductSoldout;
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
						
						<!-- 상품 추가 -->
						<div class="col-3">
							<a class="btn btn-outline-primary btn-block" href="<%=request.getContextPath()%>/product/addProduct.jsp">추가</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>