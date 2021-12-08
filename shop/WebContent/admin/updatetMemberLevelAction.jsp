<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");
	
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	int memberLevel = Integer.parseInt(request.getParameter("memberLevel"));
	
	System.out.println("[Debug] memberNo : "+memberNo);
	System.out.println("[Debug] memberLevel : "+memberLevel);
	
	MemberDao memberDao = new MemberDao();
	Member member = new Member();
	member.setMemberNo(memberNo);
	member.setMemberLevel(memberLevel);
	
	System.out.println("[Debug] member : "+member);
	
	memberDao.updateMemberLevelByAdmin(member);
	
	response.sendRedirect(request.getContextPath()+"/admin/selectMemberList.jsp");
%>