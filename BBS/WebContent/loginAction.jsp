<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="user.UserDAO" %>	<!-- user패키지에 있는 userDAO를 임폴트 -->
    <%@ page import="java.io.PrintWriter" %>	<!-- 자바스크립트로 문장을 작성하기 위해 사용 -->
    <% request.setCharacterEncoding("utf-8"); %>	<!-- 건너오는 모든 데이터를 utf-8의 형태로 받아들일수 있게 해줌.  -->	
    <jsp:useBean id="user" class="user.User" scope="page" /> <!-- java bean사용, 아이디는 user 클래스는 user패키지의 User 클래스 범위는 현재페이지 -->
    <jsp:setProperty name="user" property="userID" /> <!-- 로그인페이지에서 userID를 받아서 사용자의 userID에 넣어줌 -->
    <jsp:setProperty name="user" property="userPassword" />
<!doctype html>
<html>
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    
	
    <title>jsp게시판 웹 사이트</title>
  </head>
  <body>
   		<%
   		
   			String userID = null;			//이미 로그인 된 사람은 페이지에 접속할 수 없게 막음
   			if(session.getAttribute("userID") != null){
   				userID = (String) session.getAttribute("userID");
   			}
   			if(userID != null){
   				PrintWriter script = response.getWriter();	//PrintWriter를이용해서, 스크립트 문장을 작성할수 있게 해줌. 
   				script.println("<script>");
   				script.println("alert('already login')");	
   				script.println("location.href='main.jsp'");	//바로 전 페이지로 이동
   				script.println("</script>");
   			}
   		
   		
   			UserDAO userDAO = new UserDAO();
   			int result = userDAO.login(user.getUserID(), user.getUserPassword());	//login페이지로부터 받아들인 아이디와 패쓰워드를 전에 설정했던 java bean에 전달하고 그 값을 다시 여기서 전달해줌
   			if(result == 1){
   				session.setAttribute("userID", user.getUserID());	//문자열 userID에 id값 할당
   				PrintWriter script = response.getWriter();	//PrintWriter를이용해서, 스크립트 문장을 작성할수 있게 해줌. 
   				script.println("<script>");
   				script.println("location.href = 'main.jsp'");	//main.jsp로 이동
   				script.println("</script>");
   			}
   			else if(result == 0){
   				PrintWriter script = response.getWriter();	//PrintWriter를이용해서, 스크립트 문장을 작성할수 있게 해줌. 
   				script.println("<script>");
   				script.println("alert('wrong password')");	
   				script.println("history.back()");	//바로 전 페이지로 이동
   				script.println("</script>");
   			}
   			else if(result == -1){
   				PrintWriter script = response.getWriter();	//PrintWriter를이용해서, 스크립트 문장을 작성할수 있게 해줌. 
   				script.println("<script>");
   				script.println("alert('not existing id')");
   				script.println("history.back()");
   				script.println("</script>");
   			}
   			else if(result == -2){
   				PrintWriter script = response.getWriter();	//PrintWriter를이용해서, 스크립트 문장을 작성할수 있게 해줌. 
   				script.println("<script>");
   				script.println("alert('error in connecting database')");
   				script.println("history.back()");
   				script.println("</script>");
   			}
   		%>
  </body>
</html>