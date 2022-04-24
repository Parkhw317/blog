<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "java.io.File" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// insertPhotoAction.jsp
	
	/*
	
	form태그의 enctype="multipart/form-data"로 넘겨져서 request.getParameter() API를 사용할 수 없다.
	
	
	
	String writer = request.getParameter("writer");
	System.out.println("writer");
	
	String photo = request.getParameter("photo");
	System.out.println("photo");
	
	request.getParameter() API 대신다른 API를 사용해야 하는데 너무 복잡함.
	--> request를 단순하게 사용하게 해주는 cos.jar같은 API(외부라이브리)를 사용하자.
	*/

	request.setCharacterEncoding("utf-8");
	String path = application.getRealPath("upload"); // application변수 톰켓을 가르키는 변수
	// DefaultFileRenamePolicy rp = new DefaultFileRenamePolicy();
	MultipartRequest multiReq = new MultipartRequest(request, path, 1024*1024*100, "utf-8", new DefaultFileRenamePolicy());
	// 2^10 byte = 1kbyte 1024 byte = 1kbte
	// 2^10 kbyte = 1mbtee
	// 100 mbyte = 1024*1024*100 byte = 104857600 byte 곱셈을 계산해서 코딩하면 가독성이 떨어진다 24*65*60
	
	String photoPw = multiReq.getParameter("photoPw");
	String writer = multiReq.getParameter("writer");
	
	// <input type="file" name="photo"> 처리
	String photoOriginalName = multiReq.getOriginalFileName("photo"); // 파일 업로드시 원본의 이름
	String photoName = multiReq.getFilesystemName("photo"); // new DefaultFileRenamePolicy()객체를 통해 변경된 이름
	String photoType = multiReq.getContentType("photo");
	
	System.out.println(photoPw + "<-- photoPw");
	System.out.println(writer + "<-- writer");
	System.out.println(photoOriginalName + "<-- String photoOriginalName");
	System.out.println(photoName + "<-- photoName");
	System.out.println(photoType + "<-- photoType");

	
	// 파일업로드의 경우 100mbyte 이하의 image/gif, image/png, image/jpeg 3가지 이미지만 허용
	if(photoType.equals("image/gif") || photoType.equals("image/png") || photoType.equals("image/jpeg")) {
		// db에 저장...
		System.out.println("db고고!");
		PhotoDao photoDao = new PhotoDao();
		Photo photo = new Photo();
		photo.photoName = photoName;
		photo.photoOriginalName = photoOriginalName;
		photo.photoType = photoType;
		photo.photoPw = photoPw;
		photo.writer = writer;
		
		photoDao.insertPhoto(photo); // 메서드 구현
		response.sendRedirect(request.getContextPath()+"/photo/photoList.jsp");
	
		
	} else {
		// 업로드 취소
		System.out.println("이미지파일만 업로드하세요!");
		// 잘못들어온 파일이므로 업로드된 파일 지우고 폼으로 이동...
		File file = new File(path+"\\"+photoName); // java.io.file 잘못된 파일을 불러온다. / or \\
		file.delete();
		response.sendRedirect(request.getContextPath()+"/photo/insertPhotoForm.jsp");
	}
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
%>