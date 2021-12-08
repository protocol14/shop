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
	session.setMaxInactiveInterval(30*60);
	
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ebook 상세 수정</title>	 <!-- 관리자 Ebook 상세 수정 페이지 -->
</head>
<body>
<div class="container-fluid">
	<!-- 배너 -->
	<jsp:include page="/partial/banner.jsp"></jsp:include>
		<!-- 관리자 메뉴 include -->
	<!-- 관리자 메뉴 인클루드(include)시작 ,페이지 형태만 인클루드 하는 것이 좋음(코드 형태는 비추천).-->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- 관리자 메뉴 인클루드 끝 -->
	
	<%
		int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
		EbookDao ebookDao = new EbookDao();
		Ebook ebook = ebookDao.selectEbookOne(ebookNo);
	%>
	<div style="text-align: center">
		<h1><%=ebook.getEbookNo() %> - <%=ebook.getEbookTitle() %> 상세보기</h1>
	</div>
	<div class="container-fluid">
	<form name="UpdateEbook" method="post" action="<%=request.getContextPath()%>/admin/updateEbookOneAction.jsp">
		<table class="table" style="text-align:center; display:table;">
			<thead>
				<tr>
					<th></th>
					<th></th>
				</tr>
			</thead>
			<tbody>
						<tr>
							<td rowspan=12><img src="<%=request.getContextPath() %>/image/<%=ebook.getEbookImg()%>"></td>						
						</tr>
						<tr>
							<td style="display:table-cell; vertical-align:middle;">No : <%=ebook.getEbookNo() %></td>
						</tr>
						<tr>
							<td style="display:table-cell; vertical-align:middle;">제목 : <input type="text" class="ebookTitle" name="ebookTitle" value=<%=ebook.getEbookTitle() %>></td>
						</tr>
						<tr>
							<td style="display:table-cell; vertical-align:middle;">
								카테고리 :
								<select name="categoryName">
								<%
									for(Category c : categoryList){
										if(c.getCategoryName().equals(ebook.getCategoryName())){
								%>	
											<option value="<%=c.getCategoryName() %>" selected><%=c.getCategoryName() %></option>
								<%		
										} else{
								%>		
											<option value="<%=c.getCategoryName() %>"><%=c.getCategoryName() %></option>
								<%		
										}
									}
								%>
								</select>
						</tr>
						<tr>
							<td style="display:table-cell; vertical-align:middle;">ISBN : <input type="text" class="ebookISBN" name="ebookISBN" value=<%=ebook.getEbookISBN() %>>	
							</td>
						</tr>
						<tr>
							<td style="display:table-cell; vertical-align:middle;">저자 : <input type="text" class="ebookAuthor" name="ebookAuthor" value=<%=ebook.getEbookAuthor() %>></td>
						</tr>
						<tr>
							<td style="display:table-cell; vertical-align:middle;">출판사 : <input type="text" class="ebookCompany" name="ebookCompany" value=<%=ebook.getEbookCompany() %>></td>
						</tr>
						<tr>
							<td style="display:table-cell; vertical-align:middle;">페이지 : <input type="number" class="ebookPageCount" name="ebookPageCount" value=<%=ebook.getEbookPageCount() %>></td>
						</tr>
						<tr>
							<td style="display:table-cell; vertical-align:middle;">가격 : <input type="number" class="ebookPrice" name="ebookPrice" value=<%=ebook.getEbookPrice() %>> ₩</td>
						</tr>
						<tr>
							<td style="display:table-cell; vertical-align:middle;">소개 : <textarea rows="5" cols="50" class="ebookSummary" name="ebookSummary"><%=ebook.getEbookSummary() %></textarea></td>
						</tr>
						<tr>
							<td style="display:table-cell; vertical-align:middle;">상태 : 
							<select name="ebookState">
								<%
									if(ebook.getEbookState().equals("판매중")){
								%>	
										<option value="판매중" selected>판매중</option>
								<%		
									} else{
								%>		
										<option value="판매중">판매중</option>
								<%		
									}
								%>
								<%
									if(ebook.getEbookState().equals("품절")){
								%>	
										<option value="품절" selected>품절</option>
								<%		
									} else{
								%>		
										<option value="품절">품절</option>
								<%		
									}
								%>
								<%
									if(ebook.getEbookState().equals("절판")){
								%>	
										<option value="절판" selected>절판</option>
								<%		
									} else{
								%>		
										<option value="절판">절판</option>
								<%		
									}
								%>
								<%
									if(ebook.getEbookState().equals("구편절판")){
								%>	
										<option value="구편절판" selected>구편절판</option>
								<%		
									} else{
								%>		
										<option value="구편절판">구편절판</option>
								<%		
									}
								%>
								</select>
							</td>
						</tr>
						<tr>
							<td style="display:table-cell; vertical-align:middle;">추가일 : <%=ebook.getCreateDate() %></td>
						</tr>
						<tr>
							<td style="display:table-cell; vertical-align:middle;">
								마지막 수정일 : <%=ebook.getUpdateDate() %>
								<input type="hidden" name="ebookNo" value=<%=ebookNo %>>
							</td>
						</tr>
			</tbody>	
		</table>
		</form>
	</div>

	<div class="container-fluid" style="text-align:center;">
		<button type="button" class="btn btn-outline-secondary" onclick="updateEbook()">수정</button>
		<div id="error" style="color:red">　</div>
	</div>
	
	<!-- footer -->
	<jsp:include page="/partial/footer.jsp"></jsp:include>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	// 유효성 검사
	function updateEbook(){
		if($(".ebookTitle").val() == "" || $(".ebookISBN").val() == "" || $(".ebookAuthor").val() == "" ||
		   $(".ebookCompany").val() == "" ||  $(".ebookPageCount").val() == "" ||
		   $(".ebookPrice").val() == "" ||  $(".ebookSummary").val() == "") {
			document.getElementById("error").innerHTML = '입력되지 않은 값이 있습니다.';
			return;
		} else{
			UpdateEbook.submit();
		}
	};
</script>
</body>
</html>