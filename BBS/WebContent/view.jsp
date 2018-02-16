<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
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
	</style>
	
	
    <title>login</title>
  </head>
  <body>
  
  <%
  	String userID = null;
  	if(session.getAttribute("userID") != null){
  		userID = (String) session.getAttribute("userID"); 		//로그인한 접속자라면 userID문자열에 아이디값을 입력해줌.
  	}
  	
  	int bbsID = 0;
  	if(request.getParameter("bbsID") != null){
  		bbsID = Integer.parseInt(request.getParameter("bbsID"));
  	}
  	if(bbsID == 0){
  		PrintWriter script = response.getWriter();
  		script.println("<script>");
  		script.println("alert('impossible to access')");
  		script.println("location.href='bbs.jsp'");
  		script.println("</script>");
  	}
  	
  	BbsDAO bbsDAO = new BbsDAO();
  	Bbs bbs = bbsDAO.getBbs(bbsID);
  
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
			      <th scope="col" colspan="3" class="text-center">Bulletin Board</th>
			    </tr>
			  </thead>
			  <tbody>
			    <tr>
			      <td style="width:20%">title</td>
			      <td colspan="2"><%= bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n", "<br>") %></td>
			    </tr>
			    <tr>
			      <td >writer</td>
			      <td colspan="2"><%= bbs.getUserID() %></td>
			    </tr>
			    <tr>
			      <td >date</td>
			      <td colspan="2"><%= bbs.getBbsDate() %></td>
			    </tr>
			    <tr>
			      <td>content</td>
			      <td colspan="2" style="min-height:150px; text-align:left;"><%= bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n", "<br>") %></td>
			    </tr>
			  </tbody>
			</table>
			
			<a href="bbs.jsp" class="btn btn-secondary">List</a>
			<%
				if(userID != null && userID.equals(bbs.getUserID())){	//해당 글의 작성자가 본인이라면
					%>
					<a href="update.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">update</a>
					<a onclick="return confirm('are you sure to delete?')" href="deleteAction.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">delete</a>
					<%
				}
			%>
    
    	

    </div>
    
  
    
    
    
    
	
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  </body>
</html>