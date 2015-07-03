<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.io.PrintWriter"%>
<%@page import="java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
  <script src="//cdnjs.cloudflare.com/ajax/libs/jasny-bootstrap/3.1.3/js/jasny-bootstrap.min.js"></script>
<title>Update Form</title>
<nav class="navbar navbar-inverse">
<div class="navbar-header">
    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
         <span class="sr-only">Toggle navigation</span>
         <span class="icon-bar"></span>
         <span class="icon-bar"></span>
         <span class="icon-bar"></span>
    </button>
      <a class="navbar-brand page-scroll" href="/recruitmentportal/Bootstrap/bootstrap-3.3.5-dist/main.html">Ideas</a>
            </div>    
  <div>
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
</nav>

</head>
<body>
<h1 align="center" >Update Required Fields</h1>
<%

String id=request.getParameter("id");
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root","root");
PreparedStatement stat1= con.prepareStatement("SELECT * FROM employee WHERE id=?");
stat1.setString(1, id);
ResultSet result=stat1.executeQuery();
while(result.next())
{
String department=result.getString("department");	

String designation=result.getString("designation");
String cctc=result.getString("cctc");
String ectc=result.getString("ectc");
String prevorg=result.getString("prevorg");
String num=result.getString("num");
String comments=result.getString("comments");


%>

<div class="container">
<div class="jumbotron">
<form name="infoForm" id="infoForm" class="ajax" action="/recruitmentportal/DataUpdateController?id=<%=id %>"  method="post" onsubmit="submitbtn.disabled = true; return true;">

<div class="container">


<div class="form-group">
<label for="department">Department</label>
<input type="text" name="department" placeholder="Enter Name"  class="form-control" value="<%=result.getString("department")%>" required>
</div>

<div class="form-group">
<label for="name">Name</label>
<input type="text" name="name" placeholder="Enter Name"  class="form-control" value="<%=result.getString("name")%>" required>
</div>

<div class="form-group">
<label for="designation">Designation</label>
<input type="text" name="designation" placeholder="Enter Name"  class="form-control" value="<%=result.getString("designation")%>" required>
</div>

<div class="form-group">
<label for="experience">Experience</label>
<input type="number" min="0" name="experience" placeholder="Experience" class="form-control" value="<%=result.getString("experience")%>">
</div>

<div class="form-group">
<label for="cctc">Current CTC</label>
<input type="text" name="cctc" placeholder="Current CTC"  class="form-control" value="<%=result.getString("cctc")%>">
</div>

<div class="form-group">
<label for="ectc">Expected CTC</label>
<input type="text" name="ectc" placeholder="Expected CTC"  class="form-control" value="<%=result.getString("ectc")%>">
</div>

<div class="form-group">
<label for="prevorg">Previous organization</label>
<input type="text" name="prevorg" placeholder="Previous organization"  class="form-control" value="<%=result.getString("prevorg")%>">
</div>

<div class="form-group">
<label for="num">Contact Number</label>
<input type="text" name="num" placeholder="Contact Number"  class="form-control" value="<%=result.getString("num")%>">
</div>


<div class="form-group" align="left">
<label for="comments">Comments</label><br>
<textarea rows="4"  cols="50" name="comments" placeholder="Comments" >"<%=result.getString("comments")%>"</textarea>
</div>




</div>
</form>
<input type="submit" value="Submit" class="btn btn-primary" name="submitbtn" id="submitbtn" onclick="submitChanges()">
<input type="reset" value="Reset" class="btn btn-primary" id="Reset Button">
<a href="/recruitmentportal/Bootstrap/bootstrap-3.3.5-dist/main.html" class="btn btn-primary">Back</a>
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
</div>
</div>
<%} %>
</body>
</html>