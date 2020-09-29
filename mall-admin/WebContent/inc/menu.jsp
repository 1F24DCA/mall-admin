<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 페이지의 상단 네비게이션으로 끼울 메뉴(페이지의 일부분만 구현한 JSP 파일) -->
<!-- bootstrap class 사용 -->
<div class="row">
	<div class="col-8">
		<nav class="navbar navbar-expand">
			<ul class="navbar-nav">
				<li class="nav-item">
					<a class="btn btn-link" href="<%=request.getContextPath()%>/index.jsp">홈으로</a>
				</li>
				<li class="nav-item">
					<a class="btn btn-link" href="<%=request.getContextPath()%>/category/categoryList.jsp">상품 카테고리 관리</a>
				</li>
				<li class="nav-item">
					<a class="btn btn-link" href="<%=request.getContextPath()%>/product/productList.jsp">상품 관리</a>
				</li>
				<li class="nav-item">
					<a class="btn btn-link" href="<%=request.getContextPath()%>/orders/ordersList.jsp">주문 관리</a>
				</li>
				<li class="nav-item">
					<a class="btn btn-link" href="<%=request.getContextPath()%>/notice/noticeList.jsp">공지 관리</a>
				</li>
				<li class="nav-item">
					<a class="btn btn-link" href="<%=request.getContextPath()%>/member/memberList.jsp">회원 관리</a>
				</li>
			</ul>
		</nav>
	</div>
	
	<div class="col-4">
		<nav class="navbar navbar-expand justify-content-end">
			<ul class="navbar-nav d-flex align-items-center">
				<li class="nav-item">
					<span class="btn btn-sm disabled"><%=session.getAttribute("loginAdminEmail") %></span>
				</li>
				<li class="nav-item">
					<a class="btn btn-link" href="<%=request.getContextPath()%>/logoutAction.jsp">로그아웃</a>
				</li>
			</ul>
		</nav>
	</div>
</div>