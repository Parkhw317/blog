<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%
	int currentPage = 1; // 현재페이지의 기본값이 1페이지
	
	if(request.getParameter("currentPage") != null) { // currentPage값이 null이 아니면, (-> 이전, 다음 링크를 통해서 들어왔다면)
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 5; // 힌 페이지당 나타내는 정보가 5개
	int beginRow = (currentPage-1)*rowPerPage; // 현재페이지가 변경되면 beginRow도 변경된다. -> 가져오는 데이터도 변경된다.
	
	GuestbookDao guestbookDao = new GuestbookDao(); // guestbookDao 객체 생성
	ArrayList<Guestbook> list = guestbookDao.selectGuestbookListByPage(beginRow, rowPerPage);  // guestbookDao클래스의 selectGuestbookListByPage메소드에 beginRow, rowPerPage를 파라미터로 넣어서 실행한 결과를 list에 넣어줌
	

	int lastPage = 0;  // 마지막 페이지 담을 lastPage 변수 선언 
	int totalCount = guestbookDao.selectGuestbookTotalRow(); // guestbookDao클래스의 selectGuestbookTotalRow메소드에 파라미터 값을 넣어줌
	
	/*
	lastPage = totalCount / rowPerPage;
	if(totalCount % rowPerPage != 0) {
		lastPage++;
	}
	
	*/
	lastPage = (int)(Math.ceil((double)totalCount / (double)rowPerPage));
	// 4.0 / 2.0 = 2.0 -> 2.0
	// 5.0 / 2.0 = 2.5 -> 3.0
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	
	<div class="container p-3 my-3 bg-dark text-white">
	<h1 align="center">Guestbook List</h1>
	</div>
	
	
		<!-- 메인 메뉴 시작-->
		<div class="container p-3 my-3 bg-white text-dark">
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		</div>
		<!-- include시 컨텍스명(프로젝트)을 명시하지 않는다. -->	
		<!-- 메인 메뉴 끝 -->
	
	
	
		<!-- 방명록 입력 -->
		<div class="container p-3 my-3 bg-white text-dark">
		<form method="post" action="<%=request.getContextPath()%>/guestbook/insertGuestbookAction.jsp">
		 <table class="table table-bordered">
			<tr class="table-secondary">
				<td>글쓴이</td>
				<td><input type="text" name="writer"></td>
				<td>비밀번호</td>
				<td><input type="password" name="guestbookPw"></td>
			</tr>
			
			 <tr class="table-active">
				<td colspan="4"><textarea name="guestbookContent" rows="2" cols="100"></textarea>
			</tr>
		
		</table>
		<button type = "submit" class="btn btn-outline-secondary btn-sm">입력</button>
		
	</form>
	</div>





	<div class="container p-3 my-3 bg-white text-dark" align="right">
<%
	if(currentPage > 1) {

%>

	<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?currentPage=<%=currentPage-1%>" class="btn btn-info" role="button">이전</a>
	
<%
	}


	if(currentPage< lastPage) {
%>	
	
	<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?currentPage=<%=currentPage+1%>" class="btn btn-info" role="button">다음</a>

<%

	}

%>
	</div>





	
	
<% 
	for(Guestbook g : list) {
%>			
	
			<div class="container p-3 my-3 bg-white text-dark">
  			<table class="table">
		 
			<tr>
				<td>글쓴이</td>
				<td><%=g.getWriter()%></td>
				<td>작성일자</td>
				<td><%=g.getCreateDate()%></td>
			</tr>
			<tr>
				<td colspan="4"><%=g.getGuestbookContent()%></td>
			</tr>
		</table>
		<div>
			<a href="<%=request.getContextPath()%>/guestbook/updateGuestbookForm.jsp?guestbookNo=<%=g.getGuestbookNo()%>" class="btn btn-outline-success btn-sm" role="button">수정</a>
			<a href="<%=request.getContextPath()%>/guestbook/deleteGuestbookForm.jsp?guestbookNo=<%=g.getGuestbookNo()%>" class="btn btn-outline-danger btn-sm" role="button">삭제</a>
		</div>
		</div>
		
		<%	
			}
		%>
			
		





</body>
</html>