<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="vo.*" %>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");

	// 값 가져와서 변수선언
	Member loginMember = (Member)session.getAttribute("loginMember");
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	String qnaCategory = request.getParameter("qnaCategory");	
	String qnaTitle = request.getParameter("qnaTitle");
	String qnaContent = request.getParameter("qnaContent");
	String qnaSecret = request.getParameter("qnaSecret");
	
	// debug
	System.out.println("insertQnaAction.memberNo : " + memberNo);
	System.out.println("insertQnaAction.ebookNo : " + ebookNo);
	System.out.println("insertQnaAction.qnaCategory : " + qnaCategory);
	System.out.println("insertQnaAction.qnaTitle : " + qnaTitle);
	System.out.println("insertQnaAction.qnaContent : " + qnaContent);

	// 방어코드
	if(request.getParameter("qnaTitle") == null || request.getParameter("qnaTitle").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/insertQnaForm.jsp");
		return;
	}
	if(request.getParameter("qnaContent") == null || request.getParameter("qnaContent").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/insertQnaForm.jsp");
		return;
	}

	// dao, vo
	QnaDao qnaDao = new QnaDao();
	Qna qna = new Qna();
	
	// vo에 값 셋팅
	qna.setMemberNo(memberNo);
	qna.setEbookNo(ebookNo);
	qna.setQnaCategory(qnaCategory);
	qna.setQnaTitle(qnaTitle);
	qna.setQnaContent(qnaContent);
	qna.setQnaSecret(qnaSecret);
	
	// qnaDao.insertQna 호출
	qnaDao.insertQna(qna);
	
	// 디버그
	System.out.println("qna 추가 성공");
	
	// 돌려보냄
	response.sendRedirect(request.getContextPath() + "/selectQnaListByOne.jsp?memberNo="+loginMember.getMemberNo());


%>