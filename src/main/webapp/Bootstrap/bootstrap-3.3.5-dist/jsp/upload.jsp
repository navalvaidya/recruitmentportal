<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.io.PrintWriter"%>
<%@page import="java.io.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Database Information</title>


  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
</head>
<body>
<h1 align="center">Table Showing content of all Database</h1>
<nav class="navbar navbar-inverse navbar-fixed-top" >
<div class="container-fluid">
<div class="navbar-header">
       <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">                    
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
       </button>
   <a class="navbar-brand " href="http://localhost:8080/recruitmentportal/Bootstrap/bootstrap-3.3.5-dist/main.html">Ideas</a>
</div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        
        <li><a href="http://localhost:8080/recruitmentportal/Bootstrap/bootstrap-3.3.5-dist/uploadui.htmll">New Entry</a></li>
        <li><a href="#">Update Information</a></li>
        <li><a href="#">Upload from Excel</a></li>
      </ul>
      </div>
    </div>
 </nav>
<%
String department=request.getParameter("department");
String name=request.getParameter("name");
String designation=request.getParameter("designation");
String experience=request.getParameter("experience");
String comments=request.getParameter("comments");



	
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root","root");
	
	/*
    PreparedStatement stat2=con.prepareStatement("INSERT INTO employee (name, designation, experince) VALUES (?, ?, ?)");
	stat2.setString(1, name);
	stat2.setString(2, designation );
	stat2.setString(3, experience);
	stat2.executeUpdate();
	*/
	Statement stat1=con.createStatement();
	ResultSet result=stat1.executeQuery("SELECT * FROM employee");
	%>
	<div class="container" >
	<table class="table table-bordered">
		 <thead>
		  <tr>
		   <th>Department</th>
		   <th>Name</th>
		   <th>Designation</th>
		   <th>Experience</th>
		   <th>comments</th>
		   <th>Resume</th>
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
		  <td><%=result.getString("resumelink") %></td>
		 </tr>
		
		<% 		
	}
		%>
		</tbody>
		</table>
		</div>
		<%
		stat1.close();
		con.close();
		%>
		
	
<%
		MultipartRequest m = new MultipartRequest(request, "C:/Users/idnnaa/Desktop/upload");  
		  
		
		%>
</body>
</html>