package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import vo.Photo;

public class PhotoDao {
	// 이미지 입력
	public void insertPhoto(Photo photo) throws Exception {
	
		
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null; //  DB연결을 위한 변수 conn 선언
		PreparedStatement stmt = null; // 쿼리문 전송을 위한 변수 stmt 선언 
				
		// maria DB url,user,pw 등 선언
		String dburl = "jdbc:mariadb://localhost:3306/blog"; 
		String dbuser = "root";
		String dbpw = "java1234";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB연결
		
		// 연결할 쿼리문 작성
		String sql = "INSERT INTO photo (photo_name, photo_original_name,photo_type,photo_pw,writer,create_date,update_date) VALUES (?, ?, ?, ?, ?, NOW(), NOW())";
		stmt = conn.prepareStatement(sql); // insert sql문 전송
		
		// 쿼리문 ? 값에 대해 set해주기
		stmt.setString(1, photo.getPhotoName()); // PhotoName 값 set 
		stmt.setString(2, photo.getPhotoOriginalName()); // PhotoOriginalName 값 set
		stmt.setString(3, photo.getPhotoType()); // PhotoType 값 set
		stmt.setString(4, photo.getPhotoPw()); // PhotoPw 값 set
		stmt.setString(5, photo.getWriter()); // Writer 값 set  
		
		
		int row = stmt.executeUpdate(); // 쿼리문 실행
		
		if(row == 1) { // 디버깅, row 값이 1일 경우 입력 성공, 아닐경우 실패
			System.out.println("사진업로드 성공");
		} else {
			System.out.println("사진업로드 실패");		}
	

		stmt.close(); // stmt 자원반환
		conn.close(); // conn 자원반환
		
		
	}
	
	// 이미지 삭제
	public int deletePhoto(int photoNo, String photoPw) throws Exception { 
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
		String sql = "DELETE FROM photo WHERE photo_no=? AND photo_pw=?";
		stmt = conn.prepareStatement(sql); // delete sql문 전송
		
		// 쿼리문 ? 값에 대해 set해주기
		stmt.setInt(1, photoNo);
		stmt.setString(2, photoPw);
		
		System.out.println(stmt+"<-- sql deletePhoto");  // 디버깅
		
		row = stmt.executeUpdate(); // 쿼리문 실행
		
		if(row == 1) { // 디버깅, row 값이 1일 경우 입력 성공, 아닐경우 실패
			System.out.println("delete Photo 성공");
		} else {
			System.out.println("delete Photo 실패");		
		}
		
		
		stmt.close(); // stmt 자원 반환
		conn.close(); // conn 자원 반환
		
		return row; // return값 : row
	}
	
	
	// 전체 행의 수
	public int selectPhotoTotalRow() throws Exception {
		
		int total = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		
		Connection conn = null; //  DB연결을 위한 변수 conn 선언
		PreparedStatement stmt = null; // 쿼리문 전송을 위한 변수 stmt 선언
		ResultSet rs = null; //  DB 데이터저장을 위한 변수 rs 선언 
		
		// maria DB url,user,pw 등 선언
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";

		// 연결할 쿼리문 작성
		String sql = "SELECT COUNT(*) cnt FROM photo";
		
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB연결
		stmt = conn.prepareStatement(sql); // select sql문 전송
		rs = stmt.executeQuery();   // 쿼리문 실행
		
		if(rs.next()) {
			total = rs.getInt("cnt");
		}

		
		return total;
	}
	
	// 이미지 목록
		public ArrayList<Photo> selectPhotoListByPage(int beginRow, int rowPerPage) throws Exception {
			ArrayList<Photo> list = new ArrayList<Photo>();
			
			Class.forName("org.mariadb.jdbc.Driver");
			
			Connection conn = null;//  DB연결을 위한 변수 conn 선언
			PreparedStatement stmt = null; // 쿼리문 전송을 위한 변수 stmt 선언
			ResultSet rs = null;//  DB 데이터저장을 위한 변수 rs 선언 
			
			
			conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/blog","root","java1234"); // DB연결
			
			// 연결할 쿼리문 작성
			String sql = "SELECT photo_no photoNo, photo_name photoName FROM photo ORDER BY create_date DESC LIMIT ?,?";
			
			stmt = conn.prepareStatement(sql); // select sql문 전송
			
			// 쿼리문 ? 값에 대해 set해주기
			stmt.setInt(1, beginRow); // beginRow 값 set
			stmt.setInt(2, rowPerPage); // rowPerPage 값 set
			
			rs = stmt.executeQuery(); // 쿼리문 실행
			
			while(rs.next()) { // 데이터 변환(가공)
				Photo p = new Photo();
				p.setPhotoNo(rs.getInt("photoNo")); // photoNo 값 set 
				p.setPhotoName(rs.getString("photoName")); // photoName 값 set  
				list.add(p); // 값드 list에 add
			}
			
			rs.close(); // rs 자원 반환
			stmt.close(); // stmt 자원 반환
			conn.close(); // conn 자원 반환
			
			return list; // return값 : list
			
		}
	
	


	
	// 이미지 하나 상세보기
	public Photo selectPhotoOne(int photoNo) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver"); // 마리아DB 연결
		System.out.println("드라이버 로딩 성공"); // 마리아DB연결 디버깅
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // 마리아DB 주소
		String dbuser = "root"; // 마리아DB 아이디
		String dbpw = "java1234"; // 마리아DB 패스워드
		Connection conn = DriverManager.getConnection(dburl, dbuser, dbpw); // 마리아DB 주소, 아이디, 패스워드 변수 conn값에 입력
		System.out.println(conn + "◀◀◀◀◀ conn"); // 디버깅
		
		// 연결할 쿼리문 작성
		String photoOneSql = "select photo_no photoNo, photo_name photoName, photo_original_name photoOriginalName, writer writer, create_date createDate, update_date updateDate from photo where photo_no=?";
		PreparedStatement photoOneStmt = conn.prepareStatement(photoOneSql); // select sql문 전송
		photoOneStmt.setInt(1, photoNo); // 쿼리문 ? 값에 대해 set해주기
		
		System.out.println(photoOneStmt + "◀◀◀◀◀ photoOneStmt"); // 디버깅
		
		ResultSet rs = photoOneStmt.executeQuery(); // 쿼리문 실행
		System.out.println(rs + "◀◀◀◀◀ rs"); // 디버깅
		
		Photo photo = null; // photo 변수 null값 선언
		
		while(rs.next()) { // 데이터 변환(가공)
			photo = new Photo();
			photo.setPhotoNo(rs.getInt("photoNo")); // photoNo 값 set
			photo.setPhotoName(rs.getString("photoName")); // photoName 값 set
			photo.setPhotoOriginalName(rs.getString("photoOriginalName")); // photoOriginalName 값 set
			photo.setWriter(rs.getString("writer")); // writer 값 set
			photo.setCreateDate(rs.getString("createDate")); // createDate 값 set
			photo.setUpdateDate(rs.getString("updateDate")); // updateDate 값 set 
		}
		
		rs.close(); // rs 자원 반환
		photoOneStmt.close(); // stmt 자원 반환
		conn.close(); // conn 자원 반환
		
		return photo; // return 값 : photo
	}
	
	
	public String selectPhotoName(int photoNo) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver"); // 마리아DB 연결
		
		Connection conn = null;//  DB연결을 위한 변수 conn 선언
		PreparedStatement stmt = null; // 쿼리문 전송을 위한 변수 stmt 선언
		ResultSet rs = null;//  DB 데이터저장을 위한 변수 rs 선언 
		
		System.out.println("드라이버 로딩 성공"); // 마리아DB연결 디버깅
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // 마리아DB 주소
		String dbuser = "root"; // 마리아DB 아이디
		String dbpw = "java1234"; // 마리아DB 패스워드
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // 마리아DB 주소, 아이디, 패스워드 변수 conn값에 입력, 연결
		
		System.out.println(conn + "◀◀◀◀◀ conn"); // 디버깅
		
		// 연결할 쿼리문 작성
		String Sql = "SELECT photo_name photoName FROM photo WHERE photo_no = ?";
		stmt = conn.prepareStatement(Sql); // select sql문 전송
		stmt.setInt(1, photoNo); // 쿼리문 ? 값에 대해 set해주기
		
		System.out.println(stmt + "◀◀◀◀◀ stmt"); // 디버깅
		
		rs = stmt.executeQuery(); // 쿼리문 실행
		System.out.println(rs + "◀◀◀◀◀ rs"); // 디버깅

		
		String photoName = ""; // photoName ""값으로 변수 선언 
		int cnt = 0; // cnt 변수 선언
		
		while (rs.next()) { // 사진 업로드시 cnt, photoName 가공
			cnt++;
			photoName = rs.getString("photoName");
			System.out.println(cnt + "번째 제목 : " + photoName );
		}
		
		rs.close(); // rs 자원 반환
		stmt.close(); // stmt 자원 반환
		conn.close(); // conn 자원 반환
		
		return photoName; // return 값 : photoName
	}
		

	
}









