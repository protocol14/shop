<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
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
	// 세션 유지
	session.setMaxInactiveInterval(30*60);
	
	
	// 공지 최근 5개
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> notice = noticeDao.selectNoticeList(0, 5);	
	
	// 현재 페이지
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println("[Debug] currentPage : "+currentPage);
	
	final int ROW_PER_PAGE = 10; // rowPerPage변수 10으로 초기화되면 끝까지 10을 써야 한다. --> 상수
	
	int beginRow = (currentPage-1)*ROW_PER_PAGE;
	
	// dao, vo
	QnaCommentDao qnaCommentDao = new QnaCommentDao();
	ArrayList<Qna> qnaList = qnaCommentDao.selectNotAnswerQnaList(beginRow, ROW_PER_PAGE);
	
	MemberDao memberDao = new MemberDao();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 index</title>	<!-- 관리자 메인 페이지 -->
</head>
<body>
<div class="container-fluid">
	<!-- 배너 -->
	<jsp:include page="/partial/banner.jsp"></jsp:include>
		<!-- 관리자 메뉴 include -->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
		<!-- end : mainMenu include -->
		
	<div style="text-align: center">
		<h1>관리자 페이지</h1>
		<div><%=loginMember.getMemberId() %>님 반갑습니다.</div>
	</div>
	
	<div class="container-fluid" style="text-align: center">
		<br>
		<h2>최근 공지사항</h2>
		<br>
		<table class="table">
		<%
		for(Notice n : notice)	{
		%>
			<tr>		
				<td>
					<div><a href="<%=request.getContextPath()%>/selectNoticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>"><%=n.getNoticeTitle() %></a></div>
				</td>
				
			</tr>
		<%
		}
		%>
		</table>
	</div>
	
	<div class="container-fluid" style="text-align: center">
		<br>
		<h2>답글 달지 않은 문의글</h2>
		<br>
		<table class="table" style="text-align:center; display:table;">
			<thead>
				<tr>
					<th width="16%">qna_no</th>
					<th width="10%">qna_category</th>
					<th width="15%">qna_title</th>
					<th width="8%">member_no</th>
					<th width="12%">createDate</th>
					<th width="12%">updateDate</th>
					<th width="32%"></th>
				</tr>
			</thead>
			<tbody>
				<%
					for(Qna q : qnaList){
				%>
						<tr>
							<td style="display:table-cell;vertical-align:middle;"><%=q.getQnaNo() %></td>
							<td style="display:table-cell;vertical-align:middle;"><%=q.getQnaCategory() %></td>
							<td style="display:table-cell;vertical-align:middle;"><%=q.getQnaTitle() %></td>
							<td style="display:table-cell;vertical-align:middle;"><%=q.getMemberNo() %>(
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
							<td style="display:table-cell;vertical-align:middle;"><%=q.getCreateDate() %></td>
							<td style="display:table-cell;vertical-align:middle;"><%=q.getUpdateDate() %></td>
							<td style="display:table-cell;vertical-align:middle;">
								<!-- selectEbookOne.jsp -->
								<a href="<%=request.getContextPath()%>/admin/selectQnaOne.jsp?qnaNo=<%=q.getQnaNo()%>" class="btn btn-outline-secondary">상세보기</a>
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
			<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/adminIndex.jsp?currentPage=1">처음으로</a>
		<%
			if(currentPage != 1){
		%>
				<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/adminIndex.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%
			}
			
			int lastPage = qnaCommentDao.selectNotAnswerQnaLastPage(ROW_PER_PAGE);
			
			int displayPage = 10;
			
			int startPage = ((currentPage - 1) / displayPage) * displayPage + 1;
			int endPage = startPage + displayPage - 1;
			
			for(int i=startPage; i<=endPage; i++) {
				if(endPage<=lastPage){
		%>
					<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/adminIndex.jsp?currentPage=<%=i%>"><%=i%> </a>
		<%
				} else if(endPage>lastPage){
		%>
					<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/adminIndex.jsp?currentPage=<%=i%>"><%=i%> </a>
		<%
				}
				if(i == lastPage){
					break;
				}
			}
			if(currentPage != lastPage){
			%>
				<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/adminIndex.jsp?currentPage=<%=currentPage+1%>">다음</a>
			<%
			}
			%>
			<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/adminIndex.jsp?currentPage=<%=lastPage%>">끝으로</a>
		</div>
	<%
		}
	%>
	</div>
	
	<!-- footer -->
	<jsp:include page="/partial/footer.jsp"></jsp:include>
</div>
</body>
</html>