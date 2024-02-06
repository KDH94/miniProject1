<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../css/mini_project_style.css">
	<meta charset="UTF-8">
	<title>게임 상품번호 검사</title>
</head>
<body>
	<form name="dbCheck">
	<%@ include file="dbconn.jsp" %>
	<%
	String itemNo = request.getParameter("itemNo");
	String sql = "SELECT * FROM KDH_GAME_PRODUCT WHERE ITEMNO = '" + itemNo + "'";
	ResultSet rs = stmt.executeQuery(sql);
	if(rs.next()) {
		%>
		<div class="text-alter">중복된 상품번호입니다!</div>
		<input type="text" name="itemNo" class="join-input" placeholder="숫자만 입력, 3자리 권장."> 
		<input type="button" class="btn-default btn-check" value="중복 체크" onclick="itemCheck()"> 
		<%
	} else {
		%>
		<div class="text-alter">사용 가능한 상품번호입니다!
			<input type="button" class="btn-default btn-check" value="창 닫기" onclick="popClose('<%= itemNo %>')">
		</div>	
		<%
	}
		%>
	</form>
</body>
<script>
	function popClose(itemNo) {
		opener.document.game_insert.itemNo.value = itemNo;
		window.close();
	}
	function itemCheck() {
		var form = document.dbCheck;
		var itemNo = document.dbCheck.itemNo.value;
		const regType = /^[0-9]*$/g;
    	if(itemNo == "" || itemNo == undefined || itemNo == "null") {
			alert("값을 입력하세요!");
			form.itemNo.focus();
			return;
    	}
    	if(itemNo.length > 5) {
    		alert("값은 5자 이하로 입력하세요!");
    		form.itemNo.focus();
			return;
    	}
    	if (!regType.test(itemNo)) {
			alert("숫자만 입력하세요!");
			form.itemNo.focus();
			return;
		}
    	location.href = "game_item_check.jsp?itemNo=" + itemNo;
	}
</script>
</html>