package dao;
import java.util.ArrayList;
import vo.Guestbook;
import java.sql.*;
public class GuestbookDao {
	// 생성자 메서드
	public GuestbookDao() {}
	
	// 수정(guestbookOne,updateGuestbook), 삭제(deleteGuestbook) 프로세스 구현
	
	// updateGuestbookForm.jsp에서 호출
	public Guestbook selectGuestbookOne(int guestbookNo) throws Exception{
		Guestbook guestbook = null; // guestbook 변수 null값 선언
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null; // DB연결을 위한 변수 conn 선언
		PreparedStatement stmt = null; // 쿼리문 전송을 위한 변수 stmt 선언  
		ResultSet rs = null; // DB 데이터저장을 위한 변수 rs 선언 
		
		// maria DB url,user,pw 등 선언
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);  // DB연결 
		
		// 연결할 쿼리문 작성
		String sql = "SELECT guestbook_no guestbookNo, guestbook_content guestbookContent, writer FROM guestbook WHERE guestbook_no = ?";
		stmt = conn.prepareStatement(sql); // select sql문 전송
		stmt.setInt(1, guestbookNo);// 쿼리문 ? 값에 대해 set해주기
		System.out.println(stmt+ "<-- sql selectOne"); // 디버깅
		rs = stmt.executeQuery(); // 쿼리문 실행
		
		if(rs.next()) {
			guestbook = new Guestbook(); // Guestbook 객체 생성
			guestbook.setGuestbookNo(rs.getInt("guestbookNo")); // guestbookNo 값 set
			guestbook.setGuestbookContent(rs.getString("guestbookContent")); // guestbookContent 값 set
			guestbook.setWriter(rs.getString("writer")); // writer값 set
		} 
		
		rs.close(); // rs 자원반환
		stmt.close(); // stmt 자원반환
		conn.close(); // conn 자원반환
		return guestbook; // return값 : guestbook
		
	}
	//updateGuestbookAction.jsp에서 호출
	// 이름 updateGuestbook
	// 반환타입 수정한 행의 수 반환 -> 0 수정실패, 1 수정성공 -> int
	// 입력매개값 guestbookNo, guestbookContent, guestbookPw 3개 -> 하나의 타입 매개변수로 받고 싶다 -> Guestbook 타입을 사용
	public int updateGuestbook(Guestbook guestbook) throws Exception {
		int row = 0; // int row 기본값으로 선언
		
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null; // DB연결을 위한 변수 conn 선언
		PreparedStatement stmt = null; // 쿼리문 전송을 위한 변수 stmt 선언 
		
		// maria DB url,user,pw 등 선언
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB연결
		
		// 연결할 쿼리문 작성
		String sql = "UPDATE guestbook SET guestbook_content=? WHERE guestbook_no=? AND guestbook_pw=?";
		stmt = conn.prepareStatement(sql); // update sql문 전송
		stmt.setString(1, guestbook.getGuestbookContent()); // GuestbookContent 값 set 
		stmt.setInt(2, guestbook.getGuestbookNo()); // GuestbookNo 값 set
		stmt.setString(3, guestbook.getGuestbookPw()); // GuestbookPw 값 set
		
		System.out.println(stmt+" <-- sql updateGuestbook");  // 디버깅
		
		row = stmt.executeUpdate(); // 쿼리문 실행
		
		if(row == 1) { // 디버깅, row 값이 1일 경우 입력 성공, 아닐경우 실패
			System.out.println("update Guestbook 성공");
		} else {
			System.out.println("update Guestbook 실패");		
		}
		
		
		stmt.close(); // stmt 자원 반환
		conn.close(); // conn 자원 반환
		
		return row; // return값 : row

		
	}
	
	// 삭제(deleteGuestbook) 프로세스 deleteGuestbookAction.jsp 호출
	// 이름 - deleteGuestbook
	// 반환값 - 삭제한 행의 수 반환 -> 0 삭제실패, 1 삭제성공 -> int
	// 입력 매개값 guestbookNo, guestbookPw 2개 -> int, String (Guestbook타입을 사용해도 된다)
	public int deleteGuestbook(int guestbookNo, String guestbookPw) throws Exception {
		int row = 0; // int row 기본값으로 선언
		
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null; // DB연결을 위한 변수 conn 선언
		PreparedStatement stmt = null; // 쿼리문 전송을 위한 변수 stmt 선언 
		
		// maria DB url,user,pw 등 선언
		String dburl = "jdbc:mariadb://localhost:3306/blog"; 
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB연결
		
		// 연결할 쿼리문 작성
		String sql = "DELETE FROM guestbook WHERE guestbook_no=? AND guestbook_pw=?";
		stmt = conn.prepareStatement(sql); // delete sql문 전송
		
		// 쿼리문 ? 값에 대해 set해주기
		stmt.setInt(1, guestbookNo);
		stmt.setString(2, guestbookPw);
		
		System.out.println(stmt+"<-- sql deleteGuestbook"); // 디버깅
		
		row = stmt.executeUpdate(); // 쿼리문 실행
		
		if(row == 1) { // 디버깅, row 값이 1일 경우 입력 성공, 아닐경우 실패
			System.out.println("delete guestbook 성공");
		} else {
			System.out.println("delete guestbook 실패");		
		}
		
		stmt.close(); // stmt 자원반환
		conn.close(); // conn 자원반환
		
		
		return row; // return값 : row
		
		
		
		
	}
	
	
	
	// 입력
	// GuestbookDao guestbookDao = new GuestbookDao ();
	// Guestbook guestbook = new Guestbook();
	// guestbookDao.insertGuestbook(guestbook);
	public void insertGuestbook(Guestbook guestbook) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null; //  DB연결을 위한 변수 conn 선언
		PreparedStatement stmt = null; // 쿼리문 전송을 위한 변수 stmt 선언 
		
		// maria DB url,user,pw 등 선언
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		
		// 연결할 쿼리문 작성
		String sql = "INSERT INTO guestbook(guestbook_content, writer,guestbook_pw, create_date, update_date) VALUES (?,?,?,NOW(),now());";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);  // DB연결
		stmt = conn.prepareStatement(sql); // insert sql문 전송
	
		// 쿼리문 ? 값에 대해 set해주기
		stmt.setString(1, guestbook.getGuestbookContent()); // GuestbookContent 값 set
		stmt.setString(2, guestbook.getWriter());  // Writer 값 set 
		stmt.setString(3, guestbook.getGuestbookPw()); // GuestbookPw 값 set
		
		int row = stmt.executeUpdate(); // 쿼리문 실행
		
		if(row == 1) { // 디버깅, row 값이 1일 경우 입력 성공, 아닐경우 실패
			System.out.println("insert Guestbook 성공");
		} else {
			System.out.println("insert Guestbook 실패");
		}
		
		stmt.close(); // stmt 자원반환
		conn.close(); // conn 자원반환
		
	}
	
	
	// guestbook 전체 행의 수를 반환 메서드
	public int selectGuestbookTotalRow() throws Exception {
		
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		
		Connection conn = null; //  DB연결을 위한 변수 conn 선언
		PreparedStatement stmt = null; // 쿼리문 전송을 위한 변수 stmt 선언
		ResultSet rs = null; //  DB 데이터저장을 위한 변수 rs 선언 
		
		// maria DB url,user,pw 등 선언
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		
		// 연결할 쿼리문 작성
		String sql = "SELECT COUNT(*) cnt FROM guestbook";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB연결
		stmt = conn.prepareStatement(sql); // select sql문 전송
		rs = stmt.executeQuery();   // 쿼리문 실행
		
		if(rs.next()) {
			row = rs.getInt("cnt");
		}
		
		return row;
	}
	
	
	// guestbook n행씩 반환 메서드
	public ArrayList<Guestbook> selectGuestbookListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Guestbook> list = new ArrayList<Guestbook>();
		// guestbook 10행 반환되도록 구현
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 데이터베이스 자원 준비
		Connection conn = null; //  DB연결을 위한 변수 conn 선언
		PreparedStatement stmt = null; // 쿼리문 전송을 위한 변수 stmt 선언
		ResultSet rs = null; //  DB 데이터저장을 위한 변수 rs 선언 
		
		// maria DB url,user,pw 등 선언
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		
		/*
		 SELECT guestbook_no guestbookNo, guestbook_content guestbookContent, writer, create_date createDate 
		 FROM guestbook 
		 ORDER BY create_date 
		 DESC LIMIT ?, ?
		 */
		
		// 연결할 쿼리문 작성
		String sql = "SELECT guestbook_no guestbookNo, guestbook_content guestbookContent, writer, create_date createDate FROM guestbook ORDER BY create_date DESC LIMIT ?, ?";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB연결
		stmt = conn.prepareStatement(sql);  // select sql문 전송
		
		// 쿼리문 ? 값에 대해 set해주기
		stmt.setInt(1, beginRow); // beginRow 값 set
		stmt.setInt(2, rowPerPage); // rowPerPage 값 set
		
		rs = stmt.executeQuery(); // 쿼리문 실행
		// 데이터베이스 로직 끝
		
		// 데이터 변환(가공)
		while(rs.next()) {
			Guestbook g = new Guestbook();
			g.setGuestbookNo(rs.getInt("guestbookNo")); // guestbookNo 값 set
			g.setGuestbookContent(rs.getString("guestbookContent")); // guestbookContent 값 set
			g.setWriter(rs.getString("writer")); // writer 값 set
			g.setCreateDate(rs.getString("createDate")); // createDate 값 set
			list.add(g); // 값들 list에 add
		}
		
		
		// 데이터베이스 자원들 반환
		rs.close(); // rs 자원 반환
		stmt.close(); // stmt 자원 반환
		conn.close(); // conn 자원 반환 
	
		return list; // return값 : list 
	}
}

