<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>쇼핑몰 샘플</title>	<!-- index 페이지 -->
  <meta charset="utf-8">
  <!-- https://www.w3schools.com/ 부트스트랩 적용 -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</head>
<body>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");
	
	// 현재 페이지
	int currentPage = 1;
	
	// 로그인 상태라면 세션유지
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember != null){
		session.setMaxInactiveInterval(30*60);
	}
	
	
%>
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
		// 페이징
		if(request.getParameter("currentPage") != null){
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		System.out.println("[Debug] currentPage : "+currentPage);
		
		final int ROW_PER_PAGE = 10; // rowPerPage변수 10으로 초기화되면 끝까지 10을 써야 한다. --> 상수
		
		int beginRow = (currentPage-1)*ROW_PER_PAGE;
		
		// 화면에 표시할 버튼 갯수
		int displayPage = 10;
		
		int startPage = ((currentPage - 1) / displayPage) * displayPage + 1;
		int endPage = startPage + displayPage - 1;
		
		// 구현 코드
		EbookDao ebookDao = new EbookDao();
		ArrayList<Ebook> ebookList = new ArrayList<>();
		
		String category = "";
		if(request.getParameter("category") != null){
			category = request.getParameter("category");
		}
		
		// 목록
		if(category.equals("")){
			ebookList = ebookDao.selectEbookList(beginRow, ROW_PER_PAGE);
		} else {
			ebookList = ebookDao.selectEbookListByCategory(beginRow, ROW_PER_PAGE, category);
		}
		
		// 마지막페이지 도출
		int lastPage = ebookDao.selectEbookLastPage(ROW_PER_PAGE,category);
		
		// 인기 목록 5개(많이 주문된 5개의 ebook)
		ArrayList<Ebook> popularEbookList = ebookDao.selectPopularEbookList();
		ArrayList<Ebook> NewEbookList = ebookDao.selectNewEbookList();
		
		// 공지 최근 5개
		NoticeDao noticeDao = new NoticeDao();
		ArrayList<Notice> notice = noticeDao.selectNoticeList(0, 5);
		
		%>
	
	<!-- 최근 공지 5개 출력 -->
	<div class="container-fluid" style="text-align: center">
		<br>
		<h1>공지사항</h1>
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
	
	<!-- 상품 목록이 하나 이상 있을 경우에만 출력. -->
	<%
	if(!(ebookList).isEmpty()){
	%>
	
	<!-- 신간도서 5개 출력 -->
	<div class="container-fluid" style="text-align: center">
		<br>
		<h1>신간도서</h1>
		<br>
		<table class="table">
			<tr>
				<%
				for(Ebook e : NewEbookList)	{
				%>
				<td>
					<div><a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><img src="<%=request.getContextPath() %>/image/<%=e.getEbookImg() %>" width="170" height="200"></a></div>
					<div><a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><%=e.getEbookTitle() %></a></div>
					<div>₩ <%=e.getEbookPrice() %></div>
				</td>
				<%
				}
				%>
			</tr>
		</table>
	</div>
	
	<!-- 베스트셀러 5개 출력 -->
	<div class="container-fluid" style="text-align: center">
		<br>
		<h1>베스트셀러</h1>
		<br>
		<table class="table">
			<tr>
				<%
				for(Ebook e : popularEbookList)	{
				%>
				<td>
					<div><a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><img src="<%=request.getContextPath() %>/image/<%=e.getEbookImg() %>" width="170" height="200"></a></div>
					<div><a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><%=e.getEbookTitle() %></a></div>
					<div>₩ <%=e.getEbookPrice() %></div>
				</td>
				<%
				}
				%>
			</tr>
		</table>
	</div>
	
	
	
	<div class="container-fluid" style="text-align: center" id="EbookListID">
		<br>
		<h1>상품 목록</h1>
		<br>
		<!-- 상단 네비게이션 바
		<div style="margin: auto; text-align: center;">
			<a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/index.jsp?currentPage=1&category=<%=category%>">처음으로</a>
		<%
			if(currentPage != 1){
		%>
				<a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>">이전</a>
		<%
			}
	
			for(int i=startPage; i<=endPage; i++) {
				if(endPage<=lastPage){
		%>
					<a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=i%>&category=<%=category%>"><%=i%> </a>
		<%
				} else if(endPage>lastPage){
		%>
					<a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=i%>&category=<%=category%>"><%=i%> </a>
		<%
				}
				if(i == lastPage){
					break;
				}
			}
			if(currentPage != lastPage){
			%>
				<a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>">다음</a>
			<%
			}
			%>
			<a class="btn btn-outline-secondary" href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=lastPage%>&category=<%=category%>">끝으로</a>
		</div>
		
	-->
		<table class="table">
			<tr>
			<%
				int b = 0;
				for(Ebook e : ebookList){
			%>
					
						<td>
							<div><a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><img src="<%=request.getContextPath() %>/image/<%=e.getEbookImg() %>" width="170" height="200"></a></div>
							<div><a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><%=e.getEbookTitle() %></a></div>
							<div>₩ <%=e.getEbookPrice() %></div>
						</td>
					
			<%
					b= b+1;
					if(b%5 == 0){
			%>
					</tr><tr>
			<%			
					}
				}
			%>
			</tr>
		</table>
	</div>
	
	<!-- 하단 네비게이션 바 -->
	<div style="margin: auto; text-align: center;">
		<a class="btn btn-warning" href="<%=request.getContextPath()%>/index.jsp?currentPage=1&category=<%=category%>&scrollHeight=1">처음으로</a>
	<%
		if(currentPage != 1){
	%>
			<a class="btn btn-warning" href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>&scrollHeight=1">이전</a>
	<%
		}

		for(int i=startPage; i<=endPage; i++) {
			if(endPage<=lastPage){
	%>
				<a class="btn btn-warning" href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=i%>&category=<%=category%>&scrollHeight=1"><%=i%> </a>
	<%
			} else if(endPage>lastPage){
	%>
				<a class="btn btn-warning" href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=i%>&category=<%=category%>&scrollHeight=1"><%=i%> </a>
	<%
			}
			if(i == lastPage){
				break;
			}
		}
		if(currentPage != lastPage){
		%>
			<a class="btn btn-warning" href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>&scrollHeight=1">다음</a>
		<%
		}
		%>
		<a class="btn btn-warning" href="<%=request.getContextPath()%>/index.jsp?currentPage=<%=lastPage%>&category=<%=category%>&scrollHeight=1">끝으로</a>
	</div>
	<%
	} else {
	%>
		<div class="container-fluid" style="text-align: center">
			상품목록이 비어있습니다.
		</div>
	<%
	}
	%>
	
	<!-- footer -->
	<jsp:include page="/partial/footer.jsp"></jsp:include>
</div>
	<!-- 상품 검색을 위한 페이징 시 스크롤을 아래에 배치 -->
	<%
	if(request.getParameter("scrollHeight") != null){
	%>
		<script>document.documentElement.scrollTop = document.body.scrollHeight;</script>
	<%
	}
	%>
	<%
	if(request.getParameter("category")!="" && request.getParameter("category")!=null){
	%>
		<script>document.documentElement.scrollTop = document.body.scrollHeight;</script>
	<%
	}
	%>
</body>
</html>
