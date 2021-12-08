<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>


<%
	// 인코딩
	request.setCharacterEncoding("utf-8");
	
	// 값 받아옴
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String memberPw2 = request.getParameter("memberPw2");
	String memberName = request.getParameter("memberName");
	String getMemberAge = request.getParameter("memberAge");
	String memberGender = request.getParameter("memberGender");
	
	// request값 디버깅
	System.out.println("[Debug] memberId : "+memberId);
	System.out.println("[Debug] memberPw : "+memberPw);
	System.out.println("[Debug] memberName : "+memberName);
	System.out.println("[Debug] memberAge : "+getMemberAge);
	System.out.println("[Debug] memberGender : "+memberGender);
	
	// 받은 값에 null이 있으면 되돌아감
	if(memberId.equals("")){
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?nullParam=1");
		return;
	} else if(memberPw.equals("")){
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?nullParam=1");
		return;
	} else if(memberName.equals("")){
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?nullParam=1");
		return;
	} else if(getMemberAge.equals("")){
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?nullParam=1");
		return;
	} else if(memberGender == null){
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?nullParam=1");
		return;
	// 비밀번호가 서로 일치하지 않으면 되돌아감
	} else if(memberPw.equals(memberPw2) == false){
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?notequalsPw=1");
		return;
	}
	
	// 방어코드 검사 후 String -> int 변환
	int memberAge = Integer.parseInt(request.getParameter("memberAge"));
	
	// dao,vo
	MemberDao memberDao = new MemberDao();
	Member member = new Member();
	
	// vo값 셋팅
	member.setMemberId(memberId);
	member.setMemberPw(memberPw);
	member.setMemberName(memberName);
	member.setMemberAge(memberAge);
	member.setMemberGender(memberGender);
	
	// 디버그
	System.out.println("[Debug] member : "+member);
	
	// memberDao.insertMember 호출
	memberDao.insertMember(member);
	
	// 돌려보냄
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	
%>