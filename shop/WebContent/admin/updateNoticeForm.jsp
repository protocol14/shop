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
	int noticeNo = 0;
	if(request.getParameter("noticeNo") != null){
		noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지 수정</title>	<!-- 관리자 공지사항 수정 페이지 -->
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
		<h1>공지 수정</h1>
		<br>
		<form name="UpdateNotice" method="post" action="<%=request.getContextPath() %>/admin/updateNoticeAction.jsp?">
			<div>내용</div>
			<div><textarea rows="5" cols="50" class="noticeContent" name="noticeContent"></textarea></div>
			<div id="error" style="color:red">　</div>
			<div><input type="hidden" name ="noticeNo" value="<%=noticeNo%>"></div>
			<div><button type="button" class="btn btn-outline-secondary" onclick="updateNotice()">Submit</button></div>
		</form>
	</div>
	
	<!-- footer -->
	<jsp:include page="/partial/footer.jsp"></jsp:include>
	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	//유효성 검사
	function updateNotice() {
		if($(".noticeContent").val() == ""){
			document.getElementById("error").innerHTML = '값을 입력해주세요.';
			return;
		} else{
			UpdateNotice.submit();
		}
	};
</script>
</div>
</body>
</html>