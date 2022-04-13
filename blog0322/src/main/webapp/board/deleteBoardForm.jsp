<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("utf-8"); // 한글 꺠지지 않게 인코딩

	int boardNo = Integer.parseInt(request.getParameter("boardNo")); // boardNo 문자열을 숫자로 변환 후 int로 변수 선언 


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
	<br><h2>게시글 삭제</h2><br>
	<form method="post" action="<%=request.getContextPath()%>/board/deleteBoardAction.jsp">
	<div>
		삭제할 게시물 번호 : <input type="text" name="boardNo" value="<%=boardNo%>" readonly="readonly">
	</div>
	<div>
		비밀번호 : <input type="password" name="boardPw" >
	</div>
	<div>
		<br><button type="submit" class="btn btn-info btn-sm">삭제</button>
	</div>
	</form>
	</div>
	</div>
</div>
</body>
</html>