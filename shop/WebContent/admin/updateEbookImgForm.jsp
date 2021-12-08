<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
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
	
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이미지 수정</title>	<!-- 관리자 Ebook 이미지 수정 페이지 -->
</head>
<body>
<div class="container-fluid" style="text-align:center">
	<!-- 배너 -->
	<jsp:include page="/partial/banner.jsp"></jsp:include>
		<!-- 관리자 메뉴 include -->
	<!-- 관리자 메뉴 인클루드(include)시작 ,페이지 형태만 인클루드 하는 것이 좋음(코드 형태는 비추천).-->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- 관리자 메뉴 인클루드 끝 -->
	
	<h1>이미지 수정</h1>
	<br>
	<!-- enctype="multipart/form-data" : 액션으로 기계어코드를 넘길 때 사용 (기본값 : enctype="application/x-www-form-urlencoded" : 문자열로 넘김) -->
	<form action="<%=request.getContextPath() %>/admin/updateEbookImgAction.jsp" method="post" enctype="multipart/form-data">
		<input type="text" name="ebookNo" value="<%=ebookNo %>" type="hidden">
		<input type="file" name="ebookImg">
		<button type="submit">업로드</button>
	</form>

			
	<!-- footer -->
	<jsp:include page="/partial/footer.jsp"></jsp:include>
</div>

</body>
</html>