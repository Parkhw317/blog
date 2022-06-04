<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("utf-8");

	int photoNo = Integer.parseInt(request.getParameter("photoNo"));

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>delete Photo Form</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<div class="row">
		<div class="col-sm-12 bg-light">
			<div class="container">
				<br>
				<h2>게시글 삭제</h2>
				<br>
				<form method="post" action="<%=request.getContextPath()%>/photo/deletePhotoAction.jsp">
					<div>
						삭제할 게시물 번호 : <input type="text" name="photoNo" value="<%=photoNo%>" readonly="readonly">
					</div>
					<div>
						비밀번호 : <input type="password" name="photoPw">
					</div>
					<div>
						<br>
						<button type="submit" class="btn btn-info btn-sm">삭제</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>