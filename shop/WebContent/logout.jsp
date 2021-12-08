<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	session.invalidate(); // 사용자 세션 초기화
	response.sendRedirect("index.jsp"); // 돌려보냄
%>