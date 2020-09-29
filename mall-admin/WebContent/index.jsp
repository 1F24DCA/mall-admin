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
		<title>index</title>
		
		<!-- 부트스트랩 사용 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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
					<h1>관리자 메인 페이지</h1>
				</div>
				
				<!-- 본문 -->
				<div class="card-body">
					<p>
						<img src="<%=request.getContextPath()%>/image/exit.png">
					</p>
					<p>
						쇼핑몰 관리용 페이지입니다
					</p>
					<p>
						데이터베이스에 접근해 카테고리, 상품 등을 추가/수정/삭제 가능합니다<br>
						아직 세션 등의 보안 관련 기능이 없기 때문에, 누구나 데이터를 수정할 수 있다는 이슈가 있습니다
					</p>
					
					<hr>
					
					<p>
						<h4>페이지 히스토리</h4>
					</p>
					<p>
						<table class="table">
							<tr>
								<th colspan="3">2020-09-16 (수)</th>
							</tr>
							<tr>
								<th rowspan="14">파일 생성</th>
								<td>/WebContent/login.jsp</td>
								<td>관리자 권한을 체크하기 위해 로그인 정보를 입력하는 폼 페이지</td>
							</tr>
							<tr>
								<td>/WebContent/loginAction.jsp</td>
								<td>로그인 폼에서 받아온 정보로 정말 올바른 접근인지 체크하는 페이지</td>
							</tr>
							<tr>
								<td>/WebContent/index.jsp</td>
								<td>관리자 메인 페이지</td>
							</tr>
							<tr>
								<td>/WebContent/inc/menu.jsp</td>
								<td>다른 페이지로 이동할 수 있는 네비게이션 버튼들이 있는 페이지의 일부분, 각 페이지별로 최상단에 jsp:include 태그를 이용해 배치함</td>
							</tr>
							<tr>
								<td>/src/vo/Category.java</td>
								<td>mall 데이터베이스 category 테이블의 한 행과 매칭되는 데이터 타입</td>
							</tr>
							<tr>
								<td>/src/dao/CategoryDao.java</td>
								<td>mall 데이터베이스 category 테이블에 접근해 데이터를 관리하기 위한 기능을 제공하는 클래스</td>
							</tr>
							<tr>
								<td>/WebContent/category/categoryList.jsp</td>
								<td>카테고리 목록을 출력해서 보여주는 페이지</td>
							</tr>
							<tr>
								<td>/WebContent/category/addCategory.jsp</td>
								<td>카테고리를 추가하기 위한 입력 폼 페이지</td>
							</tr>
							<tr>
								<td>/WebContent/category/addCategoryAction.jsp</td>
								<td>입력 폼에서 받아온 데이터로 DB에 카테고리를 추가하는 작업을 하는 페이지</td>
							</tr>
							<tr>
								<td>/WebContent/category/editCategory.jsp</td>
								<td>특정 카테고리를 수정하기 위한 입력 폼 페이지</td>
							</tr>
							<tr>
								<td>/WebContent/category/editCategoryAction.jsp</td>
								<td>입력 폼에서 받아온 데이터로 DB의 카테고리를 수정하는 작업을 하는 페이지</td>
							</tr>
							<tr>
								<td>/WebContent/category/deleteCategory.jsp</td>
								<td>특정 카테고리를 정말 삭제할건지 여부를 묻는 페이지</td>
							</tr>
							<tr>
								<td>/WebContent/category/deleteCategoryAction.jsp</td>
								<td>특정 카테고리를 DB에서 삭제하는 작업을 하는 페이지</td>
							</tr>
							<tr>
								<td>/src/vo/CategoryPage.java</td>
								<td>카테고리 리스트에서 페이징을 구현하기 위해 만든 데이터 타입 겸 메서드가 있는 클래스</td>
							</tr>
							
							<tr>
								<th colspan="3">2020-09-17 (목)</th>
							</tr>
							<tr>
								<th rowspan="9">파일 생성</th>
								<td>/src/vo/Product.java</td>
								<td>mall 데이터베이스 product 테이블의 한 행과 매칭되는 데이터 타입</td>
							</tr>
							<tr>
								<td>/src/dao/ProductDao.java</td>
								<td>mall 데이터베이스 product 테이블에 접근해 데이터를 관리하기 위한 기능을 제공하는 클래스</td>
							</tr>
							<tr>
								<td>/WebContent/product/productList.jsp</td>
								<td>상품 목록을 출력해서 보여주는 페이지</td>
							</tr>
							<tr>
								<td>/WebContent/product/addProduct.jsp</td>
								<td>상품을 추가하기 위한 입력 폼 페이지</td>
							</tr>
							<tr>
								<td>/WebContent/product/addProductAction.jsp</td>
								<td>입력 폼에서 받아온 데이터로 DB에 상품을 추가하는 작업을 하는 페이지</td>
							</tr>
							<tr>
								<td>/WebContent/product/editProduct.jsp</td>
								<td>특정 상품을 수정하기 위한 입력 폼 페이지</td>
							</tr>
							<tr>
								<td>/WebContent/product/editProductAction.jsp</td>
								<td>입력 폼에서 받아온 데이터로 DB의 상품을 수정하는 작업을 하는 페이지</td>
							</tr>
							<tr>
								<td>/WebContent/product/deleteProduct.jsp</td>
								<td>특정 상품을 정말 삭제할건지 여부를 묻는 페이지</td>
							</tr>
							<tr>
								<td>/WebContent/product/deleteProductAction.jsp</td>
								<td>특정 상품을 DB에서 삭제하는 작업을 하는 페이지</td>
							</tr>
							
							<tr>
								<th colspan="3">2020-09-18 (금)</th>
							</tr>
							<tr>
								<th rowspan="2">파일 생성</th>
								<td>/WebContent/product/viewProduct.jsp</td>
								<td>mall 데이터베이스 product 테이블의 한 행에 대한 상세 정보를 보여주는 페이지</td>
							</tr>
							<tr>
								<td>/src/vo/ProductPage.java</td>
								<td>상품 리스트에서 페이징을 구현하기 위해 만든 데이터 타입 겸 메서드가 있는 클래스</td>
							</tr>
							<tr>
								<th rowspan="3">파일 수정</th>
								<td>/src/dao/ProductDao.java</td>
								<td>
									viewProduct.jsp 페이지를 위한 한 행의 상세정보를 Product 객체로 받아오는 메서드 selectProductOne()을 추가함<br>
									또한 페이징 관련 메서드를 구현함
								</td>
							</tr>
							<tr>
								<td>/src/vo/CategoryPage.java</td>
								<td>isFirstPage와 isLastPage 메서드에 검색 조건을 적용시키는것보다, JSP에 그것들을 구현하는게 낫다 싶어서 메서드를 빼는 방향으로 결정함</td>
							</tr>
							<tr>
								<td>/WebContent/**/*.jsp</td>
								<td>모든 JSP 페이지에 대해 부트스트랩 CSS를 적용함</td>
							</tr>
							
							<tr>
								<th colspan="3">2020-09-21 (월)</th>
							</tr>
							<tr>
								<th rowspan="7">파일 생성</th>
								<td>/src/vo/Orders.java</td>
								<td>mall 데이터베이스 orders 테이블의 한 행과 매칭되는 데이터 타입</td>
							</tr>
							<tr>
								<td>/src/vo/OrdersPage.java</td>
								<td>주문 리스트에서 페이징을 구현하기 위해 만든 데이터 타입 겸 메서드가 있는 클래스</td>
							</tr>
							<tr>
								<td>/src/vo/OrdersAndProduct.java</td>
								<td>mall 데이터베이스 orders 테이블과 product 테이블을 조인시킨 결과를 담는 데이터 타입</td>
							</tr>
							<tr>
								<td>/src/dao/OrdersDao.java</td>
								<td>mall 데이터베이스 orders 테이블에 접근해 데이터를 관리하기 위한 기능을 제공하는 클래스</td>
							</tr>
							<tr>
								<td>/WebContent/orders/ordersList.jsp</td>
								<td>주문 목록을 출력해서 보여주는 페이지</td>
							</tr>
							<tr>
								<td>/WebContent/orders/editOrdersState.jsp</td>
								<td>특정 주문 내역의 상태를 수정하기 위한 입력 폼 페이지</td>
							</tr>
							<tr>
								<td>/WebContent/orders/editOrdersStateAction.jsp</td>
								<td>입력 폼에서 받아온 데이터로 DB의 주문 내역 상태를 수정하는 작업을 하는 페이지</td>
							</tr>
							<tr>
								<th rowspan="3">파일 수정</th>
								<td>/src/dao/*Dao.java</td>
								<td>중구난방인 메서드명을 통일시킴(~With~(), ~By~() -> ~WithPage(), ~SearchBy~())</td>
							</tr>
							<tr>
								<td>/src/vo/*Page.java</td>
								<td>중구난방인 메서드명을 통일시킴(~With~(), ~By~() -> ~WithPage(), ~SearchBy~())</td>
							</tr>
							<tr>
								<td>/WebContent/**/*List.jsp</td>
								<td>
									리스트의 갯수가 0개면 리스트가 비었다는 메세지 출력<br>
									페이징 기능 개선(다음/이전 기능만 -> 1~10페이지..등등 클릭해서 바로 넘어가는 게 가능해짐)
								</td>
							</tr>
							
							<tr>
								<th colspan="3">2020-09-21 (월)→2020-09-22 (화): 야간 작업</th>
							</tr>
							<tr>
								<th rowspan="2">파일 생성</th>
								<td>/src/vo/ProductAndCategory.java</td>
								<td>mall 데이터베이스 product 테이블과 category 테이블을 조인시킨 결과를 담는 데이터 타입</td>
							</tr>
							<tr>
								<td>/WebContent/orders/ordersOne.jsp</td>
								<td>mall 데이터베이스 orders 테이블의 한 행에 대한 상세 정보를 보여주는 페이지</td>
							</tr>
							<tr>
								<th rowspan="4">파일 수정</th>
								<td>/src/dao/ProductDao.java</td>
								<td>조인을 이용하여 categoryName을 받아올 수 있도록 전반적인 select문 수정</td>
							</tr>
							<tr>
								<td>/WebContent/**/*.jsp</td>
								<td>전반적인 페이지 UI 수정 (테이블 색상 카테고리별 적용, 추가/수정 버튼 위치 변경, 페이징 기능 바로 위에 hr태그 추가 등...)</td>
							</tr>
							<tr>
								<td>/**/category*.*</td>
								<td>카테고리 검색 기능 추가</td>
							</tr>
							<tr>
								<td>/WebContent/product/productOne.jsp</td>
								<td>파일명 수정됨: viewProduct.jsp->productOne.jsp</td>
							</tr>
							
							<tr>
								<th colspan="3">2020-09-22 (화)</th>
							</tr>
							<tr>
								<th>파일 생성</th>
								<td>/src/commons/DBUtil.java</td>
								<td>DB 접속 관련 코드를 담당하는 유틸리티 클래스</td>
							</tr>
							<tr>
								<th rowspan="3">파일 수정</th>
								<td>/src/dao/*Dao.jsp</td>
								<td>DBUtil 객체를 사용하여 DB 접속 코드를 간단하게 만듦</td>
							</tr>
							<tr>
								<td>/src/**/Product*.java</td>
								<td>product 테이블에 상품 사진 컬럼을 추가함으로써, 관련된 데이터 타입 추가 및 행동을 수정함</td>
							</tr>
							<tr>
								<td>/WebContent/**/*.jsp</td>
								<td>로그인 정보 관련 세션 저장, 비로그인시 로그인 페이지로 리다이렉트 시키는 기능 및 이미 로그인했는데 다시 로그인 시도할 때 index.jsp로 리다이렉트 시키는 기능 추가</td>
							</tr>
							
							<tr>
								<th colspan="3">2020-09-23 (수)</th>
							</tr>
							<tr>
								<th>파일 생성</th>
								<td>/mall/WebContent/index.jsp</td>
								<td>사용자가 마주하는 메인 페이지, 쇼핑몰의 홈페이지</td>
							</tr>
							<!-- 9월 24일 파일생성:
									mall/member/
										./login.jsp
										./loginAction.jsp
										./logoutAction.jsp
										./signup.jsp
										./signupAction.jsp
							 -->
							
							<tr>
								<th colspan="3">2020-09-24 (목)</th>
							</tr>
							<tr>
								<th rowspan="2">파일 생성</th>
								<td>/mall-admin/WebContent/notice/noticeList.jsp</td>
								<td>공지사항 목록을 보여주는 페이지</td>
							</tr>
							<tr>
								<td>/mall-admin/WebContent/notice/noticeOne.jsp</td>
								<td>공지사항 하나를 보여주는 페이지</td>
							</tr>
							
							
							<!-- 9월 25일 파일생성:
									mall/product/productOne.jsp
									mall/orders/addOrdersAction.jsp
									
									mall-admin/src/
										./commons/ListPage.java
										./commons/BootstrapConst.java
								
								9월 25일 파일수정:
									mall-admin/* (vo 캡슐화, 수정된 vo에 맞게 dao 수정, jsp페이지 수정)
									
								9월 25일 파일삭제:
									mall-admin/src/vo/*Page.java
							 -->
						</table>
					</p>
					
					<hr>
					
					<p>
						<h4>개발 환경</h4>
					</p>
					<p>
						<table class="table">
							<tr>
								<th>OS</th>
								<td>Windows 10 Home 버전 2004 (빌드 19041.508)</td>
							</tr>
							<tr>
								<th>JRE</th>
								<td>OpenJDK Runtime Environment 1.8.0 Update 252 (빌드 1.8.0_252-b09)</td>
							</tr>
							<tr>
								<th>JVM</th>
								<td>OpenJDK 64-Bit Server VM (빌드 25.252-b09, mixed mode)</td>
							</tr>
							<tr>
								<th>IDE</th>
								<td>Eclipse 2020-09(4.17.0) (빌드 20200910-1200)</td>
							</tr>
							<tr>
								<th>WAS</th>
								<td>Apache Tomcat/8.5.57</td>
							</tr>
							<tr>
								<th>DB</th>
								<td>MariaDB 10.3.24 for Win64 (AMD64)</td>
							</tr>
						</table>
					</p>
					
					<hr>
					
					<p>
						<h4>구동 환경 (서버)</h4>
					</p>
					<p>
						구동 환경의 원활한 서비스를 위해, 클라우드 서비스(AWS)로 가상 서버를 임대하여 운영함<br>
						https 구축을 위해 letsencrypt 무료 인증서를 설치함 (인증서 유효 기간 2020-12-12 23:53:12+00:00 까지)
					</p>
					<p>
						<table class="table">
							<tr>
								<th>OS</th>
								<td>Ubuntu 20.04.1 LTS 버전 5.4.0-1024-aws</td>
							</tr>
							<tr>
								<th>JRE</th>
								<td>OpenJDK Runtime Environment 1.8.0 Update 265 (빌드 1.8.0_265-8u265-b01-0ubuntu2~20.04-b01)</td>
							</tr>
							<tr>
								<th>JVM</th>
								<td>OpenJDK 64-Bit Server VM (빌드 25.265-b01, mixed mode)</td>
							</tr>
							<tr>
								<th>WAS</th>
								<td>Apache Tomcat/8.5.57</td>
							</tr>
							<tr>
								<th>DB</th>
								<td>MariaDB 10.3.24 for debian-linux-gnu</td>
							</tr>
						</table>
					</p>
				</div>
			</div>
		</div>
	</body>
</html>