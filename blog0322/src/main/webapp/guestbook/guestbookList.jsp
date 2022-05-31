<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	int beginRow = (currentPage-1)*rowPerPage;
	GuestbookDao guestbookDao = new GuestbookDao();
	ArrayList<Guestbook> list = guestbookDao.selectGuestbookListByPage(beginRow, rowPerPage);
	

	int lastPage = 0;
	int totalCount = guestbookDao.selectGuestbookTotalRow();
	
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
<div class="container">
<br>
	<!-- 메인 메뉴 시작-->
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<!-- include시 컨텍스명(프로젝트)을 명시하지 않는다. -->	
	<!-- 메인 메뉴 끝 -->
<br>
<br>
<% 
	for(Guestbook g : list) {
%>
		<table class="table">
			<tr>
				<td><strong>작성자</strong></td>
				<td><%=g.writer%></td>
				<td><strong>작성일자</strong></td>
				<td><%=g.createDate%></td>
			</tr>
			<tr>
				<td><strong>방명록</strong></td>
				<td colspan="4"><%=g.guestbookContent%></td>
			</tr>
		</table>
		<div>
			<a href="<%=request.getContextPath()%>/guestbook/updateGuestbookForm.jsp?guestbookNo=<%=g.guestbookNo%>" class="btn btn-primary btn-sm" role="button">수정</a>
			<a href="<%=request.getContextPath()%>/guestbook/deleteGuestbookForm.jsp?guestbookNo=<%=g.guestbookNo%>" class="btn btn-warning btn-sm" role="button">삭제</a>
		</div>
<%	
	}
	
	if(currentPage > 1) {

%>

	<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?currentPage=<%=currentPage-1%>">이전</a>
	
<%
	}


	if(currentPage< lastPage) {
%>	
	
	<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?currentPage=<%=currentPage+1%>">다음</a>

<%

	}

%>
	</div>
	<!-- 방명록 입력 -->
	<div class="container p-5 my-5 border">
	<form method="post" action="<%=request.getContextPath()%>/guestbook/insertGuestbookAction.jsp">
		<table class="table">
			<h4>방명록 작성하기</h4>
			<tr>
				<td><strong>글쓴이</strong></td>
				<td><input type="text" name="writer"></td>
			</tr>
			<tr>	
				<td><strong>비밀번호</strong></td>
				<td><input type="password" name="guestbookPw"></td>
			</tr>
			<tr>
				<td><strong>방명록</strong></td>
				<td>
				<textarea name="guestbookContent" rows="2" cols="50" ></textarea>
				</td>
			</tr>
		</table>
		<button type = "submit" class="btn btn-info btn-sm">입력</button>
	</form>
	</div>


</body>
</html>