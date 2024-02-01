<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	div {
		font-size: 20px;
		font-weight: bold;
	}
</style>
</head>
<body>
	<form action="">
		<div>게임명: <input type="text" name="title"></div>
		<div>
			<div>내용: </div>
			<textarea rows="15" cols="60" name="contents"></textarea>
		</div>
		<input type="submit" value="등록" formaction="game_add_save.jsp">
		<input type="submit" value="취소" formaction="game_list.jsp">
	</form>
</body>                           
</html>