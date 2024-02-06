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
	<%@ include file="dbconn.jsp" %>
	<%
		String boardNo = request.getParameter("boardNo");
		String sql = "SELECT BOARDNO, P.ITEMNO, CONTENTS, RATING, GAMENAME, PRICE, IMAGE, "
				   + "(DISCOUNTRATE * 100) AS DC_RATE, TO_CHAR(P.CDATETIME, 'YYYY-MM-DD') AS RELEASEDAY, VIDEO "
				   + "FROM KDH_GAME_BOARD B "
				   + "INNER JOIN KDH_GAME_PRODUCT P ON B.ITEMNO = P.ITEMNO "
				   + "WHERE BOARDNO = " + boardNo;
		ResultSet rs = stmt.executeQuery(sql);
		rs.next();
		String rating = rs.getString("RATING");
		String all = "";
		String twelve = "";
		String fifteen = "";
		String eighteen= "";
		if(rating.equals("all")) {
			all = "selected";
		} else if(rating.equals("12")) {
			twelve = "selected";
		} else if(rating.equals("15")) {
			fifteen = "selected";
		} else if(rating.equals("18")) {
			eighteen = "selected";
		}
	%>
	<div id="game-header"></div>
	<form name="game_update" method="post" enctype="multipart/form-data">
		<div class="container-login container-join" style="height: 800px">
		<fieldset>
	        <legend>게임 수정</legend>
	        <ul>
	            <li>
	            	<input type="hidden" name="boardNo" value="<%= boardNo %>">
	                <div class="join-divide">상품번호</div>
	                <span>
	                	<input type="text" id="itemNo" name="itemNo" class="join-input" required
							value="<%= rs.getString("ITEMNO") %>" readonly>
	                </span>
	             </li>
	             <li>
	                 <div class="join-divide">게임명</div>
	                 <span>
	                 	<input type="text" name="gameName" class="join-input" required
	                 		value="<%= rs.getString("GAMENAME") %>" placeholder="ex) GTA 6">
	                 </span>
	             </li>
	             <li>
	                 <div class="join-divide">검색 키워드</div>
	                 <span>
	                 	<input type="text" name="searchKeyword" class="join-input" required placeholder="ex) 그타, 지티에이, …">
	                 </span>
	             </li>
	             <li>
	                 <div class="join-divide">가격</div>
	                 <span>
	                 	<input type="text" name="price" class="join-input" required value="<%= rs.getString("PRICE") %>">
	                 	<span style="color: #fff;">원</span>
	                 </span>
	             </li>
	             <li>
	                 <div class="join-divide">원본 이미지 명</div>
	                 <span>
            			<input type="text" name="image" class="join-input" value="<%= rs.getString("IMAGE") %>" disabled>
            			<input type="file" name="image" class="join-input" required>
            			<div style="color: #a00;">파일 크기 2MB 이하만 업로드</div>
						<!-- <input type="button" value="업로드" onclick="uploadImage()"> -->
	                </span>
	            </li>
	            <li>
	                <div class="join-divide">할인율</div>
	                <span>
	                    <input type="text" name="discountRate" class="join-input" required
							value="<%= rs.getString("DC_RATE") %>" placeholder="0부터 100까지만 입력" maxlength="3">
	                    <span style="color: #fff;">%</span>
	                 </span>
	             </li>
	             <li>
	                 <div class="join-divide">출시일</div>
	                 <span>
	                     <input type="date" name="cDateTime" class="join-input" required value="<%= rs.getString("RELEASEDAY") %>">
	                 </span>
	             </li>
	             <li>
	                 <div class="join-divide">이용등급</div>
	                 <span>
						<select name="rating" id="" class="join-input">
							<option value="ALL" <%= all %>>전체이용가</option>
							<option value="12" <%= twelve %>>12세</option>
							<option value="15" <%= fifteen %>>15세</option>
							<option value="18" <%= eighteen %>>18세</option>
						</select>
	                 </span>
	             </li>
	             <li>
	                 <div class="join-divide">영상값</div>
	                 <span>
	                     <input type="text" name="video" class="join-input" required style="width: 280px;" maxlength="11"
							value="<%= rs.getString("VIDEO") %>" placeholder="youtube.com/watch?v=「여기 적힌 11자리 값」'">
	                 </span>
	                 <span style="color: #a00;">게임 출시 트레일러 영상</span>
	            </li>
	            <li>
	                <div class="join-divide">내용</div>
	                <span>
	                    <textarea rows="10" cols="80" name="contents" required class="txtArea"
							placeholder="※작성법: 처음엔 '...社에서 만든~'으로 작성. 여기서 ...엔 회사명을 넣으며, 반드시 社 입력할 것."><%= rs.getString("CONTENTS") %></textarea>
	                </span>
	            </li>
	        </ul>
	            <div class="text-center">
	                <input type="submit" value="수정하기" class="login-btn join-btn" formaction="game_update_view.jsp">
	                <input type="button" value="취소하기" class="login-btn join-btn join-cancel" onclick="cancel(<%= boardNo %>)">
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

    function cancel(boardNo) {
		location.href = "game_view.jsp?boardNo=" + boardNo;
	}
</script>                     
</html>