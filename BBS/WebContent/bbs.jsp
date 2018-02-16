<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
<!doctype html>
<html>
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

	
	
	<style type="text/css">
		#signin{
		margin-top:40px;
		}
		#bbs{
		margin-top:100px;
		}
		#write{
		float:right;
		}
		#view{
		color:black;
		text-decoration:none;
		}
	</style>
	
	
    <title>login</title>
  </head>
  <body>
  
  <%
  	String userID = null;
  	if(session.getAttribute("userID") != null){
  		userID = (String) session.getAttribute("userID"); 		//로그인한 접속자라면 userID문자열에 아이디값을 입력해줌.
  	}
  	int pageNumber = 1;
  	
  	if(request.getParameter("pageNumber") != null){
  		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
  	}
  
  %>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
    	 <a class="navbar-brand" href="main.jsp">JSP bulletin board web site</a>
    	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  
  
  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="main.jsp">Main <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="bbs.jsp">Bulletin</a>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          Manage Account
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
        
        <%
        if(userID == null){	//로그인 안한사람한테만 보이는 부분
        %>	
        	<a class="dropdown-item" href="login.jsp">Login</a>
            <a class="dropdown-item" href="join.jsp">New Account</a>
        <%	
        }
        
        %>
        
        <%
        if(userID != null){	//로그인 한사람한테만 보이는 부분
        %>	
        	<a class="dropdown-item" href="logoutAction.jsp">Logout</a>
            
        <%	
        }
        
        %>
        
          
          
          
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="donggyu00.cafe24.com/bootstrap">Donggyu's Park</a>
        </div>
      </li>
     
    </ul>
    <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
    </form>
  </div>
  
  
    </nav>
    
   
    
    <div class="container" id="bbs">
    	<table class="table">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">Title</th>
      <th scope="col">writer</th>
      <th scope="col">Date</th>
    </tr>
  </thead>
  <tbody>
  
  <%
  	BbsDAO bbsDAO = new BbsDAO();
  	ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
  	
  	for(int i = 0 ; i < list.size(); i ++){
  %>		
  	
  		 <tr>
		      <td ><%= list.get(i).getBbsID() %></td>
		      <td><a id="view" href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n", "<br>") %></a></td>
		      <td><%= list.get(i).getUserID() %></td>
		      <td><%= list.get(i).getBbsDate() %></td>
   		 </tr>
  		
  <% 		
  	}
  %>
  
  
   
   
  </tbody>
</table>

<%
	if(pageNumber != 1){
		%>
			<a href="bbs.jsp?pageNumber=<%= pageNumber-1 %>">previous</a>
		<% 
	}

	if(bbsDAO.nextPage(pageNumber+1)){
		%>
			<a href="bbs.jsp?pageNumber=<%= pageNumber+1%>">Next</a>
		<%
	}
%>
<a id="write" href="write.jsp" class="btn btn-primary pull-right">write</a>

    </div>
    
  
    
    
    
    
	
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  </body>
</html>