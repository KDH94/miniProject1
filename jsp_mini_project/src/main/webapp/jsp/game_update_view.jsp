<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게임 등록 진행</title>
</head>
<body>
	<%@ include file="dbconn.jsp" %>
	<%@ page import="java.io.*,java.util.*"%>
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
	<%
		request.setCharacterEncoding("UTF-8");
		String itemNo = request.getParameter("itemNo");
		String gameName = request.getParameter("gameName");
		String price = request.getParameter("price");
		String image = "";
		float discountRate = (Float.parseFloat(request.getParameter("discountRate")) / 100);
		String cDateTime = request.getParameter("cDateTime");
		String video = request.getParameter("video");
		String contents = request.getParameter("contents");
		String rating = request.getParameter("rating");
		
		String sql = "INSERT INTO KDH_GAME_BOARD VALUES (KDH_GAME_SEQ.NEXTVAL, '" + itemNo + "', '" + contents + "', '" + rating +"', SYSDATE, SYSDATE)";
													//	 BOARDNO, 					ITEMNO, 		  CONTENTS, 		  RATING, 	 CDATETIME, UDATETIME
		out.println(sql);
	 	stmt.executeUpdate(sql);
											
	 	String uploadPath = "C:/Users/tj-bu-706-07/git/miniProject1/jsp_mini_project/src/main/webapp/img/";
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
		            image = fileName;
		        }
		    }
		} catch (Exception e) {
		    responseMessage = "파일 업로드 실패: " + e.getMessage();
		}
		out.println(responseMessage);
	 	sql = "INSERT INTO KDH_GAME_PRODUCT VALUES ('" + itemNo + "', '" + gameName + "', '" + price + "', '" + image +  "', " + discountRate + ", '" + cDateTime + "', '" + video + "')";
													//	 ITEMNO, 		   GAMENAME,		   PRICE, 		  	IMAGE, 			 DISCOUNTRATE, 		    CDATETIME,			 VIDEO
	 	out.println(sql);
	 	stmt.executeUpdate(sql);
	%>

</body>
<script type="text/javascript">
 	alert("게임이 등록됐습니다!");
	location.href = "game_list.jsp";
</script>
</html>