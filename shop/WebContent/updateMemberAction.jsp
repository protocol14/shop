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
	
	String memberName = request.getParameter("memberName");
	int memberAge = Integer.parseInt(request.getParameter("memberAge"));
	String memberGender = request.getParameter("memberGender");
	
	// request값 디버깅
	System.out.println("[Debug] memberName : "+memberName);
	System.out.println("[Debug] memberAge : "+memberAge);
	System.out.println("[Debug] memberGender : "+memberGender);
	
	// 받은 값에 null이 있으면 되돌아감
	if(memberName.equals("") || memberName == null || memberAge == 0 || memberGender.equals("") || memberGender == null){
		response.sendRedirect(request.getContextPath()+"/updateMemberForm.jsp");
		return;
	}
	
	// dao,vo
	MemberDao memberDao = new MemberDao();
	Member member = new Member();
	
	// vo 값셋팅
	member.setMemberId(loginMember.getMemberId());
	member.setMemberName(memberName);
	member.setMemberAge(memberAge);
	member.setMemberGender(memberGender);
	
	// 디버그
	System.out.println("[Debug] member : "+member);
	
	// 호출
	memberDao.updateMember(member);
	
	// 돌려보냄
	response.sendRedirect(request.getContextPath()+"/selectMemberForm.jsp");
	
%>