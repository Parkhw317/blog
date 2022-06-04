<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.Category" %>
<%@ page import = "vo.Board" %>
<%@ page import = "java.util.HashMap" %>

<%

	request.setCharacterEncoding("utf-8"); // 한글 깨지지 않게 인코딩 

	//boardList 페이지 실행하면 최근 10개의 목록을 보여주고 1page로 설정
	int currentPage = 1; // 현재페이지의 기본값이 1페이지

	if(request.getParameter("currentPage") != null) { // currentPage값이 null이 아니면, (-> 이전, 다음 링크를 통해서 들어왔다면)
		 currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage + "<-- currentPage"); // 디버깅
	                  
	
	// 이전, 다음링크에서 null값을 넘기는 것이 불가능해 null -> 공백으로 치환해서 코드를 처리 
	String categoryName = "";
	
	if(request.getParameter("categoryName") != null){ 
		categoryName = request.getParameter("categoryName");
	}
	
	//페이지 바뀌면 끝 아니고, 가지고 오는 데이터가 변경되어야 한다.
	/*
		알고리즘
		SELECT .... LIMIT 0,10
		
		1page	beginRow
		1		0
		2		10
		3		20
		4		30
		
		? <--------(currentPage-1)*10
		
	*/
	
	int rowPerPage = 10; // 힌 페이지당 나타내는 정보가 10개
	int beginRow = (currentPage-1) * rowPerPage; // 현재페이지가 변경되면 beginRow도 변경된다. -> 가져오는 데이터도 변경된다.
		

	
	Class.forName("org.mariadb.jdbc.Driver"); // Web App Libraries -> org.mariadb.jdbc -> Driver.class 
	Connection conn = null; // 자바와 DB를 연결을 위해 Connection 사용, conn 변수값은 빈상자.
	String dburl = "jdbc:mariadb://localhost:3306/blog"; // 처음 mariaDB설치할때 3306포트, blog 테이블로 연결
	String dbuser = "root"; // mariaDB에 설정해놓은 유저이름
	String dbpw = "mariadb1234"; // mariaDB에 설정해놓은 패스워드
	conn = DriverManager.getConnection(dburl, dbuser, dbpw); // "jdbc:mariadb://localhost:3306/blog" , "root" , "java1234"
	System.out.println(conn + " <-- conn"); // conn 에 대한 디버깅
	
	/*
		select category_name categoryName, count(*) cnt
		From board
		GROUP BY category_name
	
	*/
	
	/* 카테고리 이름을 category_name만 입력*/
	String categorySql = "select category_name categoryName, count(*) cnt From board GROUP BY category_name"; // 카테고리 sql문법 변수에 저장
	PreparedStatement categoryStmt = conn.prepareStatement(categorySql); // 카테고리 sql문법 변수에 저장해놓은값 연결
	
	ResultSet categoryRs = categoryStmt.executeQuery(); // categoryRs 결과값 sql문법 변수에 저장해놓은값 실행
	
	// 쿼리에 결과를 Category, board Vo로 저장할 수 없다. -> HashMap을 사용해서 저장하자!
	ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>();
	while(categoryRs.next()) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("categoryName", categoryRs.getString("categoryName")); // 앞 categoryName : java단에서 사용될 변수명, 뒤 categoryName : sql 쿼리문의 categoryName
		map.put("cnt", categoryRs.getInt("cnt")); // 앞 cnt : java단에서 사용될 변수명, 뒤 cnt : sql 쿼리문의 cnt
		categoryList.add(map); // map에 각 값을 add함
	}
	/* categoryRS 값이 sql문법 변수에 결과값 실행하고나면 그 저장값, next()함수는 가장 비슷한 형제의 요소를 선택하는 함수,
	그러면 categoryRS  가장 비슷한 형제의 요소를 선택해주는 함수고 그게 categoryList.add 추가된거고 그걸 "categoryName" 
	애를 불러와서 categoryList에 add한다. 는 의미 */
	
	
	
	// boardList
		String boardSql = null; // sql 저장변수 null값으로 선언
		PreparedStatement boardStmt = null; // 전송을 위한 변수 stmt 선언 
		if(categoryName.equals("")) { 
			// 만약 categoryName이 공백일 경우 boardNo, categoryName, boardTitle, createDate 값을 board에서 create_date 내림차순으로 LIMIT해서 select함
			boardSql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board ORDER BY create_date DESC LIMIT ?, ?";
			boardStmt = conn.prepareStatement(boardSql); // select sql문 전송
			boardStmt.setInt(1, beginRow); // 쿼리문 ? 값에 대해 beginRow값으로 set 해주기
			boardStmt.setInt(2, rowPerPage); // 쿼리문 ? 값에 대해 rowPerPage값으로 set해주기
			
		} else { // 만약 그 외의 경우 boardNo, categoryName, boardTitle, createDate 값을 board중 지정한 categoryName값에 대해 create_date 내림차순으로 LIMIT해서 select함
			boardSql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board WHERE category_name =? ORDER BY create_date DESC LIMIT ?, ?";
			boardStmt = conn.prepareStatement(boardSql); // select sql문 전송
			boardStmt.setString(1, categoryName); // 쿼리문 ? 값에 대해 categoryName값으로 set 해주기
			boardStmt.setInt(2, beginRow); // 쿼리문 ? 값에 대해 beginRow값으로 set 해주기
			boardStmt.setInt(3, rowPerPage); // 쿼리문 ? 값에 대해 rowPerPage값으로 set해주기
		}
		ResultSet boardRs = boardStmt.executeQuery(); // 쿼리문 실행
		ArrayList<Board> boardList = new ArrayList<Board>();
		while(boardRs.next()) { // sql문 결과값으로 가져온 categoryName값에 대해 list에 추가(while문 안에 있으니 false값 나올떄까지 계속 반복)
			Board b = new Board();
			b.setBoardNo(boardRs.getInt("boardNo")); // boardNo값 set
			b.setCategoryName(boardRs.getString("categoryName")); // categoryName값 set
			b.setBoardTitle(boardRs.getString("boardTitle")); // boardName값 set
			b.setCreateDate(boardRs.getString("createDate")); // createDate값 set
			boardList.add(b); // list에 add
		}
		
		
		
		int totalRow = 0; // 게시글 총 수를 담을 totalRow 변수 선언
		String totalRowSql = "SELECT COUNT(*) cnt FROM board"; // 쿼리문 선언
		PreparedStatement totalRowStmt = conn.prepareStatement(totalRowSql); // select sql문 전송
		ResultSet totalRowRs = totalRowStmt.executeQuery(); // 쿼리문 실행
		if(totalRowRs.next()) { // db에서 반환받은 쿼리문 값 list 추가
			totalRow = totalRowRs.getInt("cnt"); // cnt값 set
			System.out.println(totalRow+" <-- totalRow"); // 디버깅
		}

		
		
		int lastPage = 0; // 마지막 페이지 담을 lastPage 변수 선언
		if(totalRow % rowPerPage == 0) { // totalRow, rowPerpage 나머지가 0일 경우
			lastPage = totalRow / rowPerPage; // lastPage는 totalRow / rowPerPage 의 값
		} else { // 아닐경우
			lastPage = (totalRow / rowPerPage) + 1; // lastPage는 (totalRow / rowPerPage) + 1 값 
		}
		
		
		conn.close(); // conn 자원 반환
	
	%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body class="container">

	<!-- category별 게시글 링크 메뉴 -->
	<br><jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<div class="container p-3 my-3 border">
		<h1 align="center">Category</h1><br>
		<div align="center">
			
			<%
			for (HashMap<String, Object> m : categoryList) {
			%>
			
			<div class="btn-group" class="btn btn-primary">
				<a href="<%=request.getContextPath()%>/board/boardList.jsp?categoryName=<%=m.get("categoryName")%>" class="btn btn-outline-secondary" role="button"><%=m.get("categoryName")%>&nbsp;<span class="badge badge-warning"><%=m.get("cnt")%></span></a>
			</div>
			
			<%
			}
			%>
		</div>
	</div><br><br>
	
	<!-- 게시글 리스트 -->
	<h2 align="center">게시글 목록</h2>
	<h6 align="center">
		(total : <%=totalRow%>)
	</h6>
	<div align="right">
		<a href="<%=request.getContextPath()%>/board/insertBoardForm.jsp" class="btn btn-outline-info btn-sm" role="botton">게시글 입력</a><br><br>
	</div>
	<table class="table" style="text-align: center;">
		<thead>
			<tr class="table-active">
				<th>categoryName</th>
				<th>boardTitle</th>
				<th>createDate</th>
			</tr>
		</thead>
		<tbody>
			<%
			for (Board b : boardList) {
			%>
		
			<tr>
				<td><%=b.getCategoryName()%></td>
				<td><a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=b.getBoardNo()%>"><%=b.getBoardTitle()%></a></td>
				<td><%=b.getCreateDate()%></td>
			</tr>
			
			<%
			}
			%>
		</tbody>
	</table>

	<br><div align="right">
		<div class="btn-group">
			<!-- 페이지가 만약 10페이지였다면 이전을 누르면 9페이지, 다음을 누르면 11페이지 -->
		
			<%
			if (currentPage > 1) { // 현재페이지가 1이면 이전페이지가 존재해서는 안된다.
			%>
		
			<ul class="pagination">
				<li class="page-item"><a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage - 1%>&categoryName=<%=categoryName%>" class="btn btn-info btn-sm" role="button">이전</a></li>
			</ul>

			<%
			}
			%>

			<!--  
			전체행			마지막 페이지 ? 
			10개 				1
			11,12,13 ~ 20		2
			21 ~ 30				3
			31 ~ 40				4
		
			마지막 페이지 = 전체행 / rowPerPage
		-->
			<%
			//
			if (currentPage < lastPage) {
			%>
			<ul class="pagination">
				<li class="page-item"><a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage + 1%>&categoryName=<%=categoryName%>" class="btn btn-info btn-sm" role="button">다음</a></li>
			</ul>
			<%
			}
			%>
		</div>
	</div>
</body>
</html>

