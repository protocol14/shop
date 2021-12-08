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
	
	// 값 가져와서 변수선언
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));

%>
<html lang="ko">
<head>
  <title>문의사항 작성</title>	<!-- 문의사항 작성 페이지 -->
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
		<h1>문의사항</h1>
			
		<form name="InsertQna" method="post" action="<%=request.getContextPath()%>/insertQnaAction.jsp">
			<div><input type="hidden" name="memberNo" value=<%=loginMember.getMemberNo() %>></div>
			<div><input type="number" name="ebookNo" value=<%=ebookNo%> readonly></div>
			<div>카테고리</div>
			<div>
				<select name="qnaCategory">
					<option value="상품관련">상품관련</option>
					<option value="회원관련">회원관련</option>
					<option value="배송관련">배송관련</option>
					<option value="기타">기타</option>
				</select>
			</div>
			<div>제목</div>
			<div><input type="text" class="qnaTitle" name="qnaTitle"></div>
			<br>
			<div>내용</div>
			<div><textarea rows="5" cols="50" class="qnaContent" name="qnaContent" ></textarea></div>
			<div>비밀글로 작성 
				<select name="qnaSecret">
					<option value="Y">Y</option>
					<option value="N" selected>N</option>
				</select>
			</div>
			<div id="error" style="color:red">　</div>
			<button type="button" class="btn btn-outline-secondary" onclick="insertQna()">작성</button>
		</form>
		<br>
	</div>
	<!-- footer -->
	<jsp:include page="/partial/footer.jsp"></jsp:include>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	function insertQna(){
		if($(".qnaContent").val() == "" || $(".qnaTitle").val() == "" ) {
			document.getElementById("error").innerHTML = '제목과 내용을 입력해주세요.';
			return;
		} else{
			InsertQna.submit();
		}
	};
</script>
</div>
</body>
</html>