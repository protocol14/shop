<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>


<%
	// 인코딩
	request.setCharacterEncoding("utf-8");

	// 값 가져와서 변수선언
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	
	// request값 디버깅
	System.out.println("[Debug] memberId : "+memberId);
	System.out.println("[Debug] memberPw : "+memberPw);
	
	// dao, vo
	MemberDao memberDao = new MemberDao();
	Member member = new Member();
	
	// vo값 셋팅
	member.setMemberId(memberId);
	member.setMemberPw(memberPw);
	
	// 디버그
	System.out.println("[Debug] member : "+member);
	
	//호출
	Member returnMember = memberDao.login(member);
	
	// 성공 시 : memberId + memberName
	// 실패 시 : null
	if(returnMember == null){
		System.out.println("로그인 실패");
		// 돌려보냄
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?notEquals=1");
		return;
	} else {
		System.out.println("로그인 성공");
		System.out.println(returnMember.getMemberId());
		System.out.println(returnMember.getMemberName());
		// 나만의 공간에 변수를 생성
		// request, session : JSP 내장객체
		session.setAttribute("loginMember", returnMember);
		session.setMaxInactiveInterval(30*60);
		
		// 돌려보냄
		response.sendRedirect(request.getContextPath()+"/index.jsp");
	}
	
%>