<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");

	Member loginMember = (Member)session.getAttribute("loginMember");
	
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	String qnaCategory = request.getParameter("qnaCategory");
	String qnaContent = request.getParameter("qnaContent");
	
	
	System.out.println("[Debug] qnaNo : "+qnaNo);
	System.out.println("[Debug] qnaCategory : "+qnaCategory);
	System.out.println("[Debug] qnaContent : "+qnaContent);
	
	// 줄바꿈 변환
	qnaContent = qnaContent.replaceAll("\r\n|\n", "<br>");
	
	QnaDao qnaDao = new QnaDao();
	Qna qna = new Qna();
	qna.setQnaNo(qnaNo);
	qna.setQnaCategory(qnaCategory);
	qna.setQnaContent(qnaContent);
	
	System.out.println("[Debug] qna : "+qna);
	
	qnaDao.updateQna(qna);
	
	response.sendRedirect(request.getContextPath()+"/selectQnaListByOne.jsp?memberNo="+loginMember.getMemberNo());
%>