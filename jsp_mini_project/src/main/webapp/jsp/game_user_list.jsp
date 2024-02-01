<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <link rel="stylesheet" href="../css/mini_project_style.css">
	<meta charset="UTF-8">
	<title>유저 명단</title>
</head>
<body>
	<%@ include file="dbconn.jsp"%>
	<%
		if("U".equals(session.getAttribute("userLevel")) || session.getAttribute("userLevel") == null) {
	%>
		<script>
			alert("관리자만 들어갈 수 있습니다!");
			location.href = "game_list.jsp";
		</script>
	<%
		}
		String sql = "SELECT * FROM KDH_GAME_USER ";
		String word = request.getParameter("keyword");
		String keyword = word != null ? word : "";
		
		if(keyword != null) {
		sql += "WHERE USERNAME LIKE '%" + keyword + "%' OR USERID LIKE '%" + keyword + "%' OR EMAIL LIKE '%" + keyword + "%' AND USERLEVEL = 'U'"; 
		}
		ResultSet rs = stmt.executeQuery(sql);
	%>
	<div id="game-header"></div>
	<!-- 	아이디	이름	이메일	돈	-->
	<div id="container">
	<form name="user_list" style="position: relative; left: 200px;">
		<div style="margin: 10px 5px 20px 5px;"><span style="color: #fff;">검색어: </span>
			<input type="text" name="keyword" value="<%= keyword %>" class="search-input si-alter">
			<input type="button" value="검색" onclick="search()" class="btn-default btn-gh">
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
				<td><input type="button" onclick="userUpdate('<%= rs.getString("USERID") %>')" value="수정" class="btn-default btn-gh"></td>
				<td><input type="button" onclick="userDelete('<%= rs.getString("USERID") %>')" value="삭제" class="btn-default btn-gh"></td>
				<td>
				<%
					if(rs.getInt("CNT") >= 4) {
				%>
					<input type="button" onclick="userInit('<%= rs.getString("USERID") %>')" value="초기화" class="btn-default btn-gh">
				<%	
					}
				%>
				</td>
			</tr>	
		<%
			}
			conn.close();
		%>	
		</table>
	</form>
	</div>
	<div id="game-footer"></div>
</body>
<script>
	function userUpdate(userId){
		location.href="game_user_update.jsp?userId=" + userId;
	}
	function userDelete(userId) {
		if(confirm("정말 삭제하시겠습니까?")) {
			location.href="game_user_delete.jsp?userId=" + userId;
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
    $(function(){
        $("#game-header").load("game_header.jsp");
        $("#game-footer").load("game_footer.jsp");
    });
</script>
</html>