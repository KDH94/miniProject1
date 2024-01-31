<%@page import="java.awt.Cursor"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../css/mini_project_style.css">
	<meta charset="UTF-8">
	<title>게임 리스트</title>
<style>
	a{
		color : black;
		font-weight: bold;
		text-decoration : none;
	}
	a:visited {
		color : black;
	}
	a:hover {
		color : blue;
	}
	.search {
		margin-bottom: 10px;
	}
</style>
</head>
<body>
	<%@ include file="dbconn.jsp"%>
	<%
		out.println("접속한 id: "+session.getAttribute("userId"));
		out.println("접속한 유저: "+session.getAttribute("userName"));
		String sql = "SELECT BOARDNO, GAMENAME, IMAGE, "
				+ "PRICE, (DISCOUNTRATE * 100) AS DC_RATE, "
				+ "(PRICE * (1 - DISCOUNTRATE)) AS DC_PRICE "
				+ "FROM KDH_GAME_BOARD B "
				+ "INNER JOIN KDH_GAME_PRODUCT P ON B.ITEMNO = P.ITEMNO";
		
		String keyword = request.getParameter("keyword");
		if(keyword != null) {
			sql += "WHERE GAMENAME LIKE '%"+ keyword + "%'";			
		} else {keyword="";}

		ResultSet rs = stmt.executeQuery(sql);
	%>
	<form name="game_list">
		<div class="search">검색어: 
			<input type="text" name="keyword" value="<%= keyword %>">
			<input type="button" value="검색" onclick="search()">
		</div>
		<table border="1">
			<tr>
				<th style="width: 10%">번호</th>
				<th style="width: 40%">게임명</th>
				<th style="width: 10%">이미지</th>
				<th style="width: 15%">원가</th>
				<th style="width: 15%">할인율</th>
				<th style="width: 10%">할인가</th>
			</tr>
		<%
			while(rs.next()){
		%>	
			<tr>
				<td><%= rs.getString("BOARDNO") %></td>
				<td>
					<a href="board_view.jsp?boardNo=<%= rs.getString("BOARDNO") %>"><%= rs.getString("GAMENAME") %></a>
				</td>
				<td>
					<a href="board_view.jsp?boardNo=<%= rs.getString("BOARDNO") %>"><%= rs.getString("IMAGE") %></a>
				</td>
				<td><%= rs.getString("PRICE") %></td>
				<td><%= rs.getString("DC_RATE") %></td>
				<td><%= rs.getString("DC_PRICE") %></td>
			</tr>
		<%
			}
		%>
		</table>
		<input type="submit" value="게임 등록" formaction="game_add.jsp">
	</form>
</body>
<script type="text/javascript">
	var board = document.game_list;
	function search() {
		location.href = "game_list.jsp?keyword=" + board.keyword.value;
	}
</script>
</html>