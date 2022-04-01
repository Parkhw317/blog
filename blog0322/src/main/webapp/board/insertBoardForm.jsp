<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	
	request.setCharacterEncoding("utf-8");

	String categoryName = request.getParameter("categoryName");
	
	BoardDao boardDao = new BoardDao();
	
	ArrayList<String> list = boardDao.selectBoardCategoryName(categoryName);
 	
	
	
	/*
	
----------------------------------------

	

	Class.forName("org.mariadb.jdbc.Driver");
   Connection conn = null;
   String dburl = "jdbc:mariadb://localhost:3306/blog";
   String dbuser = "root";
   String dbpw = "java1234";
   conn = DriverManager.getConnection(dburl, dbuser, dbpw);
   String sql = "SELECT category_name categoryName FROM category ORDER BY category_name ASC";
   PreparedStatement stmt = conn.prepareStatement(sql);
   ResultSet rs = stmt.executeQuery();
  	ArrayList<String> list = new ArrayList<String>();
  	 while(rs.next()) {
		String b = new String();
	    list.add(rs.getString("categoryName"));
  	 }
   
   conn.close();
   
   */
   
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertBoardForm</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>
	<div class="row">
	<div class="col-sm-12 bg-light">
<div class="container">
   <br><h2>게시글 입력</h2><br>
   <form method="post" action="<%=request.getContextPath()%>/board/insertBoardAction.jsp">
      <table class = "table-bordered">
         <tr>
            <td>cetegoryName</td>
            <td>
               <select name="categoryName">
                  <%
                  
                     for(String s : list) {
                  %>
                        <option value="<%=s%>"><%=s%></option> 
             
                  <%      
                     }
                  %>             
               </select>
            
            
            
         </tr>
         <tr>
				<td>boardTitle</td>
				<td>
				<input name="boardTitle" type="text" class="form-control">
				</td>
		</tr>
			<tr>
				<td>boardContent</td>
				<td>
					<textarea name="boardContent" rows="5" cols="80" class="form-control"></textarea>
				</td>
			</tr>
			<tr>
				<td>boardPw</td>
				<td>
				<input name="boardPw" type="password" class="form-control">
				</td>
			</tr>
        	 <tr>
				<td colspan="2">
					<br><button type="submit" class="btn btn-info btn-sm">board 입력</button>
				</td>
			</tr>
         
         
      </table>
   </form>
   </div>
   </div>
   </div>
</body>
</html>

