<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<title>Error 500 | RyunKyung Portfolio</title>


<!--STYLESHEET-->
<!--=================================================-->

<!--Open Sans Font [ OPTIONAL ]-->
<link
	href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700'
	rel='stylesheet' type='text/css'>

<!--Bootstrap Stylesheet [ REQUIRED ]-->
<link href="<c:url value='/resources/css/bootstrap.min.css'/>"
	rel="stylesheet">

<!--Nifty Stylesheet [ REQUIRED ]-->
<link href="<c:url value='/resources/css/nifty.min.css'/>"
	rel="stylesheet">

<!--Nifty Premium Icon [ DEMONSTRATION ]-->
<link
	href="<c:url value='/resources/css/demo/nifty-demo-icons.min.css'/>"
	rel="stylesheet">

<!--Pace - Page Load Progress Par [OPTIONAL]-->
<link href="<c:url value='/resources/plugins/pace/pace.min.css'/>"
	rel="stylesheet">
<script src="<c:url value='/resources/plugins/pace/pace.min.js'/>"></script>


<!--=================================================-->


</head>

<!--TIPS-->
<!--You may remove all ID or Class names which contain "demo-", they are only used for demonstration. -->

<body>
	<div id="container" class="cls-container">

		<!-- HEADER -->
		<!--===================================================-->
		<div class="cls-header">
			<div class="cls-brand">
				<a class="box-inline" href="/wpf/home.do"> <!-- <img alt="Nifty Admin" src="img/logo.png" class="brand-icon"> -->
					<span class="brand-title">RyunKyung Portfolio<span
						class="text-thin"> Admin</span></span>
				</a>
			</div>
		</div>

		<!-- CONTENT -->
		<!--===================================================-->
		<div class="cls-content">
			<h1 class="error-code text-purple">500</h1>
			<p class="h4 text-uppercase text-bold">Internal Server Error!</p>
			<div class="pad-btm">Something went wrong and server couldn't process your request.</div>

			<hr class="new-section-sm bord-no">
			<div class="pad-top">
				<a class="btn btn-purple" href="<c:url value='/home.do'/>">Return Home</a>
			</div>
		</div>


	</div>
	<!--===================================================-->
	<!-- END OF CONTAINER -->



	<!--JAVASCRIPT-->
	<!--=================================================-->

	<!--jQuery [ REQUIRED ]-->
	<script src="js/jquery.min.js"></script>


	<!--BootstrapJS [ RECOMMENDED ]-->
	<script src="js/bootstrap.min.js"></script>


	<!--NiftyJS [ RECOMMENDED ]-->
	<script src="js/nifty.min.js"></script>
	
	<!--=================================================-->
	
</body>
</html>