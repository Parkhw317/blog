<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("utf-8"); // 한글 깨지지 않게 인코딩

	int photoNo = Integer.parseInt(request.getParameter("photoNo")); // photoNo 문자열을 숫자로 변환 후 int로 변수 선언 

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>delete Photo Form</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container p-3 my-3 bg-warning text-white">
	<h2 align="center">게시글 삭제</h2>
	</div>
	
	
	<form method="post" action="<%=request.getContextPath()%>/photo/deletePhotoAction.jsp">
	<div class="container p-3 my-3 bg-white text-black">
		삭제할 게시물 번호 : <input type="text" name="photoNo" value="<%=photoNo%>" readonly="readonly">
	</div>
	
	<div class="container p-3 my-3 bg-white text-black">
		비밀번호 : <input type="password" name="photoPw" >
	</div>
	
	<div class="container p-3 my-3 bg-white text-black">
		<a href="<%=request.getContextPath()%>/photo/photoList.jsp" class="btn btn-warning btn-sm" role="button">이전</a>
		<button type="submit" class="btn btn-warning btn-sm">삭제</button>
	</div>
	</form>
	

</body>
</html>