<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
						mall 프로젝트에서 사용하는 DB를 관리합니다<br>
						상품 카테고리 관리, 상품 관리, 주문 조회 및 주문 상태 변경, 공지 작성, 회원 조회 및 회원 강퇴 등이 가능합니다
					</p>
					
					<hr>
					
					<p>
						<h4>개발 환경</h4>
					</p>
					<p>
						<table class="table">
							<tr>
								<th class="w-25">OS</th>
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
								<th class="w-25">OS</th>
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