<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticeContent = request.getParameter("noticeContent");
	
	
	System.out.println("[Debug] noticeNo : "+noticeNo);
	System.out.println("[Debug] noticeContent : "+noticeContent);
	
	// 줄바꿈 변환
	noticeContent = noticeContent.replaceAll("\r\n|\n", "<br>");
	
	NoticeDao noticeDao = new NoticeDao();
	Notice notice = new Notice();
	notice.setNoticeNo(noticeNo);
	notice.setNoticeContent(noticeContent);
	
	System.out.println("[Debug] notice : "+notice);
	
	noticeDao.updateNoticeByAdmin(notice);
	
	response.sendRedirect(request.getContextPath()+"/admin/selectNoticeOne.jsp?noticeNo="+noticeNo);
%>