<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <link rel="stylesheet" href="../css/mini_project_style.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
</head>
<body>
    <div id="game-header"></div>
    <form name="join" action="game_join_save.jsp">
        <div class="container-login container-join">
            <fieldset>
                <legend>회원가입</legend>
                <ul>
                    <li>
                        <div class="join-divide">아이디</div>
                        <span>
                            <input type="text" id="userId" name="userId" class="join-input" required placeholder="5글자 이상, 10글자 이하 입력" required autofocus>
                        </span>
                        <input class="btn-default btn-check" id="btn_idCheck" value="중복확인" onclick="idCheck()">
                    </li>
                    <li>
                        <div class="join-divide">비밀번호</div>
                        <span>
                            <input type="password" id="userPwd" name="userPwd" class="join-input" required placeholder="4글자 이상, 25글자 이하 입력">
                        </span>
                    </li>
                    <li>
                        <div class="join-divide">비밀번호 확인</div>
                        <span>
                            <input type="password" id="userPwd2" name="userPwd2" class="join-input" required placeholder="비밀번호와 똑같이 입력하세요">
                        </span>
                    </li>
                    <li>
                        <div class="join-divide">이메일</div>
                        <span>
                            <input type="text" id="email" name="email" class="join-input" placeholder="이메일을 입력하세요" required style="width: 150px;">
                            <span style="color: #fff;">@</span>
                            <input type="text" id="email2" name="email2" class="join-input" placeholder="직접 입력" required style="width: 150px;">
                            <select name="email3" id="email3" class="join-input" style="width: 150px; height: 30px;">
                                <option selected>선택</option>
                                <option value="gmail.com">gmail.com</option>
                                <option value="naver.com">naver.com</option>
                                <option value="hanmail.net">hanmail.net</option>
                                <option value="direct">직접입력</option>
                            </select>
                        </span>
                    </li>
                    <li>
                        <div class="join-divide">이름</div>
                        <span>
                            <input type="text" name="userPwd" class="join-input" required placeholder="이름을 입력하세요">
                        </span>
                    </li>
                    <div class="text-center">
                        <input type="button" value="회원가입" name="login" class="login-btn join-btn" onclick="isCheck()">
                        <input type="button" value="취소하기" name="login" class="login-btn join-btn join-cancel">
                    </div>
                </ul>
            </fieldset>
            <div class="caution text-center">
                <strong>※ 아이디는 주문 및 결제 시 필요한 고유 정보로, 가입 후에는 변경이 불가합니다!</strong>
            </div>
        </div>
    </form>
    <div id="game-footer"></div>
</body>
<script>
    $(function(){
        $("#game-header").load("game_header.jsp");
        $("#game-footer").load("game_footer.jsp");
    });
    var join = document.join;
    
    function idCheck() {
    	pop = window.open("game_user_idCheck.jsp?userId=" + join.userId.value, "join", "width=300, height=300");
	}
    
    function isCheck() {
    	const regType = /^[a-zA-Z0-9]*$/g;
    	
    	if(join.userId.value == "" || join.userId.value == undefined || join.userId.value == "null") {
    		alert("아이디를 입력해 주세요!");
			join.userId.focus();
			return;
    	}
    	if(join.userId.value.length > 10 || join.userId.value.length < 5) {
    		alert("아이디는 5자 이상, 10자 이하로 입력하세요!");
			join.userId.focus();
			return;
    	}
    	if (!regType.test(join.UserId.value)) {
			alert("아이디는 영어와 숫자로만 조합해야 합니다!");
			join.id.focus();
			return;
		}
		if(join.UserPwd.value == "" || join.UserPwd.value == undefined || join.UserPwd.value == "null") {
			alert("비밀번호를 입력하세요!");
			join.pwd.focus();
			return;
		}
		if(join.UserPwd.value.length < 4 || join.UserPwd.value.length > 25) {
			alert("비밀번호는 4글자 이상, 25글자 이하여야 합니다!");
			join.pwd.focus();
			return;
		}
		if(join.UserPwd.value != join.UserPwd2.value) {
			alert("비밀번호 입력값이 같아야 합니다!");
			join.pwd2.focus();
			return;
		}
		if(join.email.value == "" || join.email.value == undefined || join.email.value == "null") {
			alert("이메일을 입력하세요!");
			join.email.focus();
			return;
		}
		if(join.email2.value == "" || join.email2.value == undefined || join.email2.value == "null") {
			alert("이메일을 입력하세요!");
			join.email2.focus();
			return;
		}

		join.submit();
	}
</script>
</html>