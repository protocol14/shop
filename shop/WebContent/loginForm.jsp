<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>로그인</title>	<!-- 로그인 페이지 -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</head>
<body>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");

	// 현재 페이지
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) { 
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 로그인이 틀렸을 경우
 	int notEquals = 0;
 	if(request.getParameter("notEquals") != null){
 		notEquals = Integer.parseInt(request.getParameter("notEquals"));
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
	<!--  본문 -->
	<div style="text-align: center">
		<h1>로그인</h1>
		<form name="loginForm" method="post" action="<%=request.getContextPath()%>/loginAction.jsp">
			<div>아이디</div>
			<div><input type="text" class="memberId" name="memberId"></div>
			<div>비밀번호</div>
			<div><input type="password" class="memberPw" name="memberPw"></div>
			<br>
			<div><button type="button" class="btn btn-outline-secondary" onclick="loginBtn()">&nbsp;&nbsp;로그인&nbsp;&nbsp;</button></div>
		</form>
		<%
			if(notEquals == 1){
		%>
				<div style="color:red">잘못된 정보입니다.</div>
		<%
			} else {
		%> 
			<div id="error" style="color:red">　</div>
		<%
			}
		%>
		<div><a href="<%=request.getContextPath()%>/insertMemberForm.jsp" class="btn btn-outline-secondary">회원가입</a></div>
		<br>
	</div>
	
	<!-- footer -->
	<jsp:include page="/partial/footer.jsp"></jsp:include>
	
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script>
		// 유효성검사
		function loginBtn(){
			if($(".memberId").val() == "") {
				document.getElementById("error").innerHTML = 'ID를 입력해주세요.';
				return;
			} else if($(".memberPw").val() == ""){
				document.getElementById("error").innerHTML = 'PW를 입력해주세요.';
				return;
			} else {
				loginForm.submit();
			}
		}
	</script>
</div>
</body>
</html>