<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	int currentPage = 1; // 현재페이지의 기본값이 1페이지
	
	if(request.getParameter("currentPage") != null) { // currentPage값이 null이 아니면, (-> 이전, 다음 링크를 통해서 들어왔다면)
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10; // 한 페이지당 나타내는 정보가 10개
	int beginRow = (currentPage-1)*rowPerPage;  // 현재페이지가 변경되면 beginRow도 변경된다. -> 가져오는 데이터도 변경된다.

	PhotoDao photoDao = new PhotoDao(); // photoDao 객체 생성
	ArrayList<Photo> list = photoDao.selectPhotoListByPage(beginRow, rowPerPage); // photoDao클래스의 selectPhotoListByPage메소드에 beginRow, rowPerPage를 파라미터로 넣어서 실행한 결과를 list에 넣어줌

	int lastPage = 0;  // 마지막 페이지 담을 lastPage 변수 선언 
	int totalCount = photoDao.selectPhotoTotalRow(); //  photoDao클래스의 selectPhotoTotalRow메소드에 파라미터 값을 넣어줌
	
	lastPage = (int)(Math.ceil((double)totalCount / (double)rowPerPage));
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>photoList</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	
	
	<div class="container p-3 my-3 bg-warning text-white">
	<h1 align="center">이미지 목록</h1>
	</div>
	
		<!-- 메인 메뉴 시작-->
		<div class="container p-3 my-3 bg-white text-dark">
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		</div>
		<!-- include시 컨텍스명(프로젝트)을 명시하지 않는다. -->	
		<!-- 메인 메뉴 끝 -->
		
		
		<div class="container p-3 my-3 bg-white text-dark" align="right">
			<a href="<%=request.getContextPath()%>/photo/insertPhotoForm.jsp" class="btn btn-outline-warning btn-sm" role="botton" >이미지 업로드</a>
		</div>
	
	<div class="container p-3 my-3 bg-white text-dark">
	<table class = "table-bordered">
		<tr>
			<%
				// 한행의 5개의 이미지 출력(tr안에 td가 5개)
				// 이미지가 3개  - tr 1 - td 5
				// 이미지가 5개  - tr 1 - td 5
				// 이미지가 10개 - tr 2 - td 10
				// 이미지가 9개  - tr 2 - td 10 
				
				// td의 갯수 5의 배수가 되도록
				// list.size()가 1~5 - td는 5개
				// list.size()가 6~10 - td는 10개
				System.out.println(list.size() + " <- list.size()");
			
				int endIdx = (((list.size()-1)/5)+1)*5; // 5의 배수가 되어야 한다.(한줄에 5개씩 출력하기로...)
				System.out.println(endIdx+" <-- 10");
				
			//	for(Photo p : list) { // size()만큼 반복되므로 5의배수가 아닐 수도 있다. 
				for(int i=0; i<endIdx; i++) { // 01234, 0123456789
					// tr을 닫고 새로운 tr 시작
					if(i!=0 && i%5==0) { // 5일때(0을 제외한 5의배수일때) 
			%>
						</tr>
						<tr>
			<%			
					}
				
					if(i<list.size()) {
			%>
						<td>
							<a href="<%=request.getContextPath()%>/photo/selectPhotoOne.jsp?photoNo=<%=list.get(i).getPhotoNo()%>">
								<img src="<%=request.getContextPath()%>/upload/<%=list.get(i).getPhotoName()%>" width="220" height="220">
								<!--  상세보기에서는 원본이미지 크기로 -->
							</a>
						</td>
			<%
					} else {
			%>
						<td>&nbsp;</td>
			<%			
					}
				}
			%>
			</tr>
			</table>
			</div>
		
			
		<div class="container p-3 my-3 bg-white text-dark" align="right">	
				
	<%
		if(currentPage > 1) {
	
	%>
	
		<a href="<%=request.getContextPath()%>/photo/photoList.jsp?currentPage=<%=currentPage-1%>" class="btn btn-warning btn-sm" role="button">이전</a>
		
	<%
		}
	
	
		if(currentPage< lastPage) {
	%>	
		
		<a href="<%=request.getContextPath()%>/photo/photoList.jsp?currentPage=<%=currentPage+1%>" class="btn btn-warning btn-sm" role="button">다음</a>
	
	<%
	
		}
	
	%>
		</div>
			
			
			
			
			
		
	
</body>
</html>

