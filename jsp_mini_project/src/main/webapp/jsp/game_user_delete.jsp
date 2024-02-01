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
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");

	ResultSet rs = stmt.executeQuery("SELECT * FROM KDH_GAME_USER WHERE USERID = '" + id + "'");
	if(rs.next()) {
		if(rs.getString("USERID").equals(id)) {
			String sql = "DELETE FROM KDH_GAME_USER WHERE USERID = '" + id + "'";
			int cnt = stmt.executeUpdate(sql);
			if(cnt > 0) {
				out.println("아이디가" + id + "인 회원의 정보가 삭제됐습니다!");
			} else {
				out.println("다시 시도해 주세요!");
			}
		}
	} else {
		out.println(id + "은(는) 존재하지 않는 아이디입니다!");
	}
	%>
</body>
<!-- <script type="text/javascript">
	alert("유저가 삭제되었습니다!");
	location.href = "game_user_list.jsp";
</script> -->
</html>