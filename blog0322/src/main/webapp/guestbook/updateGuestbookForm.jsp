<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo")); // 변수 guestbookNo int로 값을 받아옴
	

	GuestbookDao guestbookDao = new GuestbookDao(); // 변수 선언후 초기화
	
	Guestbook guestbook = new Guestbook(); // 변수 선언후 초기화

	guestbook = guestbookDao.selectGuestbookOne(guestbookNo); // guestbookNo로 selectGuestbookOne 메소드를 실행하여 변수 guestbook에 넣어줌 
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateGuestbookForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body class = "container">
	<div class="container p-3 my-3 bg-primary text-white">
	<h2 align="center">게시글 수정</h2>
	</div>
	<form method="post" action="<%=request.getContextPath()%>/guestbook/updateGuestbookAction.jsp">
		<table class="table">
			<tr>
				<td>방명록 번호</td>
				<td><input type="text" name="guestbookNo" value="<%=guestbook.guestbookNo%>" readonly="readonly"></td>
			</tr>	
			
			<tr>
				<td>글쓴이</td>
				<td><input type="text" name="writer" value="<%=guestbook.writer%>"></td>
			</tr>
				
			<tr>
				<td>방명록 내용</td>
				<td>
				<textarea rows="5" cols="50" name="guestbookContent"><%=guestbook.guestbookContent%></textarea>
				</td>
			</tr>	
			
			<tr>	
				<td>비밀번호</td>
				<td><input type="password" name="guestbookPw"></td>		
			</tr>
			
		
		</table>
		<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp" class="btn btn-secondary btn-sm" role="button">이전</a>
		<button type="submit" class="btn btn-outline-primary btn-sm">수정</button>
	</form>
	

</body>
</html>