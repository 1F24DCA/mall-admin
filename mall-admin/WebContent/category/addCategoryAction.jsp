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
	System.out.println(multi.getParameter("categoryName")+"<-multi.getParameter(\"categoryName\")");
	System.out.println(multi.getFilesystemName("categoryPic")+"<-multi.getFilesystemName(\"categoryPic\")");
	
	Category paramCategory = new Category();
	paramCategory.setCategoryName(multi.getParameter("categoryName"));
	if (multi.getFilesystemName("categoryPic") != null) {
		paramCategory.setCategoryPic(multi.getFilesystemName("categoryPic"));
	} else {
		paramCategory.setCategoryPic("category.jpg");
	}
	
	CategoryDao categoryDao = new CategoryDao();
	categoryDao.insertCategory(paramCategory);
	
	response.sendRedirect(request.getContextPath()+"/category/categoryList.jsp");
%>