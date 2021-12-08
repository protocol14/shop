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
	
	// 카테고리 목록 받아오기
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Ebook 추가</title> <!-- 관리자 Ebook 추가 페이지 -->
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
	<h1>전자책 추가</h1>
	<br>
	
	<form name="InsertEbook" method="post" action="<%=request.getContextPath()%>/admin/insertEbookAction.jsp">
		<div>책 제목</div>
		<div><input type="text" class="ebookTitle" name="ebookTitle"></div>
		<div>카테고리</div>
		<div>
			<select name="categoryName">
		<%
			for(Category c : categoryList){
		%>
				<option value="<%=c.getCategoryName() %>"><%=c.getCategoryName() %></option>
		<%	
			}
		%>
			</select>
		</div>
		<br>
		<div>ISBN</div>
		<div><input type="text" class="ebookISBN" name="ebookISBN"></div>
		<div>저자</div>
		<div><input type="text" class="ebookAuthor" name="ebookAuthor"></div>
		<div>출판사</div>
		<div><input type="text" class="ebookCompany" name="ebookCompany"></div>
		<div>페이지 수</div>
		<div><input type="number" class="ebookPageCount" name="ebookPageCount"></div>
		<div>가격</div>
		<div><input type="number" class="ebookPrice" name="ebookPrice"></div>
		<div>소개</div>
		<div><textarea rows="5" cols="50" class="ebookSummary" name="ebookSummary"></textarea></div>
		<div id="error" style="color:red">　</div>
		<div><button type="button" class="btn btn-outline-secondary" onclick="insertEbook()">추가</button></div>
	</form>
</div>
<jsp:include page="/partial/footer.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	// 유효성 검사
	function insertEbook(){
		if($(".ebookTitle").val() == "" || $(".ebookISBN").val() == "" || $(".ebookAuthor").val() == "" ||
		   $(".ebookCompany").val() == "" ||  $(".ebookPageCount").val() == "" ||
		   $(".ebookPrice").val() == "" ||  $(".ebookSummary").val() == "") {
			document.getElementById("error").innerHTML = '입력되지 않은 값이 있습니다.';
			return;
		} else{
			InsertEbook.submit();
		}
	};
</script>
</body>
</html>