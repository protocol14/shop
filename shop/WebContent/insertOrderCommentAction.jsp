<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="vo.*" %>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");
	
	// 값 가져와서 변수선언
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	int orderScore = Integer.parseInt(request.getParameter("orderScore"));
	String orderContent = request.getParameter("orderContent");
	
	// 디버그
	System.out.println("orderNo : " + orderNo);
	System.out.println("memberNo : " + memberNo);
	System.out.println("ebookNo : " + ebookNo);
	System.out.println("orderScore : " + orderScore);
	System.out.println("orderContent : " + orderContent);

	// 방어코드
	if(request.getParameter("orderContent") == null || request.getParameter("orderContent").equals("")) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	// 줄바꿈 변환
	orderContent = orderContent.replaceAll("\r\n|\n", "<br>");

	// dao, vo
	OrderCommentDao orderCommentDao = new OrderCommentDao();
	OrderComment orderComment = new OrderComment();
	
	// vo에 값 셋팅
	orderComment.setOrderNo(orderNo);
	orderComment.setMemberNo(memberNo);
	orderComment.setEbookNo(ebookNo);
	orderComment.setOrderScore(orderScore);
	orderComment.setOrderContent(orderContent);
	
	// orderCommentDao.insertComment 호출
	orderCommentDao.insertComment(orderComment);
	
	// 디버그
	System.out.println("상품평 추가 성공");
	
	// 돌려보냄
	response.sendRedirect(request.getContextPath() + "/selectOrderByMember.jsp");


%>