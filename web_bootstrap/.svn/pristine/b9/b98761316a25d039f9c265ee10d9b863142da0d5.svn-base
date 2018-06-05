<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<title>Login page</title>

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

<!--=================================================-->
<!--Pace - Page Load Progress Par [OPTIONAL]-->
<link href="<c:url value='/resources/plugins/pace/pace.min.css'/>"
	rel="stylesheet">
<script src="<c:url value='/resources/plugins/pace/pace.min.js'/>"></script>

<!--Demo [ DEMONSTRATION ]-->
<link href="<c:url value='/resources/css/demo/nifty-demo.min.css'/>"
	rel="stylesheet">


<!--JAVASCRIPT-->
<!--=================================================-->

<!--jQuery [ REQUIRED ]-->
<script src="<c:url value='/resources/js/jquery.min.js'/>"></script>

<!--BootstrapJS [ RECOMMENDED ]-->
<script src="<c:url value='/resources/js/bootstrap.min.js'/>"></script>

<!--NiftyJS [ RECOMMENDED ]-->
<script src="<c:url value='/resources/js/nifty.min.js'/>"></script>

<!--=================================================-->

<script type="text/javascript">

	$('#userId').focus();

	$(document).ready(function(){
		// controller에서 넘어오는 msg띄우는 메서드
		var msg = '<c:out value="${msg}"/>';
		if(msg != ''){
		    $.niftyNoty({
		        type: 'info',
		        icon : 'pli-exclamation icon-2x',
		        message : msg,
		        container : 'floating',
		        timer : 5000
		    });
		}
		
	});


</script>
</head>

<!--TIPS-->
<!--You may remove all ID or Class names which contain "demo-", they are only used for demonstration. -->

<body>
	<div id="container" class="cls-container">

		<!-- BACKGROUND IMAGE -->
		<!--===================================================-->
		<div id="bg-overlay"></div>


		<!-- LOGIN FORM -->
		<!--===================================================-->
		<div class="cls-content"
			style="padding-bottom: 15px; padding-top: 100px;">
			<div class="cls-content-sm panel">
				<div class="panel-body">
					<div class="mar-ver pad-btm">
						<h1 class="h3">Account Login</h1>
						<p>Sign In to your account</p>
					</div>
					<form action="/wpf/login.do" method="post">
<%-- 						<c:if test="${msg != null }"> --%>
<%-- 							<div class="alert alert-info">${msg}</div> --%>
<%-- 						</c:if> --%>
						<div class="form-group">
							<input type="text" class="form-control" name="userId" id="userId" required="required" autofocus>
						</div>
						<div class="form-group">
							<input type="password" class="form-control" name="userPw" id="userPw" required="required">
						</div>
						<div class="checkbox pad-btm text-left">
						</div>
						<button class="btn btn-primary btn-lg btn-block" type="submit">Sign In</button>
					</form>
				</div>

				<div class="pad-all">
					<a href="<c:url value='/pwReminderPage.do'/>" class="btn-link mar-rgt">Forgot password ?</a>
					<a href="<c:url value='/goJoin.do'/>" class="btn-link mar-lft">Create a new account</a>

					<!-- sns와 로그인 연동하기 -->
					<div class="media pad-top bord-top">
<!-- 						<div class="pull-right"> -->
<!-- 							<a href="#" class="pad-rgt"><i class="demo-psi-facebook icon-lg text-primary"></i></a> -->
<!-- 							<a href="#" class="pad-rgt"><i class="demo-psi-twitter icon-lg text-info"></i></a> -->
<!-- 							<a href="#" class="pad-rgt"><i class="demo-psi-google-plus icon-lg text-danger"></i></a> -->
<!-- 						</div> -->
<!-- 						<div class="media-body text-left text-bold text-main">Login	with</div> -->
					</div>
				</div>
			</div>
		</div>
		<!--===================================================-->

	</div>
	<!--===================================================-->
	<!-- END OF CONTAINER -->

</body>
</html>