<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="vo.*" %>
<%
	//encoding
	request.setCharacterEncoding("utf-8");
	
	String ebookTitle = request.getParameter("ebookTitle");
	String categoryName = request.getParameter("categoryName");
	String ebookISBN = request.getParameter("ebookISBN");
	String ebookAuthor = request.getParameter("ebookAuthor");
	String ebookCompany = request.getParameter("ebookCompany");
	int ebookPageCount = Integer.parseInt(request.getParameter("ebookPageCount"));
	int ebookPrice = Integer.parseInt(request.getParameter("ebookPrice"));
	String ebookSummary = request.getParameter("ebookSummary");
	
	// 디버그
	System.out.println("ebookTitle : " + ebookTitle);
	System.out.println("categoryName : " + categoryName);
	System.out.println("ebookISBN : " + ebookISBN);
	System.out.println("ebookAuthor : " + ebookAuthor);
	System.out.println("ebookCompany : " + ebookCompany);
	System.out.println("ebookPageCount : " + ebookPageCount);
	System.out.println("ebookPrice : " + ebookPrice);
	System.out.println("ebookSummary : " + ebookSummary);
	

	// 방어코드
	if(request.getParameter("ebookTitle") == null || request.getParameter("ebookTitle").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/insertEbookForm.jsp");
		System.out.println("ebookTitle error");
		return;
	}
	if(request.getParameter("categoryName") == null || request.getParameter("categoryName").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/insertEbookForm.jsp");
		System.out.println("categoryName error");
		return;
	}
	if(request.getParameter("ebookISBN") == null || request.getParameter("ebookISBN").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/insertEbookForm.jsp");
		System.out.println("ebookISBN error");
		return;
	}
	if(request.getParameter("ebookAuthor") == null || request.getParameter("ebookAuthor").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/insertEbookForm.jsp");
		System.out.println("ebookAuthor error");
		return;
	}
	if(request.getParameter("ebookCompany") == null || request.getParameter("ebookCompany").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/insertEbookForm.jsp");
		System.out.println("ebookCompany error");
		return;
	}
	if(Integer.parseInt(request.getParameter("ebookPageCount")) == 0) {
		response.sendRedirect(request.getContextPath()+"/admin/insertEbookForm.jsp");
		System.out.println("ebookPageCount error");
		return;
	}
	if(Integer.parseInt(request.getParameter("ebookPrice")) == 0) {
		response.sendRedirect(request.getContextPath()+"/admin/insertEbookForm.jsp");
		System.out.println("ebookPrice error");
		return;
	}
	if(request.getParameter("ebookSummary") == null || request.getParameter("ebookSummary").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/insertEbookForm.jsp");
		System.out.println("ebookSummary error");
		return;
	}
	
	// 줄바꿈
	ebookSummary = ebookSummary.replaceAll("\r\n|\n", "<br>");

	// dao
	EbookDao ebookDao = new EbookDao();
	Ebook ebook = new Ebook();
	ebook.setEbookTitle(ebookTitle);
	ebook.setCategoryName(categoryName);
	ebook.setEbookAuthor(ebookAuthor);
	ebook.setEbookCompany(ebookCompany);
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookPageCount(ebookPageCount);
	ebook.setEbookPrice(ebookPrice);
	ebook.setEbookSummary(ebookSummary);
	
	// 디버그
	System.out.println("[Debug] insertEbookAction ebook : "+ebook);
	
	ebookDao.insertEbook(ebook);
	System.out.println("ebook 추가 성공");
	response.sendRedirect(request.getContextPath() + "/admin/selectEbookList.jsp");


%>