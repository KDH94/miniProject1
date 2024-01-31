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
    <div id="container">
        <header id="gh-header" class="gh-header">
            <div class="main-logo">
                <a href="game_home.html">🎮</a>
            </div>
            <div>
                <form name="search_form">
                    <div>
                        <input type="text" class="search-input">
                        <button class="search-input search-btn">🔍</button>
                    </div>
                </form>
            </div>
            <div class="head-login">
                <a href="game_login.html" class="btn-default btn-gh">로그인</a>
                <a href="game_join.html" class="btn-default btn-gh">회원가입</a>
                <a class="btn-default btn-cart">🛒</a>
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
    </div>
</body>
</html>