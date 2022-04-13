<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>

<%

	request.setCharacterEncoding("utf-8"); // 한글 깨지지 않게 인코딩

	GuestbookDao guestbookDao = new GuestbookDao(); //변수 선언후 초기화
	
	// 각 변수들의 값 받아오기
	String guestbookContent = request.getParameter("guestbookContent");
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	String guestbookPw = request.getParameter("guestbookPw");
	String writer = request.getParameter("writer");
	
	// 인코딩
	System.out.println(guestbookContent + "◀◀◀◀◀ guestbookContent");
	System.out.println(guestbookNo + "◀◀◀◀◀ guestbookNo");
	System.out.println(guestbookPw + "◀◀◀◀◀ guestbookPw");
	System.out.println(writer + "◀◀◀◀◀ writer");
	
	
	// 변수 선언 후 받아온 값 넣어줌
	Guestbook guestbook = new Guestbook();
	guestbook.setGuestbookContent(guestbookContent);
	guestbook.setGuestbookNo(guestbookNo);
	guestbook.setGuestbookPw(guestbookPw);
	guestbook.setWriter(writer);
	

	
	int row = 0; 
	row = guestbookDao.updateGuestbook(guestbook); //  guestbookDao클래스의 updateGuestbook메소드에 guestbook를 마라미터로 넣어줌
	
	if(row == 0) { // 수정된 행이 0개라면 수정 실패
		System.out.println("수정 실패");
		response.sendRedirect(request.getContextPath()+"/guestbook/updateGuestbookForm.jsp?guestbookNo=" + guestbook.getGuestbookNo());
	} else if(row == 1) { // 수정된 행이 1개라면 수정 성공
		System.out.println("수정 성공");
		response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp");
	} else { // 수정된 행이 여러개라면 오류
		System.out.println("에러");
	}
%>




