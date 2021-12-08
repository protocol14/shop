<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="vo.*" %>
<%
	//encoding
	request.setCharacterEncoding("utf-8");

	int memberNo = 0;
	String noticeTitle = "";
	String noticeContent = "";
	
	
	noticeTitle = request.getParameter("noticeTitle");
	noticeContent = request.getParameter("noticeContent");
	memberNo = Integer.parseInt(request.getParameter("memberNo"));
	
	// 디버그
	System.out.println("noticeTitle : " + noticeTitle);
	System.out.println("noticeContent : " + noticeContent);
	System.out.println("memberNo : " + memberNo);
	

	// 방어코드
	if(request.getParameter("noticeTitle") == null || request.getParameter("noticeTitle").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/insertNoticeForm.jsp");
		System.out.println("noticeTitle error");
		return;
	}
	if(request.getParameter("noticeContent") == null || request.getParameter("noticeContent").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/insertNoticeForm.jsp");
		System.out.println("noticeContent error");
		return;
	}
	if(Integer.parseInt(request.getParameter("memberNo")) == 0) {
		response.sendRedirect(request.getContextPath()+"/admin/insertNoticeForm.jsp");
		System.out.println("memberNo error");
		return;
	}
	
	noticeContent = noticeContent.replaceAll("\r\n|\n", "<br>");
	// dao
	NoticeDao noticeDao = new NoticeDao();
	Notice notice = new Notice();
	notice.setMemberNo(memberNo);
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	
	// 디버그
	System.out.println("[Debug] insertNoticeAction notice : "+notice);
	
	noticeDao.insertNotice(notice);
	System.out.println("공지 추가 성공");
	response.sendRedirect(request.getContextPath() + "/admin/selectNoticeList.jsp");


%>