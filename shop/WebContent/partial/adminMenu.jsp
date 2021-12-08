<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<html lang="ko">
<head>	<!-- 관리자용 네비게이션 메뉴 -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</head>
<nav class="container-fluid navbar navbar-expand-sm bg-dark navbar-dark">
  <a class="navbar-brand" href="<%=request.getContextPath()%>/admin/adminIndex.jsp">index</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="collapsibleNavbar">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/admin/selectMemberList.jsp" style="text-align: center">회원관리</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/admin/selectCategoryList.jsp" style="text-align: center">전자책 카테고리 관리</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp" style="text-align: center">전자책 관리</a>
      </li>  
      <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/admin/selectOrderList.jsp" style="text-align: center">주문 관리</a>
      </li>   
      <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/admin/selectOrderCommentList.jsp" style="text-align: center">상품평 관리</a>
      </li> 
      <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/admin/selectNoticeList.jsp" style="text-align: center">공지게시판 관리</a>
      </li> 
      <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/admin/selectQnaList.jsp" style="text-align: center">QnA게시판 관리</a>
      </li> 
    </ul>
  </div>
  <div class="collapse navbar-collapse" id="collapsibleNavbar">
  	<%
    if(session.getAttribute("loginMember") == null) {
	%>
		<!-- 로그인 전 -->
		<a href="<%=request.getContextPath()%>/loginForm.jsp" class="btn btn-outline-secondary" style="flex-grow: 1;">로그인 </a>
		<a href="<%=request.getContextPath()%>/insertMemberForm.jsp" class="btn btn-outline-secondary" style="flex-grow: 1;">회원가입</a>
	<%
		} else {
			Member loginMember = (Member)session.getAttribute("loginMember");
			session.setMaxInactiveInterval(30*60);
	%>
		<!-- 로그인 후 -->
		<ul class="navbar-nav"><li style="color:darkgray"><%=loginMember.getMemberName() %></li><li style="color:gray">님 반갑습니다.</li></ul> <a href="<%=request.getContextPath()%>/logout.jsp" class="btn btn-outline-secondary" style="flex-grow: 1;">로그아웃 </a>
		<a href="<%=request.getContextPath()%>/selectMemberForm.jsp" class="btn btn-outline-secondary" style="flex-grow: 1;">회원정보</a>
	<%
		}
    %>
  </div>
</nav>