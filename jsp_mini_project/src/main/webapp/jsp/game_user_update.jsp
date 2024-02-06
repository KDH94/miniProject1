<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <link rel="stylesheet" href="../css/mini_project_style.css">
	<meta charset="UTF-8">
	<title>회원 정보 수정</title>
</head>
<body>
	<%@ include file="dbconn.jsp"%>
	<%
	String userId = request.getParameter("userId");
	String sql = "SELECT USERID, USERNAME, MONEY, "
			+ "SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) AS EMAIL, "
			+ "SUBSTR(EMAIL, INSTR(EMAIL, '@')+1) AS EMAIL2 "
			+ "FROM KDH_GAME_USER WHERE USERID = '" + userId + "'";

	ResultSet rs = stmt.executeQuery(sql);
	rs.next();
	%>
    <div id="game-header"></div>
    <form name="join" action="game_user_update.jsp">
		<div class="container-login container-join">
            <fieldset>
                <legend>회원 정보 수정</legend>
                <ul>
                    <li>
                        <div class="join-divide">아이디</div>
                        <span>
                        	<input name="userId" value="<%=rs.getString("USERID")%>" hidden>
                            <input type="text" id="userId" class="join-input" value="<%=rs.getString("USERID")%>" disabled>
                        </span>
                    </li>
                    <li>
                        <div class="join-divide">비밀번호</div>
                        <span>
                            <input type="password" id="userPwd" name="userPwd" class="join-input" required placeholder="비우면 원래 비밀번호 그대로 사용">
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
                            <input type="text" id="email" name="email" class="join-input" placeholder="이메일을 입력하세요" required style="width: 150px;" value="<%= rs.getString("EMAIL") %>">
                            <span style="color: #fff;">@</span>
                            <input type="text" id="email2" name="email2" class="join-input" placeholder="직접 입력" required style="width: 150px;" value="<%= rs.getString("EMAIL2") %>">
                            <select name="email3" id="email3" class="join-input" style="width: 150px; height: 30px;" onchange="emailInput(this.value)">
                                <option value="" selected>직접입력</option>
                                <option value="gmail.com">gmail.com</option>
                                <option value="naver.com">naver.com</option>
                                <option value="hanmail.net">hanmail.net</option>
                            </select>
                        </span>
                    </li>
                    <li>
                        <div class="join-divide">이름</div>
                        <span>
                            <input type="text" name="userName" class="join-input" required placeholder="이름을 입력하세요" value="<%=rs.getString("USERNAME")%>">
                        </span>
                    </li>
                    <%
                    	if("A".equals(session.getAttribute("userLevel"))) {
                    %>
                    <li>
                        <div class="join-divide">추가 금액</div>
                        <span>
                            <input type="text" name="money" class="join-input" placeholder="추가할 액수를 입력하세요">
                            <span style="color: #fff">현재 금액: <span style="color: rgb(239, 165, 60);"><%=rs.getString("MONEY")%></span>원</span>
                        </span>
                    </li>
                    <%
                    	}
                    %>
                </ul>
                    <div class="text-center">
                        <input type="button" value="수정하기" name="userUpdate" class="login-btn join-btn" onclick="fnCheck()">
                        <input type="button" value="취소하기" name="isBack" class="login-btn join-btn join-cancel" onclick="history.back()">
                    </div>
            </fieldset>
            <div class="caution text-center">
                <strong>※ 아이디는 주문 및 결제 시 필요한 고유 정보로, 수정이 불가합니다!</strong>
			<%
				if("U".equals(session.getAttribute("userLevel"))) {
			%>
				<input type="button" value="회원 탈퇴" class="user-out" onclick="userOut('<%=rs.getString("USERID")%>')">
			<%
				}
			%>
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
	
    function fnCheck() {
    	var join = document.join;
    	const regType = /^[a-zA-Z0-9]*$/g;
    	if (!regType.test(join.userPwd.value)) {
			alert("비밀번호는 영어와 숫자로만 조합해야 합니다!");
			join.userId.focus();
			return;
		}
    	if(join.userPwd.value.length != 0) {
			if(join.userPwd.value.length < 4 || join.userPwd.value.length > 25) {
				alert("비밀번호는 4글자 이상, 25글자 이하여야 합니다!");
				join.userPwd.focus();
				return;
			}
    	}
		if(join.userPwd.value != join.userPwd2.value) {
			alert("비밀번호 확인의 입력값은 비밀번호와 같아야 합니다!");
			join.userPwd2.focus();
			return;
		}
		if(join.email.value == "" || join.email.value == undefined || join.email.value == "null") {
			alert("이메일 아이디 부분을 입력하세요!");
			join.email.focus();
			return;
		}
		if(join.email2.value == "" || join.email2.value == undefined || join.email2.value == "null") {
			alert("이메일 주소 부분을 입력하세요!");
			join.email2.focus();
			return;
		}
		if(join.userName.value == "" || join.userName.value == undefined || join.userName.value == "null") {
			alert("이름을 입력하세요!");
			join.userName.focus();
			return;
		}
		join.action = "game_user_update_view.jsp";
		join.submit();
	}
	
    function emailInput(email) {
		document.join.email2.value = email;
	}
    
    function userOut(userId) {
		if(confirm("정말 탈퇴하시겠습니까?")) {
			location.href = "game_user_delete.jsp?userId=" + userId;
		} else {
			return;
		}
	}
</script>
</html>