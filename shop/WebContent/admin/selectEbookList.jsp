<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.util.ArrayList" %>
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
	// 세션유지
	session.setMaxInactiveInterval(30*60);
	
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println("[Debug] currentPage : "+currentPage);
	
	final int ROW_PER_PAGE = 10; // rowPerPage변수 10으로 초기화되면 끝까지 10을 써야 한다. --> 상수
	
	int beginRow = (currentPage-1)*ROW_PER_PAGE;
	
	String categoryName = "";
	
	if(request.getParameter("categoryName") != null){
		categoryName = request.getParameter("categoryName");
	}
	
	// 카테고리별 목록 받아오기
	EbookDao ebookDao = new EbookDao();
	ArrayList<Ebook> ebookList = null;
	
	if(categoryName.equals("") == true){
		ebookList = ebookDao.selectEbookList(beginRow, ROW_PER_PAGE);
	} else {
		ebookList = ebookDao.selectEbookListByCategory(beginRow, ROW_PER_PAGE, categoryName);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ebook 목록</title>	<!-- 관리자 Ebook List 페이지 -->
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
		<h1>[전자책 관리]</h1>
		<select id="categoryName" name="categoryName" onchange="categorySelect()" style="display:table-cell;vertical-align:middle;">
			<option value="">선택</option>
			<option value="">전체목록</option>
			<%
				for(Category c : categoryList){
			%>
				<option value="<%=c.getCategoryName() %>"><%=c.getCategoryName() %></option>
			<%	
				}
			%>
		</select>
		<a href="<%=request.getContextPath()%>/admin/insertEbookForm.jsp" class="btn btn-outline-secondary">전자책 추가</a>
	</div>
	
	<!-- 전자책 목록 출력 : 카테고리별 출력 -->
	<div class="container-fluid">
		<table class="table" style="text-align:center; display:table;">
			<thead>
				<tr>
					<th width="20%">ebookNo</th>
					<th width="20%">ebookTitle</th>
					<th width="20%">categoryName</th>
					<th width="20%">ebookState</th>
					<th width="20%"></th>
				</tr>
			</thead>
			<tbody>
				<%
					for(Ebook e : ebookList){
				%>
						<tr>
							<td style="display:table-cell;vertical-align:middle;"><%=e.getEbookNo() %></td>
							<td style="display:table-cell;vertical-align:middle;"><%=e.getEbookTitle() %></td>
							<td style="display:table-cell;vertical-align:middle;"><%=e.getCategoryName() %></td>
							<td style="display:table-cell;vertical-align:middle;"><%=e.getEbookState() %></td>
							<td style="display:table-cell;vertical-align:middle;">
								<!-- selectEbookOne.jsp -->
								<a href="<%=request.getContextPath()%>/admin/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>" class="btn btn-outline-secondary">상세보기</a>
							</td>
						</tr>
				<%
					}
				%>
			</tbody>	
		</table>
		
		
		<%
		if(!(ebookList).isEmpty()){
		%>	
		<!-- 하단 네비게이션 바 -->
		<div style="margin: auto; text-align: center;">
			<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=1&categoryName=<%=categoryName%>">처음으로</a>
		<%
			if(currentPage != 1){
		%>
				<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=<%=currentPage-1%>&categoryName=<%=categoryName%>">이전</a>
		<%
			}
			
			int lastPage = ebookDao.selectEbookLastPage(10, categoryName);
			
			int displayPage = 10;
			
			int startPage = ((currentPage - 1) / displayPage) * displayPage + 1;
			int endPage = startPage + displayPage - 1;
			
			for(int i=startPage; i<=endPage; i++) {
				if(endPage<=lastPage){
		%>
					<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=<%=i%>&categoryName=<%=categoryName%>"><%=i%> </a>
		<%
				} else if(endPage>lastPage){
		%>
					<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=<%=i%>&categoryName=<%=categoryName%>"><%=i%> </a>
		<%
				}
				if(i == lastPage){
					break;
				}
			}
			if(currentPage != lastPage){
			%>
				<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=<%=currentPage+1%>&categoryName=<%=categoryName%>">다음</a>
			<%
			}
			%>
			<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=<%=lastPage%>&categoryName=<%=categoryName%>">끝으로</a>
		<%
		}
		%>
		</div>
	</div>
	<!-- footer -->
	<jsp:include page="/partial/footer.jsp"></jsp:include>
</div>
<script>
	function categorySelect(){ 
		// 카테고리 선택값을 가져와서 벨류 저장
		let categoryName = document.getElementById("categoryName"); 
		let selectCategoryValue = categoryName.options[categoryName.selectedIndex].value; 
		
		location.replace('<%=request.getContextPath() %>/admin/selectEbookList.jsp?categoryName='+selectCategoryValue);
	}
</script>
</body>
</html>