<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo")); // 방명록번호 값 받아오기
	
			
			

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
	<h2 align="center">게시글 삭제</h2>
	</div>
	
	<div class="container p-3 my-3 bg-white text-dark">
	<form method="post" action="<%=request.getContextPath()%>/guestbook/deleteGuestbookAction.jsp">
		<table class="table table-bordered">
			<tr>
				<td>방명록 번호</td>
				<td><input type="text" name="guestbookNo" value="<%=guestbookNo%>" readonly="readonly"></td>
			</tr>	
			
			<tr>	
				<td>비밀번호</td>
				<td><input type="password" name="guestbookPw"></td>		
			</tr>
			
		
		</table>
		
		<button type = "submit" class="btn btn-danger btn-sm" value="Input Button">삭제</button>
	</form>
</div>












</body>
</html>