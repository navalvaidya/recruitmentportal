<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.io.PrintWriter"%>
<%@page import="java.io.*" %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Result</title>
 <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
</head>
<body>
<%

String keyword=request.getParameter("searchbox");
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root","root");
PreparedStatement stat1 = con.prepareStatement("SELECT * FROM EMPLOYEE WHERE department REGEXP ? OR name REGEXP ? OR designation REGEXP ? OR experience REGEXP ?");
stat1.setString(1, keyword);
stat1.setString(2, keyword);
stat1.setString(3, keyword);
stat1.setString(4, keyword);
ResultSet result=stat1.executeQuery();

        
%>

<nav class="navbar navbar-inverse navbar-fixed-top" >
<div class="container-fluid">
<div class="navbar-header">
       <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">                    
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
       </button>
   <a class="navbar-brand " href="/recruitmentportal/Bootstrap/bootstrap-3.3.5-dist/main.html">Ideas</a>
</div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        
        <li><a href="/recruitmentportal/Bootstrap/bootstrap-3.3.5-dist/uploadui.html">New Entry</a></li>
        <li><a href="/recruitmentportal/Bootstrap/bootstrap-3.3.5-dist/jsp/UpdateEntries.jsp">Update Information</a></li>
        <li><a href="#">Upload from Excel</a></li>
      </ul>
      <form name="information" action="/recruitmentportal/Bootstrap/bootstrap-3.3.5-dist/jsp/SearchResult.jsp"  method="post" >
      
    <div class="navbar-form navbar-right" role="search">
    <div class="form-group">
      <input type="text" name="searchbox" class="form-control" placeholder="Search" required> 
    </div>
      <button type="submit" class="btn btn-default">Search</button>
    </div>
    </form>
      </div>
    </div>
 </nav>
 
<div class="container" >
<div class="jumbotron">
<h3>Search Results</h3>
	<table class="table table-bordered">
		 <thead>
		  <tr>
		   <th>Department</th>
		   <th>Name</th>
		   <th>Designation</th>
		   <th>Experience</th>
		   <th>comments</th>
		   <th>Resume</th>
		   <th>Other Files</th>
		 </tr>
		</thead>
		<tbody>
		<%
	while(result.next())
	{
		%>
		
		 <tr>
		 <td><%=result.getString("department") %></td>
		  <td><%=result.getString("name") %></td>
		  <td><%=result.getString("designation") %></td>
		  <td><%=result.getString("experience") %>
		  <td><%=result.getString("comments") %></td>
		  <td><a href="/recruitmentportal/ResumeDownloadController?id=<%=result.getString("id") %>"><%=result.getString("resumelink")%></a></td>
		  <td><a href="/recruitmentportal/FileDownloadController?id=<%=result.getString("id") %>"><%=result.getString("otherfile")%></a></td>
		 </tr>
		
		<% 		
	}
		%>
		</tbody>
		</table>
		</div>
		</div>
		<%
		stat1.close();
		con.close();
		%>
		 <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>
</body>
</html>