<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

     
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
  <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
<style>
h2 {
    position: absolute;
    left: 400px;
    top: 150px;
}
h1{
position: absolute;
    left: 400px;
    top: 100px;


}
</style>
<title>Update Entries</title>
<h1>Search for Record to Update</h1>
</head>
<body>
<form name="information" action="/recruitmentportal/Bootstrap/bootstrap-3.3.5-dist/jsp/UpdateSearchResult.jsp"  method="post" >
<h2><div class="row">
	<div class="col-lg-6">
		<div class="input-group">
		<input type="text" class="form-control" name="updatesearch" placeholder="Search" required>
        <span class="input-group-btn">
        <button class="btn btn-default"  type="Submit">Search</button>
        </span>
		
		</div>
	</div>
</div></h2>
</form>
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
        <li class="active"><a href="/recruitmentportal/Bootstrap/bootstrap-3.3.5-dist/jsp/UpdateEntries.jsp">Update Information</a></li>
        <li><a href="#">Upload from Excel</a></li>
      </ul>

    </div>
    </div>
 </nav>
 


</body>
</html>