<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>

<%

	request.setCharacterEncoding("utf-8"); // 한글입력시 깨지지 않게 인코딩 
	
	BoardDao boardDao = new BoardDao(); // boardDao 객체 생성
	
	
	String categoryName = request.getParameter("categoryName"); // catrgoryName 변수선언
	String boardTitle = request.getParameter("boardTitle"); // boardTitle 변수선언
	String boardContent = request.getParameter("boardContent"); // boardContent 변수선언
	String boardPw = request.getParameter("boardPw"); // boardPw 변수선언
	String createDate = request.getParameter("createDate"); // createDate 변수선언
	String updateDate = request.getParameter("updateDate"); // updateDate 변수선언
	
	// 디버깅
	System.out.println(categoryName + "◀◀◀◀◀ categoryName"); 
	System.out.println(boardTitle + "◀◀◀◀◀ boardTitle");
	System.out.println(boardContent + "◀◀◀◀◀ boardContent");
	System.out.println(boardPw + "◀◀◀◀◀ boardPw");
	
	
	Board board = new Board(); // board 객체 생성
	board.setCategoryName(categoryName); // board 객체내에 categoryName 값 set
	board.setBoardTitle(boardTitle); // board 객체내에 boardTitle 값 set
	board.setBoardContent(boardContent); // board 객체내에 boardContent 값 set
	board.setBoardPw(boardPw); // board 객체내에 boardPw 값 set
	board.setCreateDate(createDate); // board 객체내에 cratetDate 값 set
	board.setUpdateDate(updateDate); // board 객체내에 updateDate 값 set

	boardDao.insertBoard(board); // boardDao클래스의 insertBoard메소드에 board를 파라미터로 넣음
	boardDao.selectBoardCategoryName(categoryName); // boardDao클래스의 selectBoardCategoryName메소드에 categoryName를 파라미터로 넣음 
	
	response.sendRedirect(request.getContextPath()+"/board/boardList.jsp"); // boardList 페이지로 이동
	

   %>

