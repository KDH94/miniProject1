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
	request.setCharacterEncoding("UTF-8");
	String boardNo = request.getParameter("boardNo");
	String sql = "DELETE FROM KDH_GAME_BOARD WHERE BOARDNO = " + boardNo;
	stmt.executeUpdate(sql);
	%>
</body>
<script>
	alert("등록된 게임이 삭제되었습니다!");
	location.href="board_list.jsp";
</script>
</html>