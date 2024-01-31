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
      String pwd = request.getParameter("pwd");
      
      String sql = ("SELECT * FROM TBL_MEMBER "
               + "WHERE USERID = '"
               + userId + "' AND PWD ='"
               + pwd + "'");
               /*  SELECT * FROM TBL_MEMBER WHERE USERID = 'userId' AND PWD = 'pwd'; */
      ResultSet rs =stmt.executeQuery(sql);
      
      
      if(rs.next()){
         if(rs.getInt("CNT") >= 4){            
            out.print("비밀번호 5번 이상 실패했습니다. 관리자에게 문의하세요.");
         }else{
            session.setAttribute("userId", rs.getString("USERID"));
            session.setAttribute("userName", rs.getString("USERNAME"));
            session.setAttribute("status", rs.getString("STATUS"));
            
            if(rs.getString("STATUS").equals("A")){
               response.sendRedirect("user_list.jsp");
            }
            out.print("로그인 성공");
            sql = "UPDATE TBL_MEMBER SET "
                     +"CNT = 0 "
                     +"WHERE USERID ='" + userId + "'";
            stmt.executeUpdate(sql);
            
      %>
       <form action="user_update.jsp" method="post" name="userInfo">
         <input name="userId" value="<%=userId%>" hidden>
         <input type="button" value="게시판" onclick="btn('g')">
         <input type="button" value="회원정보 수정" onclick="btn('u')">
         <input type="button" value="회원정보 삭제" onclick="btn('d')">
      </form>  

      <%
         }
        }else{
           String idSql = ("SELECT * FROM TBL_MEMBER "
               + "WHERE USERID = '"+ userId + "'");
           ResultSet rsId =stmt.executeQuery(idSql);
           if(rsId.next()){
              //1. 아이디가 있는데 패스워드가 다른 경우
                int cnt = rsId.getInt("CNT");
              if((cnt+1)>=5){
                 out.println("5번 이상 실패한 계정입니다. 관리자에게 문의하세요.");
              }else{
                 out.println((cnt+1)+"번 실패 !!!");  
                 stmt.executeUpdate(
                       "UPDATE TBL_MEMBER SET "
                       +"CNT = CNT + 1 "
                       +"WHERE USERID ='" + userId + "'"
                       );
              }
           }else{
              //2. 아이디가 없는 경우
                out.print("아이디를 확인해주세요.");
           }
           
        %>
      <div><input type="button" value="돌아가기" onclick="history.back()"></div>
      <%
      }
   %>
</body>
</html>
<script>
   function btn(txt){
      var userInfo = document.userInfo;
      if(txt == "u"){
         userInfo.action = "user_update.jsp";
      }else if(txt == "g"){
         userInfo.action = "board_list.jsp";
      }
      else{
         userInfo.action = "user_delect.jsp";         
      }
      userInfo.submit();
   }
</script>