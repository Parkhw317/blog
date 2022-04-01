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
		Connection conn = null;
		PreparedStatement stmt = null;
				
		String dburl = "jdbc:mariadb://localhost:3306/blog"; 
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		
		String sql = "INSERT INTO photo (photo_name, photo_original_name,photo_type,photo_pw,writer,create_date,update_date) VALUES (?, ?, ?, ?, ?, NOW(), NOW())";
		stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, photo.photoName);
		stmt.setString(2, photo.photoOriginalName);
		stmt.setString(3, photo.photoType);
		stmt.setString(4, photo.photoPw);
		stmt.setString(5, photo.writer);
		
		
		int row = stmt.executeUpdate();
		
		if(row == 1) {
			System.out.println("사진업로드 성공");
		} else {
			System.out.println("사진업로드 실패");		}
	

		stmt.close();
		conn.close();
		
		
	}
	
	// 이미지 삭제
	public int deletePhoto(int photoNo, String photoPw) throws Exception { 
		int row = 0;
		
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; 
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		
		String sql = "DELETE FROM photo WHERE photo_no=? AND photo_pw=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, photoNo);
		stmt.setString(2, photoPw);
		
		System.out.println(stmt+"<-- sql deletePhoto");
		
		row = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		
		return row;
	}
	
	
	// 전체 행의 수
	public int selectPhotoTotalRow() {
		int total = 0;
		return total;
	}
	
	// 이미지 목록
		public ArrayList<Photo> selectPhotoListByPage(int beginRow, int rowPerPage) throws Exception {
			ArrayList<Photo> list = new ArrayList<Photo>();
			Class.forName("org.mariadb.jdbc.Driver");
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/blog","root","java1234");
			String sql = "SELECT photo_no photoNo, photo_name photoName FROM photo ORDER BY create_date DESC LIMIT ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Photo p = new Photo();
				p.photoNo = rs.getInt("photoNo");
				p.photoName = rs.getString("photoName");
				list.add(p);
			}
			
			rs.close();
			stmt.close();
			conn.close();
			return list;
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
		
		String photoOneSql = "select photo_no photoNo, photo_name photoName, photo_original_name photoOriginalName, writer writer, create_date createDate, update_date updateDate from photo where photo_no=?";
		PreparedStatement photoOneStmt = conn.prepareStatement(photoOneSql);
		photoOneStmt.setInt(1, photoNo);
		
		System.out.println(photoOneStmt + "◀◀◀◀◀ photoOneStmt"); // 디버깅
		
		
		ResultSet rs = photoOneStmt.executeQuery();
		System.out.println(rs + "◀◀◀◀◀ rs");
		
		Photo photo = null;
		
		while(rs.next()) {
			photo = new Photo();
			photo.photoNo = rs.getInt("photoNo");
			photo.photoName = rs.getString("photoName");
			photo.photoOriginalName = rs.getString("photoOriginalName");
			photo.writer = rs.getString("writer");
			photo.createDate = rs.getString("createDate"); 
			photo.updateDate = rs.getString("updateDate"); 		
		}
		
		rs.close();
		photoOneStmt.close();
		conn.close();
		return photo;
	}
	
	
	public String selectPhotoName(int photoNo) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver"); // 마리아DB 연결
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		System.out.println("드라이버 로딩 성공"); // 마리아DB연결 디버깅
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // 마리아DB 주소
		String dbuser = "root"; // 마리아DB 아이디
		String dbpw = "java1234"; // 마리아DB 패스워드
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // 마리아DB 주소, 아이디, 패스워드 변수 conn값에 입력
		System.out.println(conn + "◀◀◀◀◀ conn"); // 디버깅
		
		String Sql = "SELECT photo_name photoName FROM photo WHERE photo_no = ?";
		stmt = conn.prepareStatement(Sql);
		stmt.setInt(1, photoNo);
		
		System.out.println(stmt + "◀◀◀◀◀ stmt"); // 디버깅
		
		
		rs = stmt.executeQuery();
		System.out.println(rs + "◀◀◀◀◀ rs");

		
		String photoName = "";
		int cnt = 0;
		while (rs.next()) {
			cnt++;
			photoName = rs.getString("photoName");
			System.out.println(cnt + "번째 제목 : " + photoName );
		}
		rs.close();
		stmt.close();
		conn.close();
		
		return photoName;
	}
		

	
	
	
}






















