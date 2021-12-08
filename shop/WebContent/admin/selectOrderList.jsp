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
	
	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println("[Debug] currentPage : "+currentPage);
	
	final int ROW_PER_PAGE = 10; // rowPerPage변수 10으로 초기화되면 끝까지 10을 써야 한다. --> 상수
	
	int beginRow = (currentPage-1)*ROW_PER_PAGE;
	
	// 구현 코드
	OrderDao orderDao = new OrderDao();
	ArrayList<OrderEbookMember> list = orderDao.selectOrderList(beginRow, ROW_PER_PAGE);
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 목록</title>	<!--  관리자 주문 목록 페이지 -->
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
	<div style="text-align: center">
		<h1>[주문 관리]</h1>
	</div>
	
	<table class="table" style="text-align:center; display:table;">
		<thead>
			<tr>
				<th width="10%">order_no</th>
				<th width="15%">ebookTitle</th>
				<th width="15%">order_price</th>
				<th width="15%">memberId</th>
				<th width="15%">create_date</th>
				<th width="15%">update_date</th>
				<th width="15%"></th>
			</tr>
		</thead>
		<tbody>
			<%
				for(OrderEbookMember oem : list){
			%>
					<tr>
						<td style="display:table-cell;vertical-align:middle;"><%=oem.getOrder().getOrderNo() %></td>
						<td style="display:table-cell;vertical-align:middle;"><%=oem.getEbook().getEbookTitle() %></td>
						<td style="display:table-cell;vertical-align:middle;"><%=oem.getOrder().getOrderPrice() %></td>
						<td style="display:table-cell;vertical-align:middle;"><%=oem.getMember().getMemberId() %></td>
						<td style="display:table-cell;vertical-align:middle;"><%=oem.getOrder().getCreate_date() %></td>
						<td style="display:table-cell;vertical-align:middle;"><%=oem.getOrder().getUpdate_date() %></td>
						<td style="display:table-cell;vertical-align:middle;"><a href="<%=request.getContextPath()%>/admin/selectEbookOne.jsp?ebookNo=<%=oem.getEbook().getEbookNo() %>"  class="btn btn-outline-secondary">상품 상세보기</a></td>
					</tr>
			<%
				}
			%>
		</tbody>
	</table>
	
	<%
	if(!(list).isEmpty()){
	%>
	<!-- 하단 네비게이션 바 -->
		<div style="margin: auto; text-align: center;">
			<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectOrderList.jsp?currentPage=1">처음으로</a>
		<%
			if(currentPage != 1){
		%>
				<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectOrderList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%
			}
			
			int lastPage = orderDao.selectOrderLastPage(10);
			
			int displayPage = 10;
			
			int startPage = ((currentPage - 1) / displayPage) * displayPage + 1;
			int endPage = startPage + displayPage - 1;
			
			for(int i=startPage; i<=endPage; i++) {
				if(endPage<=lastPage){
		%>
					<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectOrderList.jsp?currentPage=<%=i%>"><%=i%> </a>
		<%
				} else if(endPage>lastPage){
		%>
					<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectOrderList.jsp?currentPage=<%=i%>"><%=i%> </a>
		<%
				}
				if(i == lastPage){
					break;
				}
			}
			if(currentPage != lastPage){
			%>
				<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectOrderList.jsp?currentPage=<%=currentPage+1%>">다음</a>
			<%
			}
			%>
			<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectOrderList.jsp?currentPage=<%=lastPage%>">끝으로</a>
		</div>
	<%
	}
	%>
	
	<!-- footer -->
	<jsp:include page="/partial/footer.jsp"></jsp:include>
</div>
</body>
</html>