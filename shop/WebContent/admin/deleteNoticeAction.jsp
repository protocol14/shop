<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	NoticeDao noticeDao = new NoticeDao();
	noticeDao.deleteNoticeByAdmin(noticeNo);
	
	response.sendRedirect(request.getContextPath()+"/admin/selectNoticeList.jsp");
%>