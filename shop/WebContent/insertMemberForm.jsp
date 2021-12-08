<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<%
	// 인증 방어 코드 : 로그인 전에만 페이지 열람 가능
	// session.getAttribute("loginMember") --> null
	
	if(session.getAttribute("loginMember") != null){
		System.out.println("이미 로그인 되어있음.");
		response.sendRedirect("index.jsp");
	}

%>
<html lang="ko">
<head>
  <title>회원가입</title>	<!-- 회원가입 페이지 -->
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
	
	// 현재 페이지
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) { 
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 아이디 중복검사 요소
	String memberIdCheckResult = "";
	String memberIdCheck = "";
	int idAvailable = 0;
	
	// 체크
	if(request.getParameter("memberIdCheckResult") != null) { 
		memberIdCheckResult = request.getParameter("memberIdCheckResult");
	}
	if(request.getParameter("memberIdCheck") != null) { 
		memberIdCheck = request.getParameter("memberIdCheck");
	}
	if(request.getParameter("idAvailable") != null) { 
		idAvailable = Integer.parseInt(request.getParameter("idAvailable"));
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
	<div style="text-align: center">
		<h1>회원가입</h1>
		<br>
		<form name=IdCheck method="post" action="<%=request.getContextPath()%>/selectMemberIdCheck.jsp">
			<div>아이디 중복체크</div>
			<div><input class="memberIdCheck" type="text" name="memberIdCheck"></div>
			<%
			// 아이디 중복검사 -> 사용불가. Result값은 액션에서 받아옴
			if(idAvailable==0){
			%>
				<div><button type="submit" class="btn btn-outline-secondary">검사</button></div>
				<div style="color:red"><%=memberIdCheckResult %></div>
			<%
			// 아이디 중복검사 -> 사용가능
			} else if(idAvailable==1){
			%>
				<div style="color:blue">사용할 수 있는 아이디입니다.</div>
			<%
			}
			%>
			
		</form>
		<form name="InsertMember" method="post" action="<%=request.getContextPath()%>/insertMemberAction.jsp">
			<div>아이디</div>
			<div><input class="memberId" type="text" name="memberId" value="<%=memberIdCheck %>" readonly></div>
			<div>비밀번호</div>
			<div><input class="memberPw" type="password" name="memberPw"></div>
			<div>비밀번호 확인</div>
			<div><input class="memberPw2" type="password" name="memberPw2"></div>
			<div>사용할 이름</div>
			<div><input class="memberName" type="text" name="memberName"></div>
			<div>나이</div>
			<div><input class="memberAge" type="number" name="memberAge"></div>
			<div>성별</div>
			<div><input class="memberGender" type="radio" name="memberGender" value="남">남&nbsp;
			<input class="memberGender" type="radio" name="memberGender" value="여">여</div>
			<div id="error" style="color:red">　</div>
			<div><button type="button" class="btn btn-outline-secondary" onclick="insertMember()">회원가입</button></div>
		</form>
		<br>
	</div>
	
	<!-- footer -->
	<jsp:include page="/partial/footer.jsp"></jsp:include>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	// 유효성 검사
	function insertMember(){
		let gender = $(".memberGender:checked");
		if($(".memberId").val() == "" || $(".memberPw").val() == "" || $(".memberPw2").val() == "" ||
		   $(".memberName").val() == "" ||  $(".memberAge").val() == "") {
			document.getElementById("error").innerHTML = '입력되지 않은 값이 있습니다.';
			return;
		} else if(gender.length < 1){
			document.getElementById("error").innerHTML = '입력되지 않은 값이 있습니다.';
			return;
		} else if(!($(".memberPw").val() == $(".memberPw2").val())){
			document.getElementById("error").innerHTML = '패스워드 값이 동일하지 않습니다.';
			return;
		} else{
			InsertMember.submit();
		}
	};
</script>
</body>
</html>