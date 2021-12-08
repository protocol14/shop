<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>주문정보 확인</title>	<!-- 주문정보 확인 페이지 -->
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
	// 인코딩
	request.setCharacterEncoding("utf-8");
	
	// 세션 유지
	session.setMaxInactiveInterval(30*60);
	
	// 값 가져와서 변수 선언
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	
	// dao, vo
	EbookDao ebookDao = new EbookDao();
	Ebook ebook = ebookDao.selectEbookOne(ebookNo);
	
	OrderDao ordarDao = new OrderDao();	
	String date = ordarDao.selectOrderByMember(memberNo);

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
<div class="container-fluid" style="text-align: center">
	<h1>주문</h1>
	<br>
	<ul>
		<li>주문이 완료되었습니다.</li>
		<li>　</li>
		<li>상품 이름 : <%=ebook.getEbookTitle() %></li>
		<li>날짜 : <%=date %></li>
	</ul>
	<br>
	<a href="<%=request.getContextPath()%>/index.jsp" class="btn btn-outline-secondary">메인화면</a>
</div>
	
	<!-- footer -->
	<jsp:include page="/partial/footer.jsp"></jsp:include>
</div>
</body>
</html>