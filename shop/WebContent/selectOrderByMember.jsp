<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%	
//인코딩
	request.setCharacterEncoding("utf-8");
	
	// 로그인 중이 아니면 튕겨나옴
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	// 세션 유지
	session.setMaxInactiveInterval(30*60);
	
	// 구현코드
	OrderDao orderDao = new OrderDao();
	ArrayList<OrderEbookMember> list = orderDao.selectOrderListByMember(loginMember.getMemberNo());
	
	OrderCommentDao orderCommentDao = new OrderCommentDao();
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>나의 주문 목록</title>	<!-- 개인 회원 주문 목록 페이지 -->
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
	<div style="text-align: center">
		<h1>[주문 관리]</h1>
	</div>
	
	<table class="table" style="text-align:center; display:table;">
		<thead>
			<tr>
				<th>order_no</th>
				<th>ebookTitle</th>
				<th>order_price</th>
				<th>memberId</th>
				<th>create_date</th>
				<th></th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<%
				for(OrderEbookMember oem : list){
			%>
					<tr>
						<td width="15%" style="display:table-cell;vertical-align:middle;"><%=oem.getOrder().getOrderNo() %></td>
						<td width="10%" style="display:table-cell;vertical-align:middle;"><%=oem.getEbook().getEbookTitle() %></td>
						<td width="10%" style="display:table-cell;vertical-align:middle;"><%=oem.getOrder().getOrderPrice() %></td>
						<td width="10%" style="display:table-cell;vertical-align:middle;"><%=oem.getMember().getMemberId() %></td>
						<td width="15%" style="display:table-cell;vertical-align:middle;"><%=oem.getOrder().getCreate_date() %></td>
					<%
						// 해당 ebookNo의 memberNo에 해당하는 상품평이 비어있는지
						if(!(orderCommentDao.selectOrderCommentOne(oem.getEbook().getEbookNo(),oem.getMember().getMemberNo()).isEmpty())){
					%>
							<td width="15%" style="display:table-cell;vertical-align:middle;"><a href="<%=request.getContextPath()%>/selectOrderComment.jsp?ebookNo=<%=oem.getEbook().getEbookNo() %>&memberNo=<%=oem.getMember().getMemberNo() %>"  class="btn btn-outline-secondary">상품평 상세보기</a></td>
					<%
						} else {
					%>
							<td width="15%" style="display:table-cell;vertical-align:middle;"></td>
					<%
						}
					
					%>	
					<%
						ArrayList<OrderComment> commentlist = new ArrayList<>();
						
						// 해당 ebookNo의 memberNo에 해당하는 상품평이 비어있는지
						if(orderCommentDao.selectOrderCommentOne(oem.getEbook().getEbookNo(),oem.getMember().getMemberNo()).isEmpty()){
					%>
							<td width="15%" style="display:table-cell;vertical-align:middle;"><a href="<%=request.getContextPath()%>/insertOrderCommentFrom.jsp?orderNo=<%=oem.getOrder().getOrderNo()%>&ebookNo=<%=oem.getEbook().getEbookNo()%>" class="btn btn-outline-secondary">상품평</a></td>
					<%
						} else {
					%>
							<td width="15%" style="display:table-cell;vertical-align:middle;">작성함</td>
					<%
						}
					
					%>	

					</tr>
			<%
				}
			%>
		</tbody>
	</table>
	
	<!-- footer -->
	<jsp:include page="/partial/footer.jsp"></jsp:include>
</div>
</body>
</html>