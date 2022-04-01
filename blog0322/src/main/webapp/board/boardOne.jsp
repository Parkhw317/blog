<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo")); // boardNo 문자열을 숫자로 변환
	System.out.println(boardNo + "◀◀◀◀◀ boardNo"); // 디버깅
	
	
	Class.forName("org.mariadb.jdbc.Driver"); // 마리아DB 연결
	System.out.println("드라이버 로딩 성공"); // 마리아DB연결 디버깅
	
	String dburl = "jdbc:mariadb://localhost:3306/blog"; // 마리아DB 주소
	String dbuser = "root"; // 마리아DB 아이디
	String dbpw = "java1234"; // 마리아DB 패스워드
	Connection conn = DriverManager.getConnection(dburl, dbuser, dbpw); // 마리아DB 주소, 아이디, 패스워드 변수 conn값에 입력
	System.out.println(conn + "◀◀◀◀◀ conn"); // 디버깅
	
	
	String boardOneSql = "select board_no boardNo, category_name categoryName, board_title boardTitle, board_content boardContent, create_date createDate, update_date updateDate from board where board_no=?";
	// boardNo, categoryName, boardTitle, boardContent, createDate, updateDate 값 boardOneSql변수에 저장
	
	PreparedStatement boardOneStmt = conn.prepareStatement(boardOneSql);
	boardOneStmt.setInt(1, boardNo); // 쿼리중 ? 값이 있는 boardNo에 대해 실행 후 결과값 받음

	System.out.println(boardOneStmt + "◀◀◀◀◀ boardOneStmt"); // 디버깅

	
	ResultSet rs = boardOneStmt.executeQuery(); // ResultSet에 결과값 담기
	System.out.println(rs + "◀◀◀◀◀ rs"); // 디버깅
	
	Board board = null; // 보드변수에 빈상자(null값)지정

	while(rs.next()) {
		board = new Board(); 
		board.setBoardNo(rs.getInt("boardNo")); // 보드번호 지정
		board.setCategoryName(rs.getString("categoryName")); // 카테고리이름 지정 
		board.setBoardTitle(rs.getString("boardTitle")); // 보드타이틀 지정
		board.setBoardContent(rs.getString("boardContent"));//보드컨텐츠 지정
		board.setCreateDate(rs.getString("createDate")); //createDate 지정
		board.setUpdateDate(rs.getString("updateDate")); //updateDate 지정 
	}
	
	conn.close(); // conn 반환
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardOne</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="row">
	<div class="col-sm-12 bg-light">
	<div class="container">
	<br><h2>게시글 상세보기</h2><br>
	<table class = "table-bordered" >
	
		
		<tr>
			<td>boardNo</td>
			<td><%=board.getBoardNo()%></td>
		</tr>
		<tr>
			<td>categoryName</td>
			<td><%=board.getCategoryName()%></td>
		</tr>
		<tr>
			<td>boardTitle</td>
			<td><%=board.getBoardTitle()%></td>
		</tr>
		<tr>
			<td>boardContent</td>
			<td><%=board.getBoardContent()%></td>
		</tr>
		<tr>
			<td>createDate</td>
			<td><%=board.getCreateDate()%></td>
		</tr>
		<tr>
			<td>updateDate</td>
			<td><%=board.getUpdateDate()%></td>
		</tr>
	</table>
	
	<br>
	<div class="btn-group">
		<ul class="pagination">
		<li class="page-item">
			<a href="<%=request.getContextPath()%>/board/updateBoardForm.jsp?boardNo=<%= board.getBoardNo() %>"class="btn btn-info btn-sm" role="button">수정</a>
		</li>
  		</ul>	
			
		<ul class="pagination">
		<li class="page-item">	
			<a href="<%=request.getContextPath()%>/board/deleteBoardForm.jsp?boardNo=<%= board.getBoardNo()%>"class="btn btn-info btn-sm" role="button">삭제</a>
  		</li>
  		</ul>
    </div>
    </div>
	</div>
	</div>
	
</body>
</html>


