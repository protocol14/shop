<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>공지 상세</title>	<!-- 공지 상세 페이지 -->
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
	
	// 세션 유지
	session.setMaxInactiveInterval(30*60);
	
	// 값 받아와서 변수 선언
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	// dao -> 호출 -> Array배열
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> notice = noticeDao.selectNoticeOne(noticeNo);
	
	// dao
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
		
<!-- 본문 -->
<div class="container-fluid" style="text-align: center">
		<!-- for each문 -->
		<% for(Notice n : notice){%>
		<h1><%=n.getNoticeTitle() %> 상세</h1>
		<br>
		<ul>
			<li>작성자 : <% ArrayList<Member> member = memberDao.selectMemberOne(n.getMemberNo());
				for(Member m : member){%><%=m.getMemberName() %><%	}%></li>
			<%
			if(n.getCreateDate().equals(n.getUpdateDate())){
			%>	
				<li>추가일 : <%=n.getCreateDate() %></li>
			<%
				} else {
			%>
				<li>마지막 변경일 : <%=n.getUpdateDate() %></li>
			<%
				}
			%>
			<li>　</li>
			<li>내용</li>
		</ul>
		<ul style="background-color:lightyellow">
			<li ><%=n.getNoticeContent() %></li>
		</ul>
	<% } %>
</div>
	
	<!-- footer -->
	<jsp:include page="/partial/footer.jsp"></jsp:include>
</div>
</body>
</html>