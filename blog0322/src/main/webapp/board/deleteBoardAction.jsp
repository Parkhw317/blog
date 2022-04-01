<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%

	request.setCharacterEncoding("utf-8");
	
	BoardDao boardDao = new BoardDao();

	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String boardPw = request.getParameter("boardPw");
	
	System.out.println(boardNo + "◀◀◀◀◀ boardNo"); // 디버깅
	System.out.println(boardPw + "◀◀◀◀◀ boardPw"); // 디버깅

	Board board = new Board();
	board.setBoardNo(boardNo);
	board.setBoardPw(boardPw);
	
	
	int row = 0;
	row = boardDao.deleteBoard(boardNo, boardPw);
	
	if(row == 0) {	
		System.out.println("삭제 실패");
		response.sendRedirect(request.getContextPath()+"/board/deleteBaordForm.jsp?boardNo=" + board.getBoardNo());
	} else if(row == 1) {
		System.out.println("삭제 성공");
		response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
	} else {
		System.out.println("에러");
	}

%>


	/* 
	request.setCharacterEncoding("utf-8");
	
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));

	
	Board board = new Board();
	board.boardNo = boardNo;

	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	String dburl = "jdbc:mariadb://localhost:3306/blog";
	String dbuser = "root";
	String dbpw = "java1234";
	conn = DriverManager.getConnection(dburl, dbuser, dbpw);
	System.out.println(conn + "◀◀◀◀◀ 마리아DB 서버연결성공");
	
	String boardDeleteSql = "delete from board where board_No=?";
	PreparedStatement boardDeleteStmt = conn.prepareStatement(boardDeleteSql);
	boardDeleteStmt.setInt(1, board.boardNo);

	
	
	int row = boardDeleteStmt.executeUpdate();
	
	if (row == 0) {
		response.sendRedirect("./deleteBoardForm.jsp?boardNo="+board.boardNo);
		System.out.println("◁◁◁◁◁ 삭제 실패");
	} else if (row == 1) {
		response.sendRedirect("./boardList.jsp");
		System.out.println("◀◀◀◀ 삭제 성공");
	} else {
		System.out.println("-----Error-----");
	}
	
	
	conn.close();

	*/
%>


