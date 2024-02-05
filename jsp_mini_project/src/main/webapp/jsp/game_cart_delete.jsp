<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>선택한 장바구니 삭제</title>
</head>
<body>
	<%@ include file="dbconn.jsp" %>
	<%
		String cartNo[] = request.getParameterValues("check");
		String sql = "DELETE FROM KDH_GAME_CART WHERE CARTNO IN(";	
		for(int i=0; i<cartNo.length; i++){
			if(!"on".equals(cartNo[i])) {
				sql += cartNo[i];
				if(i != cartNo.length-1){
					sql += ",";
				}
			}
		}
		sql += ")";
		stmt.executeUpdate(sql);
	%>
</body>
<script>
	location.href = "game_cart.jsp?userId=" + "<%= session.getAttribute("userId") %>";
</script>
</html>