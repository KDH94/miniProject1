<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 완료 페이지</title>
</head>
<body>
   <%@ include file="dbconn.jsp"%>
   <%
      String userId = request.getParameter("userId");
      String userPwd = request.getParameter("userPwd");
      
      String sql = ("SELECT * FROM KDH_GAME_USER "
               + "WHERE USERID = '"
               + userId + "' AND USERPWD ='"
               + userPwd + "'");
      ResultSet rs =stmt.executeQuery(sql);
      
      if(rs.next()){
         if(rs.getInt("CNT") >= 4){            
			%>
	      	<script>
	      		alert("비밀번호 입력을 5번 이상 실패했습니다. 관리자에게 문의하세요.");
	      		location.href = "game_login.jsp";
	      	</script>
	    	<%
         } else {
            session.setAttribute("userId", rs.getString("USERID"));
            session.setAttribute("userName", rs.getString("USERNAME"));
            session.setAttribute("userLevel", rs.getString("USERLEVEL"));
            session.setAttribute("money", rs.getString("MONEY"));
            
            if("A".equals(rs.getString("USERLEVEL"))){
            	sql = "UPDATE KDH_GAME_USER SET CNT = 0 WHERE USERID ='" + userId + "'";
    	       	stmt.executeUpdate(sql);
              	response.sendRedirect("game_user_list.jsp");
            } else if("U".equals(rs.getString("USERLEVEL"))) {
	            sql = "UPDATE KDH_GAME_USER SET "
	                + "CNT = 0 "
	                + "WHERE USERID ='" + userId + "'";
	            stmt.executeUpdate(sql);
	            response.sendRedirect("game_list.jsp");
            }
         }
        } else {
           String idSql = ("SELECT * FROM KDH_GAME_USER "
               + "WHERE USERID = '"+ userId + "'");
           ResultSet rsId =stmt.executeQuery(idSql);
           if(rsId.next()) {
              //1. 아이디가 있는데 패스워드가 다른 경우
                int cnt = rsId.getInt("CNT");
              if((cnt + 1) >= 5 && "U".equals(rs.getString("USERLEVEL"))) {
      			%>
		      	<script>
		      		alert("5번 이상 실패한 계정입니다. 관리자에게 문의하세요.");
		      		location.href = "game_login.jsp";
		      	</script>
		    	<%
              } else {
            	%>
            	<input value="<%= cnt+1 %>" hidden>
            	<script>
	            	var cnt = "<%= cnt+1 %>";
	            	alert(cnt+"번 로그인 실패! 5번 틀리면 로그인이 불가합니다!");
	            	location.href = "game_login.jsp";
            	</script>
            	<%
                 stmt.executeUpdate(
                       "UPDATE KDH_GAME_USER SET "
                       + "CNT = CNT + 1 "
                       + "WHERE USERID ='" + userId + "'"
                       );
              }
           } else {
              //2. 아이디가 없는 경우
			%>
		      	<script>
		      		alert("없는 아이디입니다. 다시 한번 확인해 주세요.");
		      		 location.href = "game_login.jsp"; 
		      	</script>
		    <%
           }
      }
   %>
</body>
</html>