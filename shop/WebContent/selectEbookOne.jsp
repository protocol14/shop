<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.util.ArrayList" %>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");

	//로그인 상태라면 세션유지
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember != null){
		session.setMaxInactiveInterval(30*60);
	}
	
	// 상품평 댓글 현재 페이지
	int commentCurrentPage = 1;
	if(request.getParameter("commentCurrentPage") != null){
		commentCurrentPage = Integer.parseInt(request.getParameter("commentCurrentPage"));
	}
	// 디버그
	System.out.println("[Debug] commentCurrentPage : "+commentCurrentPage);
	
	// 문의글목록 현재 페이지
	int qnaCurrentPage = 1;
	if(request.getParameter("qnaCurrentPage") != null){
		qnaCurrentPage = Integer.parseInt(request.getParameter("qnaCurrentPage"));
	}
	// 디버그
	System.out.println("[Debug] qnaCurrentPage : "+qnaCurrentPage);
	
	// 상수선언 int값
	final int ROW_PER_PAGE = 10; // rowPerPage변수 10으로 초기화되면 끝까지 10을 써야 한다. --> 상수
	
	// 상품평, 문의 네비게이션에서 보여줄 시작 페이지
	int commentBeginRow = (commentCurrentPage-1)*ROW_PER_PAGE;
	int qnaBeginRow = (qnaCurrentPage-1)*ROW_PER_PAGE;
	
	// MemberDao
	MemberDao memberDao = new MemberDao();
	
	// 값 가져와서 변수 선언
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	
	// CategoryDao -> 호출 -> Array배열값
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	// OrderCommentDao -> 호출 -> Array배열값
	OrderCommentDao orderCommentDao = new OrderCommentDao();
	ArrayList<OrderComment> orderCommentList = orderCommentDao.selectOrderComment(commentBeginRow, ROW_PER_PAGE, ebookNo);
	
	// QnaDao -> 호출 -> Array배열값
	QnaDao qnaDao = new QnaDao();
	ArrayList<Qna> qnaList = qnaDao.selectEbookQnaList(qnaBeginRow, ROW_PER_PAGE, ebookNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책 상세 페이지</title>	<!-- 책 상세 페이지 -->
</head>
<body>
<div class="container-fluid">
	<!-- 배너 -->
	<jsp:include page="/partial/banner.jsp"></jsp:include>
		<!-- start : mainMenu include -->
		<div>
			<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
	</div>
	<!-- end : mainMenu include -->
	
	<!-- 본문 -->
	<%
		// dao -> 호출 -> 1. vo에 받아온 값 셋팅 2. 평균값
		EbookDao ebookDao = new EbookDao();
		Ebook ebook = ebookDao.selectEbookOne(ebookNo);
		float ebookAVG = ebookDao.selectAVGEbookOne(ebookNo);
	%>
	<div style="text-align: center">
		<br>
		<h1><%=ebook.getEbookTitle() %> 상세보기</h1>
		<br>
	</div>
	<div class="container-fluid">
		<form method="post" action="<%=request.getContextPath()%>/insertOrderAction.jsp">
		<% 
			// 로그인중이면
			if(loginMember != null){
		%>	
				<!-- 잠재고객이므로 정보를 hidden으로 배치 -->
				<input type="hidden" name="ebookNo" value="<%=ebookNo%>">
	            <input type="hidden" name="memberNo" value="<%=loginMember.getMemberNo()%>">
	           	<input type="hidden" name="orderPrice" value="<%=ebook.getEbookPrice()%>">
				<table class="table" style="text-align:center; display:table;">
					<thead>
							<tr>
								<th></th>
								<th></th>
							</tr>
					</thead>
					
					<tbody>
							<tr>
								<td rowspan=13><img src="<%=request.getContextPath() %>/image/<%=ebook.getEbookImg()%>"></td>						
							</tr>
					
							<!-- 구매 활성화 -->
							<tr>
								<td class="btn btn-outline-secondary" style="display:table-cell; vertical-align:middle;"><button type="submit" class="btn btn-warning" style="width:67%;">구매</button></td>
							</tr>
			<% 	
				// 로그인 중이 아닐 경우
				} else {
			%>
				<table class="table" style="text-align:center; display:table;">
					<thead>
							<tr>
								<th width="50%"></th>
								<th width="50%"></th>
							</tr>
					</thead>
					
					<tbody>
							<tr>
								<td rowspan=13 width="50%"><img width="100%" src="<%=request.getContextPath() %>/image/<%=ebook.getEbookImg()%>"></td>						
							</tr>
								<!-- 구매 비활성화 -->
								<tr>
									<td width="50%" style="display:table-cell;vertical-align:middle; color:blue;">로그인 후에 구매 가능합니다.</td>
								</tr>
						<% 	
							}
						
						%>
							<!-- 로그인 유무와 관계없이 상품정보 배치 -->
							<tr>
								<td width="50%" style="display:table-cell;vertical-align:middle;">제목 : <%=ebook.getEbookTitle() %></td>
							</tr>
							<tr>
								<!-- 별점 -->
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
								<td style="display:table-cell;vertical-align:middle;">카테고리 : <%=ebook.getCategoryName() %></td>
							</tr>
							<tr>
								<td style="display:table-cell;vertical-align:middle;">ISBN : <%=ebook.getEbookISBN() %></td>
							</tr>
							<tr>
								<td style="display:table-cell;vertical-align:middle;">저자 : <%=ebook.getEbookAuthor() %></td>
							</tr>
							<tr>
								<td style="display:table-cell;vertical-align:middle;">출판사 : <%=ebook.getEbookCompany() %></td>
							</tr>
							<tr>
								<td style="display:table-cell;vertical-align:middle;">페이지 : <%=ebook.getEbookPageCount() %></td>
							</tr>
							<tr>
								<td style="display:table-cell;vertical-align:middle;">가격 : <%=ebook.getEbookPrice() %> ₩</td>
							</tr>
							<tr>
								<td style="display:table-cell;vertical-align:middle;">소개 : <%=ebook.getEbookSummary() %></td>
							</tr>
							<tr>
								<td style="display:table-cell;vertical-align:middle;">상태 : <%=ebook.getEbookState() %></td>
							</tr>
							<tr>
								<%
								// 추가일과 변경일 날짜가 같으면
								if(ebook.getCreateDate().equals(ebook.getUpdateDate())){
								%>	
									<td style="display:table-cell;vertical-align:middle;">추가일 : <%=ebook.getCreateDate() %></td>
								<%
									// 같지 않으면
									} else {
								%>
									<td style="display:table-cell;vertical-align:middle;">마지막 변경일 : <%=ebook.getUpdateDate() %></td>
								<%
									}
								%>
							</tr>
					</tbody>	
			</table>
		</form>
	</div>
	
	<!-- 상품평 -->
	<br>
	<br>
	<div class="container-fluid">
		<table class="table">
			<thead>
					<tr>
						<th width="20%">후기</th>
						<th width="20%">작성자</th>
						<th width="30%">내용</th>
						<th width="30%">추가일</th>
					</tr>
			</thead>
		<%
		// for each문
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
	// 상품평이 존재하지 않을 경우 네비게이션 바만 표시하지 않음
	if(!(orderCommentList).isEmpty()){
	%>
	<!-- 후기 네비게이션 바 -->
		<div style="margin: auto; text-align: center;">
			<a class="btn btn-warning" href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=ebookNo %>&commentCurrentPage==1&qnaCurrentPage=<%=qnaCurrentPage%>">처음으로</a>
		<%
			if(commentCurrentPage != 1){
		%>
				<a class="btn btn-warning" href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=ebookNo %>&commentCurrentPage=<%=commentCurrentPage-1%>&qnaCurrentPage=<%=qnaCurrentPage%>">이전</a>
		<%
			}
			
			int CommentLastPage = orderCommentDao.selectOrderCommentLastPageByOne(ebookNo, ROW_PER_PAGE);
			
			int CommentDisplayPage = 10;
			
			int CommentStartPage = ((commentCurrentPage - 1) / CommentDisplayPage) * CommentDisplayPage + 1;
			int CommentEndPage = CommentStartPage + CommentDisplayPage - 1;
			
			for(int i=CommentStartPage; i<=CommentEndPage; i++) {
				if(CommentEndPage<=CommentLastPage){
		%>
					<a class="btn btn-warning" href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=ebookNo %>&commentCurrentPage=<%=i%>&qnaCurrentPage=<%=qnaCurrentPage%>"><%=i%> </a>
		<%
				} else if(CommentEndPage>CommentLastPage){
		%>
					<a class="btn btn-warning" href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=ebookNo %>&commentCurrentPage=<%=i%>&qnaCurrentPage=<%=qnaCurrentPage%>"><%=i%> </a>
		<%
				}
				if(i == CommentLastPage){
					break;
				}
			}
			if(commentCurrentPage != CommentLastPage){
			%>
				<a class="btn btn-warning" href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=ebookNo %>&commentCurrentPage=<%=commentCurrentPage+1%>&qnaCurrentPage=<%=qnaCurrentPage%>">다음</a>
			<%
			}
			%>
			<a class="btn btn-warning" href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=ebookNo %>&commentCurrentPage=<%=CommentLastPage%>&qnaCurrentPage=<%=qnaCurrentPage%>">끝으로</a>
		</div>
	<%
	}
	%>
			
	<!-- 문의사항 -->
	<br>
	<br>
	<div class="container-fluid">
		<table class="table">
			<thead>
					<tr>
						<th width="20%">문의사항 <a href="<%=request.getContextPath()%>/insertQnaForm.jsp?ebookNo=<%=ebookNo %>" class="btn btn-outline-secondary">건의</a></th>
						<th width="20%">작성자</th>
						<th width="30%">내용</th>
						<th width="30%">마지막 수정일</th>
					</tr>
			</thead>
		<%
		for(Qna q: qnaList){
			if(loginMember != null){
				if(loginMember.getMemberLevel() >=1 || q.getQnaSecret().equals("Y") &&  loginMember.getMemberNo() == q.getMemberNo()){
			%>
				<tr>
					<td><%=q.getQnaCategory()%></td>
					<td>
					<%
					ArrayList<Member> member = memberDao.selectMemberOne(q.getMemberNo());
					for(Member m : member){
					%>
						<%=m.getMemberName() %>
					<%	
					}
					%>
					</td>
					<td><a href="selectQnaOne.jsp?qnaNo=<%=q.getQnaNo()%>&memberNo=<%=q.getMemberNo()%>"><%=q.getQnaTitle()%></a></td>
					<td><%=q.getUpdateDate() %></td>
				</tr>
			<%
				} else if(q.getQnaSecret().equals("Y") &&  loginMember.getMemberNo() != q.getMemberNo()){
				%>
					<tr>
						<td></td>
						<td></td>
						<td>비밀글입니다.</td>
						<td></td>
					</tr>
				<%
				} else {
				%>
					<tr>
					<td><%=q.getQnaCategory()%></td>
					<td>
					<%
					ArrayList<Member> member = memberDao.selectMemberOne(q.getMemberNo());
					for(Member m : member){
					%>
						<%=m.getMemberName() %>
					<%	
					}
					%>
					</td>
					<td><a href="selectQnaOne.jsp?qnaNo=<%=q.getQnaNo()%>&memberNo=<%=q.getMemberNo()%>"><%=q.getQnaTitle()%></a></td>
					<td><%=q.getUpdateDate() %></td>
				</tr>
				<%
				}
			} else if(q.getQnaSecret().equals("Y")){
			%>
				<tr>
					<td></td>
					<td></td>
					<td>비밀글입니다.</td>
					<td></td>
				</tr>
			<%
			} else {
			%>
				<tr>
					<td><%=q.getQnaCategory()%></td>
					<td>
					<%
					ArrayList<Member> member = memberDao.selectMemberOne(q.getMemberNo());
					for(Member m : member){
					%>
						<%=m.getMemberName() %>
					<%	
					}
					%>
					</td>
					<td><a href="selectQnaOne.jsp?qnaNo=<%=q.getQnaNo()%>&memberNo=<%=q.getMemberNo()%>"><%=q.getQnaTitle()%></a></td>
					<td><%=q.getUpdateDate() %></td>
			</tr>
			<%
			}
		} 
		%>
		</table>
	</div>	
	
	<!-- 문의사항이 없을 경우 네비게이션바만 표시하지 않음 -->
	<%
	if(!(qnaList).isEmpty()){
	%>
	<!-- 문의 네비게이션 바 -->
		<div style="margin: auto; text-align: center;">
			<a class="btn btn-warning" href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=ebookNo %>&qnaCurrentPage=1&commentCurrentPage=<%=commentCurrentPage%>">처음으로</a>
		<%
			if(qnaCurrentPage != 1){
		%>
				<a class="btn btn-warning" href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=ebookNo %>&qnaCurrentPage=<%=qnaCurrentPage-1%>&commentCurrentPage=<%=commentCurrentPage%>">이전</a>
		<%
			}
			
			int QnaLastPage = qnaDao.selectQnaLastPageByOne(ebookNo, ROW_PER_PAGE);
			
			int QnaDisplayPage = 10;
			
			int QnaStartPage = ((qnaCurrentPage - 1) / QnaDisplayPage) * QnaDisplayPage + 1;
			int QnaEndPage = QnaStartPage + QnaDisplayPage - 1;
			
			for(int i=QnaStartPage; i<=QnaEndPage; i++) {
				if(QnaEndPage<=QnaLastPage){
		%>
					<a class="btn btn-warning" href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=ebookNo %>&qnaCurrentPage=<%=i%>&commentCurrentPage=<%=commentCurrentPage%>"><%=i%> </a>
		<%
				} else if(QnaEndPage>QnaLastPage){
		%>
					<a class="btn btn-warning" href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=ebookNo %>&qnaCurrentPage=<%=i%>&commentCurrentPage=<%=commentCurrentPage%>"><%=i%> </a>
		<%
				}
				if(i == QnaLastPage){
					break;
				}
			}
			if(qnaCurrentPage != QnaLastPage){
			%>
				<a class="btn btn-warning" href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=ebookNo %>&qnaCurrentPage=<%=qnaCurrentPage+1%>&commentCurrentPage=<%=commentCurrentPage%>">다음</a>
			<%
			}
			%>
			<a class="btn btn-warning" href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=ebookNo %>&qnaCurrentPage=<%=QnaLastPage%>&commentCurrentPage=<%=commentCurrentPage%>">끝으로</a>
		</div>
	<%
	}
	%>
	
	<!-- footer -->
	<jsp:include page="/partial/footer.jsp"></jsp:include>
</div>

</body>
</html>