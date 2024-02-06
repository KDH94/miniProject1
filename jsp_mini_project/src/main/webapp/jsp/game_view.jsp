<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <link rel="stylesheet" href="../css/mini_project_style.css">
	<meta charset="UTF-8">
	<title>게임 상세 정보</title>
</head>
<body>
<%@ include file="dbconn.jsp" %>
<%
	String boardNo = request.getParameter("boardNo");
	String sql = "SELECT IMAGE, PRICE, VIDEO, P.ITEMNO, "
			+ "(PRICE * (1- DISCOUNTRATE)) AS PRICE_DC, TO_CHAR(P.CDATETIME, 'YYYY-MM-DD') AS DATE_R, "
			+ "SUBSTR(CONTENTS, 1, INSTR(CONTENTS, '社')-1) AS DEVELOPER "
			+ "FROM KDH_GAME_PRODUCT P "
			+ "INNER JOIN KDH_GAME_BOARD B ON P.ITEMNO = B.ITEMNO "
			+ "WHERE BOARDNO = " + boardNo;
	ResultSet rs = stmt.executeQuery(sql);
	rs.next();
%>
	<div id="game-header"></div>
	<div id="container">
		<div class="conBox left">
		<!-- 영상 나오는 박스 -->
		    <div style="margin: 10px;">
		    	<iframe width="560" height="315" src="https://www.youtube.com/embed/<%= rs.getString("VIDEO") %>" frameborder="0"
						allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen>
				</iframe>
    		</div>
		</div>
		<div class="conBox right">
		<!-- 게임 이미지, 가격, 장바구니 -->
			<img src="../img/<%= rs.getString("IMAGE") %>" class="img-size" style="margin: 10px">
			<div class="underLine"></div>
			<div class="text-alter">정상가 <span class="price-og"><%= rs.getString("PRICE") %>원</span></div>
			<div class="text-alter">할인가 <span class="price-dc"><%= rs.getString("PRICE_DC") %></span>원</div>
			<div class="underLine"></div>
			<div class="text-alter">출시일 <span><%= rs.getString("DATE_R") %></span></div>
			<div class="text-alter">개발사 <span><%= rs.getString("DEVELOPER") %></span></div>
			<div class="underLine"></div>
			<div>
		<%
			if("A".equals(session.getAttribute("userLevel"))) {
		%>
				<input type="button" value="수정" class="board-btn" style="margin-left: 25px" onclick="gameUpdate(<%= boardNo %>)">
				<input type="button" value="삭제" class="board-btn" style="margin: 32px 0px 0px 25px" onclick="gameRemove(<%= boardNo %>, <%= rs.getString("ITEMNO") %>)">
		<%
			} else {
		%>
				<input type="button" value="장바구니" class="cart-btn text-alter" style="margin: 23px 0px 0px 41px"
					onclick="isTake('<%= session.getAttribute("userId") %>', <%= rs.getString("ITEMNO") %>)">
		<%
			}
		%>
			</div>
		</div>
		<div class="conBox left">
		<!-- 요구사항과 간단한 게임 소개 -->
			<div class="text-alter">요구사항과 간단한 게임 정보</div>
			<fieldset>
				<legend>요구사항</legend>
				<div class="text-alter">
					TEST TEXT
				</div>
			</fieldset>
		</div>
	</div>
	<div id="game-footer" class="f-clear"></div>
</body>
<script type="text/javascript">
	$(function(){
	    $("#game-header").load("game_header.jsp");
	    $("#game-footer").load("game_footer.jsp");
	});
	
	function isTake(userId, itemNo) {
		if(userId == null) {
			alert("로그인 후 사용하실 수 있습니다!");
			return;
		} else {
			if(confirm("장바구니에 담을까요?")) {
				location.href = "game_cart_save.jsp?userId=" + userId + "&itemNo=" + itemNo;
			} else {
				return;
			}
		}
	}
	
	function gameUpdate(boardNo) {
		location.href = "game_update.jsp?boardNo=" + boardNo;
	}
	
	function gameRemove(boardNo, itemNo) {
		if(confirm("정말 삭제하실 겁니까?")) {
			location.href = "game_remove.jsp?boardNo=" + boardNo + "&itemNo=" + itemNo;
		} else {
			return;
		}
	}
</script>
</html>