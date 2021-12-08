<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>회원탈퇴</title> <!-- 회원탈퇴 페이지 -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");
	
	// 로그인 중이 아니면 튕겨나옴
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	// 세션유지
	session.setMaxInactiveInterval(30*60);
	
	// 에러판별값
	int error = 0;
	if(request.getParameter("error") != null) { 
		error = Integer.parseInt(request.getParameter("error"));
	}

%>
<div class="container-fluid">
	<!-- 배너 -->
	<jsp:include page="/partial/banner.jsp"></jsp:include>
		<!-- start : mainMenu include -->
		<div>
			<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
		</div>
		<!-- end : mainMenu include -->
	<!-- 본문 -->
<div class="container-fluid" style="text-align: center">
	<h1>회원 탈퇴</h1>
	<br>
	<form name="updateMember" method="post" action="<%=request.getContextPath()%>/deleteMemberAction.jsp">
		<div>PW를 입력해주세요.</div>
		<br>
		<div><input type="password" class="memberPw" name="memberPw"></div>
		<button type="submit" class="btn btn-outline-secondary">회원탈퇴</button>
	</form>
	<%
	if(error==1){
	%>
		<div id="error" style="color:red">패스워드 값이 동일하지 않습니다.</div>
	<%
	} else {
	%>
		<div id="error" style="color:red"></div>
	<%
	}
	%>
</div>
	<!-- footer -->
	<jsp:include page="/partial/footer.jsp"></jsp:include>
</div>
</body>
</html>