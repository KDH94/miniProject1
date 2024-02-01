<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="dbconn.jsp" %>
	<%	
	String title = request.getParameter("title");
	String contents = request.getParameter("contents");
	String userId = (String)session.getAttribute("userId");
	
	String sql = "INSERT INTO KDH_GAME_BOARD VALUES (bbs_seq.NEXTVAL, '" + title + "', '" + contents + "', 0, '" + userId +"', 2, SYSDATE, SYSDATE)";
											//	BOARDNO, 			TITLE, 			CONTENTS, 		HIT, 	USERID, 	KIND, CDATETIME, UDATETIME 
 	stmt.executeUpdate(sql);
	%>
</body>
<script type="text/javascript">
	alert("게시글이 등록됐습니다!");
	location.href = "board_list.jsp";
</script>
</html>