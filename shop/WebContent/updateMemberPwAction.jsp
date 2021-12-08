<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>


<%
	// 인코딩
	request.setCharacterEncoding("utf-8");
	
	// 로그인중 아니면 튕겨나옴
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	String usingPw = request.getParameter("usingPw");
	String newPw = request.getParameter("newPw");
	String newPw2 = request.getParameter("newPw2");
	
	// request값 디버깅
	System.out.println("[Debug] usingPw : "+usingPw);
	System.out.println("[Debug] newPw : "+newPw);
	
	// 받은 값에 null이 있으면 되돌아감
	if(newPw.equals("") || newPw == null || newPw2.equals("") || newPw2 == null || usingPw.equals("") || usingPw == null){
		response.sendRedirect(request.getContextPath()+"/updateMemberPwForm.jsp");
		return;
	}
	// 비밀번호가 서로 일치하지 않으면 되돌아감
	if(newPw.equals(newPw2) == false){
		response.sendRedirect(request.getContextPath()+"/updateMemberPwForm.jsp");
		return;
	}
	
	MemberDao memberDao = new MemberDao();
	Member member = new Member();
	member.setMemberId(loginMember.getMemberId());
	member.setMemberPw(usingPw);
	
	System.out.println("[Debug] member : "+member);
	
	String result = memberDao.updateMemberPw(member, newPw);
	
	if(result == null){
		response.sendRedirect(request.getContextPath()+"/updateMemberPwForm.jsp?error=1");
		return;
	}
	
	session.invalidate();
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	
%>