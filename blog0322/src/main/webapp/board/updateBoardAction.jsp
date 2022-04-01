<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<% 
	
	request.setCharacterEncoding("utf-8");

	BoardDao boardDao = new BoardDao();
	
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String categoryName = request.getParameter("categoryName");
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");
	
	
	System.out.println(boardNo + "◀◀◀◀◀ boardNo");
	System.out.println(categoryName + "◀◀◀◀◀ categoryName");
	System.out.println(boardTitle + "◀◀◀◀◀ boardTitle");
	System.out.println(boardContent + "◀◀◀◀◀ boardContent");
	
	Board board = new Board();
	board.setBoardNo(boardNo);
	board.setCategoryName(categoryName);
	board.setBoardTitle(boardTitle);
	board.setBoardContent(boardContent);
	
	int row = 0;
	row = boardDao.updateBoard(board);
	
	if(row == 0){
		System.out.println("수정 실패");
		response.sendRedirect(request.getContextPath()+"/board/updateBoardForm.jsp?boardNo=" + board.getBoardNo());
	} else if(row == 1) { // 수정된 행이 1개라면 수정 성공
		System.out.println("수정 성공");
		response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
	} else { // 수정된 행이 여러개라면 오류
		System.out.println("에러");
	
	}
	
	


	/*

	request.setCharacterEncoding("utf-8"); // 한글 입력시에도 글자 깨짐 방지용 인코딩
	
	int boardNo = Integer.parseInt(request.getParameter("boardNo")); // boardNo 문자열->숫자열로 변수 (페이지에서 사용자가 실행한)boardno에 받기
	String categoryName = request.getParameter("categoryName"); // categoryName변수에 (페이지에서 사용자가 실행한)categoryName에 받기 
	String boardTitle = request.getParameter("boardTitle"); // boardTitle변수에 (페이지에서 사용자가 실행한)boardTitle에 받기 
	String boardContent = request.getParameter("boardContent"); // boardContent변수에 (페이지에서 사용자가 실행한)boardContent에 받기 
	
	
	Board board = new Board(); // board에 boardNo, categoryName, boardTitle, boardContent 묶기
	board.boardNo = boardNo;
	board.categoryName = categoryName;
	board.boardTitle = boardTitle;
	board.boardContent = boardContent;
	
	
	Class.forName("org.mariadb.jdbc.Driver"); // 마리아DB 연결
	System.out.println("◀◀◀◀◀ 드라이버 로딩 성공"); // 마리아DB연결 디버깅

	Connection conn = null;
	String dburl = "jdbc:mariadb://localhost:3306/blog"; // 마리아DB 주소
	String dbuser = "root"; // 마리아DB 아이디
	String dbpw = "java1234"; // 마리아DB 패스워드
	conn = DriverManager.getConnection(dburl,dbuser,dbpw);// 마리아DB 주소, 아이디, 패스워드 변수 conn값에 입력
	System.out.println(conn+"◀◀◀◀◀ conn"); // 디버깅
	
	String updateBoardSql = "UPDATE board SET category_name = ?, board_title = ?, board_content = ?, update_date = now() WHERE board_no = ?" ;
	PreparedStatement updateBoardStmt = conn.prepareStatement(updateBoardSql);
	updateBoardStmt.setString(1, categoryName); // 쿼리중 ? 값이 있는 categoryName에 대해 실행 후 결과값 받음
	updateBoardStmt.setString(2, boardTitle); // 쿼리중 ? 값이 있는 boardTitle에 대해 실행 후 결과값 받음
	updateBoardStmt.setString(3, boardContent); // 쿼리중 ? 값이 있는 boardContent에 대해 실행 후 결과값 받음
	updateBoardStmt.setInt(4, board.boardNo); // 쿼리중 ? 값이 있는 boardNo에 대해 실행 후 결과값 받음

int row = updateBoardStmt.executeUpdate();
	
	if(row == 0) { // 디버깅 
		System.out.println("■■■■■■■■■■ 수정 실패 ■■■■■■■■■■");
		response.sendRedirect("./updateBoardForm.jsp?boardNo="+board.boardNo);
	} else if(row == 1) {
		System.out.println("■■■■■■■■■■ 수정 성공 ■■■■■■■■■■");
		response.sendRedirect("./boardOne.jsp?boardNo=" +board.boardNo);
	} else {
		System.out.println("■■■■■■■■■■ ?????? ■■■■■■■■■■");
	}
	
	
	conn.close(); // conn 값 반환
	
	*/
%>

