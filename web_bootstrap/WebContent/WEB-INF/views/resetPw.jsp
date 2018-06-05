<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Reset password</title>
<!--STYLESHEET-->
<!--=================================================-->
<!--Open Sans Font [ OPTIONAL ]-->
<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700' rel='stylesheet' type='text/css'>

<!--Bootstrap Stylesheet [ REQUIRED ]-->
<link href="<c:url value='/resources/css/bootstrap.min.css'/>" rel="stylesheet">

<!--Nifty Stylesheet [ REQUIRED ]-->
<link href="<c:url value='/resources/css/nifty.min.css'/>" rel="stylesheet">

<!--Nifty Premium Icon [ DEMONSTRATION ]-->
<link href="<c:url value='/resources/css/demo/nifty-demo-icons.min.css'/>" rel="stylesheet">
<!--=================================================-->
<!--Pace - Page Load Progress Par [OPTIONAL]-->
<link href="<c:url value='/resources/plugins/pace/pace.min.css'/>" rel="stylesheet">
<script src="<c:url value='/resources/plugins/pace/pace.min.js'/>"></script>

<!--Demo [ DEMONSTRATION ]-->
<link href="<c:url value='/resources/css/demo/nifty-demo.min.css'/>" rel="stylesheet">

<!--Animate.css [ OPTIONAL ]-->
<link href="<c:url value='/resources/plugins/animate-css/animate.min.css'/>" rel="stylesheet">
	
<!--JAVASCRIPT-->
<!--=================================================-->
<!--jQuery [ REQUIRED ]-->
<script src="<c:url value='/resources/js/jquery.min.js'/>"></script>
<script src="<c:url value='/resources/js/common.js'/>"></script>

<!--BootstrapJS [ RECOMMENDED ]-->
<script src="<c:url value='/resources/js/bootstrap.min.js'/>"></script>

<!--NiftyJS [ RECOMMENDED ]-->
<script src="<c:url value='/resources/js/nifty.min.js'/>"></script>

<!--Bootbox Modals [ OPTIONAL ]-->
<script src="<c:url value='/resources/plugins/bootbox/bootbox.min.js'/>"></script>
<!--=================================================-->

<!--Background Image [ DEMONSTRATION ]-->
<script src="<c:url value='/resources/js/demo/bg-images.js'/>"></script>

<script src="https://cdn.ckeditor.com/4.9.1/standard/ckeditor.js"></script>

<script type="text/javascript">
var ctx = "<%= request.getContextPath()%>";

function changePassword(){
	var password = $('#password').val();
	var passwordCf = $('#passwordCf').val();
	var userId = $('#userId').val();
	var email = $('#email').val();
	
	if(password == undefined || password == ''){
		bootbox.alert("Enter new password");
		$('#password').focus();
		return;
	}
	
	if(passwordCf == undefined || passwordCf == ''){
		bootbox.alert("Enter confirm password");
		$('#passwordCf').focus();
		return;
	}
	
	if(passwordCf != password){
		bootbox.alert("Password and confrim password does not match");
		$('#passwordCf').focus();
		return;
	}
	
	$.ajax({
		url: '/wpf/resetPassword.do',
		type: "post",
		data: {'password' : password, 'passwordCf' : passwordCf, "userId" : encodeURIComponent(userId), "email" : encodeURIComponent(email)},
		success : function(data, textStatus, XMLHttpRequest) {
			bootbox.alert(data.msg);
			if (data.code == "ok") {
				window.location.href = ctx+"/goLogin.do"
			}
			if (data.code == "no") {
			}
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			bootbox.alert(XMLHttpRequest.responseText);
		}
	});
}
</script>
</head>
<body>
	<div id="container" class="cls-container" style="background: rgba(17, 30, 46, 1);">

		<!-- BACKGROUND IMAGE -->
		<!--===================================================-->
		<div id="bg-overlay"></div>
		
		<!-- PASSWORD RESETTING FORM -->
		<!--===================================================-->
		<div class="cls-content">
			<div class="cls-content-sm panel">
				<div class="panel-body">
					<h1 class="h3">Reset password</h1>
					<p class="pad-btm">Enter your new password.</p>

					<form>
						<input type="hidden" name="userId" id="userId" value="${userId}" />
						<input type="hidden" name="email" id="email" value="${email}" />
						<div class="form-group">
							<input type="password" id="password" class="form-control" placeholder="password">
						</div>
						<div class="form-group">
							<input type="password" id="passwordCf" class="form-control" placeholder="confirm password">
						</div>
						<div class="form-group text-right">
							<button class="btn btn-danger btn-lg btn-block" onclick="changePassword()" type="button">Save</button>
						</div>
					</form>

				</div>
			</div>
		</div>
		<!--===================================================-->
	</div>
	<!--===================================================-->
	<!-- END OF CONTAINER -->
</body>
</html>