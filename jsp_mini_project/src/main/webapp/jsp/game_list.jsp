<%@page import="java.awt.Cursor"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <link rel="stylesheet" href="../css/mini_project_style.css">
	<meta charset="UTF-8">
	<title>게임 리스트</title>
<style>
	a{
		color : #fff;
		font-weight: bold;
		text-decoration : none;
	}
	a:visited {
		color : #eee;
	}
	a:hover {
		color : blue;
	}
</style>
</head>
<body>
	<%@ include file="dbconn.jsp"%>
	<%
		out.println("접속한 id: "+session.getAttribute("userId"));
		out.println("접속한 유저: "+session.getAttribute("userName"));
		String sql = "SELECT BOARDNO, GAMENAME, IMAGE, "
				+ "SUBSTR(GAMENAME, 1, INSTR(GAMENAME, '/')-1) AS GAMENAME2, "
				+ "PRICE, (DISCOUNTRATE * 100) AS DC_RATE, "
				+ "(PRICE * (1 - DISCOUNTRATE)) AS DC_PRICE "
				+ "FROM KDH_GAME_BOARD B "
				+ "INNER JOIN KDH_GAME_PRODUCT P ON B.ITEMNO = P.ITEMNO ";
		
		String keyword = request.getParameter("keyword");
		if(keyword != null) {
			keyword = keyword.toUpperCase();
			sql += "WHERE GAMENAME LIKE '%"+ keyword + "%'";			
		} else {
			keyword = "";
		}

		ResultSet rs = stmt.executeQuery(sql);
	%>
    <div id="game-header"></div>
	<div id="container">
		<form name="game_list">
<%-- 			<div class="search">검색어:
				<input type="text" name="keyword" id="keyword" value="<%= keyword %>" class="search-input si-alter">
				<input type="submit" value="검색" onclick="search()" class="btn-default btn-gh" id="searchGame">
			</div> --%>
			<table border="1">
				<tr>
					<th style="width: 7%">번호</th>
					<th style="width: 30%">게임명</th>
					<th style="width: 35%">이미지</th>
					<th style="width: 10%">원가(원)</th>
					<th style="width: 10%">할인율(%)</th>
					<th style="width: 12%">할인가(원)</th>
				</tr>
			<%
				while(rs.next()){
			%>	
				<tr>
					<td><%= rs.getString("BOARDNO") %></td>
					<td>
						<a href="game_view.jsp?boardNo=<%= rs.getString("BOARDNO") %>"><%= rs.getString("GAMENAME2") %></a>
					</td>
					<td>
						<a href="game_view.jsp?boardNo=<%= rs.getString("BOARDNO") %>"><%= rs.getString("IMAGE") %></a>
					</td>
					<td><%= rs.getString("PRICE") %></td>
					<td><%= rs.getString("DC_RATE") %></td>
					<td><%= rs.getString("DC_PRICE") %></td>
				</tr>
			<%
				}
				conn.close();
			%>
			</table>
			<%
				if("A".equals(session.getAttribute("userLevel"))) {
			%>
					<div class="right-sorting">
						<input type="submit" value="게임 등록" formaction="game_add.jsp" class="btn-default btn-gh">
						<input type="submit" value="게임 삭제" formaction="game_remove.jsp" class="btn-default btn-gh">
					</div>
					<div style="clear: both;"></div>
			<%		
				}
			%>
		</form>
	</div>
    <div id="game-footer"></div>
</body>
<script type="text/javascript">
	$("input[type='submit']").keydown(function() {
		if(e.keyCode === 13) {
				e.preventDefault();
		}
	});
    $(function(){
        $("#game-header").load("game_header.jsp");
        $("#game-footer").load("game_footer.jsp");
    });
/* 	function search() {
		var board = document.game_list;
		location.href = "game_list.jsp?keyword=" + board.keyword.value;
	} */
</script>
</html>