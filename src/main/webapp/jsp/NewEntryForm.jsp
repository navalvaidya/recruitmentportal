<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.io.PrintWriter"%>
<%@page import="java.io.*" %>
<%@page import= "java.util.Properties" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>New Entry</title>
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
  <script src="//cdnjs.cloudflare.com/ajax/libs/jasny-bootstrap/3.1.3/js/jasny-bootstrap.min.js"></script>
  <script src="js/main.js"></script>
</head>
<body  style="background:#E6E6E6">
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
     <li class="active"><a href="/recruitmentportal/jsp/NewEntryForm.jsp">New Entry</a></li>
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
<h1 align="center" >Enter the Information</h1>
<div class="jumbotron">
<form name="infoForm" id="infoForm" class="ajax" action="/recruitmentportal/UploadFileServlet"  enctype="multipart/form-data" method="post" onsubmit="submitbtn.disabled = true; return true;">

<div class="container">
<div class="row">
<div class="form-group">
<label for="department" class="col col-lg-2">Department<font color="red">*</font><a href="/recruitmentportal/AddDepartment.html"><span class="glyphicon glyphicon-plus-sign"></span></a><a href="/recruitmentportal/jsp/RemoveDepartment.jsp"><span class="glyphicon glyphicon-minus-sign"></span></a></label>
<div class="col col-lg-4">
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
ResultSet result = stat1.executeQuery("SELECT * FROM department");
Statement stat2 = con.createStatement();
ResultSet result2 = stat2.executeQuery("SELECT * FROM designation");



%>
<select name="department" class="form-control" >
<%
while(result.next()){
%>
    <option value=<%=result.getString("department")%>><%=result.getString("department")%></option> 
<%} %> 

</select>
</div>

<label for="name" class="col col-lg-2">Name<font color="red">*</font></label>
<div class="col col-lg-4">
<input type="text" name="name" placeholder="Enter Name"  class="form-control" required>
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
    <%
while(result2.next()){
%>
    <option value=<%=result2.getString("designation")%>><%=result2.getString("designation")%></option> 
<%} %> 
 </select>
</div>
<%con.close(); %>
<label for="experience" class="col col-lg-2">Experience<font color="red">*</font></label>
<div class="col col-lg-4">
<div class="input-group container-fluid">			
<input type="number" step="any" min="0" name="experience" placeholder="Experience" class="form-control" required>
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
<input type="number" step="any" name="cctc" placeholder="Current CTC"  class="form-control" >
<div class="input-group-addon container-fluid">Lakhs Per Annum</div>
</div>
</div>

<label for="ectc" class="col col-lg-2">Expected CTC</label>
<div class="col col-lg-4">
<div class="input-group container-fluid">
<input type="number" step="any" name="ectc" placeholder="Expected CTC"  class="form-control" >
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
<input type="text" name="prevorg" placeholder="Previous organization"  class="form-control" >
</div>
</div>
</div>
<br>
<br>
<div class="row">
<div class="form-group" align="left">
<label class="col col-lg-2">Upload document</label>
<div class="col col-lg-4">
<input type="file" name="other" id="other"> 
</div>

<label class="col col-lg-2">Upload Resume</label>
<div class="col-lg-4">
<input type="file" name="resumelink" id="resumelink"> 
</div>
</div>
</div>
<br>
<br>
<div class="form-group" align="left">
<label for="comments">Comments</label><br>
<textarea rows="4"  cols="50" name="comments" placeholder="Comments" ></textarea>
</div>



<input type="submit" value="Submit" class="btn btn-primary" name="submitbtn" id="submitbtn">
<input type="reset" value="Reset" class="btn btn-primary" id="Reset Button">
<a href="/recruitmentportal/main.html" class="btn btn-primary">Back</a>
</div>
</form>


<div id="resultContainer"> </div>
<script>

	$("#infoForm").submit(function(e)
			{
		 var formObj = $(this);
		    var formURL = formObj.attr("action");
		    var formData = new FormData(this);
		    $.ajax({
		        url: formURL,
		        type: 'POST',
		        data:  formData,
		    mimeType:"multipart/form-data",
		 contentType: false,
		       cache: false,
		 processData: false,
		        
				
				success: function (msg) {
					
				
					if (msg === 'true') {
						$("#resultContainer").html("<p style='color:green' class='alert alert-success'>Database Updated</p>");
						$("#resultContainer").delay(100).fadeIn(300);
						$("#resultContainer").delay(1200).fadeOut(800);
					} else {
						$("#resultContainer").html("<p style='color:red' class='alert alert-danger'>Database Update Failed</p>");
						$("#resultContainer").delay(1200).fadeOut(800);
					}
				},
				error : function() {
					$("#resultContainer").html("<div class='alert alert-danger'>Server Error. Request could not be placed, please try again later</div>");
				}
			});
		    e.preventDefault(); //Prevent Default action. 
		    e.unbind();
		    $("#infoForm")[0].reset();
			});
			
</script>
</div>
<p><font size="2">Fields with * cannot be left empty</font></p>
</body>
</html>