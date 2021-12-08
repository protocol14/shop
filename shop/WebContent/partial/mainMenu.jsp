<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<%
	// 회원, 비회원용 네비게이션 메뉴

	// 카테고리 배열로 받아옴
	CategoryDao categorydao = new CategoryDao();
	ArrayList<Category> categoryList = new ArrayList<>();
	
	categoryList = categorydao.selectCategoryList();
%>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</head>
<nav class="container-fluid navbar navbar-expand-sm bg-dark navbar-dark">
  <a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp?category=">전체 카테고리</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="collapsibleNavbar">
    <ul class="navbar-nav">
      <% 
      for(Category c : categoryList){
    	 if(c.getCategoryState().equals("Y")){
      %>
	      	<li class="nav-item">
	        	<a class="nav-link" href="<%=request.getContextPath()%>/index.jsp?category=<%=c.getCategoryName()%>"><%=c.getCategoryName() %></a>
	      	</li>
      <%
    	 }  
      }
      %>
    </ul>
  </div>
  <div class="collapse navbar-collapse" id="collapsibleNavbar">
  	<%
  	Member loginMember = (Member)session.getAttribute("loginMember");
    if(session.getAttribute("loginMember") == null) {
	%>
		<!-- 로그인 전 -->
		<a href="<%=request.getContextPath()%>/loginForm.jsp" class="btn btn-outline-secondary" style="flex-grow: 1;">로그인</a>
		<a href="<%=request.getContextPath()%>/insertMemberForm.jsp" class="btn btn-outline-secondary" style="flex-grow: 1;">회원가입</a>
	<%
		} else {
			session.setMaxInactiveInterval(30*60);
	%>
			<!-- 로그인 후 -->
			<ul class="navbar-nav"><li style="color:darkgray"><%=loginMember.getMemberName() %></li><li style="color:gray">님 반갑습니다.</li></ul> 
			<a href="<%=request.getContextPath()%>/logout.jsp" class="btn btn-outline-secondary" style="flex-grow: 1;">로그아웃</a>
			<a href="<%=request.getContextPath()%>/selectOrderByMember.jsp" class="btn btn-outline-secondary" style="flex-grow: 1;">나의주문</a>
	<%	
			if(loginMember.getMemberLevel() > 0){
	%>
				<a href="<%=request.getContextPath()%>/admin/adminIndex.jsp" class="btn btn-outline-secondary" style="flex-grow: 1;">관리자페이지</a>
	<%
			} else {
	%>
				<a href="<%=request.getContextPath()%>/selectMemberForm.jsp" class="btn btn-outline-secondary" style="flex-grow: 1;">회원정보</a>
	<%
			}
		}
	%>
  </div>
</nav>