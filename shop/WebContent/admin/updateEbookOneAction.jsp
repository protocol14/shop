<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="vo.*" %>
<%
	//encoding
	request.setCharacterEncoding("utf-8");
	
	int ebookNo = 0;
	String ebookTitle = "";
	String categoryName = "";
	String ebookISBN = "";
	String ebookAuthor = "";
	String ebookCompany = "";
	int ebookPageCount = 0;
	int ebookPrice = 0;
	String ebookSummary = "";
	String ebookState = "";
	
	ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	ebookTitle = request.getParameter("ebookTitle");
	categoryName = request.getParameter("categoryName");
	ebookISBN = request.getParameter("ebookISBN");
	ebookAuthor = request.getParameter("ebookAuthor");
	ebookCompany = request.getParameter("ebookCompany");
	ebookPageCount = Integer.parseInt(request.getParameter("ebookPageCount"));
	ebookPrice = Integer.parseInt(request.getParameter("ebookPrice"));
	ebookSummary = request.getParameter("ebookSummary");
	ebookState = request.getParameter("ebookState");
	
	// debug
	System.out.println("ebookTitle : " + ebookTitle);
	System.out.println("categoryName : " + categoryName);
	System.out.println("ebookISBN : " + ebookISBN);
	System.out.println("ebookAuthor : " + ebookAuthor);
	System.out.println("ebookCompany : " + ebookCompany);
	System.out.println("ebookPageCount : " + ebookPageCount);
	System.out.println("ebookPrice : " + ebookPrice);
	System.out.println("ebookSummary : " + ebookSummary);
	System.out.println("ebookState : " + ebookState);
	

	// 방어코드
	if(Integer.parseInt(request.getParameter("ebookNo")) == 0) {
		response.sendRedirect(request.getContextPath()+"/admin/insertEbookForm.jsp");
		System.out.println("ebookNo error");
		return;
	}
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
	if(request.getParameter("ebookState") == null || request.getParameter("ebookState").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/insertEbookForm.jsp");
		System.out.println("ebookState error");
		return;
	}
	
	
	// 줄바꿈
	ebookSummary = ebookSummary.replaceAll("\r\n|\n", "<br>");
	
	// dao
	EbookDao ebookDao = new EbookDao();
	Ebook ebook = new Ebook();
	ebook.setEbookNo(ebookNo);
	ebook.setEbookTitle(ebookTitle);
	ebook.setCategoryName(categoryName);
	ebook.setEbookAuthor(ebookAuthor);
	ebook.setEbookCompany(ebookCompany);
	ebook.setEbookISBN(ebookISBN);
	ebook.setEbookPageCount(ebookPageCount);
	ebook.setEbookPrice(ebookPrice);
	ebook.setEbookSummary(ebookSummary);
	ebook.setEbookState(ebookState);
	
	System.out.println("[Debug] updateEbookOneAction ebook : "+ebook);
	
	ebookDao.updateEbookOne(ebook);
	System.out.println("ebook 수정 성공");
	response.sendRedirect(request.getContextPath() + "/admin/selectEbookOne.jsp?ebookNo="+ebookNo);


%>