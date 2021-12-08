<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "model.*" %>

<%
	// 회원가입 시 아이디 중복체크
	
	// 인코딩
	request.setCharacterEncoding("utf-8");

	// MemberIdCheck 공백인지 
	if(request.getParameter("memberIdCheck")==null || request.getParameter("memberIdCheck").equals("")){
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?memberIdCheckResult=%EC%95%84%EC%9D%B4%EB%94%94%EB%A5%BC%20%EC%9E%85%EB%A0%A5%ED%95%B4%EC%A3%BC%EC%84%B8%EC%9A%94.");
		return;
	}
	
	// 값 가져와서 변수 선언
	String memberIdCheck = request.getParameter("memberIdCheck");
	// 선언한 변수를 URL용으로 인코딩
	String memberIdCheckURL = java.net.URLEncoder.encode(memberIdCheck,"utf-8");
	
	// dao -> 호출
	MemberDao memberDao = new MemberDao();
	String result = memberDao.selectMemberIdCheck(memberIdCheck);
	
	// 값과 함께 돌려보냄
	if(result == null){
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?memberIdCheck="+memberIdCheckURL+"&idAvailable=1");
	} else {
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?memberIdCheckResult=%EC%9D%B4%EB%AF%B8%20%EC%A1%B4%EC%9E%AC%ED%95%98%EB%8A%94%20%EC%95%84%EC%9D%B4%EB%94%94%EC%9E%85%EB%8B%88%EB%8B%A4.");
	}
%>