package dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import vo.Board;


	
	public class BoardDao {
		public BoardDao() {}
		
		// board insert 관련 코딩
		public void insertBoard(Board board) throws Exception {
			Class.forName("org.mariadb.jdbc.Driver");
			Connection conn = null;
			PreparedStatement stmt = null;
			
			String dburl = "jdbc:mariadb://localhost:3306/blog";
			String dbuser = "root";
			String dbpw = "java1234";
			String sql = "INSERT INTO board (category_name, board_title, board_content, board_pw, create_date, update_Date) VALUES (?, ?, ?, ?, NOW(), NOW())";
			
			conn = DriverManager.getConnection(dburl, dbuser, dbpw);
			stmt = conn.prepareStatement(sql);
			
			stmt.setString(1, board.getCategoryName());
			stmt.setString(2, board.getBoardTitle());
			stmt.setString(3, board.getBoardContent());
			stmt.setString(4, board.getBoardPw());
			
		
			int row = stmt.executeUpdate();
			
			if(row == 1) {
				System.out.println("입력 성공");
			} else {
				System.out.println("입력 실패");		
			}
		
	
			stmt.close();
			conn.close();
	
		}
		
		// insertBoard DB에서 categoryName 리스트 불러오는 코딩 (ArrayList로 받아오기)
		public ArrayList<String> selectBoardCategoryName(String categoryName) throws Exception {
			ArrayList<String> list = new ArrayList<String>();
			
			Class.forName("org.mariadb.jdbc.Driver");
			
		
			Connection conn = null;
			
			String dburl = "jdbc:mariadb://localhost:3306/blog";
			String dbuser = "root";
			String dbpw = "java1234";
			
			conn = DriverManager.getConnection(dburl, dbuser, dbpw);
			String sql = "SELECT category_name categoryName FROM category ORDER BY category_name ASC";
			PreparedStatement categoryNemeStmt = conn.prepareStatement(sql);
			ResultSet categoryNemeRs = categoryNemeStmt.executeQuery();
			
			while(categoryNemeRs.next()) {
				list.add(categoryNemeRs.getString("categoryName"));
		  
			
		}
		
			categoryNemeRs.close();
			categoryNemeStmt.close();
			conn.close();
		
			return list;
			
			
		}
		
		public Board selectBoardOne(int boardNo) throws Exception{
			Board board = null;
			
			Class.forName("org.mariadb.jdbc.Driver");
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			String dburl = "jdbc:mariadb://localhost:3306/blog";
			String dbuser = "root";
			String dbpw = "java1234";
			conn = DriverManager.getConnection(dburl, dbuser, dbpw);
			
			String boardOneSql = "select board_no boardNo, category_name categoryName, board_title boardTitle, board_content boardContent, board_pw boardPw, create_date createDate, update_date updateDate from board WHERE board_no = ?"; 
			stmt = conn.prepareStatement(boardOneSql);
			stmt.setInt(1, boardNo);
			System.out.println(stmt+ "<-- sql selectBoardOne");
			
			rs = stmt.executeQuery();
			if(rs.next()) {
				board = new Board();
				board.setBoardNo(rs.getInt("boardNo"));
				board.setCategoryName(rs.getString("categoryName"));
				board.setBoardTitle(rs.getString("boardTitle"));
				board.setBoardContent(rs.getString("boardContent"));
				board.setCreateDate(rs.getString("createDate"));
				board.setUpdateDate(rs.getString("updateDate"));
			}
			
			
			rs.close();
			stmt.close();
			conn.close();
			return board;
			
			
		}
		
		public int updateBoard(Board board) throws Exception {
			int row = 0; 
			Class.forName("org.mariadb.jdbc.Driver");
			Connection conn = null;
			PreparedStatement stmt = null;
			
			String dburl = "jdbc:mariadb://localhost:3306/blog";
			String dbuser = "root";
			String dbpw = "java1234";
			conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
			
			
			String updateBoardSql = "UPDATE board SET category_name = ?, board_title = ?, board_content = ?, update_date = now() WHERE board_no = ?";
			stmt = conn.prepareStatement(updateBoardSql);
			stmt.setString(1,board.getCategoryName());
			stmt.setString(2,board.getBoardTitle());
			stmt.setString(3,board.getBoardContent());
			stmt.setInt(4,board.getBoardNo());
			
			System.out.println(stmt+" <-- sql updateBoard"); 
			
			row = stmt.executeUpdate();
			
			stmt.close();
			conn.close();
			return row;
			
		
		}
		
		public int deleteBoard(int boardNo, String boardPw) throws Exception {
			int row = 0; 
			Class.forName("org.mariadb.jdbc.Driver");
			Connection conn = null;
			PreparedStatement stmt = null;
			
			String dburl = "jdbc:mariadb://localhost:3306/blog"; 
			String dbuser = "root";
			String dbpw = "java1234";
			conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
			
			String sql = "DELETE FROM board WHERE board_no=? AND board_pw=?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, boardNo);
			stmt.setString(2, boardPw);
			
			System.out.println(stmt+"<-- sql deleteBoard");
			
			row = stmt.executeUpdate();
			
			stmt.close();
			conn.close();
			
			return row;
			
		}
		
		
		
		
		
	}
	
			
	
	
