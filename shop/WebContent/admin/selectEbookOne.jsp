<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.util.ArrayList" %>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");

	// 인증 방어 코드 : 로그인 후, MemgerLevel이 1이상인 경우에만 페이지 열람 가능
	// session.getAttribute("loginMember") --> null
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() <1 ){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	// 세션유지
	session.setMaxInactiveInterval(30*60);
	
	// 페이징
	int commentCurrentPage = 1;
	if(request.getParameter("commentCurrentPage") != null){
		commentCurrentPage = Integer.parseInt(request.getParameter("commentCurrentPage"));
	}
	System.out.println("[Debug] commentCurrentPage : "+commentCurrentPage);
	int qnaCurrentPage = 1;
	if(request.getParameter("qnaCurrentPage") != null){
		qnaCurrentPage = Integer.parseInt(request.getParameter("qnaCurrentPage"));
	}
	System.out.println("[Debug] qnaCurrentPage : "+qnaCurrentPage);
	
	final int ROW_PER_PAGE = 10; // rowPerPage변수 10으로 초기화되면 끝까지 10을 써야 한다. --> 상수
	
	// 구현 코드
	int commentBeginRow = (commentCurrentPage-1)*ROW_PER_PAGE;
	int qnaBeginRow = (qnaCurrentPage-1)*ROW_PER_PAGE;
	
	MemberDao memberDao = new MemberDao();
	
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	OrderCommentDao orderCommentDao = new OrderCommentDao();
	ArrayList<OrderComment> orderCommentList = orderCommentDao.selectOrderComment(commentBeginRow, ROW_PER_PAGE, ebookNo);
	
	QnaDao qnaDao = new QnaDao();
	ArrayList<Qna> qnaList = qnaDao.selectEbookQnaList(qnaBeginRow, ROW_PER_PAGE, ebookNo);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ebook 상세 - 관리자</title>	<!-- 관리자 Ebook 상세 페이지 -->
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
		EbookDao ebookDao = new EbookDao();
		Ebook ebook = ebookDao.selectEbookOne(ebookNo);
		
		float ebookAVG = ebookDao.selectAVGEbookOne(ebookNo);
	%>
	<div style="text-align: center">
		<h1><%=ebook.getEbookNo() %> - <%=ebook.getEbookTitle() %> 상세보기</h1>
	</div>
	<div class="container-fluid">
		<table class="table" style="text-align:center; display:table;">
			<thead>
				<tr>
					<th width="50%"></th>
					<th width="50%"></th>
				</tr>
			</thead>
			<tbody>
						<tr>
							<td width="50%" rowspan=14><img width="100%" src="<%=request.getContextPath() %>/image/<%=ebook.getEbookImg()%>"></td>						
						</tr>
						<tr>
							<td width="50%" style="display:table-cell; vertical-align:middle;">No : <%=ebook.getEbookNo() %></td>
						</tr>
						<tr>
							<td width="50%" style="display:table-cell; vertical-align:middle;">제목 : <%=ebook.getEbookTitle() %></td>
						</tr>
						<tr>
							<td style="display:table-cell; vertical-align:middle;">별점 : 
									<%
									if(ebookAVG < 0.5){
									%>
									<img src="<%=request.getContextPath() %>/image/star(0).png">
									<%	
									} else if(ebookAVG < 1) {
									%>
									<img src="<%=request.getContextPath() %>/image/star(0.5).png">
									<%
									}else if(ebookAVG < 1.5) {
									%>
									<img src="<%=request.getContextPath() %>/image/star(1).png">
									<%
									}else if(ebookAVG < 2) {
									%>
									<img src="<%=request.getContextPath() %>/image/star(1.5).png">
									<%
									}else if(ebookAVG < 2.5) {
									%>
									<img src="<%=request.getContextPath() %>/image/star(2).png">
									<%
									}else if(ebookAVG < 3) {
									%>
									<img src="<%=request.getContextPath() %>/image/star(2.5).png">
									<%
									}else if(ebookAVG < 3.5) {
									%>
									<img src="<%=request.getContextPath() %>/image/star(3).png">
									<%
									}else if(ebookAVG < 4) {
									%>
									<img src="<%=request.getContextPath() %>/image/star(3.5).png">
									<%
									}else if(ebookAVG < 4.5) {
									%>
									<img src="<%=request.getContextPath() %>/image/star(4).png">
									<%
									}else if(ebookAVG < 5) {
									%>
									<img src="<%=request.getContextPath() %>/image/star(4.5).png">
									<%
									}else if(ebookAVG == 5) {
									%>
									<img src="<%=request.getContextPath() %>/image/star(5).png">
									<%
									}
									%>
									
									&nbsp;<%=ebookAVG %></td>
						</tr>
						<tr>
							<td style="display:table-cell; vertical-align:middle;">카테고리 : <%=ebook.getCategoryName() %></td>
						</tr>
						<tr>
							<td style="display:table-cell; vertical-align:middle;">ISBN : <%=ebook.getEbookISBN() %></td>
						</tr>
						<tr>
							<td style="display:table-cell; vertical-align:middle;">저자 : <%=ebook.getEbookAuthor() %></td>
						</tr>
						<tr>
							<td style="display:table-cell; vertical-align:middle;">출판사 : <%=ebook.getEbookCompany() %></td>
						</tr>
						<tr>
							<td style="display:table-cell; vertical-align:middle;">페이지 : <%=ebook.getEbookPageCount() %></td>
						</tr>
						<tr>
							<td style="display:table-cell; vertical-align:middle;">가격 : <%=ebook.getEbookPrice() %> ₩</td>
						</tr>
						<tr>
							<td style="display:table-cell; vertical-align:middle;">소개 : <%=ebook.getEbookSummary() %></td>
						</tr>
						<tr>
							<td style="display:table-cell; vertical-align:middle;">상태 : <%=ebook.getEbookState() %></td>
						</tr>
						<tr>
							<td style="display:table-cell; vertical-align:middle;">추가일 : <%=ebook.getCreateDate() %></td>
						</tr>
						<tr>
							<td style="display:table-cell; vertical-align:middle;">마지막 수정일 : <%=ebook.getUpdateDate() %></td>
						</tr>
			</tbody>	
		</table>
	</div>
	
	<br>
	
	<div class="container-fluid" style="text-align:center;">
		<a href="<%=request.getContextPath()%>/admin/deleteEbookOneForm.jsp?ebookNo=<%=ebook.getEbookNo()%>&ebookTitle=<%=ebook.getEbookTitle() %>" onclick="return confirm('정말로 삭제하시겠습니까?');"  class="btn btn-outline-secondary">삭제</a>
		<a href="<%=request.getContextPath()%>/admin/updateEbookOneForm.jsp?ebookNo=<%=ebook.getEbookNo()%>" class="btn btn-outline-secondary">수정</a>
		<a href="<%=request.getContextPath()%>/admin/updateEbookImgForm.jsp?ebookNo=<%=ebook.getEbookNo()%>" class="btn btn-outline-secondary">이미지수정</a>
	</div>
	
	<br>
	<br>
	<div class="container-fluid">
		<table class="table">
			<thead>
					<tr>
						<th width="20%">후기</th>
						<th width="20%">작성자</th>
						<th width="30%">내용</th>
						<th width="30%">마지막 수정일</th>
					</tr>
			</thead>
		<%
		for(OrderComment o: orderCommentList){
		%>
			<tr>
				<td><%=o.getOrderScore()%>점</td>
				<td>
					<%
					ArrayList<Member> member = memberDao.selectMemberOne(o.getMemberNo());

					for(Member m : member){
						%>
							<%=m.getMemberName() %>
						<%	
						}
					%>
					</td>
				<td><%=o.getOrderContent()%></td>
				<td><%=o.getUpdateDate()%></td>
			</tr>
		<%
		}
		%>
		</table>
	</div>
	<%
	if(!(orderCommentList).isEmpty()){
	%>
	<!-- 후기 네비게이션 바 -->
		<div style="margin: auto; text-align: center;">
			<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectEbookOne.jsp?ebookNo=<%=ebookNo %>&commentCurrentPage==1&qnaCurrentPage=<%=qnaCurrentPage%>">처음으로</a>
		<%
			if(commentCurrentPage != 1){
		%>
				<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectEbookOne.jsp?ebookNo=<%=ebookNo %>&commentCurrentPage=<%=commentCurrentPage-1%>&qnaCurrentPage=<%=qnaCurrentPage%>">이전</a>
		<%
			}
			
			int CommentLastPage = orderCommentDao.selectOrderCommentLastPageByOne(ebookNo, ROW_PER_PAGE);
			
			int CommentDisplayPage = 10;
			
			int CommentStartPage = ((commentCurrentPage - 1) / CommentDisplayPage) * CommentDisplayPage + 1;
			int CommentEndPage = CommentStartPage + CommentDisplayPage - 1;
			
			for(int i=CommentStartPage; i<=CommentEndPage; i++) {
				if(CommentEndPage<=CommentLastPage){
		%>
					<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectEbookOne.jsp?ebookNo=<%=ebookNo %>&commentCurrentPage=<%=i%>&qnaCurrentPage=<%=qnaCurrentPage%>"><%=i%> </a>
		<%
				} else if(CommentEndPage>CommentLastPage){
		%>
					<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectEbookOne.jsp?ebookNo=<%=ebookNo %>&commentCurrentPage=<%=i%>&qnaCurrentPage=<%=qnaCurrentPage%>"><%=i%> </a>
		<%
				}
				if(i == CommentLastPage){
					break;
				}
			}
			if(commentCurrentPage != CommentLastPage){
			%>
				<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectEbookOne.jsp?ebookNo=<%=ebookNo %>&commentCurrentPage=<%=commentCurrentPage+1%>&qnaCurrentPage=<%=qnaCurrentPage%>">다음</a>
			<%
			}
			%>
			<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectEbookOne.jsp?ebookNo=<%=ebookNo %>&commentCurrentPage=<%=CommentLastPage%>&qnaCurrentPage=<%=qnaCurrentPage%>">끝으로</a>
		</div>
	<%
	}
	%>
			
		<br>
	<br>
	<div class="container-fluid">
		<table class="table">
			<thead>
					<tr>
						<th width="20%">문의사항 <a href="<%=request.getContextPath()%>/insertQnaForm.jsp?ebookNo=<%=ebookNo %>" class="btn btn-outline-secondary">건의</a></th>
						<th width="20%">작성자</th>
						<th width="30%" >내용</th>
						<th width="30%">마지막 수정일</th>
					</tr>
			</thead>
		<%
		for(Qna q: qnaList){
		%>
			<tr>
				<td><%=q.getQnaCategory()%></td>
				<td><%=q.getMemberNo() %>(
				<%
				ArrayList<Member> member = memberDao.selectMemberOne(q.getMemberNo());
				for(Member m : member){
				%>
					<%=m.getMemberName() %>
				<%	
				}
				%>
				)
				</td>
				<td><a href="selectQnaOne.jsp?qnaNo=<%=q.getQnaNo()%>&memberNo=<%=q.getMemberNo()%>"><%=q.getQnaTitle()%></a></td>
				<td><%=q.getUpdateDate() %></td>
			</tr>
		<%
		} 
		%>
		</table>
	</div>	
	
	<%
	if(!(qnaList).isEmpty()){
	%>
	<!-- 문의 네비게이션 바 -->
		<div style="margin: auto; text-align: center;">
			<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectEbookOne.jsp?ebookNo=<%=ebookNo %>&qnaCurrentPage=1&commentCurrentPage=<%=commentCurrentPage%>">처음으로</a>
		<%
			if(qnaCurrentPage != 1){
		%>
				<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectEbookOne.jsp?ebookNo=<%=ebookNo %>&qnaCurrentPage=<%=qnaCurrentPage-1%>&commentCurrentPage=<%=commentCurrentPage%>">이전</a>
		<%
			}
			
			int QnaLastPage = qnaDao.selectQnaLastPageByOne(ebookNo, ROW_PER_PAGE);
			
			int QnaDisplayPage = 10;
			
			int QnaStartPage = ((qnaCurrentPage - 1) / QnaDisplayPage) * QnaDisplayPage + 1;
			int QnaEndPage = QnaStartPage + QnaDisplayPage - 1;
			
			for(int i=QnaStartPage; i<=QnaEndPage; i++) {
				if(QnaEndPage<=QnaLastPage){
		%>
					<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectEbookOne.jsp?ebookNo=<%=ebookNo %>&qnaCurrentPage=<%=i%>&commentCurrentPage=<%=commentCurrentPage%>"><%=i%> </a>
		<%
				} else if(QnaEndPage>QnaLastPage){
		%>
					<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectEbookOne.jsp?ebookNo=<%=ebookNo %>&qnaCurrentPage=<%=i%>&commentCurrentPage=<%=commentCurrentPage%>"><%=i%> </a>
		<%
				}
				if(i == QnaLastPage){
					break;
				}
			}
			if(qnaCurrentPage != QnaLastPage){
			%>
				<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectEbookOne.jsp?ebookNo=<%=ebookNo %>&qnaCurrentPage=<%=qnaCurrentPage+1%>&commentCurrentPage=<%=commentCurrentPage%>">다음</a>
			<%
			}
			%>
			<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectEbookOne.jsp?ebookNo=<%=ebookNo %>&qnaCurrentPage=<%=QnaLastPage%>&commentCurrentPage=<%=commentCurrentPage%>">끝으로</a>
		</div>
	<%
	}
	%>
	
	<!-- footer -->
	<jsp:include page="/partial/footer.jsp"></jsp:include>
</div>

</body>
</html>