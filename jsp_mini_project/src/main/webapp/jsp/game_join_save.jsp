<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 저장</title>
</head>
<body>
	<%@ include file="dbconn.jsp"%>
	<%
		request.setCharacterEncoding("UTF-8");
		
		String userId = request.getParameter("userId");
		String userPwd = request.getParameter("userPwd");
		String userName = request.getParameter("userName");
		String email_f = request.getParameter("email");
		String email_b = request.getParameter("email2");
		String email = email_f + "@" + email_b;
		
		String sql = "INSERT INTO KDH_GAME_USER "
				+ "(USERID, USERPWD, USERNAME, EMAIL, USERLEVEL, CDATETIME, UDATETIME) VALUES ('"
				+ userId +"', '" + userPwd + "', '" + userName +  "', '" + email + "', 'U', SYSDATE, SYSDATE)";
		stmt.executeUpdate(sql);

	%>
		<form name="userName">
			<input type="text" name="userName" value="<%= userName %>" hidden>
		</form>
		<div><%= userName %> 회원님, 가입을 환영합니다!</div>
</body>
<script type="text/javascript">
	var userName = document.userName.userName.value;
	alert(userName + " 회원님, 가입을 환영합니다!\n로그인 후 사이트 이용 바랍니다.")
	location.href = "game_list.jsp";
</script>
</html>