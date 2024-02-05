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
	String itemNo = request.getParameter("itemNo");
	String contents = request.getParameter("contents");
	String rating = request.getParameter("rating");
	String userId = (String)session.getAttribute("userId");
	
	String sql = "INSERT INTO KDH_GAME_BOARD VALUES (KDH_GAME_SEQ.NEXTVAL, '" + itemNo + "', '" + contents + "', '" + rating +"', SYSDATE, SYSDATE)";
													//	BOARDNO, 				ITEMNO, 		CONTENTS, 			RATING, 	CDATETIME, UDATETIME
 	stmt.executeUpdate(sql);
	%>
</body>
<script type="text/javascript">
	alert("게임이 등록됐습니다!");
	location.href = "game_list.jsp";
</script>
</html>