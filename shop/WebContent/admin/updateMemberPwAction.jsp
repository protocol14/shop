<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");
	
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String memberPw = request.getParameter("memberPw");
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	System.out.println("[Debug] memberNo : "+memberNo);
	System.out.println("[Debug] memberPw : "+memberPw);
	
	MemberDao memberDao = new MemberDao();
	Member member = new Member();
	member.setMemberNo(memberNo);
	member.setMemberPw(memberPw);
	
	System.out.println("[Debug] member : "+member);
	
	memberDao.updateMemberPwByAdmin(member);
	
	response.sendRedirect(request.getContextPath()+"/admin/selectMemberList.jsp");
%>