<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<!-- 
		1) html5 = html5(컨텐츠) + css3(스타일) + javascript(태그에 기능 부여)
		
		2) css 문법
		선택자 {속성:값;}
			1) 태그이름 : 거의 사용하지 않는다. 태그의 디폴트 스타일을 적용할때만 사용
			2) 클래스 속성
			3) 아이디 속성
		
	 -->
	 
	 <style>
	 	/* div {align-content: center; color:red;}
	 	div {text-align: center;}*/ 
	 	
	 	/* id="t1"인 태그의 컬러를 빨간색
	 	#t1 {color:red;}
	 	#t2 {color:red;} */
	 	
	 	.r {color:red;}
	 	.g {color:green;}
	 	.b {color:blue;}
	 	
	 	
	 </style>
	

	
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>
<!-- <div class=".container-fluid">  -->

<div class="row">
	<div class="col-sm-2">
	
	</div>
	
	<div class="col-sm-10">
			<table class="table table-dark table-hover">
			<thead>
				<tr>
					<th>번호</th>
					<th>이름</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>1</th>
					<th>강민창</th>
				</tr>
				<tr>
					<th>2</th>
					<th>강한빛</th>
				</tr>
				<tr>
					<th>3</th>
					<th>구혜민</th>
				</tr>
				<tr>
					<th>4</th>
					<th>김득환</th>
				</tr>
			</tbody>
		</table>
	
	
	</div>
</div>

	<div class="text-danger">구디아카데미</div>



	
	<!-- <div id="t1" class="r">abc</div>
	<div>가나다</div>
	<span id="t2" class="b">자바</span> */ -->
	
	
</body>
</html>