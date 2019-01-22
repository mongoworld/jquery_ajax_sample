<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(ServletFileUpload.isMultipartContent(request)) {
		ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
		uploadHandler.setHeaderEncoding("UTF-8");
		List<FileItem> items = uploadHandler.parseRequest(request);
		String realnm = "";
		Long size = 0L;
		for(FileItem item : items) {
			if(item.isFormField()) {
				System.out.println("text 값::"+item.getString("UTF-8"));
			}
			else {
				System.out.println("file 값::"+item.getName());
			}
		}
	}
%>    