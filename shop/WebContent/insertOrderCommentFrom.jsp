<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");
	
	//로그인 상태라면 세션유지. 아니면 튕겨나감
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember != null){
		session.setMaxInactiveInterval(30*60);
	} else{
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}

%>
<html lang="ko">
<head>
  <title>상품평 작성</title>	<!-- 상품평 작성 페이지 -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</head>
<body>
<div class="container-fluid">
	<!-- 배너 -->
	<jsp:include page="/partial/banner.jsp"></jsp:include>
		<!-- start : mainMenu include -->
		<div>
			<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
		</div>
		<!-- end : mainMenu include -->
	<!-- 본문 -->
	<div style="text-align: center">
		<h1>상품평 작성</h1>
			
		<form name="InsertOrderComment" method="post" action="<%=request.getContextPath()%>/insertOrderCommentAction.jsp?orderNo=<%=request.getParameter("orderNo")%>&ebookNo=<%=request.getParameter("ebookNo")%>">
			<div><input type="hidden" name="memberNo" value=<%=loginMember.getMemberNo() %>></div>
			<div>별점</div>
			<div>
				<select name="orderScore">
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5" selected>5</option>
				</select>
			</div>
			<div>후기</div>
			<div><textarea rows="5" cols="50" class="orderContent" name="orderContent">감사합니다.</textarea></div>
			<div id="error" style="color:red">　</div>
			<button type="submit" class="btn btn-outline-secondary" onclick="insertMember()">작성</button>
		</form>
		<br>
	</div>
	
	<jsp:include page="/partial/footer.jsp"></jsp:include>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	// 유효성검사
	function insertMember(){
		if($(".orderContent").val() == "" ) {
			document.getElementById("error").innerHTML = '후기 내용을 입력해주세요.';
			return;
		} else{
			InsertOrderComment.submit();
		}
	};
</script>
</div>
</body>
</html>