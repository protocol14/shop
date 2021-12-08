<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");
	
	int orderCommentNo = Integer.parseInt(request.getParameter("orderCommentNo"));
	
	
	OrderCommentDao orderCommentDao = new OrderCommentDao();
	orderCommentDao.deleteOrderComment(orderCommentNo);
	
	response.sendRedirect(request.getContextPath()+"/admin/selectOrderCommentList.jsp");
%>