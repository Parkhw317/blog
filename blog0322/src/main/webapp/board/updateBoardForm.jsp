<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
		
	request.setCharacterEncoding("utf-8");

	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String categoryName = request.getParameter("categoryName");
	
	BoardDao boardDao = new BoardDao();
	
	Board board = new Board();
	
	board = boardDao.selectBoardOne(boardNo);
	
	ArrayList<String> list = boardDao.selectBoardCategoryName(categoryName);
	
	

	/*
	
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));	
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이버 로딩 성공");
		
	Connection conn = null;
	String dburl = "jdbc:mariadb://localhost:3306/blog"; // 주소저장dk..
	String dbuser = "root"; // 아이디 저장
	String dbpw = "java1234"; // 비번 저장
	conn = DriverManager.getConnection(dburl,dbuser,dbpw);
	System.out.println(conn+"<--conn"); // 디버깅
	
	String boardOneSql = "select board_no boardNo, category_name categoryName, board_title boardTitle, board_content boardContent, board_pw boardPw, create_date createDate, update_date updateDate from board WHERE board_no = ?";
	PreparedStatement stmt = conn.prepareStatement(boardOneSql);
	stmt.setInt(1,boardNo); // 요청받아온 boardNo값 넣기
	
	ResultSet boardOneRs = stmt.executeQuery(); // boardOneRs boardSql 쿼리로 들고온 값 저장
	System.out.println(boardOneRs + "<--boardOneRs"); // 디버깅
	
	Board board = null;
	if(boardOneRs.next()) { // true값일때만 커서 옮기면서
		board = new Board(); // board값 담을 새로운 리스트 생성
		board.boardNo = boardOneRs.getInt("boardNo");
		board.categoryName = boardOneRs.getString("categoryName");
		board.boardTitle =  boardOneRs.getString("boardTitle");
		board.boardContent = boardOneRs.getString("boardContent");
		board.createDate =  boardOneRs.getString("createDate");
		board.updateDate =  boardOneRs.getString("updateDate");
	}
	
	// category 목록
	String categorySql = "SELECT category_name categoryName FROM category";
	PreparedStatement categoryStmt = conn.prepareStatement(categorySql);
	ResultSet categoryRs = categoryStmt.executeQuery();
	ArrayList<String> categoryList = new ArrayList<String>();
	while(categoryRs.next()) { // categoryRs -> categoryList 
		categoryList.add(categoryRs.getString("categoryName"));
	}
	conn.close();
	/*
		UDATE board SET
			category_name = ?,
			board_title = ?,
			board_content = ?,
			update_date = NOW()
		WHERE board_no = ? AND board_pw = ?
	*/
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="row">
		<div class="col-sm-12 bg-light">
			<div class="container">
				<br>
				<h2>게시글 수정</h2>
				<br>
				<form method="post" action="<%=request.getContextPath()%>/board/updateBoardAction.jsp">
					<table class="table-bordered">
						<tr>
							<td>boardNo</td>
							<td><input type="text" name="boardNo" value="<%=board.getBoardNo()%>" readonly="readonly"></td>
						</tr>
						<tr>
							<td>categoryName</td>
							<td><select name="categoryName">
									<%
									for (String s : list) {
										if (s.equals(board.getCategoryName())) {
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
							</select></td>
						</tr>
						<tr>
							<td>boardTitle</td>
							<td><input type="text" name="boardTitle" value="<%=board.getBoardTitle()%>"></td>
						</tr>
						<tr>
							<td>boardContent</td>
							<td><textarea rows="5" cols="50" name="boardContent"><%=board.getBoardContent()%></textarea>
							</td>
						<tr>
							<td>boardPw</td>
							<td><input type="password" name="boardPw" value=""></td>
						</tr>
					</table>
					<br>
					<button type="submit" class="btn btn-info btn-sm" role="button">수정</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>

