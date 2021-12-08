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
	session.setMaxInactiveInterval(30*60);
	
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>문의답글 달기</title>	<!-- 관리자 문의답글 페이지 -->
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
	<h1>답글 달기</h1>
	<br>
	
	<form name="InsertQnaComment" method="post" action="<%=request.getContextPath()%>/admin/insertQnaCommentAction.jsp">
		<div><input type="hidden" name="memberNo" value=<%=loginMember.getMemberNo() %>></div>
		<div><input type="hidden" name="qnaNo" value=<%=qnaNo%>></div>
		<div>답글내용</div>
		<div><textarea rows="5" cols="50" class="qnaCommentContent" name="qnaCommentContent"></textarea></div>
		<div id="error" style="color:red">　</div>
		<div><button type="button" class="btn btn-outline-secondary" onclick="insertQnaComment()">추가</button></div>
	</form>
</div>
<jsp:include page="/partial/footer.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	function insertQnaComment() {
		if($(".QnaCommentContent").val() == ""){
			document.getElementById("error").innerHTML = '내용을 입력해주세요.';
			return;
		} else{
			InsertQnaComment.submit();
		}
	};
</script>
</body>
</html>