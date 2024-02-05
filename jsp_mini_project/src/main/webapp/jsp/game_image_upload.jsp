<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 업로드</title>
</head>
<body>
	<%@ page import="java.io.*,java.util.*"%>
	<%
		String uploadPath = request.getServletContext().getRealPath("/") + "img/"; // 원하는 경로

		// 해당 폴더 없으면 생성해 줌
		File uploadDir = new File(uploadPath);
		if (!uploadDir.exists()) {
		    uploadDir.mkdir();
		}
		
		String fileName = "";
		String responseMessage = "";
		try {
		    for (Part part : request.getParts()) {
		        fileName = getFileName(part);
		        if (!fileName.isEmpty()) {
		            part.write(uploadPath + fileName);
		            responseMessage = "파일 업로드 완료: " + fileName;
		        }
		    }
		} catch (Exception e) {
		    responseMessage = "파일 업로드 실패: " + e.getMessage();
		}
		out.println(responseMessage);
	%>
	<%!
		private String getFileName(Part part) {
		    for (String content : part.getHeader("content-disposition").split(";")) {
		        if (content.trim().startsWith("filename")) {
		            return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
		        }
		    }
		    return "";
		}
	%>
</body>
</html>