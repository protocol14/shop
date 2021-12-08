<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%	
	//한글인코딩
	request.setCharacterEncoding("utf-8");
	//사용자(일반 회원)들 리스트는 관리자만 출입
	//방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	//로그인 멤버값이 없거나 memberLevel이 1미만(일반 사용자)일때는 접근 불가. 순서를 바꾸면안됨(바꾸면 null포인트 인셉션이 일어남).
	if(loginMember==null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	session.setMaxInactiveInterval(30*60);
	
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>selectCategoryList.jsp 페이징 안함</title>
</head>
<body>
<div class="container-fluid">
	<!-- banner include -->
	<jsp:include page="/partial/banner.jsp"></jsp:include>
		<!-- 관리자 메뉴 include -->
	<!-- 관리자 메뉴 인클루드(include)시작 ,페이지 형태만 인클루드 하는 것이 좋음(코드 형태는 비추천).-->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- 관리자 메뉴 인클루드 끝 -->
	<div style="text-align: center">
		<h1>[전자책 카테고리 관리]</h1>
	</div>
	<div style="text-align: center">
		<a href="insertCategoryForm.jsp" class="btn btn-warning">추가</a>
	</div>
	<br>
	<div class="container-fluid">
		<table class="table" style="text-align:center; display:table;">
			<thead>
				<tr>
				 	<th width="30%">categoryName</th>
				 	<th width="10%">categoryState</th>
				 	<th width="20%">updateDate</th>
				 	<th width="20%">createDate</th>
				 	<th width="20%">상태수정</th>
				</tr>
			</thead>
			<tbody>
				<%
				for(Category c : categoryList){
				%>
				<tr>
					<td style="display:table-cell;vertical-align:middle;"><%=c.getCategoryName()%></td>
					<td style="display:table-cell;vertical-align:middle;"><%=c.getCategoryState()%></td>
					<td style="display:table-cell;vertical-align:middle;"><%=c.getUpdateDate()%></td>
					<td style="display:table-cell;vertical-align:middle;"><%=c.getCreateDate()%></td>
					<td style="display:table-cell;vertical-align:middle;">
						<!-- 사용상태 수정 -->
						<form method="post" action="updateCategoryStateAction.jsp?categoryName=<%=c.getCategoryName()%>">
							<!-- 상태에 따라 그 값이 기본으로 선택되게 만듦 -->
							<select name="categoryState" style="display:table-cell;vertical-align:middle;">
							<%
	                       		if(c.getCategoryState().equals("Y")) {
	                   		%>
	                       			<option value="Y" selected="selected">Y</option>
	                           		<option value="N">N</option>
	                     	<%
	                        	} else {
	                     	%>
	                           		<option value="Y">Y</option>
	                           		<option value="N" selected="selected">N</option>
	                        <%
	                        	}
	                     	%>
							</select>
							<button type="submit" class="btn btn-outline-secondary">결정</button>
						</form>
					</td>
				<%
				}
				%>
			</tbody>
		</table>
	</div>
	
	<!-- footer -->
	<jsp:include page="/partial/footer.jsp"></jsp:include>
</div>
</body>
</html>