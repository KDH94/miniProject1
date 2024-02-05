<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form name="cartIn">
	<%@ include file="dbconn.jsp" %>
	<%
		String userId = request.getParameter("userId");
		String itemNo = request.getParameter("itemNo");
	
		String sql = "INSERT INTO KDH_GAME_CART VALUES ('3', '"
				+ userId + "', " + itemNo + ", SYSDATE)";
	 	stmt.executeUpdate(sql);
		//out.println(sql);
	%>	
		<input name="userId" value="<%= userId %>" hidden>	
	</form>
</body>
<script>
	var userId = document.cartIn.userId.value;
	alert("장바구니로 이동합니다!");
	location.href = "game_cart.jsp?userId=" + userId;
</script>
</html>