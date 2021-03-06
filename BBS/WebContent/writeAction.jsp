<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="bbs.BbsDAO" %>	<!-- user패키지에 있는 userDAO를 임폴트 -->
    <%@ page import="java.io.PrintWriter" %>	<!-- 자바스크립트로 문장을 작성하기 위해 사용 -->
    <% request.setCharacterEncoding("utf-8"); %>	<!-- 건너오는 모든 데이터를 utf-8의 형태로 받아들일수 있게 해줌.  -->	
    <jsp:useBean id="bbs" class="bbs.Bbs" scope="page" /> <!-- java bean사용, 아이디는 user 클래스는 user패키지의 User 클래스 범위는 현재페이지 -->
    <jsp:setProperty name="bbs" property="bbsTitle" /> 
    <jsp:setProperty name="bbs" property="bbsContent" />
    
<!doctype html>
<html>
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    
	
    <title>jsp게시판 웹 사이트</title>
  </head>
  <body>
   		<%
   		
   			String userID = null;				
			if(session.getAttribute("userID") != null){
				userID = (String) session.getAttribute("userID");
			}
			
			
			
			if(userID == null){
				PrintWriter script = response.getWriter();	//PrintWriter를이용해서, 스크립트 문장을 작성할수 있게 해줌. 
				script.println("<script>");
				script.println("alert('have to login')");	
				script.println("location.href='login.jsp'");	
				script.println("</script>");
			}
   		
   		
			else if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null ){
   			PrintWriter script = response.getWriter();	//PrintWriter를이용해서, 스크립트 문장을 작성할수 있게 해줌. 
				script.println("<script>");
				script.println("alert('please fill the whole form')");	
				script.println("history.back()");	//바로 전 페이지로 이동
				script.println("</script>");
   				}
   		
   			else{
   			
   			BbsDAO bbsDAO = new BbsDAO();
   			int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
   			
   			if(result == -1){	//글쓰기 실패한 경우
				PrintWriter script = response.getWriter();
   				script.println("<script>");
   				script.println("alert('fail to write')");
   				script.println("history.back()");
   				script.println("</script>");
   			}
   			else {
   				PrintWriter script = response.getWriter();
   				script.println("<script>");
   				script.println("location.href='bbs.jsp'");
   				script.println("</script>");
   			}
   		}
   		
   		%>
  </body>
</html>