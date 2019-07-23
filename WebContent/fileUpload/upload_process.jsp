<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>업로드 처리</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String savePath = "/fileUpload/upload"; //다운받는 경로 설정
	int uploadFileSizeLimit = 5 * 1024 * 1024; //5m로 크기 제한
	String encType = "UTF-8"; //char인코딩 방식
	
	//서버 상의 실제 경로 설정
	ServletContext context = getServletContext();
	String uploadFilePath = context.getRealPath(savePath);
	System.out.println("서버상의 실제 디렉터리");
	System.out.println(uploadFilePath);
	//MultipartRequest클래스 객체 생성
	try {
		MultipartRequest multi = new MultipartRequest(
				request, //request 객체
				uploadFilePath, //서버 상의 실제 데이터
				uploadFileSizeLimit, //최대 업로드 파일크기
				encType, //인코딩 타입
				new DefaultFileRenamePolicy());
		String fileName = multi.getFilesystemName("uploadFile");
		if(fileName == null) {
			System.out.print("파일업로드 실패");
		}
		else {
			out.println("<br> 글쓴이 : " + multi.getParameter("name"));
			out.println("<br> 제 &nbsp; 목 : " + multi.getParameter("title"));
			out.println("<br> 파일명 : " + fileName);
		}
	} catch (Exception e) {
		System.out.print("예외 발생 : " + e);
		e.printStackTrace();
	}
%>
</body>
</html>