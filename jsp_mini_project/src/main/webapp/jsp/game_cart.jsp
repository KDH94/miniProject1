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
		color : rgb(103, 193, 245);
		font-weight: bold;
		text-decoration : none;
	}
	td a:hover {
		color : rgb(63, 153, 205);
	}
	.cart-title {
		font-size: 20px;
		font-weight: bold;
		color: #fff;
		margin: 10px;
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
				alert("로그인을 하시고 사용해 주세요!");
				location.href = "game_list.jsp";
			</script>
			<%
		}
		String sql = "SELECT IMAGE, BOARDNO, CARTNO, "
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
	<div class="cart-title">장바구니</div>
	<div class="underLine"></div>
		<form name="game_cart">
			<table>
				<tr>
					<th style=""><input type="checkbox" name="check" id="check_all"></th>
					<th style="">이미지</th>
					<th style="width: 500px">상품명</th>
					<th style="">원가</th>
					<th style="">할인율</th>
					<th style="">할인가</th>
				</tr>
				<%
				int sum_price = 0;
				while(rs.next()) {
					sum_price += rs.getInt("PRICE_DC");
				%>
				<tr>
					<td style="width: 50px"><input type="checkbox" name="check" value="<%= rs.getString("CARTNO") %>"></td>
					<td style="width: 150px"><img src="../img/<%= rs.getString("IMAGE") %>" class="img-size" style="width: 50%; height: 50%;"></td>
					<td>
						<a href="game_view.jsp?boardNo=<%= rs.getString("BOARDNO") %>" style="font-size: 20px"><%= rs.getString("GAMENAME") %></a>
					</td>
					<td><%= rs.getString("PRICE") %>원</td>
					<td><%= rs.getString("DCRATE") %>%</td>
					<td><%= rs.getString("PRICE_DC") %>원</td>
				</tr>
				<%
					}
				%>
				<tr>
					<td><input type="button" name="selectDelete" value="선택 삭제" onclick="fnDelete()"></td>
					<td colspan="4" style="text-align: left;">합계: </td>
					<td><%= sum_price %>원</td>
				</tr>
			</table>
			<input type="button" name="order" value="주문하기" class="login-btn join-btn" style="float: right; margin-top: 10px;">
		</form>
	</div>
	<div class="f-clear"></div>
	<div id="game-footer"></div>
</body>
<script>
	$(function(){
	    $("#game-header").load("game_header.jsp");
	    $("#game-footer").load("game_footer.jsp");
	    
	    $("#check_all").click(function(){
	    	if($("#check_all").is(":checked")) {
	    		$("input[name=check]").prop("checked", true);
	    	} else {
	    		$("input[name=check]").prop("checked", false);
	    	}
	    });
	    
	    $("input[name=check]").click(function() {
	    	var total = $("input[name=check]").length;
	    	var checked = $("input[name=check]:checked").length;
	    	
	    	if(total != checked) {
	    		$("#check_all").prop("checked", false);
	    	} else {
	    		$("#check_all").prop("checked", true);
	    	}
	    });
	});

	function fnDelete() {
		var form = document.game_cart;
		form.action = "game_cart_delete.jsp";
		form.submit();
	}
</script>
</html>