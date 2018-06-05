<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<title>Register page</title>


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

<!--------------------------------------------------->

<!--Pace - Page Load Progress Par [OPTIONAL]-->
<link href="<c:url value='/resources/plugins/pace/pace.min.css'/>"
	rel="stylesheet">
<script src="<c:url value='/resources/plugins/pace/pace.min.js'/>"></script>

<!--Demo [ DEMONSTRATION ]-->
<link href="<c:url value='/resources/css/demo/nifty-demo.min.css'/>"
	rel="stylesheet">

<!--Animate.css [ OPTIONAL ]-->
<link
	href="<c:url value='/resources/plugins/animate-css/animate.min.css'/>"
	rel="stylesheet">

<!--=================================================


<!--JAVASCRIPT-->
<!--=================================================-->

<!--jQuery [ REQUIRED ]-->
<script src="<c:url value='/resources/js/jquery.min.js'/>"></script>

<!--BootstrapJS [ RECOMMENDED ]-->
<script src="<c:url value='/resources/js/bootstrap.min.js'/>"></script>

<!--NiftyJS [ RECOMMENDED ]-->
<script src="<c:url value='/resources/js/nifty.min.js'/>"></script>

<!----------------------------------------------------->

<!--Background Image [ DEMONSTRATION ]-->
<script src="<c:url value='/resources/js/demo/bg-images.js'/>"></script>

<!--Bootbox Modals [ OPTIONAL ]-->
<script
	src="<c:url value='/resources/plugins/bootbox/bootbox.min.js'/> "></script>

<!--=================================================-->

<!-- ajax 설정 -->
<script type="text/javascript">

	function doJoin() {

		var userId = $('#userId').val();
		if (userId == undefined || userId == '') {
			console.log($('#userId'));
			bootbox.alert("Enter your ID.", function(){
// 				$('#userId').focus();
				$(document).on('hidden.bs.modal','.bootbox', function () {
					   $('#userId').focus();
					});
			});
			return;
		}

		var userName = $('#userName').val();
		if (userName == undefined || userName == '') {
			bootbox.alert("Enter your name.", function(){
				$(document).on('hidden.bs.modal','.bootbox', function () {
					   $('#userName').focus();
					});
			});
			return;
		}

		var nickname = $('#nickname').val();
		if (nickname == undefined || nickname == '') {
			bootbox.alert("Enter your nickname.", function(){
				$(document).on('hidden.bs.modal','.bootbox', function () {
					   $('#nickname').focus();
					});
			});
			return;
		}

		var email = $('#email').val();
		if (email == undefined || email == '') {
			bootbox.alert("Enter your email.", function(){
				$(document).on('hidden.bs.modal','.bootbox', function () {
					   $('#email').focus();
					});
			});
			return;
		}

		var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{3,4}$/i;
		if (email.match(regExp) == null) {
			bootbox.alert("Invalid Format.<br/>You Should follow this format.<br/><b>ex: sample@sample.xxxx</b><br/>Enter your Email Again.", function(){
				$(document).on('hidden.bs.modal','.bootbox', function () {
					   $('#email').focus();
					});
			});
			return;
		}

		var userPw = $('#userPw').val();
		if (userPw == undefined || userPw == '') {
			bootbox.alert("비밀번호를 입력하세요.", function(){
				$(document).on('hidden.bs.modal','.bootbox', function () {
					   $('#userPw').focus();
					});
			});
			return;
		}

		var cUserPw = $('#cUserPw').val();
		if (cUserPw == undefined || cUserPw == '') {
			bootbox.alert("비밀번호를 입력하세요.", function(){
				$(document).on('hidden.bs.modal','.bootbox', function () {
					   $('#cUserPw').focus();
					});
			});
			return;
		}

		if ($('#userPw').val() != $('#cUserPw').val()) {
			bootbox.alert("비밀번호가 다름", function(){
				$(document).on('hidden.bs.modal','.bootbox', function () {
					   $('#cUserPw').focus();
					});
			});
			return;
		}

		$.ajax({
			url : '/wpf/chkId.do',
			type : 'post',
			data : {
				'userId' : userId
			},
			success : function(result, textStatus, jqXHR) {
				if (result == 0) { // 중복 안됨
					var frm = document.joinForm;
					//frm = $('form[name=joinForm]')[0];  // 위와 같은 코드
					frm.action = '/wpf/join.do';
					frm.method = "post";
					frm.submit(); // 중복되지 않으면 컨트롤러로 보내서 정보 저장
				} else if (result == 1) {
					bootbox.alert("This ID already exists.)");
					return;
				}
			}, // function() : 콜백함수
			error : function(jqXHR, textStatus, errorThrown) { // 통신이 안되면 error
				console.log(jqXHR);
				console.log(textStatus);
				console.log(errorThrown);
			}
		});

	}
</script>

</head>

<!--TIPS-->
<!--You may remove all ID or Class names which contain "demo-", they are only used for demonstration. -->

<body>
	<div id="container" class="cls-container">


		<!-- BACKGROUND IMAGE -->
		<!--===================================================-->
		<div id="bg-overlay"></div>


		<!-- REGISTRATION FORM -->
		<!--===================================================-->
		<div class="cls-content"
			style="padding-bottom: 15px; padding-top: 100px;">
			<div class="cls-content-lg panel">
				<div class="panel-body">
					<div class="mar-ver pad-btm">
						<h1 class="h3">Create a New Account</h1>
						<p>Come join My Portfolio! Let's set up your account!</p>
					</div>
					<form name="joinForm">
						<div class="row">
						
							<div class="col-sm-6">
								<div class="form-group">
									<input type="text" class="form-control" placeholder="ID" name="userId" id="userId">
								</div>
								<div class="form-group">
									<input type="text" class="form-control" placeholder="nickname" name="nickname" id="nickname">
								</div>
								<div class="form-group">
									<input type="password" class="form-control" placeholder="Password" name="userPw" id="userPw">
								</div>
							</div>
							
							<div class="col-sm-6">
								<div class="form-group">
									<input type="text" class="form-control" placeholder="Username" name="userName" id="userName">
								</div>
								<div class="form-group">
									<input type="text" class="form-control" placeholder="E-mail" name="email" id="email">
								</div>
								<div class="form-group">
									<input type="password" class="form-control"	placeholder="Confirm Password" name="cUserPw" id="cUserPw">
								</div>
							</div>
							
						</div>

						<button class="btn btn-primary btn-lg btn-block" type="button" onclick="doJoin()"> Register </button>
					</form>
				</div>

				<div class="pad-all">
					Already have an account ? 
					<a href="<c:url value='/goLogin.do'/>" class="btn-link mar-rgt text-bold">Sign In</a>

					<!-- sns와 회원가입 연동하기 -->
					<div class="media pad-top bord-top">
<!-- 						<div class="pull-right"> -->
<!-- 							<a href="#" class="pad-rgt"><i class="demo-psi-facebook icon-lg text-primary"></i></a> -->
<!-- 							<a href="#"	class="pad-rgt"><i class="demo-psi-twitter icon-lg text-info"></i></a> -->
<!-- 							<a href="#" class="pad-rgt"><i class="demo-psi-google-plus icon-lg text-danger"></i></a> -->
<!-- 						</div> -->
<!-- 						<div class="media-body text-left text-main text-bold">Sign Up with</div> -->
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
