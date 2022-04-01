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
</head>
<body>
	<!-- 메인 메뉴 시작-->
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<!-- include시 컨텍스명(프로젝트)을 명시하지 않는다. -->	
	<!-- 메인 메뉴 끝 -->

<% 
	for(Guestbook g : list) {
%>
		<table border="1">
			<tr>
				<td><%=g.writer%></td>
				<td><%=g.createDate%></td>
			</tr>
			<tr>
				<td colspan="2"><%=g.guestbookContent%></td>
			</tr>
		</table>
		<div>
			<a href="<%=request.getContextPath()%>/guestbook/updateGuestbookForm.jsp?guestbookNo=<%=g.guestbookNo%>">수정</a>
			<a href="<%=request.getContextPath()%>/guestbook/deleteGuestbookForm.jsp?guestbookNo=<%=g.guestbookNo%>">삭제</a>
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

	<!-- 방명록 입력 -->
	<form method="post" action="<%=request.getContextPath()%>/guestbook/insertGuestbookAction.jsp">
		<table border = "1">
			<tr>
				<td>글쓴이</td>
				<td><input type="text" name="writer"></td>
				<td>비밀번호</td>
				<td><input type="password" name="guestbookPw"></td>
			</tr>
			<tr>
				<td colspan="4"><textarea name="guestbookContent" rows="2" cols="70"></textarea>
			
			</tr>
		
		</table>
		<button type = "submit">입력</button>
	</form>



</body>
</html>