<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<%
	System.out.println(session.getAttribute("loginAdminEmail")+"<-session.getAttribute(\"loginAdminEmail\")");
	if (session.getAttribute("loginAdminEmail") == null) {
		response.sendRedirect(request.getContextPath()+"/login.jsp?loginRequired=true");
		return;
	}
	
	final int MEGABYTE = 1024*1024;

	String imageDirPath = application.getRealPath("image");
	int imageFileSize = 10*MEGABYTE;
	
	MultipartRequest multi = new MultipartRequest(request, imageDirPath, imageFileSize, "UTF-8", new DefaultFileRenamePolicy());
	System.out.println(multi.getParameter("categoryId")+"<-request.getParameter(\"categoryId\")");
	System.out.println(multi.getParameter("productName")+"<-request.getParameter(\"productName\")");
	System.out.println(multi.getParameter("productPrice")+"<-request.getParameter(\"productPrice\")");
	System.out.println(multi.getParameter("productContent")+"<-request.getParameter(\"productContent\")");
	System.out.println(multi.getParameter("productSoldout")+"<-request.getParameter(\"productSoldout\")");
	System.out.println(multi.getFilesystemName("productPic")+"<-multi.getFilesystemName(\"productPic\")");
	
	Product paramProduct = new Product();
	paramProduct.setCategoryId(Integer.parseInt(multi.getParameter("categoryId")));
	paramProduct.setProductName(multi.getParameter("productName"));
	paramProduct.setProductPrice(Integer.parseInt(multi.getParameter("productPrice")));
	paramProduct.setProductContent(multi.getParameter("productContent"));
	paramProduct.setProductSoldout(multi.getParameter("productSoldout"));
	if (multi.getFilesystemName("productPic") != null) {
		paramProduct.setProductPic(multi.getFilesystemName("productPic"));
	} else {
		paramProduct.setProductPic("default.jpg");
	}
	
	ProductDao productDao = new ProductDao();
	productDao.insertProduct(paramProduct);
	
	response.sendRedirect(request.getContextPath()+"/product/productList.jsp");
%>