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
		String cartNo[] = request.getParameterValues("check");
		String sql = "DELETE FROM KDH_GAME_CART WHERE CARTNO IN(";	
		for(int i=0; i<cartNo.length; i++){
			sql += cartNo[i];
			if(i != cartNo.length-1){
				sql += ",";
			}
		}
		sql += ")";
		out.println(sql);
	%>
</body>
</html>