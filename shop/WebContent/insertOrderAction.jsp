<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>

<%
	// 인코딩
	request.setCharacterEncoding("utf-8");

	//받은 값에 null이 있으면 되돌아감
	if(request.getParameter("ebookNo") == null || request.getParameter("ebookNo").equals("") ){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	} else if(request.getParameter("memberNo") == null || request.getParameter("memberNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	} else if(request.getParameter("orderPrice") == null || request.getParameter("orderPrice").equals("")){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	// 값 받아와서 변수선언
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	int orderPrice = Integer.parseInt(request.getParameter("orderPrice"));
	
	// request값 디버깅
	System.out.println("[Debug] ebookNo : "+ebookNo);
	System.out.println("[Debug] memberNo : "+memberNo);
	System.out.println("[Debug] orderPrice : "+orderPrice);
	
	// dao, vo
	OrderDao orderDao = new OrderDao();
	Order order = new Order();
	
	// vo에 값 셋팅
	order.setEbookNo(ebookNo);
	order.setMemberNo(memberNo);
	order.setOrderPrice(orderPrice);
	
	// 디버그
	System.out.println("[Debug] order : "+order);
	
	// orderDao.insertOrderByMember 호출
	orderDao.insertOrderByMember(order);
	
	// 돌려보냄
	response.sendRedirect(request.getContextPath()+"/orderComplete.jsp?memberNo="+memberNo+"&ebookNo="+ebookNo);
	
%>