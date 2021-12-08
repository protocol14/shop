<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>공지사항 상세 - 관리자</title>	<!-- 관리자 공지 상세 페이지 -->
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
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> notice = noticeDao.selectNoticeOne(noticeNo);
	
	MemberDao memberDao = new MemberDao();
	

%>
<div class="container-fluid">
	<!-- 브루스 배너 -->
	<jsp:include page="/partial/banner.jsp"></jsp:include>
		<!-- start : mainMenu include -->
		<div>
			<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
		</div>
		<!-- end : mainMenu include -->
<div class="container-fluid" style="text-align: center">
	
	<form method="post" action="<%=request.getContextPath()%>/admin/updateNoticeForm.jsp">	
		<% for(Notice n : notice){%>
		<h1><%=n.getNoticeTitle() %> 상세</h1>
		<br>
		<ul>
			<li>작성자 : <% ArrayList<Member> member = memberDao.selectMemberOne(n.getMemberNo());
				for(Member m : member){%><%=m.getMemberName() %><%	}%></li>
			<li>마지막 변경일 : <%=n.getUpdateDate() %></li>
			<li>　</li>
			<li>내용</li>
		</ul>
		<ul style="background-color:lightyellow">
			<li ><%=n.getNoticeContent() %></li>
		</ul>
		<input type="hidden" name="noticeNo" value="<%=n.getNoticeNo() %>">
		<button type="submit" class="btn btn-outline-secondary">수정</button>
		<br>
	</form>
	<a href="<%=request.getContextPath()%>/admin/deleteNoticeAction.jsp?noticeNo=<%=n.getNoticeNo() %>" onclick="return confirm('정말로 삭제하시겠습니까?');" class="btn btn-outline-secondary">삭제</a>
	<% } %>
</div>
	
	<jsp:include page="/partial/footer.jsp"></jsp:include>
</div>
</body>
</html>