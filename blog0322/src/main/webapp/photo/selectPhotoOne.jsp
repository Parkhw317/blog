<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%

	request.setCharacterEncoding("utf-8"); // 한글 깨지지 않게 인코딩


	int photoNo = Integer.parseInt(request.getParameter("photoNo")); // photoNo 문자열을 숫자로 변환 후 int로 변수 선언 
	int beginRow = 0; // 시작페이지 0
	int rowPerPage = 10; // 한 페이지당 나타내는 정보가 10개
	
	PhotoDao photoDao = new PhotoDao();  // photoDao 객체 생성
	
	Photo photo = new Photo(); // photo 객체 생성
	
	photo = photoDao.selectPhotoOne(photoNo); // photoDao클래스의 selectPhotoOne메소드에 photoNo를 파라미터로 넣어서 실행한 결과를 photo에 넣어줌
	
	ArrayList<Photo> list = photoDao.selectPhotoListByPage(beginRow, rowPerPage);  // photoDao클래스의 selectPhotoListByPage메소드에 beginRow, rowPerPage를 파라미터로 넣어서 실행한 결과를 list에 넣어줌
	


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>photoOne</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container p-3 my-3 bg-warning text-white">
	<h2 align="center">사진내역 상세보기</h2>
	</div>
	
	
	<div class="container p-3 my-3 bg-white text-black">
	<table class = "table-bordered">
		<tr>
			<td>photoNo</td>
			<td><%=photo.getPhotoNo()%></td>
		</tr>
		<tr>
			<td>photoName</td>
			<td><img src="<%=request.getContextPath()%>/upload/<%=photo.getPhotoName()%>" width="200" height="200" ></td>
		</tr>
		<tr>
			<td>photoOriginalName</td>
			<td><%=photo.getPhotoOriginalName()%></td>
		</tr>
		<tr>
			<td>writer</td>
			<td><%=photo.getWriter()%></td>
		</tr>
		<tr>
			<td>createDate</td>
			<td><%=photo.getCreateDate()%></td>
		</tr>
		<tr>
			<td>updateDate</td>
			<td><%=photo.getUpdateDate()%></td>
		</tr>
	</table>
	</div>
	
		<div class="container p-3 my-3 bg-white text-black">
		<ul class="pagination">
		<li class="page-item">	
			<a href="<%=request.getContextPath()%>/photo/photoList.jsp" class="btn btn-warning btn-sm" role="button">이전</a>
			<a href="<%=request.getContextPath()%>/photo/deletePhotoForm.jsp?photoNo=<%= photo.getPhotoNo() %>"class="btn btn-warning btn-sm" role="button">삭제</a>
  		</li>
  		</ul>
    	</div>
    

	
</body>
</html>


