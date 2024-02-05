<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <link rel="stylesheet" href="../css/mini_project_style.css">
	<meta charset="UTF-8">
	<title>게임 등록 - 관리자용</title>
	<style type="text/css">
	</style>
</head>
<body>
	<div id="game-header"></div>
	<form name="game_insert" method="post" enctype="multipart/form-data">
		<div class="container-login container-join" style="height: 800px">
		<fieldset>
	        <legend>게임 등록</legend>
	        <ul>
	            <li>
	                <div class="join-divide">상품번호</div>
	                <span>
	                	<input type="text" id="itemNo" name="itemNo" class="join-input" required placeholder="숫자만 입력, 3자리 권장.">
	                </span>
	                <input class="btn-default btn-check" id="btn_itemCheck" value="중복 확인" onclick="itemCheck()" readonly>
	             </li>
	             <li>
	                 <div class="join-divide">게임명</div>
	                 <span>
	                 	<input type="text" name="gameName" class="join-input" required placeholder="「게임 이름/검색될 추가 키워드」">
	                 </span>
	             </li>
	             <li>
	                 <div class="join-divide">가격</div>
	                 <span>
	                 	<input type="text" name="price" class="join-input" required>
	                 </span>
	             </li>
	             <li>
	                 <div class="join-divide">이미지</div>
	                 <span>
            			<input type="file" name="image" class="join-input" required>
						<input type="button" value="업로드" onclick="uploadImage()">
	                </span>
	            </li>
	            <li>
	                <div class="join-divide">할인율</div>
	                <span>
	                    <input type="text" name="discountRate" class="join-input" required
							placeholder="0부터 100까지만 입력" maxlength="3">
	                    <span style="color: #fff;">%</span>
	                 </span>
	             </li>
	             <li>
	                 <div class="join-divide">출시일</div>
	                 <span>
	                     <input type="date" name="cDateTime" class="join-input" required>
	                 </span>
	             </li>
	             <li>
	                 <div class="join-divide">이용등급</div>
	                 <span>
						<select name="rating" id="" class="join-input">
							<option value="ALL">전체이용가</option>
							<option value="12">12세</option>
							<option value="15">15세</option>
							<option value="18">18세</option>
						</select>
	                 </span>
	             </li>
	             <li>
	                 <div class="join-divide">영상값</div>
	                 <span>
	                     <input type="text" name="video" class="join-input" required style="width: 280px;"
							placeholder="youtube.com/watch?v=「여기 적힌 11자리 값」'" maxlength="11">
	                 </span>
	                 <span style="color: #a00;">게임 출시 트레일러 영상</span>
	            </li>
	            <li>
	                <div class="join-divide">내용</div>
	                <span>
	                    <textarea rows="10" cols="80" name="contents" required
							placeholder="※작성법: 처음엔 '...社에서 만든~'으로 작성. 여기서 ...엔 회사명을 입력할 것."></textarea>
	                </span>
	            </li>
	        </ul>
	            <div class="text-center">
	                <input type="button" value="등록하기" class="login-btn join-btn" onclick="fnCheck()">
	                <input type="button" value="취소하기" class="login-btn join-btn join-cancel" onclick="cancel()">
	            </div>
		</fieldset>
    	</div>
	</form>
	<div id="game-footer"></div>
</body>
<script>
	$(function(){
	    $("#game-header").load("game_header.jsp");
	    $("#game-footer").load("game_footer.jsp");
	});
	
	function itemCheck() {
		var form = document.game_insert;
    	var itemNo = form.itemNo.value;
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
    	pop = window.open("game_item_idCheck.jsp?itemNo=" + itemNo, "item", "width=520, height=130, top=400, left=770");
	}

	function fnCheck() {
		var form = document.game_insert;
		form.action = "game_add_view.jsp";
		form.submit();
	}
	function uploadImage() {
		var form = document.game_insert;
		form.action = "game_image_upload.jsp";
		//form.action = window.open("game_image_upload.jsp", "image_upload", "width=520, height=130, top=400, left=770");
		form.submit();
	}
</script>                     
</html>