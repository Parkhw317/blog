<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo")); // 변수 guestbookNo int로 값을 받아옴
	

	GuestbookDao guestbookDao = new GuestbookDao(); // 변수 선언후 초기화
	
	Guestbook guestbook = new Guestbook(); // 변수 선언후 초기화

	guestbook = guestbookDao.selectGuestbookOne(guestbookNo);  //  guestbookDao클래스의 selectGuestbookOne메소드에 guestbookNo를 마라미터로 넣어줌
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateGuestbookForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container p-3 my-3 bg-dark text-white">
	<h2 align="center">게시글 수정</h2>
	</div>
	
	
	<div class="container p-3 my-3 bg-white text-dark">
	<form method="post" action="<%=request.getContextPath()%>/guestbook/updateGuestbookAction.jsp">
		<table class="table table-bordered">
			<tr>
				<td>방명록 번호</td>
				<td><input type="text" name="guestbookNo" value="<%=guestbook.getGuestbookNo()%>" readonly="readonly"></td>
			</tr>	
			
			<tr>
				<td>글쓴이</td>
				<td><input type="text" name="writer" value="<%=guestbook.getWriter()%>"></td>
			</tr>
				
			<tr>
				<td>방명록 내용</td>
				<td>
				<textarea rows="5" cols="50" name="guestbookContent"><%=guestbook.getGuestbookContent()%></textarea>
				</td>
			</tr>	
			
			<tr>	
				<td>비밀번호</td>
				<td><input type="password" name="guestbookPw"></td>		
			</tr>
			
		
		</table>
		
		<button type = "submit" class="btn btn-success btn-sm">수정</button>
	</form>
</div>

</body>
</html>