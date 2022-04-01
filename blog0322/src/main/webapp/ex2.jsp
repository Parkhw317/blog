<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

	<!-- 상단 메뉴 / 좌측 메뉴 / 메인 / 아래내용... -->

	<div class="container">
		<!-- 상단 메뉴 -->
		<div class="bg-secondary">
			상단 메뉴
		</div>
		<!-- 좌측 메뉴 + 메인 -->
		<div class="row">
		<!-- 좌측 메뉴 -->
		<div class="col-sm-3 bg-warning">
			<ul class="list-group">
			  <li class="list-group-item"><a href="">좌측 메뉴</a><span class="badge bg-danger">10</span></li>
			  <li class="list-group-item"><a href="">좌측 메뉴</a><span class="badge bg-danger">25</span></li>
			  <li class="list-group-item"><a href="">좌측 메뉴</a><span class="badge bg-danger">40</span></li>
			</ul>
		
			<a href="">좌측 메뉴</a><span class="badge bg-danger">25</span>
		</div>
		<!-- 메인 -->
		<div class="col-sm-9">
			<div>
				<img src="./one.jpg">
			</div>
			<div>
				<img src="./one.jpg" class="rounded-circle" alt="Cinque Terre">
			</div>
			<div>
				<img src="./one.jpg" class="img-thumbnail" alt="Cinque Terre">
			</div>
			<div>
				<img src="./one.jpg" class="rounded" alt="Cinque Terre">
			</div>
			<div>
				<button type="button" class="btn btn-success"> BUTTON 회원가입</button><br>
				<input type="button" class="btn btn-info" value="INPUT 회원가입"><br>
				<a href="" class="btn btn-warning">A 회원가입</a><br>
			</div>
			<ul class="pagination">
			  <li class="page-item"><a class="page-link" href="#">다음</a></li>
			  <li class="page-item"><a class="page-link" href="#">이전</a></li>
			</ul>
			
			
			메인 내용
		</div>
		</div>
		<!-- 아래 내용 -->
		<div class="bg-secondary">
			<div>주소...</div>
			<div>Copyright</div>
		</div>
	</div>
</body>
</html>