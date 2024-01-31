<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 중복 검사</title>
</head>
<body>
	<form name="dbCheck">
	<%@ include file="dbconn.jsp" %>
	<%
	String userId = request.getParameter("userId");
	String sql = "SELECT * FROM KDH_GAME_USER WHERE USERID = '" + userId + "'";
	ResultSet rs = stmt.executeQuery(sql);
	if(rs.next()) {
		out.println("중복된 아이디입니다!");
		%>
		<div><input type="text" name="userId"></div>
		<input type="button" value="중복 체크" onclick="idCheck()">
		<%
	} else {
		out.println("사용 가능한 아이디입니다!");
	}
	%>
		<input type="button" value="닫기" onclick="popClose('<%= userId %>')">
	</form>
</body>
<script>
	function popClose(userId) {
		opener.document.join.userId.value = userId;
		window.close();
	}
	function idCheck() {
		var userId = document.dbCheck.userId.value;
		if(userId == "" || userId == undefined || userId =="null") {
			alert("아이디를 입력해 주세요!");
			return;
		} else {
			location.href = "game_user_idCheck.jsp?userId=" + userId;
		}
	}
</script>
</html>