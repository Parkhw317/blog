<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 다른 페이지의 부분으로 사용되는 페이지 -->

	<div class="btn-group" class="btn btn-primary">
		<a href="<%=request.getContextPath()%>/index.jsp" class="btn btn-outline-secondary btn-sm" role="button">홈으로</a>
		<a href="<%=request.getContextPath()%>/board/boardList.jsp" class="btn btn-outline-secondary btn-sm" role="button">게시판</a>
		<a href="<%=request.getContextPath()%>/photo/photoList.jsp" class="btn btn-outline-secondary btn-sm" role="button">갤러리</a>
		<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp" class="btn btn-outline-secondary btn-sm" role="button">방명록</a>
		<a href="<%=request.getContextPath()%>" class="btn btn-outline-secondary btn-sm" role="button">PDF자료실</a>
	</div>
