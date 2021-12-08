<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "model.*" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %> <!-- request 대신 멀티파트 변환 -->
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %> <!-- 파일이름 중복을 막아주는 모듈 -->
<%@page import="java.io.*" %>
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
	// 1gb 제한
    int maxSize  = 1024*1024*1024;       
    // 저장할 파일 경로
    String savePath = "/var/lib/tomcat9/webapps/shop/image";
 	// multipart/form-data로 넘겼기 때문에 request.getParameter("ebookNo"); 형태 사용 불가
 	// request.getInputStream()로 받아야하지만 너무 복잡해짐
    MultipartRequest mr = new MultipartRequest(request,savePath,maxSize,"utf-8", new DefaultFileRenamePolicy());
 	
	int ebookNo = Integer.parseInt(mr.getParameter("ebookNo"));
	
	EbookDao ebookDao = new EbookDao();
	Ebook ebookList = ebookDao.selectEbookOne(ebookNo);
 	
 	// 기존 파일명
    String oldFileName = ebookList.getEbookImg();
 	// 실제로 받아온 파일명
    String ebookImg = mr.getFilesystemName("ebookImg");
 	
 	// 기존 파일 객체
    File oldFile = new File(savePath + oldFileName);
 	
 	if(oldFile.exists()){ // 기존에 똑같은 이름의 파일이 있을 경우
 		// 기존 파일명이 이전 파일명과 같지 않고 이미지 업로드 파일명이 기본값인 noimage.jpg가 아닐 경우에 기존 이미지 삭제
 	   if(!(oldFileName.equals(ebookImg) && !(ebookImg.equals("noimage.jpg")))){
 	    	// 
 	    	if(!(oldFileName.equals("noimage.jpg"))&&oldFile.exists()) {
 	    		if(oldFile.delete()) {
 	    			System.out.println("이전 파일삭제 성공");
 	    			} else {
 	    				System.out.println("이전 파일삭제 실패");
 	    				}
 	    		} else {
 	    			System.out.println("파일이 존재하지 않습니다.");
 	    		}
 	    }
 	}
	
    
	
	Ebook ebook = new Ebook();
	ebook.setEbookNo(ebookNo);
	ebook.setEbookImg(ebookImg);
			
	ebookDao.updateEbookImg(ebook);
	response.sendRedirect(request.getContextPath()+"/admin/selectEbookOne.jsp?ebookNo="+ebookNo);
%>