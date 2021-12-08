<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>문의 수정</title>	<!-- 개인 문의 수정 페이지 -->
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
	
	/// 로그인 중이 아니면 튕겨나옴
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	session.setMaxInactiveInterval(30*60);
	
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	
	String qnaCategory = request.getParameter("qnaCategory");
	
	QnaDao qnaDao = new QnaDao();
	ArrayList<Qna> qna = qnaDao.selectQnaOne(qnaNo);
	
	MemberDao memberDao = new MemberDao();
	

%>
<div class="container-fluid">
	<!-- banner include -->
	<jsp:include page="/partial/banner.jsp"></jsp:include>
		<!-- start : mainMenu include -->
		<div>
			<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
		</div>
		<!-- end : mainMenu include -->
<div class="container-fluid" style="text-align: center">
	
	<form name="UpdateQna" method="post" action="<%=request.getContextPath()%>/updateQnaAction.jsp">	
		<% for(Qna q : qna){%>
		<h1><%=q.getQnaTitle() %> 상세</h1>
		<br>
		<ul>
			<li>작성자 : <% ArrayList<Member> member = memberDao.selectMemberOne(q.getMemberNo());
				for(Member m : member){%><%=m.getMemberName() %><%	}%></li>
			<li>마지막 변경일 : <%=q.getUpdateDate() %></li>
			<li>카테고리 : 
				<select name="qnaCategory">
					<%
					if(q.getQnaCategory().equals("상품관련")){
					%>
						<option value="상품관련" selected>상품관련</option>
						<option value="회원관련">회원관련</option>
						<option value="배송관련">배송관련</option>
						<option value="기타">기타</option>
					<%
					} else if(q.getQnaCategory().equals("회원관련")){
					%>
						<option value="상품관련">상품관련</option>
						<option value="회원관련" selected>회원관련</option>
						<option value="배송관련">배송관련</option>
						<option value="기타">기타</option>
					<%	
					} else if (q.getQnaCategory().equals("배송관련")){
					%>
						<option value="상품관련">상품관련</option>
						<option value="회원관련">회원관련</option>
						<option value="배송관련" selected>배송관련</option>
						<option value="기타">기타</option>
					<%	
					} else if (q.getQnaCategory().equals("기타")){
					%>
						<option value="상품관련">상품관련</option>
						<option value="회원관련">회원관련</option>
						<option value="배송관련">배송관련</option>
						<option value="기타" selected>기타</option>
					<%	
					}
					%>
				</select>
			</li>
			<li>　</li>
			<li>내용</li>
		</ul>
		<ul style="background-color:lightyellow">
			<li ><textarea rows="5" cols="50" class="qnaContent" name="qnaContent"></textarea></li>
		</ul>
		<input type="hidden" name="qnaNo" value="<%=q.getQnaNo() %>">
		<button type="button" class="btn btn-outline-secondary" onclick="updateQna()">수정완료</button>
		<div id="error" style="color:red">　</div>
		<br>
	</form>
	<% } %>
</div>
	
	<jsp:include page="/partial/footer.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	function updateQna(){
		if($(".qnaContent").val() == ""){
			document.getElementById("error").innerHTML = '입력되지 않은 값이 있습니다.';
			return;
		} else {
			UpdateQna.submit();
		}
	};
</script>
</div>
</body>
</html>