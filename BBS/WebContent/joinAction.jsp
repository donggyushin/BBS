<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="user.UserDAO" %>	<!-- user패키지에 있는 userDAO를 임폴트 -->
    <%@ page import="java.io.PrintWriter" %>	<!-- 자바스크립트로 문장을 작성하기 위해 사용 -->
    <% request.setCharacterEncoding("utf-8"); %>	<!-- 건너오는 모든 데이터를 utf-8의 형태로 받아들일수 있게 해줌.  -->	
    <jsp:useBean id="user" class="user.User" scope="page" /> <!-- java bean사용, 아이디는 user 클래스는 user패키지의 User 클래스 범위는 현재페이지 -->
    <jsp:setProperty name="user" property="userID" /> 
    <jsp:setProperty name="user" property="userPassword" />
    <jsp:setProperty name="user" property="userName" /> 
    <jsp:setProperty name="user" property="userGender" />
    <jsp:setProperty name="user" property="userEmail" /> 
    
<!doctype html>
<html>
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    
	
    <title>jsp게시판 웹 사이트</title>
  </head>
  <body>
   		<%
   		
   			String userID = null;				//이미 로그인 된 사람은 페이지에 접속할 수 없게 막음
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
   		
   		
   		if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null||
   			user.getUserGender() == null || user.getUserEmail() == null){
   			PrintWriter script = response.getWriter();	//PrintWriter를이용해서, 스크립트 문장을 작성할수 있게 해줌. 
				script.println("<script>");
				script.println("alert('please fill the whole form')");	
				script.println("history.back()");	//바로 전 페이지로 이동
				script.println("</script>");
   		}
   		
   		else{
   			UserDAO userDAO = new UserDAO();
   			int result = userDAO.join(user);
   			
   			if(result == -1){	//아이디가 이미 있는경우
				PrintWriter script = response.getWriter();
   				script.println("<script>");
   				script.println("alert('already existing ID')");
   				script.println("history.back()");
   				script.println("</script>");
   			}
   			else {
   				session.setAttribute("userID", user.getUserID());	//문자열 userID에 id값 할당
   				PrintWriter script = response.getWriter();
   				script.println("<script>");
   				script.println("location.href='main.jsp'");
   				script.println("</script>");
   			}
   		}
   		
   		%>
  </body>
</html>