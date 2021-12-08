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
	
	String searchMemberId = "";
	
	if(request.getParameter("searchMemberId")  != null){
		searchMemberId = request.getParameter("searchMemberId");
	}
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println("[Debug] currentPage : "+currentPage);
	
	final int ROW_PER_PAGE = 10; // rowPerPage변수 10으로 초기화되면 끝까지 10을 써야 한다. --> 상수
	
	int beginRow = (currentPage-1)*ROW_PER_PAGE;
	
	// 회원목록 받아오기
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> memberList = null;
	
	if(searchMemberId.equals("") == true){
		memberList = memberDao.selectMemberListAllByPage(beginRow, ROW_PER_PAGE);
	} else {
		memberList = memberDao.selectMemberListAllBySearchMemberId(beginRow, ROW_PER_PAGE, searchMemberId);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>	<!-- 관리자 회원 목록 페이지 -->
</head>
<body>
<div class="container-fluid">
	<!-- banner include -->
	<jsp:include page="/partial/banner.jsp"></jsp:include>
		<!-- 관리자 메뉴 include -->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
		<!-- end : mainMenu include -->
	<div style="text-align: center">
		<h1>[회원 목록]</h1>
		<div>
			<!-- memberId로 검색 -->
			<form action="<%=request.getContextPath() %>/admin/selectMemberList.jsp" method="get">
				memberId : 
				<input type="text" name="searchMemberId">
				<button type="submit"  class="btn btn-outline-secondary">search</button>
			</form>
		</div>
	</div>
</div>
<div class="container-fluid">
	<table class="table" style="text-align:center; display:table;">
		<thead>
			<tr>
				<th width="5%">memberNo</th>
				<th width="10%">memberId</th>
				<th width="8%">memberLevel</th>
				<th width="9%">memberName</th>
				<th width="8%">memberAge</th>
				<th width="10%">memberGender</th>
				<th width="10%">updateDate</th>
				<th width="10%">createDate</th>
				<th width="10%">등급수정</th>
				<th width="10%">PW수정</th>
				<th width="10%">강제탈퇴</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Member m : memberList){
			%>
					<tr>
						<td style="display:table-cell;vertical-align:middle;"><%=m.getMemberNo() %></td>
						<td style="display:table-cell;vertical-align:middle;"><%=m.getMemberId() %></td>
						<td style="display:table-cell;vertical-align:middle;">
							<%
								if(m.getMemberLevel() == 0){
							%>
									<span>일반회원</span>
							<%
								} else if(m.getMemberLevel() == 1){
							%>
									<span>관리자</span>
							<%		
								}
							%>
							(<%=m.getMemberLevel() %>)
						</td>
						<td style="display:table-cell;vertical-align:middle;"><%=m.getMemberName() %></td>
						<td style="display:table-cell;vertical-align:middle;"><%=m.getMemberAge() %></td>
						<td style="display:table-cell;vertical-align:middle;"><%=m.getMemberGender() %></td>
						<td style="display:table-cell;vertical-align:middle;"><%=m.getUpdateDate() %></td>
						<td style="display:table-cell;vertical-align:middle;"><%=m.getCreateDate() %></td>
						<td style="display:table-cell;vertical-align:middle;">
							<!-- 특정회원의 등급 수정 -->
							<a href="<%=request.getContextPath()%>/admin/updateMemberLevelForm.jsp?memberNo=<%=m.getMemberNo()%>&memberName=<%=m.getMemberName()%>" class="btn btn-outline-secondary">등급수정</a>
						</td>
						<td style="display:table-cell;vertical-align:middle;">
							<!-- 특정회원의 비밀번호를 수정 -->
							<a href="<%=request.getContextPath()%>/admin/updateMemberPwForm.jsp?memberNo=<%=m.getMemberNo()%>&memberName=<%=m.getMemberName()%>" class="btn btn-outline-secondary">PW수정</a>
						</td>
						<td style="display:table-cell;vertical-align:middle;">
							<!-- 특정회원을 강제탈퇴 -->
							<a href="<%=request.getContextPath()%>/admin/deleteMemberForm.jsp?memberNo=<%=m.getMemberNo()%>&memberName=<%=m.getMemberName()%>" onclick="return confirm('정말로 탈퇴시키겠습니까?');" class="btn btn-outline-secondary">강제탈퇴</a>
						</td>
					</tr>
			<%
				}
			%>
		</tbody>	
	</table>
	
	<%
	if(!(memberList).isEmpty()){
	%>
	<!-- 하단 네비게이션 바 -->
	<div style="margin: auto; text-align: center;">
		<a class="btn btn-warning" href="./selectMemberList.jsp?currentPage=1&searchMemberId=<%=searchMemberId%>">처음으로</a>
	<%
		if(currentPage != 1){
	%>
			<a class="btn btn-warning" href="./selectMemberList.jsp?currentPage=<%=currentPage-1%>&searchMemberId=<%=searchMemberId%>">이전</a>
	<%
		}
		
		int lastPage = memberDao.selectMemberLastPage(10, searchMemberId);
		
		int displayPage = 10;
		
		int startPage = ((currentPage - 1) / displayPage) * displayPage + 1;
		int endPage = startPage + displayPage - 1;
		
		for(int i=startPage; i<=endPage; i++) {
			if(endPage<=lastPage){
	%>
				<a class="btn btn-warning" href="./selectMemberList.jsp?currentPage=<%=i%>&searchMemberId=<%=searchMemberId%>"><%=i%> </a>
	<%
			} else if(endPage>lastPage){
	%>
				<a class="btn btn-warning" href="./selectMemberList.jsp?currentPage=<%=i%>&searchMemberId=<%=searchMemberId%>"><%=i%> </a>
	<%
			}
			if(i == lastPage){
				break;
			}
		}
		if(currentPage != lastPage){
		%>
			<a class="btn btn-warning" href="./selectMemberList.jsp?currentPage=<%=currentPage+1%>&searchMemberId=<%=searchMemberId%>">다음</a>
		<%
		}
		%>
		<a class="btn btn-warning" href="./selectMemberList.jsp?currentPage=<%=lastPage%>&searchMemberId=<%=searchMemberId%>">끝으로</a>
	</div>
	<%
	}
	%>
	
	<jsp:include page="/partial/footer.jsp"></jsp:include>
</div>
</body>
</html>