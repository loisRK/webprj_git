<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">

	$(document).ready(function(){
		$('#moveToHome').click(function(){
			window.location.href = '/wpf/home.do';
		})
	});

	function doEdit() {

		var nickname = $('#nickname').val();
		if (nickname == undefined || nickname == '') {
			bootbox.alert("Enter your nickname.", function() {
				$(document).on('hidden.bs.modal', '.bootbox', function() {
					$('#nickname').focus();
				});
			});
			return;
		}

		var email = $('#email').val();
		if (email == undefined || email == '') {
			bootbox.alert("Enter your email.", function() {
				$(document).on('hidden.bs.modal', '.bootbox', function() {
					$('#email').focus();
				});
			});
			return;
		}

		var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{3,4}$/i;
		if (email.match(regExp) == null) {
			bootbox.alert("Invalid Format.<br/>You Should follow this format.<br/><b>ex: sample@sample.xxxx</b><br/>Enter your Email Again.",
				function() {
					$(document).on('hidden.bs.modal', '.bootbox', function() {
						$('#email').focus();
					});
				});
			return;
		}

		var userPw = $('#userPw').val();
		if (userPw == undefined || userPw == '') {
			bootbox.alert("비밀번호를 입력하세요.", function() {
				$(document).on('hidden.bs.modal', '.bootbox', function() {
					$('#userPw').focus();
				});
			});
			return;
		}

		var cUserPw = $('#cUserPw').val();
		if (cUserPw == undefined || cUserPw == '') {
			bootbox.alert("비밀번호를 입력하세요.", function() {
				$(document).on('hidden.bs.modal', '.bootbox', function() {
					$('#cUserPw').focus();
				});
			});
			return;
		}

		if ($('#userPw').val() != $('#cUserPw').val()) {
			bootbox.alert("새 비밀번호 확인 실패", function() {
				$(document).on('hidden.bs.modal', '.bootbox', function() {
					$('#cUserPw').focus();
				});
			});
			return;
		}
		
		var params = {};
		params.nickname = nickname;
		params.email = email;
		params.userPw = userPw;

		$.ajax({
			url : '/wpf/editProfile.do',
			type : 'post',
			data : params,
			success : function(result, textStatus, jqXHR) {
				bootbox.alert(result.msg, function(){
					if (result.code == 'success') { // 비밀번호 변경 성공 & 프로필 수정 성공
						window.location.href = '/wpf/home.do';
					} else {
						movePage(null, '/goEditProfile.do');
					}
				});
			}, // function() : 콜백함수
			error : function(jqXHR, textStatus, errorThrown) { // 통신이 안되면 error
				console.log(jqXHR);
				console.log(textStatus);
				console.log(errorThrown);
			}
		});

	}
</script>


<div id="page-head">

	<!--Page Title-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<div id="page-title">
		<h1 class="page-header text-overflow">Profile</h1>
	</div>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--End page title-->

	<!--Breadcrumb-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<ol class="breadcrumb">
		<li><a href="<c:url value='/home.do'/>"><i
				class="pli-haunted-house"></i></a></li>
		<li><a href="">Profile</a></li>
		<li class="active">Edit Page</li>
	</ol>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--End breadcrumb-->
</div>

<!--Page content-->
<!--===================================================-->
<div id="page-content">
	<div class="panel">
		<div class="panel-body">

			<div class="row">
				<div class="col-lg-6">
					<div class="panel">
						<div class="panel-heading">
							<h3 class="panel-title">Edit Your Profile!</h3>
						</div>

						<!--Input Size-->
						<!--===================================================-->
						<form class="form-horizontal">
							<div class="panel-body">
								<div class="form-group">
									<label for="demo-is-inputnormal" class="col-sm-3 control-label">User ID</label>
									<div class="col-sm-6">
										<input type="text" class="form-control" id="userId" readonly="readonly" value="<c:out value='${user.userId }'/>" >
									</div>
								</div>
								<div class="form-group">
									<label for="demo-is-inputnormal" class="col-sm-3 control-label">User Name</label>
									<div class="col-sm-6">
										<input type="text" class="form-control" id="userName" readonly="readonly" value="<c:out value='${user.userName }'/>" >
									</div>
								</div>
								<div class="form-group">
									<label for="demo-is-inputnormal" class="col-sm-3 control-label">Nickname</label>
									<div class="col-sm-6">
										<input type="text" placeholder="Nickname" class="form-control" id="nickname" value="<c:out value='${user.nickname }'/>" >
									</div>
								</div>
								<div class="form-group">
									<label for="demo-is-inputnormal" class="col-sm-3 control-label">Email</label>
									<div class="col-sm-6">
										<input type="text" placeholder="Email" class="form-control" id="email" value="<c:out value='${user.email }'/>">
									</div>
								</div>
								<div class="form-group">
									<label for="demo-is-inputnormal" class="col-sm-3 control-label">Register Date</label>
									<div class="col-sm-6">
										<input type="text" class="form-control" id="createDate" readonly="readonly" value="<c:out value='${user.createDate }'/>">
									</div>
								</div>
								<div class="form-group">
									<label for="demo-is-inputnormal" class="col-sm-3 control-label">New Password</label>
									<div class="col-sm-6">
										<input type="password" placeholder="New Password" class="form-control" id="userPw" >
									</div>
								</div>
								<div class="form-group">
									<label for="demo-is-inputnormal" class="col-sm-3 control-label">Confirm New Password</label>
									<div class="col-sm-6">
										<input type="password" placeholder="Confirm your new password" class="form-control" id="cUserPw">
									</div>
								</div>

							</div>

							<div class="panel-footer">
								<div class="row">
									<div class="col-sm-9 col-sm-offset-3">
										<button class="btn btn-pink" type="button" id="moveToHome">
											<font color="yellow">Return to Home</font>
										</button>
										<button class="btn btn-warning" type="reset">Reset</button>
										<button class="btn btn-purple" type="button" onclick="doEdit()">
											<font color="orange">Edit</font>
										</button>
									</div>
								</div>
							</div>
						</form>
						<!--===================================================-->
						<!--End Input Size-->


					</div>
				</div>


			</div>
		</div>
	</div>
	<!--===================================================-->
	<!--End page content-->