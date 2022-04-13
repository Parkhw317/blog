<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>

<%

	request.setCharacterEncoding("utf-8"); // 한글 꺠지지 않게 인코딩 

	GuestbookDao guestbookDao = new GuestbookDao(); // guestbookDao 객체 생성
	
	String writer = request.getParameter("writer"); // writer 변수선언
	String guestbookPw = request.getParameter("guestbookPw"); // guestbookPw 변수선언
	String guestbookContent = request.getParameter("guestbookContent"); // guestbookContent 변수선언
	String createDate = request.getParameter("createDate"); // createDate 변수선언
	
	
	Guestbook guestbook = new Guestbook(); // guestbook 객체 생성
	guestbook.setWriter(writer); // guestbook 객체 내에 writer 값 set
	guestbook.setGuestbookPw(guestbookPw); // guestbook 객체 내에 guestbookPw 값 set
	guestbook.setGuestbookContent(guestbookContent); // guestbook 객체 내에 guestbookContent 값 set
	guestbook.setCreateDate(createDate);// guestbook 객체 내에 createDate 값 set
	

	guestbookDao.insertGuestbook(guestbook); //  guestbookDao클래스의 insertGuestbook메소드에 guestbook를 마라미터로 넣어줌
	
	
	response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp"); // guestbookList 페이지로 이동
	
	
	
%>


