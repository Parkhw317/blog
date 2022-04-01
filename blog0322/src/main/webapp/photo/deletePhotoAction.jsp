<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "vo.*" %>
<%
	// 1) 테이블 데이터 삭제 <- photoNo 필요
	// 2) upload폴더에 이미지 삭제 <-- photoName

	int photoNo = Integer.parseInt(request.getParameter("photoNo"));
	String photoPw = request.getParameter("photoPw");
	
	System.out.println(photoNo + "◀◀◀◀◀ photoNo"); // 디버깅
	System.out.println(photoPw + "◀◀◀◀◀ photoPw"); // 디버깅
	
	PhotoDao photoDao = new PhotoDao();
	
	String photoName = photoDao.selectPhotoName(photoNo);
	// 1) 테이블 데이터 삭제
	int delRow = photoDao.deletePhoto(photoNo, photoPw);
	// 2) 폴더 이미지 삭제
	if(delRow == 1) { // 테이블 데이터 삭제 성공
		String path = application.getRealPath("upload"); // application(현재프로젝트)안의 upload폴더의 실제 폴더경로를 반환
		File file = new File(path+"\\"+photoName); // 이미지 파일을 불러온다. java.io.File  
		file.delete(); // 이미지 파일을 삭제
		response.sendRedirect(request.getContextPath()+"/photo/photoList.jsp"); // 이동...
	} else {
		System.out.println("삭제 실패!");
		response.sendRedirect(request.getContextPath()+"/photo/deletePhotoForm.jsp?photoNo=" + photoNo); // 이동....
	}

	

%>