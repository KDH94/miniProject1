<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table, tr, th, td {
		border : 1px solid black;
		padding : 5px 10px;
		border-collapse: collapse;
		text-align: center;
	}
	th {
		background-color: #eee;
	}
</style>
</head>
<body>
	<%@ include file="dbconn.jsp"%>
	<%
		out.println(session.getAttribute("userId"));
		out.println(session.getAttribute("userName"));
		String sql = "SELECT * FROM KDH_GAME_USER ";
		String word = request.getParameter("keyword");
		String keyword = word != null ? word : "";
		
		if(keyword != null) {
		sql += "WHERE USERNAME LIKE '%" + keyword + "%' OR USERID LIKE '%" + keyword +"%'"; 
		}
		ResultSet rs = stmt.executeQuery(sql);
	%>
	<!-- 	아이디	이름	이메일	돈	-->
	<form name="user_list">
		<div>검색어: 
			<input type="text" name="keyword" value="<%= keyword %>">
			<input type="button" value="검색" onclick="search()">
		</div>
		<table>
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>이메일</th>
				<th>지닌 돈</th>
				<th>수정</th>
				<th>삭제</th>
				<th>비밀번호<br>초기화</th>
			</tr>
		<%
			while(rs.next()){
		%>	
			<tr>
				<td><%= rs.getString("USERID") %></td>
				<td><%= rs.getString("USERNAME") %></td>
				<td><%= rs.getString("EMAIL") %></td>
				<td><%= rs.getString("MONEY") %></td>
				<td><input type="button" onclick="userUpdate('<%= rs.getString("USERID") %>')" value="수정"></td>
				<td><input type="button" onclick="userDelete('<%= rs.getString("USERID") %>')" value="삭제"></td>
				<td>
				<%
					if(rs.getInt("CNT") >= 4) {
				%>
					<input type="button" onclick="userInit('<%= rs.getString("USERID") %>')" value="초기화">
				<%	
					}
				%>
				</td>
			</tr>	
		<%
			}
		%>	
		</table>
	</form>
</body>
<script>
	function userUpdate(userId){
		location.href="user_update.jsp?userId=" + userId;
	}
	function userDelete(userId) {
		if(confirm("정말 삭제하시겠습니까?")) {
			location.href="user_delete.jsp?userId=" + userId;
		} else {
			return;
		}
	}
	function userInit(userId) {
		location.href="user_login_init.jsp?userId=" + userId;
	}
	var user = document.user_list;
	function search() {
		location.href = "game_user_list.jsp?keyword=" + user.keyword.value;
	}
</script>
</html>