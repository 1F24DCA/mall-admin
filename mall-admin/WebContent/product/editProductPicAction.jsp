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
	System.out.println(multi.getParameter("productId")+"<-multi.getParameter(\"productId\")");
	System.out.println(multi.getFilesystemName("productPic")+"<-multi.getFilesystemName(\"productPic\")");
	
	Product paramProduct = new Product();
	paramProduct.setProductId(Integer.parseInt(multi.getParameter("productId")));
	paramProduct.setProductPic(multi.getFilesystemName("productPic"));
	
	ProductDao productDao = new ProductDao();
	productDao.updateProductPic(paramProduct);

	response.sendRedirect(request.getContextPath()+"/product/productOne.jsp?productId="+paramProduct.getProductId());
%>