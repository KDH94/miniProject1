<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <link rel="stylesheet" href="../css/mini_project_style.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
</head>
<body>
    <%
		if(request.isRequestedSessionIdValid()) {
			session.invalidate();
		} else if("A".equals(session.getAttribute("userLevel"))) {
			response.sendRedirect("game.user.list.jsp");
		} else {
			response.sendRedirect("game_list.jsp");
		}
    %>
    <div id="game-header"></div>
    <form name="login" method="post">
        <div class="container-login">
            <fieldset>
                <legend>로그인</legend>
                <ul>
                    <li>
                        <div>아이디</div>
                        <div>
                            <input type="text" id="userId" name="userId" class="login-input" autofocus>
                        </div>
                    </li>
                    <li>
                        <div>비밀번호</div>
                        <div>
                            <input type="password" id="userPwd" name="userPwd" class="login-input">
                        </div>
                    </li>
                    <div>
                        <input type="button" value="로그인" class="login-btn">
                        <!-- ↑타입을 버튼으로 바꾸고 onclick 이벤트 줘야 함 -->
                    </div>
                </ul>
            </fieldset>
            <ul>
                <a href="game_join.jsp" class="login-subButton">회원가입</a>
            </ul>
        </div>
    </form>
    <div id="game-footer"></div>
</body>
<script>
    $(function(){
        $("#game-header").load("game_header.jsp");
        $("#game-footer").load("game_footer.jsp");
    });
</script>
</html>