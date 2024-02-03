<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 삭제 완료</title>
</head>
<body>
	<%@ include file="dbconn.jsp"%>
	<%
	String userId = request.getParameter("userId");
	ResultSet rs = stmt.executeQuery("SELECT * FROM KDH_GAME_USER WHERE USERID = '" + userId + "'");
	if(rs.next()) {
		if(rs.getString("USERID").equals(userId)) {
			String sql = "DELETE FROM KDH_GAME_USER WHERE USERID = '" + userId + "'";
			int cnt = stmt.executeUpdate(sql);
			if(cnt > 0) {
				if(request.isRequestedSessionIdValid() && "U".equals(session.getAttribute("userLevel"))) {
					session.invalidate();
				%>
					<script>
					alert("탈퇴되었습니다!");
					location.href = "game_list.jsp";
					</script>
				<%
				}
			} else {
				%>
					<script>
					alert("다시 시도해 주세요!");
					location.href = "game_list.jsp";
					</script>
				<%
			}
		}
	} else {
		%>
			<script>
			alert("존재하지 않는 아이디입니다!");
			location.href = "game_list.jsp";
			</script>
		<%
	}
	%>
</body>
</html>