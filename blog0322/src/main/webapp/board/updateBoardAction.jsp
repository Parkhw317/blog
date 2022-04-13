<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<% 
	
	request.setCharacterEncoding("utf-8"); // 한글 깨지지 않게 인코딩

	BoardDao boardDao = new BoardDao(); // boardDao 객체 생성 
	
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));  // boardNo 문자열을 숫자로 변환 후 int로 변수 선언
	String categoryName = request.getParameter("categoryName"); // catrgoryName 변수선언
	String boardTitle = request.getParameter("boardTitle"); // boardTitle 변수선언
	String boardContent = request.getParameter("boardContent"); // boardContent 변수선언
	
	// 디버깅
	System.out.println(boardNo + "◀◀◀◀◀ boardNo");
	System.out.println(categoryName + "◀◀◀◀◀ categoryName");
	System.out.println(boardTitle + "◀◀◀◀◀ boardTitle");
	System.out.println(boardContent + "◀◀◀◀◀ boardContent");
	
	Board board = new Board(); // board 객체 생성
	board.setBoardNo(boardNo); // board 객체내에 boardNo 값 set
	board.setCategoryName(categoryName); // board 객체내에 categoryName 값 set
	board.setBoardTitle(boardTitle); // board 객체내에 boardTitle 값 set
	board.setBoardContent(boardContent); // board 객체내에 boardContent 값 set
	
	int row = 0; // int row 기본값으로 선언
	row = boardDao.updateBoard(board);  // boardDao클래스의 updateBoard메소드에 board를 파라미터로 넣어서 실행한 결과를 row에 넣어줌
	
	if(row == 0){ // 수정된 행(row)이 0개라면 수정 실패
		System.out.println("수정 실패");
		response.sendRedirect(request.getContextPath()+"/board/updateBoardForm.jsp?boardNo=" + board.getBoardNo());
	} else if(row == 1) { // 수정된 행(row)이 1개라면 수정 성공
		System.out.println("수정 성공");
		response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
	} else { // 그 외 일 경우 오류
		System.out.println("에러");
	
	}
	
	


%>

