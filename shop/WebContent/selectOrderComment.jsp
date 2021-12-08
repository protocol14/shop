<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>상품평 상세</title>	<!-- 개인 상품평 상세 페이지 -->
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
	
	// 로그인 중이면 세션 유지
	Member loginMember = new Member();
	if(session.getAttribute("loginMember") != null){	
		loginMember = (Member)session.getAttribute("loginMember");
	}
	session.setMaxInactiveInterval(30*60);
	
	// 값 가져와서 변수 선언
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	
	// 로그인 정보가 페이지의 정보와 같지 않으면 되돌려보냄
	if(loginMember.getMemberNo() != memberNo){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	// 구현 코드
	OrderCommentDao orderCommentDao = new OrderCommentDao();
	ArrayList<OrderComment> orderComment = orderCommentDao.selectOrderCommentOne(ebookNo, memberNo);
	
	EbookDao ebookDao = new EbookDao();
	Ebook ebook = ebookDao.selectEbookOne(ebookNo);
	

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
	<div class="container" style="text-align: center">
		<% for(OrderComment o : orderComment){%>
		<h1><%=o.getEbookNo() %>.<%=ebook.getEbookTitle() %> 상품평 상세</h1>
		<br>
		<ul>
			<li>추가일 : <%=o.getUpdateDate() %></li>
			<li>　</li>
			<li>내용</li>
		</ul>
		<ul style="background-color:lightyellow">
			<li ><%=o.getOrderContent() %></li>
		</ul>
		<br>
		<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=o.getEbookNo() %>" class="btn btn-outline-secondary">상품 상세보기</a>
			<%
					
		} 
	  %>
	</div>
	
	<!-- footer -->
	<jsp:include page="/partial/footer.jsp"></jsp:include>
</div>
</body>
</html>