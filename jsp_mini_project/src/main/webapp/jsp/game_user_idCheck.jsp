<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../css/mini_project_style.css">
	<meta charset="UTF-8">
	<title>아이디 중복 검사</title>
</head>
<body>
	<form name="dbCheck">
	<%@ include file="dbconn.jsp" %>
	<%
	String userId = request.getParameter("userId");
	String sql = "SELECT * FROM KDH_GAME_USER WHERE USERID = '" + userId + "'";
	ResultSet rs = stmt.executeQuery(sql);
	if(rs.next()) {
		%>
		<div class="text-alter">중복된 아이디입니다!</div>
		<input type="text" name="userId" class="join-input" placeholder="5글자 이상, 10글자 이하 입력"> 
		<input type="button" class="btn-default btn-check" value="중복 체크" onclick="idCheck()"> 
		<%
	} else {
		%>
		<div class="text-alter">사용 가능한 아이디입니다!
			<input type="button" class="btn-default btn-check" value="창 닫기" onclick="popClose('<%= userId %>')">
		</div>	
		<%
	}
		%>
	</form>
</body>
<script>
	function popClose(userId) {
		opener.document.join.userId.value = userId;
		window.close();
	}
	function idCheck() {
		var userId = document.dbCheck.userId.value;
		const regType = /^[a-zA-Z0-9]*$/g;
		if(userId == "" || userId == undefined || userId =="null") {
			alert("아이디를 입력해 주세요!");
			return;
		}
    	if(userId.length > 10 || userId.length < 5) {
    		alert("아이디는 5자 이상, 10자 이하로 입력하세요!");
			join.userId.focus();
			return;
    	}
    	if (!regType.test(userId)) {
			alert("아이디는 영어와 숫자로만 조합해야 합니다!");
			join.id.focus();
			return;
		}
    	location.href = "game_user_idCheck.jsp?userId=" + userId;
	}
</script>
</html>