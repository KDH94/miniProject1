<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <link rel="stylesheet" href="../css/mini_project_style.css">
	<meta charset="UTF-8">
	<title>게임 주문</title>
</head>
<body>
	<form name="cartBuy" id="cartBuyForm">
	<%@ include file="dbconn.jsp" %>
	<%
		Object moneyObj = session.getAttribute("money");
		int sumPrice = Integer.parseInt(request.getParameter("sumPrice"));
		
        if (moneyObj == null) {
    %>
            <script>
                alert("금액 정보를 가져올 수 없습니다.");
                location.href = "game_cart.jsp?userId=<%= session.getAttribute("userId") %>";
            </script>
    <%
        }

        int money = 0; // 기본값 설정
        try {
            money = Integer.parseInt(String.valueOf(moneyObj));
        } catch (NumberFormatException e) {
            // 숫자로 변환할 수 없는 경우
            e.printStackTrace(); // 또는 로그 등을 통해 에러 확인
            // 처리할 내용을 여기에 추가할 수 있습니다.
        }
		int leftMoney = money-sumPrice;
		String userId = (String)session.getAttribute("userId");
		String cartNo[] = request.getParameterValues("check");
		
		if(leftMoney >= 0) {
			String sql = "UPDATE KDH_GAME_USER SET MONEY = " + leftMoney + " WHERE USERID = '" + userId + "'";
			stmt.executeUpdate(sql);
			%>
				<%-- <input type="hidden" name="cartNo" value="<%= cartNo %>"> --%>
				<script>
					alert("선택한 상품이 구매되었습니다!");
					// 마이페이지에서 구매한 상품 보기는 미구현
					location.href = "game_cart_delete.jsp?cartNo="+ <%= String.join(",", cartNo) %> + "&fromSecondCode=true";
				</script>
			<%
		} else {
		%>
				<input type="hidden" name="userId" value="<%= userId %>">
				<input type="hidden" name="cash" value="<%= leftMoney %>">
			<script>
				var cash = document.cartBuy.cash.value;
				alert(cash+"원이 부족하여 구매할 수 없습니다!");
				// 현재 admin이 직접 쳐서 넣어줘야 함
				location.href = "game_cart.jsp?userId=" + userId;
			</script>
		<%
		}
	%>
	</form>
</body>
</html>