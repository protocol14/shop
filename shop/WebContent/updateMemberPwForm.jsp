<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>비밀번호 변경</title>	<!-- 비밀번호 변경 -->
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
	session.setMaxInactiveInterval(30*60);
	String memberPw = loginMember.getMemberPw();
	
	int error = 0;
	if(request.getParameter("error") != null) { 
		error = Integer.parseInt(request.getParameter("error"));
	}

%>
<div class="container-fluid">
	<!-- banner include -->
	<jsp:include page="/partial/banner.jsp"></jsp:include>
		<!-- start : mainMenu include -->
		<div>
			<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
		</div>
		<!-- end : mainMenu include -->
	
<div class="container-fluid" style="text-align: center">
	<h1>PW 수정</h1>
	<br>
	<form name="updateMember" method="post" action="<%=request.getContextPath()%>/updateMemberPwAction.jsp">
		<div>사용중인 PW :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="password" class="usingPw" name="usingPw"></div>
		<br>
		<div>새로운 PW : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="password" class="newPw" name="newPw"></div>
		<div>새 비밀번호 확인 : <input type="password" class="newPw2" name="newPw2"></div>
		<button type="button" class="btn btn-outline-secondary" onclick="updateMemberPw()">수정</button>
	</form>
	<%
	if(error==1){
	%>
		<div id="error" style="color:red">사용중인 패스워드 값이 동일하지 않습니다.</div>
	<%
	} else {
	%>
		<div id="error" style="color:red"></div>
	<%
	}
	%>
</div>
	
	<jsp:include page="/partial/footer.jsp"></jsp:include>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	function updateMemberPw(){
		let memberPw = document.getElementById("memberPw"); 
		
		if($(".usingPw").val() == "" || $(".newPw").val() == "" || $(".newPw2").val() == "") {
			document.getElementById("error").innerHTML = '입력되지 않은 값이 있습니다.';
			return;
		} else if(!($(".newPw").val() == $(".newPw2").val())){
			document.getElementById("error").innerHTML = '패스워드 값이 동일하지 않습니다.';
			return;
		} else{
			updateMember.submit();
		}
	};
</script>
</body>
</html>