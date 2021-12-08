<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");
	
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String memberName = request.getParameter("memberName");
	
	// memberName.equals(memberNameCheck)
	if(memberName.equals(request.getParameter("memberNameCheck"))){
		// 디버그
		System.out.println("[Debug] memberNo : "+memberNo);
		
		MemberDao memberDao = new MemberDao();
		memberDao.deleteMemberByAdmin(memberNo);
		
		response.sendRedirect(request.getContextPath()+"/admin/selectMemberList.jsp");
	} else {
		response.sendRedirect(request.getContextPath()+"/admin/deleteMemberForm.jsp?notEq=1&memberNo="+memberNo+"&memberName="+memberName);
	}
%>