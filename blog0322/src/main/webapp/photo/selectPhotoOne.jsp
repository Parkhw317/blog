<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%

	request.setCharacterEncoding("utf-8");

	int photoNo = Integer.parseInt(request.getParameter("photoNo"));
	int beginRow = 0;
	int rowPerPage = 10;
	
	PhotoDao photoDao = new PhotoDao();
	
	Photo photo = new Photo();
	
	photo = photoDao.selectPhotoOne(photoNo);
	ArrayList<Photo> list = photoDao.selectPhotoListByPage(beginRow, rowPerPage);


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>photoOne</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="row">
	<div class="col-sm-12 bg-light">
	<div class="container">
	<br><h2>사진내역 상세보기</h2><br>
	<table class = "table-bordered" >
		<tr>
			<td>photoNo</td>
			<td><%=photo.photoNo%></td>
		</tr>
		<tr>
			<td>photoName</td>
			<td><img src="<%=request.getContextPath()%>/upload/<%=photo.photoName%>" width="200" height="200" ></td>
		</tr>
		<tr>
			<td>photoOriginalName</td>
			<td><%=photo.photoOriginalName%></td>
		</tr>
		<tr>
			<td>writer</td>
			<td><%=photo.writer%></td>
		</tr>
		<tr>
			<td>createDate</td>
			<td><%=photo.createDate%></td>
		</tr>
		<tr>
			<td>updateDate</td>
			<td><%=photo.updateDate%></td>
		</tr>
	</table>
		<ul class="pagination">
		<li class="page-item">	
			<a href="<%=request.getContextPath()%>/photo/deletePhotoForm.jsp?photoNo=<%= photo.photoNo %>"class="btn btn-info btn-sm" role="button">삭제</a>
  		</li>
  		</ul>
    
    </div>
	</div>
	</div>
	
</body>
</html>


