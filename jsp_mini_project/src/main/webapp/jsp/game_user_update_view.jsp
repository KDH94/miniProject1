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
		request.setCharacterEncoding("UTF-8");
		String userId = request.getParameter("userId");
		String userPwd = request.getParameter("userPwd");
		String userName = request.getParameter("userName");
		String email_f = request.getParameter("email");
		String email_b = request.getParameter("email2");
		String email = email_f + email_b;
		
		String pwdStr = "";
		if(userPwd != null && !userPwd.equals("")) {
			pwdStr = "USERPWD = '" + userPwd + "',";
		}
		
		String sql 
			= "UPDATE KDH_GAME_USER SET "
			+ pwdStr
			+ "USERNAME = '" + userName + "', "
			+ "EMAIL = '" + email + "' "
			+ "WHERE USERID = '" + userId + "'";
		stmt.executeUpdate(sql);
	%>
</body>
<script type="text/javascript">
	alert("회원의 정보가 수정됐습니다!");
	location.href = "game_user_list.jsp";
</script>
</html>