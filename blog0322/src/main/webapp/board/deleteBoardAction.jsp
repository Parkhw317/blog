<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%

	request.setCharacterEncoding("utf-8"); // 한글 꺠지지 않게 인코등
	
	BoardDao boardDao = new BoardDao(); // boardDao 객체 생성

	int boardNo = Integer.parseInt(request.getParameter("boardNo")); // boardNo 문자열을 숫자로 변환 후 int로 변수 선언 
	String boardPw = request.getParameter("boardPw"); // boardPw 변수 선언
	
	System.out.println(boardNo + "◀◀◀◀◀ boardNo"); // 디버깅
	System.out.println(boardPw + "◀◀◀◀◀ boardPw"); // 디버깅

	Board board = new Board(); // board 객체 생성
	board.setBoardNo(boardNo); // board 객체내에 boardNo 값 set
	board.setBoardPw(boardPw); // board 객체내에 boardPw 값 set
	
	
	int row = 0; // int row 기본값으로 선언
	row = boardDao.deleteBoard(boardNo, boardPw); // boardDao클래스의 deleteBoard메소드에 boardNo, boardPw를 파라미터로 넣어서 실행한 결과를 row에 넣어줌
	
	if(row == 0) { // row 값이 0과 같을 때 삭제 실패
		System.out.println("삭제 실패");
		response.sendRedirect(request.getContextPath()+"/board/deleteBaordForm.jsp?boardNo=" + board.getBoardNo());
	} else if(row == 1) { // row 값이 1과 같을 때 삭제 성공
		System.out.println("삭제 성공");
		response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
	} else { // 그 외 오류
		System.out.println("에러");
	}

%>
<% 

	// 이전 코딩
	
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


