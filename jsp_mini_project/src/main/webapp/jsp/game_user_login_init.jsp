<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="dbconn.jsp"%>
	<%
		String userId = request.getParameter("userId");
		stmt.executeUpdate("UPDATE KDH_GAME_USER SET CNT = '" + 0 +"' WHERE USERID = '" + userId + "'");	
	%>
<script>
	alert("해당 유저의 비밀번호 횟수가 초기화되었습니다!");
	location.href="game_user_list.jsp";
</script>
</body>
</html>