<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<br>
	<div class="container p-3 my-3 bg-primary text-white">
		<h2 align="center">[ I N D E X ]</h2>
	</div>
	<div class="container p-3 my-3 bg-white text-black">
		<br> <a href="<%=request.getContextPath()%>/board/boardList.jsp" class="btn btn-outline-secondary btn-block" role="button">게시판 바로가기</a><br>
		<br> <a href="<%=request.getContextPath()%>/photo/photoList.jsp" class="btn btn-outline-secondary btn-block" role="button">갤러리 바로가기</a><br>
		<br> <a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp" class="btn btn-outline-secondary btn-block" role="button">방명록 바로가기</a><br>
		<br> <a href="<%=request.getContextPath()%>" class="btn btn-outline-secondary btn-block" role="button">PDF자료실 바로가기</a>
	</div>
</body>
</html>