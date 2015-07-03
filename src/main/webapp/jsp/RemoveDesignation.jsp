<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.io.PrintWriter"%>
<%@page import="java.io.*" %>
<%@page import= "java.util.Properties" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

     
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
  <!-- Bootstrap Core CSS -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">
<title>Remove Designation</title>

</head>
<body>
<br><br><br><br><br><br>
<h1 align="center">Remove a Designation</h1>

<%
Properties prop = new Properties();
InputStream input = new FileInputStream("/Recruitment Portal/config.properties");
prop.load(input);
String dburl = prop.getProperty("database");
String user = prop.getProperty("dbuser");
String passwd = prop.getProperty("dbpassword");

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(dburl,user,passwd);
Statement stat1 = con.createStatement();
ResultSet result = stat1.executeQuery("SELECT * FROM designation");
%>
<div class="container container-fluid">
<table class="table table-bordered" id="mytable">
	<thead>
		<tr>
			<th style="text-align: centre;">Designation</th>
		</tr>
	</thead>
<%
while(result.next()){
%>

<tr>

	<td><a style="margin: 10px 5px;" href="/recruitmentportal/DesignationRemover?id=<%=result.getString("id")%>"><%=result.getString("designation") %></a></td>

</tr>
    
<%} %> 


<%
stat1.close();
con.close();
%>
 
</table>
</div>
<nav class="navbar navbar-inverse navbar-fixed-top" >
<div class="container-fluid">
<div class="navbar-header">
       <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">                    
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
       </button>
   <a class="navbar-brand " href="/recruitmentportal/main.html">IDeaS</a>
</div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li><a href="/recruitmentportal/jsp/ViewAll.jsp">View</a></li>
        <li><a href="/recruitmentportal/jsp/NewEntryForm.jsp">New Entry</a></li>
        <li class="active"><a href="/recruitmentportal/jsp/UpdateEntries.jsp">Update Information</a></li>
        <li><a href="/recruitmentportal/ExcelUpload.html">Upload from Excel</a></li>
        
      </ul>

    </div>
    </div>
 </nav>
 
</body>
</html>