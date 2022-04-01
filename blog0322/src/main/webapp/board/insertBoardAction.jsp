<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>

<%

	request.setCharacterEncoding("utf-8"); // 한글입력시 깨지지 않게 인코딩 
	
	BoardDao boardDao = new BoardDao();
	
	String categoryName = request.getParameter("categoryName");
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");
	String boardPw = request.getParameter("boardPw");
	String createDate = request.getParameter("createDate");
	String updateDate = request.getParameter("updateDate");
	
	System.out.println(categoryName + "◀◀◀◀◀ categoryName");
	System.out.println(boardTitle + "◀◀◀◀◀ boardTitle");
	System.out.println(boardContent + "◀◀◀◀◀ boardContent");
	System.out.println(boardPw + "◀◀◀◀◀ boardPw");
	
	
	Board board = new Board();
	board.setCategoryName(categoryName);
	board.setBoardTitle(boardTitle);
	board.setBoardContent(boardContent);
	board.setBoardPw(boardPw);
	board.setCreateDate(createDate);
	board.setUpdateDate(updateDate);

	boardDao.insertBoard(board);
	boardDao.selectBoardCategoryName(categoryName);
	
	response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
	
	
	/*
	
	// HTTP 요청의 파라미터 값을 얻기 위한 메소드 선언
	String categoryName = request.getParameter("categoryName"); 
	String boardTitle = request.getParameter("boardTitle"); 
	String boardContent = request.getParameter("boardContent"); 
	String boardPw = request.getParameter("boardPw"); 
	String createDate = request.getParameter("createDate");
	String updateDate = request.getParameter("updateDate");
	
	// board에 category외 값들 지정해주기
	Board board = new Board();
	board.categoryName = categoryName;
	board.boardTitle = boardTitle;
	board.boardContent = boardContent;
	board.boardPw = boardPw;
	board.createDate = createDate;
	board.updateDate = updateDate;
	
	
	Class.forName("org.mariadb.jdbc.Driver"); // 마리아DB 연결
	System.out.println("◀◀◀◀◀ 마리아DB 로딩 성공"); // 마리아DB연결 디버깅
	
	String dburl = "jdbc:mariadb://localhost:3306/blog"; // 마리아DB 주소
	String dbuser = "root"; // 마리아DB 아이디
	String dbpw = "java1234"; // 마리아DB 패스워드
	Connection conn = DriverManager.getConnection(dburl, dbuser, dbpw); // 마리아DB 주소, 아이디, 패스워드 변수 conn값에 입력
	System.out.println(conn + "◀◀◀◀◀ conn"); // 디버깅
	
	// SQL문법을 변수 boardInsertSql에 저장
	String boardInsertSql = "INSERT INTO board (category_name, board_title, board_content, board_pw, create_date, update_date) VALUES (?, ?, ?, ?, NOW(), NOW())";
	
	PreparedStatement boardInsertStmt = conn.prepareStatement(boardInsertSql);// 카테고리 sql문법 변수에 저장해놓은값 연결
	
	// 쿼리중 ? 값이 있는 board.categoryName외의 3개의 값에 대해 실행 후 결과값 받음
	boardInsertStmt.setString(1, board.categoryName);
	boardInsertStmt.setString(2, board.boardTitle);
	boardInsertStmt.setString(3, board.boardContent);
	boardInsertStmt.setString(4, board.boardPw);
	
	
	// 디버깅
	int row = boardInsertStmt.executeUpdate(); 
	
	if(row == 1) {
		System.out.println(row + "◀◀◀◀◀ 행 입력성공");
	} else {
		System.out.println(row + "◁◁◁◁◁ 행 입력실패");
	} 

	*/
	
   /*
      INSERT INTO board(
            category_name,
            board_title,
            board_content,
            board_pw,
            create_date,
            update_date
      ) VALUES (
         ?, ?, ?, ?, NOW(), NOW()
      )
   

   response.sendRedirect(request.getContextPath()+"/boardList.jsp");
	
	*/

   %>

