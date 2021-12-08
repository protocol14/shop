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

	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println("[Debug] currentPage : "+currentPage);
	
	final int ROW_PER_PAGE = 10; // rowPerPage변수 10으로 초기화되면 끝까지 10을 써야 한다. --> 상수
	
	int beginRow = (currentPage-1)*ROW_PER_PAGE;
	
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> noticeList = noticeDao.selectNoticeList(beginRow, ROW_PER_PAGE);
	
	MemberDao memberDao = new MemberDao();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 목록</title>	<!-- 관리자 공지 List 페이지 -->
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
		<h1>[공지게시판 관리]</h1>
		
		<a href="<%=request.getContextPath()%>/admin/insertNoticeForm.jsp" class="btn btn-outline-secondary">공지 추가</a>
	</div>
	
	<!-- 전자책 목록 출력 : 카테고리별 출력 -->
	<div class="container-fluid">
		<table class="table" style="text-align:center; display:table;">
			<thead>
				<tr>
					<th width="10%">noticeNo</th>
					<th width="8%">memberNo</th>
					<th width="8%">noticeTitle</th>
					<th width="50%">noticeContent</th>
					<th width="8%">createDate</th>
					<th width="8%">updateDate</th>
					<th width="8%"></th>
				</tr>
			</thead>
			<tbody>
				<%
					for(Notice n : noticeList){
				%>
						<tr>
							<td style="display:table-cell;vertical-align:middle;"><%=n.getNoticeNo() %></td>
							<td style="display:table-cell;vertical-align:middle;"><%=n.getMemberNo() %> (
							<%
							ArrayList<Member> member = memberDao.selectMemberOne(n.getMemberNo());
							for(Member m : member){
							%>
								<%=m.getMemberName() %>
							<%	
							}
							%>
							)	
							</td>
							<td style="display:table-cell;vertical-align:middle;"><%=n.getNoticeTitle() %></td>
							<td style="display:table-cell;vertical-align:middle;"><%=n.getNoticeContent() %></td>
							<td style="display:table-cell;vertical-align:middle;"><%=n.getCreateDate() %></td>
							<td style="display:table-cell;vertical-align:middle;"><%=n.getUpdateDate() %></td>
							<td style="display:table-cell;vertical-align:middle;">
								<!-- selectEbookOne.jsp -->
								<a href="<%=request.getContextPath()%>/admin/selectNoticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>" class="btn btn-outline-secondary">상세보기</a>
							</td>
						</tr>
				<%
					}
				%>
			</tbody>	
		</table>
		
		
		<%
		if(!(noticeList).isEmpty()){
		%>
		<!-- 하단 네비게이션 바 -->
		<div style="margin: auto; text-align: center;">
			<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectNoticeList.jsp?currentPage=1">처음으로</a>
		<%
			if(currentPage != 1){
		%>
				<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectNoticeList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%
			}
			
			int lastPage = noticeDao.selectNoticeLastPage(ROW_PER_PAGE);
			
			int displayPage = 10;
			
			int startPage = ((currentPage - 1) / displayPage) * displayPage + 1;
			int endPage = startPage + displayPage - 1;
			
			for(int i=startPage; i<=endPage; i++) {
				if(endPage<=lastPage){
		%>
					<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectNoticeList.jsp?currentPage=<%=i%>"><%=i%> </a>
		<%
				} else if(endPage>lastPage){
		%>
					<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectNoticeList.jsp?currentPage=<%=i%>"><%=i%> </a>
		<%
				}
				if(i == lastPage){
					break;
				}
			}
			if(currentPage != lastPage){
			%>
				<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectNoticeList.jsp?currentPage=<%=currentPage+1%>">다음</a>
			<%
			}
			%>
			<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectNoticeList.jsp?currentPage=<%=lastPage%>">끝으로</a>
		</div>
		<%
		}
		%>
	</div>
	<jsp:include page="/partial/footer.jsp"></jsp:include>
</div>
</body>
</html>