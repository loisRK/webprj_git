<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<script type="text/javascript">
	$(document).ready(function() {
		$('#sendMail').click(function() {
			var sender = $('#sender').val();
			if (sender.length == 0) {
				alert("이름을 작성해 주세요.");
				return;
			}
			var sEmail = $('#sEmail').val();
			if (sEmail.length == 0) {
				alert("본인 이메일 주소를 작성해 주세요.");
				return;
			}
			var message = $('#message').val();
			if (message.length == 0) {
				alert("메세지를 작성해 주세요.");
				return;
			}
			var subject = $('#subject').val();

			var params = {};
			params.sender = sender;
			params.sEmail = sEmail;
			params.message = message;
			params.subject = subject;
			console.log(params);

			$.ajax({
				url : '<c:url value="/sendMail.do"/>',
				type : 'POST',
				data : params,

				success : function(data, textStatus, XMLHttpRequest) {
					alert(data.msg);
					if (data.code == "success") { // 로그인 한 후 글쓰기 버튼 눌렀을 때
						window.location.href = ctx + "/home.do"
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					alert(XMLHttpRequest.responseText);
				}
			});
		});
	});
</script>

<div id="page-head">

	<!--Page Title-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<div id="page-title">
		<h1 class="page-header text-overflow">Home page</h1>
	</div>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--End page title-->


	<!--Breadcrumb-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<ol class="breadcrumb">
		<li><a href=""><i class="pli-haunted-house"></i></a></li>
		<li class="active">Home page</li>
	</ol>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--End breadcrumb-->

</div>


<!--Page content-->
<!--===================================================-->
<div id="page-content">

	<!-- Page Info Panel -->
	<!---------------------------------->
	<hr class="new-section-sm bord-no">
	<div class="row">
		<div class="col-lg-8 col-lg-offset-2">
			<div class="panel panel-body text-center" style="background-color: #25476a70;">
				<p style="font-size: 30px; font-weight: 600; color: white;">
				<font style="color: rgb(253, 235, 48);">RyunKyung</font>'s Portfolio Page</p>
				<div class="panel-body" style="padding-bottom: 0px;">
					<!--Horizontal description-->
					<!--===================================================-->
					<dl class="dl-horizontal" style="font-weight: 400; color: white; font-size: 15px;">
						<dt>Used Tools & Skills</dt>
							<dd>Spring Framework 4.3.14.RELEASE</dd>
							<dd>myBatis 3.4.1</dd>
							<dd>jUnit 4.12</dd>
							<dd>MySQL</dd>
							<dd>Bootstrap</dd>
						<br/>
						<dt>Update Date</dt>
							<dd style="color: rgb(253, 235, 48);">03-05-2018</dd>
					</dl>
					<!--===================================================-->
				</div>
			</div>
		</div>
	</div>

	<!---------------------------------->


	<!-- Contact Panel -->
	<!---------------------------------->
	<div class="panel">
		<div class="panel-body">

			<h3>Leave Me a Message</h3>
			<p>If you have any opinion with my page, please send me a message!</p>
			<div class="row">
				<div class="col-sm-6">
					<form>
						<div class="form-group">
							<input class="form-control" id="sender" name="sender"
								placeholder="Your name" type="text">
						</div>
						<div class="form-group">
							<input class="form-control" id="sEmail" name="sEmail"
								type="email" placeholder="Your email">
						</div>
						<div class="form-group select">
							<select id="subject" name="subject">
								<option value="none"
									<c:if test="${subject == 'none' }">selected</c:if>>Subject</option>
								<option value="Feedback"
									<c:if test="${subject == 'Feedback' }">selected</c:if>>Feedback</option>
								<option value="Loveletter"
									<c:if test="${subject == 'Loveletter' }">selected</c:if>>Loveletter</option>
								<option value="Support"
									<c:if test="${subject == 'Support' }">selected</c:if>>Support</option>
								<option value="Donation"
									<c:if test="${subject == 'Donation' }">selected</c:if>>Donation</option>
							</select>
						</div>
						<div class="form-group">
							<textarea class="form-control" id="message" name="message"
								rows="10" placeholder="Your message"></textarea>
						</div>
						<button type="button" id="sendMail"
							class="btn btn-primary btn-block btn-lg">Submit</button>
					</form>
				</div>

				<div class="col-sm-6">
					<div class="mar-all">
						<div class="media" style="padding-top: 5px;">
							<div class="media-left">
								<i class="icon-lg icon-fw demo-pli-map-marker-2"></i>
							</div>
							<div class="media-body">
								<address>
									<strong class="text-main"> RyunKyung, Home.</strong><br>
									Mapo-Gu<br> Seoul, Republic of Korea 04045<br>
								</address>
							</div>
						</div>

						<p>
							<i class="icon-lg icon-fw demo-pli-old-telephone"></i> <span>+82
								10-7154-5083</span>
						</p>
						<div class="pad-btm">
							<i class="icon-lg icon-fw demo-pli-mail"></i> <span>loiskim150@gmail.com</span>
						</div>

						<!-- sns계정 연결3 -->
						<div class="pad-ver">
							<a href="#"
								class="mar-rgt box-inline demo-pli-facebook icon-lg add-tooltip"
								data-original-title="Facebook" data-container="body"></a> <a
								href="#"
								class="mar-rgt box-inline demo-pli-twitter icon-lg add-tooltip"
								data-original-title="Twitter" data-container="body"></a> <a
								href="#"
								class="mar-rgt box-inline demo-pli-google-plus icon-lg add-tooltip"
								data-original-title="Google+" data-container="body"></a> <a
								href="#"
								class="mar-rgt box-inline demo-pli-instagram icon-lg add-tooltip"
								data-original-title="Instagram" data-container="body"></a>
						</div>

						<!-- 구글맵연결 -->
						<div>
							<!-- q = 원하는 주소 구글맵에서 찾아서 주소명넣으면 됨 -->
							<iframe
								src="https://www.google.com/maps/embed/v1/place?q=합정역&amp;key=AIzaSyBSFRN6WWGYwmFi498qXXsD2UwkbmD74v4"
								frameborder="0" scrolling="no" marginheight="0" marginwidth="0"
								style="width: 100%; height: 200px;"></iframe>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!---------------------------------->


</div>
<!--===================================================-->
<!--End page content-->
