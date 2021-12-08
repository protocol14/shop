<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="vo.*" %>
<%
	//encoding
	request.setCharacterEncoding("utf-8");
	
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	String qnaCommentContent = request.getParameter("qnaCommentContent");
	
	// debug
	System.out.println("memberNo : " + memberNo);
	System.out.println("qnaNo : " + qnaNo);
	System.out.println("qnaCommentContent : " + qnaCommentContent);
	

	// 방어코드
	if(request.getParameter("qnaCommentContent") == null || request.getParameter("qnaCommentContent").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/insertQnaCommentAction.jsp");
		return;
	}
	
	qnaCommentContent = qnaCommentContent.replaceAll("\r\n|\n", "<br>");
	// dao
	QnaCommentDao qnaCommentDao = new QnaCommentDao();
	QnaComment qnaComment = new QnaComment();
	qnaComment.setMemberNo(memberNo);
	qnaComment.setQnaNo(qnaNo);
	qnaComment.setQnaCommentContent(qnaCommentContent);
	
	System.out.println("[Debug] insertqnaCommentAction qnaComment : "+qnaComment);
	
	qnaCommentDao.insertQnaComment(qnaComment);
	System.out.println("답변 추가 성공");
	response.sendRedirect(request.getContextPath() + "/admin/adminIndex.jsp");


%>