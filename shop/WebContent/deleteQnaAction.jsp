<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");
	
	// qnaNo값을 받아와서 int변환 후 삽입
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	
	// dao, vo
	QnaDao qnaDao = new QnaDao();
	qnaDao.deleteQna(qnaNo);
	
	// 처리 후 돌려보냄
	response.sendRedirect(request.getContextPath()+"/admin/selectQnaList.jsp");
%>