<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <link rel="stylesheet" href="../css/mini_project_style.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게임 판매 게시판</title>
</head>
<body>
	<%
		String keyword = "";
	%>
    <div id="container">
		<form name="search_form">
	        <header id="gh-header" class="gh-header">
	            <div class="main-logo">
	                <a href="game_list.jsp">🎮</a>
	            </div>
	            <div>
	                    <div>
	                        <input type="text" class="search-input" name="keyword" value="<%= keyword %>">
	                        <input type="submit" class="search-input search-btn" value="🔍" onclick="search()">
	                    </div>
	            </div>
	            <div class="head-login">
	            <%
	            	if(session.getAttribute("userId") == null || !request.isRequestedSessionIdValid()) {
	            %>
		                <a href="game_login.jsp" class="btn-default btn-gh">로그인</a>
		                <a href="game_join.jsp" class="btn-default btn-gh">회원가입</a>
	            <%		
	            	} else {
	            %>
		                <a href="game_login.jsp" class="btn-default btn-gh">로그아웃</a>
	            <% 
	            	}
	            %>
	                <input type="button" class="btn-default btn-cart" value="🛒" onclick="isLogin(<%= session.getAttribute("userId") %>)">
	            </div>
	        </header>
	        <ul class="menu">
	            <li>
	                <a href="#about">게임▼</a>
	                <div class="submenu">
	                    <a href="#">Steam</a>
	                    <a href="#">Epic Games</a>
	                    <a href="#">All Games</a>
	                </div>
	            </li>
	            <li><a href="#home">공지사항</a></li>
	            <li>
	                <a href="#services">고객지원▼</a>
	                <div class="submenu">
	                    <a href="#">자주 묻는 질문</a>
	                    <a href="#">문의하기</a>
	                </div>
	            </li>
	            <li><a href="#contact">사이트 소개</a></li>
	        </ul>
		</form>
    </div>
</body>
<script type="text/javascript">
	function search() {
		var board = document.search_form;
		location.href = "game_list.jsp?keyword=" + board.keyword.value;
	}
	function isLogin(userId) {
		if(userId == null) {
			alert("로그인 후 사용하실 수 있습니다!");
			return;
		} else {
			location.href = "game_cart.jsp?userId=" + userId;
		}
	}
</script>
</html>