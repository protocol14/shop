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
	
	boolean donAnswer = false;
	if(request.getParameter("donAnswer") != null){
		donAnswer = Boolean.parseBoolean(request.getParameter("donAnswer"));
	}
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println("[Debug] currentPage : "+currentPage);
	
	final int ROW_PER_PAGE = 10; // rowPerPage변수 10으로 초기화되면 끝까지 10을 써야 한다. --> 상수
	
	int beginRow = (currentPage-1)*ROW_PER_PAGE;
	
	
	// 체크박스 체크 여부에 따라 답글을 달지 않은 qna 목록 출력 결정
	QnaDao qnaDao = new QnaDao();
	QnaCommentDao qnaCommentDao = new QnaCommentDao();
	ArrayList<Qna> qnaList = new ArrayList<>();
	if(donAnswer == false){
		qnaList = qnaDao.selectQnaList(beginRow, ROW_PER_PAGE);
	} else if(donAnswer == true){
		qnaList = qnaCommentDao.selectNotAnswerQnaList(beginRow, ROW_PER_PAGE);
	}
	
	MemberDao memberDao = new MemberDao();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 목록</title>	<!-- 관리자 문의 목록 페이지 -->
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
		<h1>[Qna 게시판 관리]</h1>
		<br>
		<%
		if(donAnswer==false){
		%>
			답변하지 않은 글만 보기 <input type="checkbox" class="qnaDonAnswer">
		<%
		} else if(donAnswer==true){
		%>
			답변하지 않은 글만 보기 <input type="checkbox" class="qnaDonAnswer" checked>
		<%
		}
		%>
	</div>
	
	<!-- 전자책 목록 출력 : 카테고리별 출력 -->
	<div class="container-fluid">
		<table class="table" style="text-align:center; display:table;">
			<thead>
				<tr>
					<th width="15%">qna_no</th>
					<th width="10%">qna_category</th>
					<th width="15%">qna_title</th>
					<th width="8%">member_no</th>
					<th width="12%">createDate</th>
					<th width="12%">updateDate</th>
					<th width="8%">상태</th>
					<th width="25%"></th>
				</tr>
			</thead>
			<tbody>
				<%
					for(Qna q : qnaList){
				%>
						<tr>
							<td style="display:table-cell;vertical-align:middle;"><%=q.getQnaNo() %></td>
							<td style="display:table-cell;vertical-align:middle;"><%=q.getQnaCategory() %></td>
							<td style="display:table-cell;vertical-align:middle;"><%=q.getQnaTitle() %></td>
							<td style="display:table-cell;vertical-align:middle;"><%=q.getMemberNo() %>(
							<%
							ArrayList<Member> member = memberDao.selectMemberOne(q.getMemberNo());
							for(Member m : member){
							%>
								<%=m.getMemberName() %>
							<%	
							}
							%>
							)	
							</td>
							<td style="display:table-cell;vertical-align:middle;"><%=q.getCreateDate() %></td>
							<td style="display:table-cell;vertical-align:middle;"><%=q.getUpdateDate() %></td>
							<td style="display:table-cell;vertical-align:middle;">
							<%
							boolean qnaState = qnaCommentDao.selectQnaAnswerState(q.getQnaNo());
							if(qnaState == true){
							%>
							답변완료
							<%
							}
							%>
							</td>
							<td style="display:table-cell;vertical-align:middle;">
								<!-- selectEbookOne.jsp -->
								<a href="<%=request.getContextPath()%>/admin/selectQnaOne.jsp?qnaNo=<%=q.getQnaNo()%>" class="btn btn-outline-secondary">상세보기</a>
							</td>
						</tr>
				<%
					}
				%>
			</tbody>	
		</table>
		
		
		<%
		if(!(qnaList).isEmpty()){
		%>
		<!-- 하단 네비게이션 바 -->
		<div style="margin: auto; text-align: center;">
			<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectQnaList.jsp?currentPage=1">처음으로</a>
		<%
			if(currentPage != 1){
		%>
				<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectQnaList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%
			}
			
			int lastPage = qnaDao.selectQnaLastPage(ROW_PER_PAGE);
			
			int displayPage = 10;
			
			int startPage = ((currentPage - 1) / displayPage) * displayPage + 1;
			int endPage = startPage + displayPage - 1;
			
			for(int i=startPage; i<=endPage; i++) {
				if(endPage<=lastPage){
		%>
					<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectQnaList.jsp?currentPage=<%=i%>"><%=i%> </a>
		<%
				} else if(endPage>lastPage){
		%>
					<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectQnaList.jsp?currentPage=<%=i%>"><%=i%> </a>
		<%
				}
				if(i == lastPage){
					break;
				}
			}
			if(currentPage != lastPage){
			%>
				<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectQnaList.jsp?currentPage=<%=currentPage+1%>">다음</a>
			<%
			}
			%>
			<a class="btn btn-warning" href="<%=request.getContextPath()%>/admin/selectQnaList.jsp?currentPage=<%=lastPage%>">끝으로</a>
		</div>
	<%
		}
	%>
	</div>
	
	<!-- footer -->
	<jsp:include page="/partial/footer.jsp"></jsp:include>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	// 체크박스 체크 -> 답글달지 않은 글 목록만 보기 
	$(document).ready(function(){
	    $(".qnaDonAnswer").change(function(){
	        if($(".qnaDonAnswer").is(":checked")){
	            location.replace('<%=request.getContextPath() %>/admin/selectQnaList.jsp?donAnswer=true');
	        }else{
	        	location.replace('<%=request.getContextPath() %>/admin/selectQnaList.jsp?donAnswer=false');
	        }
	    });
	});
</script>

</body>
</html>