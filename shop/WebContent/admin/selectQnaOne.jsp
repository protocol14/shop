<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>문의 상세 - 관리자</title>	<!-- 관리자 문의 상세 페이지 -->
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
	
	//인증 방어 코드 : 로그인 후, MemgerLevel이 1이상인 경우에만 페이지 열람 가능
	// session.getAttribute("loginMember") --> null
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() <1 ){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	session.setMaxInactiveInterval(30*60);
	
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	
	QnaDao qnaDao = new QnaDao();
	ArrayList<Qna> qna = qnaDao.selectQnaOne(qnaNo);
	
	QnaCommentDao qnaCommentDao = new QnaCommentDao();
	ArrayList<QnaComment> qnaComment = qnaCommentDao.selectQnaCommentOne(qnaNo);
	
	MemberDao memberDao = new MemberDao();
	

%>
<div class="container-fluid">
	<!-- 배너 -->
	<jsp:include page="/partial/banner.jsp"></jsp:include>
		<!-- start : mainMenu include -->
		<div>
			<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
		</div>
		<!-- end : mainMenu include -->
	<div class="container" style="text-align: center">
		<% for(Qna q : qna){%>
		<h1><%=q.getQnaTitle() %> 상세</h1>
		<br>
		<ul>
			<li>작성자 : <% ArrayList<Member> member = memberDao.selectMemberOne(q.getMemberNo());
				for(Member m : member){%><%=m.getMemberName() %><%	}%></li>
			<%
			if(q.getCreateDate().equals(q.getUpdateDate())){
			%>	
				<li>추가일 : <%=q.getCreateDate() %></li>
			<%
				} else {
			%>
				<li>마지막 변경일 : <%=q.getUpdateDate() %></li>
			<%
				}
			%>
			<li>카테고리 : <%=q.getQnaCategory() %></li>
			<li>　</li>
			<li>내용</li>
		</ul>
		<ul style="background-color:lightyellow">
			<li ><%=q.getQnaContent() %></li>
		</ul>
		<br>
		<a href="<%=request.getContextPath()%>/admin/insertQnaCommentForm.jsp?qnaNo=<%=q.getQnaNo() %>" class="btn btn-outline-secondary">답글달기</a>
		<br>
		<br>
		<a href="<%=request.getContextPath()%>/deleteQnaAction.jsp?qnaNo=<%=q.getQnaNo() %>" onclick="return confirm('정말로 삭제하시겠습니까?');" class="btn btn-outline-secondary">삭제</a>
		<% } %>
	</div>
	
	<%
	if(!(qnaComment).isEmpty()){
	%>
	<div class="container" style="text-align: center">
		<br>
		<h4>답변</h4>
		<%
		for(QnaComment c : qnaComment){
		%>
		<br>
		<ul style="background-color:lightblue; color:magenta">
				<li ><%=c.getQnaCommentContent() %></li>
		</ul>
		<%
		}
		%>
	
	</div>
	<%
	}
	%>
	
	<!-- footer -->
	<jsp:include page="/partial/footer.jsp"></jsp:include>
</div>
</body>
</html>