<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("utf-8");

	int boardNo = Integer.parseInt(request.getParameter("boardNo"));

	


	/*
	
	request.setCharacterEncoding("utf-8");
	
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String categoryName = request.getParameter("categoryName");
	

	System.out.println(request.getParameter("boardNo") + "◀◀◀◀◀ 게시글 번호");
	System.out.println(request.getParameter("categoryName") + "◀◀◀◀◀ 게시글 이름");

	
	*/
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<div class="row">
		<div class="col-sm-12 bg-light">
			<div class="container">
				<br>
				<h2>게시글 삭제</h2>
				<br>
				<form method="post" action="<%=request.getContextPath()%>/board/deleteBoardAction.jsp">
					<div>
						삭제할 게시물 번호 : <input type="text" name="boardNo" value="<%=boardNo%>" readonly="readonly">
					</div>
					<div>
						비밀번호 : <input type="password" name="boardPw">
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