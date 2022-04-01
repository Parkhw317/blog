<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>

<%

	request.setCharacterEncoding("utf-8");

	GuestbookDao guestbookDao = new GuestbookDao();
	
	String writer = request.getParameter("writer");
	String guestbookPw = request.getParameter("guestbookPw");
	String guestbookContent = request.getParameter("guestbookContent");
	String createDate = request.getParameter("createDate");
	
	
	Guestbook guestbook = new Guestbook();
	guestbook.writer = writer;
	guestbook.guestbookPw = guestbookPw;
	guestbook.guestbookContent = guestbookContent;
	guestbook.createDate = createDate;
	

	guestbookDao.insertGuestbook(guestbook);
	
	
	response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp");
	
	
	
%>


