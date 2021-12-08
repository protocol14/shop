<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>회원 정보</title> 	<!-- 회원 정보 페이지 -->
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
	<h1>회원 정보</h1>
	<br>
	<ul>
	<% for(Member l : list){%>
		<li>회원님은 <%=l.getMemberNo() %>번째 회원이십니다.</li>
		<li>　</li>
		<li>ID : <%=l.getMemberId() %></li>
		<li>Name : <%=l.getMemberName() %></li>
		<li>Age : <%=l.getMemberAge() %></li>
		<li>Gender : <%=l.getMemberGender() %></li>
		<li>가입일 : <%=l.getCreateDate() %></li>
	<%
		String memberGender = java.net.URLEncoder.encode(l.getMemberGender(),"utf-8");
	%>
	</ul>
	<a href="<%=request.getContextPath()%>/selectQnaListByOne.jsp?memberNo=<%=l.getMemberNo() %>" class="btn btn-outline-secondary">문의 보기</a>
	<br>
	<a href="<%=request.getContextPath()%>/updateMemberForm.jsp?memberName=<%=l.getMemberName() %>&memberAge=<%=l.getMemberAge() %>&memberGender=<%=memberGender %>" class="btn btn-outline-secondary">정보 수정</a>
	<br>
	<% } %>
	<a href="<%=request.getContextPath()%>/updateMemberPwForm.jsp" class="btn btn-outline-secondary">&nbsp;PW&nbsp;수정&nbsp;</a>
	<br>
	<a href="<%=request.getContextPath()%>/deleteMemberForm.jsp" onclick="return confirm('정말로 탈퇴하시겠습니까?');" class="btn btn-outline-secondary">회원 탈퇴</a>
	<br>
</div>
	
	<jsp:include page="/partial/footer.jsp"></jsp:include>
</div>
</body>
</html>