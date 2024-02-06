<%@page import="java.awt.Cursor"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <link rel="stylesheet" href="../css/mini_project_style.css">
    <meta charset="UTF-8">
    <title>게임 리스트</title>
    <style>
        .grid-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
        }
        .grid-item {
            width: 300px;
            margin-bottom: 20px;
        }
        .image-container {
            position: relative;
            width: 300px;
            height: 400px;
            overflow: hidden;
        }
        .game-image {
            width: 100%;
            height: auto;
            transition: transform 0.3s ease-in-out;
            border-radius: 10px;
        }
        .image-info {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            background-color: rgba(0, 0, 0, 0.8);
            color: #fff;
            padding: 10px;
            opacity: 0;
            transition: opacity 0.3s ease-in-out;
            transform: translateY(100%);
            border-radius: 10px;
        }
        .image-container:hover .image-info {
            opacity: 1;
            transform: translateY(0);
        }
    </style>
</head>
<body>
<%@ include file="dbconn.jsp"%>
<%
    String sql = "SELECT BOARDNO, GAMENAME, IMAGE, "
            + "SUBSTR(GAMENAME, 1, INSTR(GAMENAME, '/')-1) AS GAMENAME2, "
            + "PRICE, (DISCOUNTRATE * 100) AS DC_RATE, "
            + "(PRICE * (1 - DISCOUNTRATE)) AS DC_PRICE "
            + "FROM KDH_GAME_BOARD B "
            + "INNER JOIN KDH_GAME_PRODUCT P ON B.ITEMNO = P.ITEMNO ";

    String keyword = request.getParameter("keyword");
    if(keyword != null) {
        keyword = keyword.toUpperCase();
        sql += "WHERE GAMENAME LIKE '%" + keyword + "%'";
    } else {
        keyword = "";
    }

    ResultSet rs = stmt.executeQuery(sql);
%>
<div id="game-header"></div>
<div id=container>
	<div class="grid-container">
	    <%
	        int count = 0;
	        while(rs.next()){
	    %>
	    <div class="grid-item">
	        <a href="game_view.jsp?boardNo=<%= rs.getString("BOARDNO") %>">
	            <div class="image-container">
	                <img class="game-image" src="../img/<%= rs.getString("IMAGE") %>" alt="<%= rs.getString("GAMENAME2") %>">
	                <div class="image-info">
	                    <p>게임명: <%= rs.getString("GAMENAME2") %></p>
	                    <p>정상가: <%= rs.getString("PRICE") %>원</p>
	                    <p>할인율: <%= rs.getString("DC_RATE") %>%</p>
	                    <p>할인가: <span style="color: rgb(239, 165, 60); font-weight: bold"><%= rs.getString("DC_PRICE") %></span>원</p>
	                </div>
	            </div>
	        </a>
	    </div>
	    <%
	        count++;
	        if (count % 3 == 0) {
	    %>
	</div>
	<div class="grid-container">
	    <%
	        }
	    %>
	    <%
	        }
	        conn.close();
	    %>
	</div>
</div>
<div id="game-footer"></div>
</body>
<script type="text/javascript">
    $(function(){
        $("#game-header").load("game_header.jsp");
        $("#game-footer").load("game_footer.jsp");
    });
</script>
</html>
