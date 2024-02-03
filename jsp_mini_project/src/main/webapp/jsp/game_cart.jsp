<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <link rel="stylesheet" href="../css/mini_project_style.css">
	<meta charset="UTF-8">
	<title>장바구니</title>
<style>
	td a {
		color : #fff;
		font-weight: bold;
		text-decoration : none;
	}
	td a:hover {
		color : #aaa;
	}
</style>
</head>
<body>
	<%@ include file="dbconn.jsp" %>
	<%
		/* String userId = request.getParameter("userId"); */
		String userId = (String)session.getAttribute("userId");
		if(userId == null) {
			%>
			<script>
				alert("장바구니는 로그인 이후에 사용해 주세요!");
				location.href = "game_list.jsp";
			</script>
			<%
		}
		String sql = "SELECT IMAGE, BOARDNO, "
				+ "SUBSTR(GAMENAME, 1, INSTR(GAMENAME, '/')-1) AS GAMENAME, " 
				+ "PRICE, (DISCOUNTRATE * 100) AS DCRATE, (PRICE * (1- DISCOUNTRATE)) AS PRICE_DC "
				+ "FROM KDH_GAME_CART C "
				+ "INNER JOIN KDH_GAME_PRODUCT P ON C.ITEMNO = P.ITEMNO "
				+ "INNER JOIN KDH_GAME_BOARD B ON C.ITEMNO = B.ITEMNO "
				+ "WHERE USERID = '" + userId + "'";
		ResultSet rs = stmt.executeQuery(sql);
	%>
	<div id="game-header"></div>
	<div id="container">
		<form name="game_cart">
			<table>
				<tr>
					<th style=""><input type="checkbox" name="check_all" id="check_all"></th>
					<th style="">이미지</th>
					<th style="">상품명</th>
					<th style="">원가</th>
					<th style="">할인율</th>
					<th style="">할인가</th>
				</tr>
				<tr>
				<%
					int sum_price = 0;
					while(rs.next()) {
				%>
					<td style="width: 50px"><input type="checkbox"></td>
					<td style="width: 150px"><img src="../img/<%= rs.getString("IMAGE") %>" class="img-size" style="width: 50%; height: 50%;"></td>
					<td>
						<a href="game_view.jsp?boardNo=<%= rs.getString("BOARDNO") %>"><%= rs.getString("GAMENAME") %></a>
					</td>
					<td><%= rs.getString("PRICE") %>원</td>
					<td><%= rs.getString("DCRATE") %>%</td>
					<td><%= rs.getString("PRICE_DC") %>원</td>
				<%
					sum_price += rs.getInt("PRICE_DC");
					}
				%>
				</tr>
				<tr>
					<td><input type="button" name="selectDelete" value="선택 삭제"></td>
					<td colspan="4" style="text-align: left;">합계: </td>
					<td><%= sum_price %>원</td>
				</tr>
			</table>
			<input type="button" name="order" value="주문하기">
		</form>
	</div>
	<div id="game-footer"></div>
</body>
<script>
	$(function(){
	    $("#game-header").load("game_header.jsp");
	    $("#game-footer").load("game_footer.jsp");
	});
</script>
</html>