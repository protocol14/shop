<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>회원정보 수정</title>	<!-- 회원정보 수정 페이지 -->
  <style>

	ul {
	    list-style: none;
	    margin:0px; padding:0px;
	 }

  </style>
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
	
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> list = memberDao.selectMemberOne(loginMember.getMemberNo());
	
	String memberName = "";
	int memberAge = 0;
	String memberGender = "";
	
	if(request.getParameter("memberName") != null) { 
		memberName = request.getParameter("memberName");
	}
	if(request.getParameter("memberAge") != null) { 
		memberAge = Integer.parseInt(request.getParameter("memberAge"));
	}
	if(request.getParameter("memberGender") != null) { 
		memberGender = request.getParameter("memberGender");
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
	
	<form method="post" action="updateMemberAction.jsp">
		<div class="container-fluid" style="text-align: center">
			<h1>회원 정보 수정</h1>
			<br>
			<ul>
			<% for(Member l : list){%>
				<li>회원님은 <%=l.getMemberNo() %>번째 회원입니다.</li>
				<li>　</li>
				<li>ID : <%=l.getMemberId() %></li>
				<li>Name : &nbsp;<input class="memberName" type="text" name="memberName" value=<%=memberName %>></li>
				<li>&nbsp;&nbsp;Age :&nbsp;&nbsp;&nbsp;<input class="memberAge" type="number" name="memberAge" value=<%=memberAge %>></li>
				<li>Gender : 
					<select name="memberGender">
					<%
						if(memberGender.equals("남")){
					%>	
						<option value="남" selected>남</option>
						<option value="여">여</option>
					<%	
						} else if(memberGender.equals("여")){
					%>		
						<option value="남">남</option>
						<option value="여" selected>여</option>
					<%
						}
					%>
					</select>
				</li>
				<li>가입일 : <%=l.getCreateDate() %></li>
			</ul>
			<%} %>
			<button type="submit" class="btn btn-outline-secondary">수정</button>
		</div>
	</form>
	
	<!-- footer -->
	<jsp:include page="/partial/footer.jsp"></jsp:include>
</div>
</body>
</html>