<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>

<%

	request.setCharacterEncoding("utf-8"); // 한글 깨지지않게 인코딩
	
	GuestbookDao guestbookDao = new GuestbookDao(); //변수 선언후 초기화
	
	// 각 변수들의 값 받아오기
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	String guestbookPw = request.getParameter("guestbookPw");
	
	// 디버깅
	System.out.println(guestbookNo + "◀◀◀◀◀ guestbookNo"); // 디버깅
	System.out.println(guestbookPw + "◀◀◀◀◀ guestbookPw"); // 디버깅
	
	// 변수 선언 후 받아온 값 넣어줌
	Guestbook guestbook = new Guestbook();
	guestbook.guestbookNo = guestbookNo;
	guestbook.guestbookPw = guestbookPw;
	
	
	int row = 0;
	row = guestbookDao.deleteGuestbook(guestbookNo, guestbookPw);  // GuestbookDao에 있는 deleteGuestbook 메소드 실행
	
	if(row == 0) { // 수정된 행이 0개라면 수정 실패
		System.out.println("수정 실패");
		response.sendRedirect(request.getContextPath()+"/guestbook/deleteGuestbookForm.jsp?guestbookNo=" + guestbook.guestbookNo);
	} else if(row == 1) { // 수정된 행이 1개라면 수정 성공
		System.out.println("수정 성공");
		response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp");
	} else { // 수정된 행이 여러개라면 오류
		System.out.println("에러");
	}

%>

