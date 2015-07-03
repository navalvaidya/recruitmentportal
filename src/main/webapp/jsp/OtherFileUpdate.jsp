<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.io.PrintWriter"%>
<%@page import="java.io.*" %>
<%@page import="com.ideas.LoadConfigFile" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
  <title>Update Other Documents</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
  <script src="//cdnjs.cloudflare.com/ajax/libs/jasny-bootstrap/3.1.3/js/jasny-bootstrap.min.js"></script>
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

<div class="container">
<div class="jumbotron">
<form name="infoForm" id="infoForm" class="ajax" action="/recruitmentportal/UpdateOtherFileController?id=<%=request.getParameter("id")%>"  enctype="multipart/form-data" method="post" onsubmit="submitbtn.disabled = true; return true;">

<div class="container">


<div class="form-group" align="left">
<label>Upload other documents</label>
<input type="file" name="other" id="other" required> 
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
</div>
</body>
</html>