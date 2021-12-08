<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.util.ArrayList" %>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");

	// 방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	} 
	// 세션유지
	session.setMaxInactiveInterval(30*60);
	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>공지사항 추가</title>	<!-- 관리자 공지사항 추가 페이지 -->
</head>
<body>
<div class="container-fluid">
	<!-- banner include -->
	<jsp:include page="/partial/banner.jsp"></jsp:include>
		<!-- 관리자 메뉴 include -->
	<!-- 관리자 메뉴 인클루드(include)시작 ,페이지 형태만 인클루드 하는 것이 좋음(코드 형태는 비추천).-->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
</div>
<div class="container" style="text-align:center;">
	<h1>공지 추가</h1>
	<br>
	
	<form name="InsertNotice" method="post" action="<%=request.getContextPath()%>/admin/insertNoticeAction.jsp">
		<div><input type="hidden" name="memberNo" value=<%=loginMember.getMemberNo() %>></div>
		<div>제목</div>
		<div><input type="text" class="noticeTitle" name="noticeTitle"></div>
		<br>
		<div>내용</div>
		<div><textarea rows="5" cols="50" class="noticeContent" name="noticeContent"></textarea></div>
		<div id="error" style="color:red">　</div>
		<div><button type="button" class="btn btn-outline-secondary" onclick="insertNotice()">추가</button></div>
	</form>
</div>
<!-- footer -->
<jsp:include page="/partial/footer.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	// 유효성 검사
	function insertNotice() {
		if($(".noticeTitle").val() == "" || $(".noticeContent").val() == ""){
			document.getElementById("error").innerHTML = '입력되지 않은 값이 있습니다.';
			return;
		} else{
			InsertNotice.submit();
		}
	};
</script>
</body>
</html>