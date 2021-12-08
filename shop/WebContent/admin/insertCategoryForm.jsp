<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
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
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>카테고리 추가</title>	<!-- 관리자 카테고리 추가 페이지 -->
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
	<h1>카테고리 추가</h1>
	
	<%
		String categoryCheckResult = "";
		if(request.getParameter("categoryCheckResult") != null){
			categoryCheckResult = request.getParameter("categoryCheckResult");
		}
		String categoryNameCheck = "";
		if(request.getParameter("categoryNameCheck") != null){
			categoryNameCheck = request.getParameter("categoryNameCheck");
		}
	%>
	<form action="<%=request.getContextPath() %>/admin/selectCategoryNameCheckAction.jsp" method="post">
			<div>중복 검사</div>
			<div>
				<input type="text" name="categoryNameCheck"> 
				<button type="submit" class="btn btn-outline-secondary">중복 검사</button> 
			</div>
		</form>
	<form name="InsertCategory" method="post" action="<%=request.getContextPath() %>/admin/insertCategoryAction.jsp">
		<div>추가할 카테고리</div>
		<div>
			<input type="text" class="categoryName" name="categoryName"  value="<%=categoryNameCheck%>" readonly>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<button type="button" class="btn btn-outline-secondary" onclick="insertCategory()">추가</button>
			<div id="error" style="color:red">　</div>
		</div>
	</form>
	<%
		if(!categoryCheckResult.equals("")){
	%>
			<%=request.getParameter("categoryCheckResult") %>
	<%
		}
	%>
</div>
<jsp:include page="/partial/footer.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	// 유효성 검사
	function insertCategory() {
		if($(".categoryName").val() == ""){
			document.getElementById("error").innerHTML = '먼저 중복검사를 진행해주세요.';
			return;
		} else{
			InsertCategory.submit();
		}
	};
</script>
</body>
</html>