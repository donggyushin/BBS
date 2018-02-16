<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="user.UserDAO" %>	<!-- user패키지에 있는 userDAO를 임폴트 -->
    <%@ page import="java.io.PrintWriter" %>	<!-- 자바스크립트로 문장을 작성하기 위해 사용 -->
  
    
<!doctype html>
<html>
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    
	
    <title>logout</title>
  </head>
  <body>
   		<%
   		
   		session.invalidate();
   		
   		%>
   		<script>
   			location.href="main.jsp";
   		</script>
  </body>
</html>