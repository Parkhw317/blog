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
			Connection conn = null; // Connection : sql 실행을 위해 DB연결, DB연결을 위한 변수 conn 선언
			PreparedStatement stmt = null; //  PreparedStatement : 자바에서 DB로 쿼리문 전송할때 사용, 전송을 위한 변수 stmt 선언 
			
			// maria DB url,user,pw 등 선언
			String dburl = "jdbc:mariadb://localhost:3306/blog";
			String dbuser = "root";
			String dbpw = "mariadb1234";
			
			// 연결할 쿼리문 작성
			String sql = "INSERT INTO board (category_name, board_title, board_content, board_pw, create_date, update_Date) VALUES (?, ?, ?, ?, NOW(), NOW())";
			
			conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB연결
			stmt = conn.prepareStatement(sql); // insert sql문 전송
			
			// 쿼리문 ? 값에 대해 set해주기
			stmt.setString(1, board.getCategoryName()); // categoryName 값 set
			stmt.setString(2, board.getBoardTitle()); // boardTitle 값 set
			stmt.setString(3, board.getBoardContent()); // boardContent 값 set
			stmt.setString(4, board.getBoardPw()); // boardPw 값 set
			
			int row = stmt.executeUpdate(); // 전송하는 행위를 int row로 설정/ executeUpdat : DB 데이터를 insert, delete, update하는 sql문을 수행할 때 사용되는 함수. 
			
			if(row == 1) { // 디버깅, row 값이 1일 경우 입력 성공, 아닐경우 실패
				System.out.println("insert Board 성공");
			} else {
				System.out.println("insert Board 실패");		
			}
			
			stmt.close(); // stmt 자원반환
			conn.close(); // conn 자원반환
		}
		
		// insertBoard DB에서 categoryName 리스트 불러오는 코딩 (ArrayList로 받아오기)
		public ArrayList<String> selectBoardCategoryName(String categoryName) throws Exception {
			ArrayList<String> list = new ArrayList<String>(); // Array리스트 객체 선언
			
			Class.forName("org.mariadb.jdbc.Driver");
			Connection conn = null; // DB연결을 위한 변수 conn 선언
			
			// maria DB url,user,pw 등 선언
			String dburl = "jdbc:mariadb://localhost:3306/blog";
			String dbuser = "root";
			String dbpw = "mariadb1234";
			
			// 연결할 쿼리문 작성
			String sql = "SELECT category_name categoryName FROM category ORDER BY category_name ASC";
			
			conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB연결
			PreparedStatement categoryNemeStmt = conn.prepareStatement(sql); // select sql문 전송
			ResultSet categoryNemeRs = categoryNemeStmt.executeQuery(); // ResultSet : java 프로그램에서 sql문을 수행 한 후 DB테이블에서 반환된 데이터를 저장 
			
			while(categoryNemeRs.next()) { // rs.next( ) : ResultSet에 저장된 sql문 실행결과를 행단위로 1행씩 넘겨서 만약에 다음 행이 있으면 ture, 다음행이 없으면 false를 반환
				list.add(categoryNemeRs.getString("categoryName")); // sql문 결과값으로 가져온 categoryName 값에 대해 list에 추가(while문 안에있으니 false값 나올때까지 반복)
		}
		
			categoryNemeRs.close(); // categoryNemeRs 자원반환
			categoryNemeStmt.close(); // categoryNemeStmt 자원반환
			conn.close(); // conn 반환
		
			return list; // return값 : list
		
		}
		
		// board 게시글 중 한개의 게시물 select 관련 코딩
		public Board selectBoardOne(int boardNo) throws Exception{
			Board board = null; // board변수 null값 선언
			
			Class.forName("org.mariadb.jdbc.Driver");
			Connection conn = null; // DB연결을 위한 변수 conn 선언
			PreparedStatement stmt = null; // 쿼리문 전송을 위한 변수 stmt 선언 
			ResultSet rs = null; // DB 데이터저장을 위한 변수 rs 선언 
			
			// maria DB url,user,pw 등 선언
			String dburl = "jdbc:mariadb://localhost:3306/blog";
			String dbuser = "root";
			String dbpw = "mariadb1234";
			conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB연결
			
			// 연결할 쿼리문 작성
			String boardOneSql = "select board_no boardNo, category_name categoryName, board_title boardTitle, board_content boardContent, board_pw boardPw, create_date createDate, update_date updateDate from board WHERE board_no = ?"; 
			stmt = conn.prepareStatement(boardOneSql); // select sql문 전송
			stmt.setInt(1, boardNo); // 쿼리문 ? 값에 대해 set해주기
			System.out.println(stmt+ "<-- sql selectBoardOne"); // 디버깅
			
			rs = stmt.executeQuery(); // 쿼리문 실행
			
			if(rs.next()) { // sql문 결과값으로 가져온 값(boardNo외 5개)에 대해 list에 추가
				board = new Board(); // board 객체 생성
				board.setBoardNo(rs.getInt("boardNo")); // boardNo 값 set
				board.setCategoryName(rs.getString("categoryName")); // categoryName 값 set
				board.setBoardTitle(rs.getString("boardTitle")); // boardTitle 값 set
				board.setBoardContent(rs.getString("boardContent")); // boardContent 값 set
				board.setCreateDate(rs.getString("createDate")); // createDate 값 set
				board.setUpdateDate(rs.getString("updateDate")); // updateDate 값 set
			}
			
			rs.close(); // rs 자원반환
			stmt.close(); // stmt 자원반환
			conn.close(); // conn 자원반환
			
			return board; // return값 : board	
		}
		
		// board update 관련 코딩
		public int updateBoard(Board board) throws Exception {
			
			int row = 0; // int row 기본값으로 선언
			Class.forName("org.mariadb.jdbc.Driver");
			Connection conn = null; // DB연결을 위한 변수 conn 선언
			PreparedStatement stmt = null; // 쿼리문 전송을 위한 변수 stmt 선언 
			
			// maria DB url,user,pw 등 선언
			String dburl = "jdbc:mariadb://localhost:3306/blog";
			String dbuser = "root";
			String dbpw = "mariadb1234";
			conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB연결
			
			// 연결할 쿼리문 작성
			String updateBoardSql = "UPDATE board SET category_name = ?, board_title = ?, board_content = ?, update_date = now() WHERE board_no = ?";
			stmt = conn.prepareStatement(updateBoardSql); // update sql문 전송
			
			// 쿼리문 ? 값에 대해 set해주기
			stmt.setString(1,board.getCategoryName()); // categoryName 값 set
			stmt.setString(2,board.getBoardTitle()); // boardTitle 값 set
			stmt.setString(3,board.getBoardContent()); // boardContent 값 set
			stmt.setInt(4,board.getBoardNo()); // boardNo 값 set
			
			System.out.println(stmt+" <-- sql updateBoard"); // 디버깅
			
			row = stmt.executeUpdate(); // 쿼리문 실행
			
			if(row == 1) { // 디버깅, row 값이 1일 경우 입력 성공, 아닐경우 실패
				System.out.println("update Board 성공");
			} else {
				System.out.println("update Board 실패");		
			}
			
			stmt.close(); // stmt 자원 반환
			conn.close(); // conn 자원 반환
			
			return row;  // return값 : row
			
		
		}
		
		// board delete 관련
		public int deleteBoard(int boardNo, String boardPw) throws Exception {
			int row = 0; // int row 기본값으로 선언
			
			Class.forName("org.mariadb.jdbc.Driver");
			Connection conn = null; // DB연결을 위한 변수 conn 선언
			PreparedStatement stmt = null; // 쿼리문 전송을 위한 변수 stmt 선언 
			
			// maria DB url,user,pw 등 선언
			String dburl = "jdbc:mariadb://localhost:3306/blog"; 
			String dbuser = "root";
			String dbpw = "mariadb1234";
			conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB연결
			
			// 연결할 쿼리문 작성
			String sql = "DELETE FROM board WHERE board_no=? AND board_pw=?";
			stmt = conn.prepareStatement(sql);  // delete sql문 전송
			
			// 쿼리문 ? 값에 대해 set해주기
			stmt.setInt(1, boardNo); // boradNo 값 set
			stmt.setString(2, boardPw); // boardPw 값 set
			
			System.out.println(stmt+"<-- sql deleteBoard"); // 디버깅
			
			row = stmt.executeUpdate(); // 쿼리문 실행
			
			if(row == 1) { // 디버깅, row 값이 1일 경우 입력 성공, 아닐경우 실패
				System.out.println("delete Board 성공");
			} else {
				System.out.println("delete Board 실패");		
			}
			
			stmt.close(); // stmt 자원반환
			conn.close(); // conn 자원 반환
			
			return row; // return값 : row
			
		}
	}
	
			
	
	
