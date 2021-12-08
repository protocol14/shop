<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");
	
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	String ebookTitle = request.getParameter("ebookTitle");
	
	// 한글 URL 변환용
	String ebookTitleURL = "";
	
	// ebookTitle.equals(ebookTitleCheck)라면
	if(ebookTitle.equals(request.getParameter("ebookTitleCheck"))){
		
		System.out.println("[Debug] ebookNo : "+ebookNo);
		EbookDao ebookDao = new EbookDao();
		ebookDao.deleteEbookOneByAdmin(ebookNo);
		
		response.sendRedirect(request.getContextPath()+"/admin/selectEbookList.jsp");
	} else { // 아니면
		ebookTitleURL = java.net.URLEncoder.encode(ebookTitle,"utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/deleteEbookOneForm.jsp?notEq=1&ebookNo="+ebookNo+"&ebookTitle="+ebookTitleURL);
	}
%>