<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.util.ArrayList" %>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");

	//인증 방어 코드 : 로그인 후, MemgerLevel이 1이상인 경우에만 페이지 열람 가능
	// session.getAttribute("loginMember") --> null
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() <1 ){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	session.setMaxInactiveInterval(30*60);
	
	int memberNo = 0;
	if(request.getParameter("memberNo") != null){
		memberNo = Integer.parseInt(request.getParameter("memberNo"));
	}
	String memberName = "";
	if(request.getParameter("memberNo") != null){
		memberName = request.getParameter("memberName");
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원등급 수정</title>	<!-- 관리자 회원등급 수정 페이지 -->
</head>
<body>
<div class="container-fluid">
	<!-- 배너 -->
	<jsp:include page="/partial/banner.jsp"></jsp:include>
		<!-- 관리자 메뉴 include -->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
		<!-- end : mainMenu include -->
	<div style="text-align: center">
		<h1><%=memberNo%> <%=memberName%> - 회원등급수정</h1>
		<br>
		<form name="updateMemberLevel" method="post" action="<%=request.getContextPath() %>/admin/updatetMemberLevelAction.jsp?memberNo=<%=memberNo%>">
			<div>
				memberLevel &nbsp;
				<select name="memberLevel">
					<option value=0>0</option>
					<option value=1>1</option>
				</select>
			</div>
			<br>
			<div><button type="submit" class="btn btn-outline-secondary" onclick="updateMemberLevel()">Submit</button></div>
		</form>
	</div>
	
	<!-- footer -->
	<jsp:include page="/partial/footer.jsp"></jsp:include>
</div>
</body>
</html>