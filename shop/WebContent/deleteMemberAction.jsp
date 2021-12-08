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
	
	String memberPw = request.getParameter("memberPw");
	
	// request값 디버깅
	System.out.println("[Debug] usingPw : "+memberPw);
	
	// 받은 값에 null이 있으면 되돌아감
	if(memberPw.equals("") || memberPw == null){
		response.sendRedirect(request.getContextPath()+"/updateMemberPwForm.jsp");
		return;
	}
	
	// dao,vo
	MemberDao memberDao = new MemberDao();
	Member member = new Member();

	// member Id,Pw값 셋팅
	member.setMemberId(loginMember.getMemberId());
	member.setMemberPw(memberPw);
	
	// 디버그
	System.out.println("[Debug] member : "+member);
	
	// memberDao.deleteMember에서 받아온 값 result에 셋팅
	String result = memberDao.deleteMember(member);
	
	// result값이 null이면 돌려보내고 리턴
	if(result == null){
		response.sendRedirect(request.getContextPath()+"/deleteMemberForm.jsp?error=1");
		return;
	}
	
	// null이 아니면 삭제 후 되돌아감
	session.invalidate();
	response.sendRedirect(request.getContextPath()+"/index.jsp");
	
%>