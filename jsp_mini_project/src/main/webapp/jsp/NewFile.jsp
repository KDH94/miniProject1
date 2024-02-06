<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String all="";
String onetwo="";
String onefive="";
String oneeight="";
String db="18";

if(db.equals("12")){
	onetwo="selected";
} else if(db.equals("all")){
	all="selected";
} else if(db.equals("18")){
	oneeight="selected";
} else if(db.equals("15")){
	onefive="selected";
}
%>

<select name="rating"  class="join-input">
							<option value="ALL" <%=all %>>전체이용가</option>
							<option value="12" <%=onetwo %>>12세</option>
							<option value="15" <%=onefive %>>15세</option>
							<option value="18" <%=oneeight %>>18세</option>
						</select>

</body>
</html>