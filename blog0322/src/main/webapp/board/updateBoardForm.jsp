<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
		
	request.setCharacterEncoding("utf-8"); // 한글 꺠지지 않게 인코딩 

	int boardNo = Integer.parseInt(request.getParameter("boardNo")); // boardNo 문자열을 숫자로 변환 후 int로 변수 선언
	String categoryName = request.getParameter("categoryName"); // catrgoryName 변수선언
	
	BoardDao boardDao = new BoardDao(); // boardDao 객체 생성 
	
	Board board = new Board(); // board 객체 생성 
	
	board = boardDao.selectBoardOne(boardNo); // boardDao클래스의 selectBoardOne메소드에 boardNo를 파라미터로 넣음 
	
	// boardDao클래스의 selectBoardCategoryName메소드에 categoryName을 파라미터로 넣어서 실행한 결과를 ArrayList에 넣어줌
	ArrayList<String> list = boardDao.selectBoardCategoryName(categoryName); // 
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="row">
	<div class="col-sm-12 bg-light">
	<div class="container">
	<br><h2>게시글 수정</h2><br>
	<form method="post" action="<%=request.getContextPath()%>/board/updateBoardAction.jsp">
		<table class = "table-bordered">
			<tr>
				<td>boardNo</td>
				<td><input type="text" name="boardNo" value="<%=board.getBoardNo()%>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>categoryName</td>
				<td>
					<select name="categoryName">
						<%
							for(String s : list) {
								if(s.equals(board.getCategoryName())) {
						%>
									<option selected="selected" value="<%=s%>"><%=s%></option>
						<%
								} else {
						%>
									<option value="<%=s%>"><%=s%></option>
						<%		
								}
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td>boardTitle</td>
				<td><input type="text" name="boardTitle" value="<%=board.getBoardTitle()%>"></td>
			</tr>
			<tr>
				<td>boardContent</td>
				<td>
					<textarea rows="5" cols="50" name="boardContent"><%=board.getBoardContent()%></textarea>
				</td>
			<tr>	
				<td>boardPw</td>
				<td><input type="password" name="boardPw" value=""></td>
			</tr>
		</table>
		<br><button type="submit" class="btn btn-info btn-sm" role="button">수정</button>
		
	</form>
	</div>
	</div>
	</div>
</body>
</html>

