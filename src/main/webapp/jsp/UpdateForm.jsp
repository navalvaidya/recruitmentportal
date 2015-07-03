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
  <script src="//cdnjs.cloudflare.com/ajax/libs/jasny-bootstrap/3.1.3/js/jasny-bootstrap.min.js"></script>
<title>Update Form</title>
</head>
<nav class="navbar navbar-inverse">
<div class="navbar-header">
    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
         <span class="sr-only">Toggle navigation</span>
         <span class="icon-bar"></span>
         <span class="icon-bar"></span>
         <span class="icon-bar"></span>
    </button>
      <a class="navbar-brand page-scroll" href="/recruitmentportal/main.html">IDeaS</a>
            </div>    
  <div>
     <ul class="nav navbar-nav">  
     <li><a href="/recruitmentportal/jsp/ViewAll.jsp">View</a></li>   
     <li><a href="/recruitmentportal/jsp/NewEntryForm.jsp">New Entry</a></li>
     <li><a href="/recruitmentportal/jsp/UpdateEntries.jsp">Update Information</a></li>
     <li><a href="/recruitmentportal/ExcelUpload.html">Upload from Excel</a></li>
     
     </ul>
     
  <form name="information" action="/recruitmentportal/jsp/SearchResult.jsp"  method="post" >    
    <div class="navbar-form navbar-right" role="search">
    <div class="form-group">
      <input type="text" name="searchbox" class="form-control" placeholder="Search" required> 
    </div>
      <button type="submit" class="btn btn-default">Search</button>
    </div>
  </form>
</div>
</nav>


<body>
<h1 align="center" >Update Required Fields</h1>
<%
Properties prop = new Properties();
InputStream input = new FileInputStream("/Recruitment Portal/config.properties");
prop.load(input);
String dburl = prop.getProperty("database");
String user = prop.getProperty("dbuser");
String passwd = prop.getProperty("dbpassword");

String id=request.getParameter("id");
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(dburl,user,passwd);
PreparedStatement stat1= con.prepareStatement("SELECT * FROM employee WHERE id=?");

Statement stat2 = con.createStatement();
ResultSet result2 = stat2.executeQuery("SELECT * FROM department");
Statement stat3 = con.createStatement();
ResultSet result3 = stat3.executeQuery("SELECT * FROM designation");
stat1.setString(1, id);
ResultSet result=stat1.executeQuery();
while(result.next())
{
String department=result.getString("department");	

String designation=result.getString("designation");
String cctc=result.getString("cctc");
String ectc=result.getString("ectc");
String prevorg=result.getString("prevorg");
String comments=result.getString("comments");


%>


<div class="jumbotron">
<form name="infoForm" id="infoForm" class="ajax" action="/recruitmentportal/DataUpdateController?id=<%=id %>"  method="post" onsubmit="submitbtn.disabled = true; return true;">

<div class="container">
<div class="row">
<div class="form-group">
<label for="department" class="col col-lg-2">Department<font color="red">*</font><a href="/recruitmentportal/AddDepartment.html"><span class="glyphicon glyphicon-plus-sign"></span></a><a href="/recruitmentportal/jsp/RemoveDepartment.jsp"><span class="glyphicon glyphicon-minus-sign"></span></a></label>
<div class="col col-lg-4">
<select name="department" class="form-control" >
<option value=<%=result.getString("department")%>><%=result.getString("department")%></option>
<%
while(result2.next()){
%>
 <option value=<%=result2.getString("department")%>><%=result2.getString("department")%></option>
 
<%} %> 

</select>
</div>
<label for="name" class="col col-lg-2">Name<font color="red">*</font></label>
<div class="col col-lg-4">
<input type="text" name="name" placeholder="Enter Name"  class="form-control" value="<%=result.getString("name")%>" required>
</div>
</div>
</div>
<br>
<br>


<div class="row">
<div class="form-group">
<label for="designation" class="col col-lg-2">Designation<font color="red">*</font><a href="/recruitmentportal/AddDesignation.html"><span class="glyphicon glyphicon-plus-sign"></span></a><a href="/recruitmentportal/jsp/RemoveDesignation.jsp"><span class="glyphicon glyphicon-minus-sign"></span></a></label>
<div class="col col-lg-4">
<select name="designation" class="form-control" >
<option value=<%=result.getString("designation")%>><%=result.getString("designation")%></option>
<%
while(result3.next()){
%>
 <option value=<%=result3.getString("designation")%>><%=result3.getString("designation")%></option>
 
<%} %> 

</select>
</div>
<label for="experience" class="col col-lg-2">Experience<font color="red">*</font></label>
<div class="col col-lg-4">
<div class="input-group container-fluid">			
<input type="number" min="0" name="experience" placeholder="Experience" class="form-control" value="<%=result.getString("experience")%>">
<div class="input-group-addon container-fluid">Years</div>
</div>
</div>
</div>
</div>
<br>
<br>
<div class="row">
<div class="form-group">
<label for="cctc" class="col col-lg-2">Current CTC</label>
<div class="col col-lg-4">
<div class="input-group container-fluid">
<input type="text" name="cctc" placeholder="Current CTC"  class="form-control" value="<%=result.getString("cctc")%>">
<div class="input-group-addon container-fluid">Lakhs Per Annum</div>
</div>
</div>

<label for="ectc" class="col col-lg-2">Expected CTC</label>
<div class="col col-lg-4">
<div class="input-group container-fluid">
<input type="text" name="ectc" placeholder="Expected CTC"  class="form-control" value="<%=result.getString("ectc")%>">
<div class="input-group-addon container-fluid">Lakhs Per Annum</div>
</div>
</div>
</div>
</div>
<br>
<br>
<div class="row">
<div class="form-group">
<label for="prevorg" class="col col-lg-2">Previous organization</label>
<div class="col col-lg-4">
<div class="form-group">
<input type="text" name="prevorg" placeholder="Previous organization"  class="form-control" value="<%=result.getString("prevorg")%>">
</div>
</div>
</div>
<br>
<br>

<div class="form-group" align="left">
<label for="comments">Comments</label><br>
<textarea rows="4"  cols="50" name="comments" placeholder="Comments" >"<%=result.getString("comments")%>"</textarea>
</div>
</div>
</div>
</form>
<div class="row">
<div class="col col-xs-1"></div>
<div class="col col-lg-3">
<input type="submit" value="Submit" class="btn btn-primary" name="submitbtn" id="submitbtn" onclick="submitChanges()">
<input type="reset" value="Reset" class="btn btn-primary" id="Reset Button">
<a href="/recruitmentportal/main.html" class="btn btn-primary">Back</a>
</div>
</div>
</div>

<div id="resultContainer"> </div>

<script>
function submitChanges(){
	
$.ajax({
type: "POST",
url: "/recruitmentportal/DataUpdateController?id=<%=id%>",
data: $("#infoForm").serialize(),
success: function (msg) {
	if (msg === true) {
		$("#resultContainer").html("<p style='color:green' class='alert alert-success'>Database Updated</p>");
		$("#resultContainer").delay(100).fadeIn(300);
		$("#resultContainer").delay(1200).fadeOut(800);
	} else {
		$("#resultContainer").html("<div class='alert alert-danger'>Database Update Failed</div>");
		$("#resultContainer").delay(1200).fadeOut(800);
	}
},
error : function() {
	$("#resultContainer").html("<div class='alert alert-danger'>Server Error. Request could not be placed, please try again later</div>");
}
});

}
</script>

<%} %>
</body>
</html>