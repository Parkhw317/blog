<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.Category" %>
<%@ page import = "vo.Board" %>
<%@ page import = "java.util.HashMap" %>

<%

	//boardList 페이지 실행하면 최근 10개의 목록을 보여주고 1page로 설정
	int currentPage = 1; // 현재페이지의 기본값이 1페이지

	if(request.getParameter("currentPage") != null) { // 이전, 다음 링크를 통해서 들어왔다면
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
	
	int rowPerPage = 10;
	int beginRow = (currentPage-1) * rowPerPage; // 현재페이지가 변경되면 beginRow도 변경된다. -> 가져오는 데이터도 변경된다.
		
	
	
	request.setCharacterEncoding("utf-8");

	Class.forName("org.mariadb.jdbc.Driver"); // Web App Libraries -> org.mariadb.jdbc -> Driver.class 
	Connection conn = null; // 자바와 DB를 연결을 위해 Connection 사용, conn 변수값은 빈상자.
	String dburl = "jdbc:mariadb://localhost:3306/blog"; // 처음 mariaDB설치할때 3306포트, blog 테이블로 연결
	String dbuser = "root"; // mariaDB에 설정해놓은 유저이름
	String dbpw = "java1234"; // mariaDB에 설정해놓은 패스워드
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
		map.put("categoryName", categoryRs.getString("categoryName"));
		map.put("cnt", categoryRs.getInt("cnt"));
		categoryList.add(map);
	}
	/* categoryRS 값이 sql문법 변수에 결과값 실행하고나면 그 저장값, next()함수는 가장 비슷한 형제의 요소를 선택하는 함수,
	그러면 categoryRS  가장 비슷한 형제의 요소를 선택해주는 함수고 그게 categoryList.add 추가된거고 그걸 "categoryName" 
	애를 불러와서 categoryList에 add한다. 는 의미 */
	
	// boardList
		String boardSql = null;
		PreparedStatement boardStmt = null;
		if(categoryName.equals("")) {
			boardSql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board ORDER BY create_date DESC LIMIT ?, ?";
			boardStmt = conn.prepareStatement(boardSql);
			boardStmt.setInt(1, beginRow);
			boardStmt.setInt(2, rowPerPage);
			
		} else {
			boardSql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board WHERE category_name =? ORDER BY create_date DESC LIMIT ?, ?";
			boardStmt = conn.prepareStatement(boardSql);
			boardStmt.setString(1, categoryName);
			boardStmt.setInt(2, beginRow);
			boardStmt.setInt(3, rowPerPage);
		}
		ResultSet boardRs = boardStmt.executeQuery();
		ArrayList<Board> boardList = new ArrayList<Board>();
		while(boardRs.next()) {
			Board b = new Board();
			b.setBoardNo(boardRs.getInt("boardNo"));
			b.setCategoryName(boardRs.getString("categoryName"));
			b.setBoardTitle(boardRs.getString("boardTitle"));
			b.setCreateDate(boardRs.getString("createDate"));
			boardList.add(b);
		}
		
		
		
		int totalRow = 0; // select count(*) from board;
		String totalRowSql = "SELECT COUNT(*) cnt FROM board";
		PreparedStatement totalRowStmt = conn.prepareStatement(totalRowSql);
		ResultSet totalRowRs = totalRowStmt.executeQuery();
		if(totalRowRs.next()) {
			totalRow = totalRowRs.getInt("cnt");
			System.out.println(totalRow+" <-- totalRow");
		}

		
		
		int lastPage = 0;
		if(totalRow % rowPerPage == 0) {
			lastPage = totalRow / rowPerPage;
		} else {
			lastPage = (totalRow / rowPerPage) + 1;
		}
		
		
		conn.close();
	
	%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>


	<!-- category별 게시글 링크 메뉴 -->
	
	<div class="row">
	<div class="col-sm-3 bg-light">
	<div class="container" >
		<ul class="list-group">
			
			<div style= "text-align : center;">
			<br><h2>Category</h2><br>		
			</div>
				
			<%
				for(HashMap<String, Object> m : categoryList) {
			%>
					
					<li class="list-group-item list-group-item-action">
						<a href="<%=request.getContextPath()%>/board/boardList.jsp?categoryName=<%=m.get("categoryName")%>"><%=m.get("categoryName")%>&nbsp;<span class="badge badge-info"><%=m.get("cnt")%></span></a>
					</li>
					
			<%		
				}
			%>
		
		</ul>
		
	</div>	
	</div>
	<!-- 게시글 리스트 -->
	<div class="col-sm-9 bg-light">
	<br><h2>게시글 목록</h2><h6>(total : <%=totalRow%>)</h6><br>
	<div>
		<a href="<%=request.getContextPath()%>/board/insertBoardForm.jsp" class="btn btn-outline-info btn-sm" role="botton" >게시글 입력</a>
	</div>
	<br><table class = "table-bordered" style="text-align : center;" >
		<thead>
			<tr class="table-active">
				<th>categoryName</th>
				<th>boardTitle</th>
				<th>createDate</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Board b : boardList) {
			%>
					<tr>
						<td><%=b.getCategoryName()%></td>
						<td><a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=b.getBoardNo()%>" ><%=b.getBoardTitle()%></a></td>
						<td><%=b.getCreateDate()%></td>
					</tr>
			<%		
				}
			%>
		</tbody>
	</table>
	
	<br>
	<div class="btn-group">
		<!-- 페이지가 만약 10페이지였다면 이전을 누르면 9페이지, 다음을 누르면 11페이지 -->
		<%
			if(currentPage > 1) { // 현재페이지가 1이면 이전페이지가 존재해서는 안된다.
		%>
				<ul class="pagination">
				<li class="page-item">
				<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage-1%>&categoryName=<%=categoryName%>" class="btn btn-info btn-sm" role="button">이전</a>
				</li></ul>
				
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
			if(currentPage < lastPage) {
		%>
				<ul class="pagination">
				<li class="page-item">
				<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage+1%>&categoryName=<%=categoryName%>" class="btn btn-info btn-sm" role="button">다음</a>
				</li></ul>
		<%		
			}
		%>
	</div>
	</div>
	</div>

</body>
</html>

