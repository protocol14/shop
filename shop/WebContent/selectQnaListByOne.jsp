<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.util.ArrayList" %>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");

	//로그인 중이 아니면 튕겨나옴
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	// 세션유지
	session.setMaxInactiveInterval(30*60);
	
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println("[Debug] currentPage : "+currentPage);
	
	final int ROW_PER_PAGE = 10; // rowPerPage변수 10으로 초기화되면 끝까지 10을 써야 한다. --> 상수
	
	int beginRow = (currentPage-1)*ROW_PER_PAGE;
	
	QnaDao qnaDao = new QnaDao();
	ArrayList<Qna> qnaList = qnaDao.selectQnaListOne(beginRow, ROW_PER_PAGE, memberNo);
	
	QnaCommentDao qnaCommentDao = new QnaCommentDao();
	
	MemberDao memberDao = new MemberDao();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 목록</title>	<!-- 개인 문의 목록 페이지 -->
</head>
<body>
<div class="container-fluid">
	<!-- banner include -->
	<jsp:include page="/partial/banner.jsp"></jsp:include>
		<!-- start : mainMenu include -->
		<div>
			<jsp:include page="/partial/mainMenu.jsp"></jsp:include>
		</div>
		<!-- end : mainMenu include -->
		
	<div style="text-align: center">
		<h1>[건의한 Qna 목록]</h1>
	</div>
	
	<!-- 전자책 목록 출력 : 카테고리별 출력 -->
	<div class="container-fluid">
		<table class="table" style="text-align:center; display:table;">
			<thead>
				<tr>
					<th>qna_category</th>
					<th>qna_title</th>
					<th>createDate</th>
					<th>updateDate</th>
					<th>상태</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<%
					for(Qna q : qnaList){
				%>
						<tr>
							<td style="display:table-cell;vertical-align:middle;"><%=q.getQnaCategory() %></td>
							<td style="display:table-cell;vertical-align:middle;"><%=q.getQnaTitle() %></td>
							<td style="display:table-cell;vertical-align:middle;"><%=q.getCreateDate() %></td>
							<td style="display:table-cell;vertical-align:middle;"><%=q.getUpdateDate() %></td>
							<td style="display:table-cell;vertical-align:middle;">
							<%
							boolean qnaState = qnaCommentDao.selectQnaAnswerState(q.getQnaNo());
							if(qnaState == true){
							%>
							답변완료
							<%
							}
							%>
							</td>
							<td style="display:table-cell;vertical-align:middle;">
								<!-- selectEbookOne.jsp -->
								<a href="<%=request.getContextPath()%>/selectQnaOne.jsp?qnaNo=<%=q.getQnaNo()%>&memberNo=<%=q.getMemberNo() %>" class="btn btn-outline-secondary">상세보기</a>
							</td>
						</tr>
				<%
					}
				%>
			</tbody>	
		</table>
		
		
		<%
		if(!(qnaList).isEmpty()){
		%>
		<!-- 하단 네비게이션 바 -->
		<div style="margin: auto; text-align: center;">
			<a class="btn btn-warning" href="<%=request.getContextPath()%>/selectQnaListByOne.jsp?currentPage=1">처음으로</a>
		<%
			if(currentPage != 1){
		%>
				<a class="btn btn-warning" href="<%=request.getContextPath()%>/selectQnaListByOne.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%
			}
			
			int lastPage = qnaDao.selectQnaLastPage(ROW_PER_PAGE);
			
			int displayPage = 10;
			
			int startPage = ((currentPage - 1) / displayPage) * displayPage + 1;
			int endPage = startPage + displayPage - 1;
			
			for(int i=startPage; i<=endPage; i++) {
				if(endPage<=lastPage){
		%>
					<a class="btn btn-warning" href="<%=request.getContextPath()%>/selectQnaListByOne.jsp?currentPage=<%=i%>"><%=i%> </a>
		<%
				} else if(endPage>lastPage){
		%>
					<a class="btn btn-warning" href="<%=request.getContextPath()%>/selectQnaListByOne.jsp?currentPage=<%=i%>"><%=i%> </a>
		<%
				}
				if(i == lastPage){
					break;
				}
			}
			if(currentPage != lastPage){
			%>
				<a class="btn btn-warning" href="<%=request.getContextPath()%>/selectQnaListByOne.jsp?currentPage=<%=currentPage+1%>">다음</a>
			<%
			}
			%>
			<a class="btn btn-warning" href="<%=request.getContextPath()%>/selectQnaListByOne.jsp?currentPage=<%=lastPage%>">끝으로</a>
		</div>
	<%
		}
	%>
	</div>
	<jsp:include page="/partial/footer.jsp"></jsp:include>
</div>
</body>
</html>