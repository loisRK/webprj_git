<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<title>Home</title>


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
<link href="<c:url value='/resources/css/nifty.css'/>" rel="stylesheet">

<!--Font Awesome [ OPTIONAL ]-->
<link href="<c:url value='/resources/plugins/font-awesome/css/font-awesome.min.css' /> "
	rel="stylesheet">

<!----------------------------------------------------->

<!--Pace - Page Load Progress Par [OPTIONAL]-->
<link href="<c:url value='/resources/plugins/pace/pace.min.css'/>"
	rel="stylesheet">
<script src="<c:url value='/resources/plugins/pace/pace.min.js'/>"></script>

<!--Demo [ DEMONSTRATION ]-->
<link href="<c:url value='/resources/css/demo/nifty-demo.min.css'/>"
	rel="stylesheet">

<!--Themify Icons [ OPTIONAL ]-->
<link
	href="<c:url value='/resources/plugins/themify-icons/themify-icons.min.css'/> rel="stylesheet">

<!--Nifty Premium Icon [ DEMONSTRATION ]-->
<link
	href="<c:url value='/resources/css/demo/nifty-demo-icons.min.css'/> "
	rel="stylesheet">

<!--Premium Solid Icons [ OPTIONAL ]-->
<link
	href="<c:url value='/resources/premium/icon-sets/icons/solid-icons/premium-solid-icons.css'/> "
	rel="stylesheet">

<!--Premium Line Icons [ OPTIONAL ]-->
<link
	href="<c:url value='/resources/premium/icon-sets/icons/line-icons/premium-line-icons.min.css'/> "
	rel="stylesheet">

<!--Ion Icons [ OPTIONAL ]-->
<link
	href="<c:url value='/resources/plugins/ionicons/css/ionicons.min.css'/> "
	rel="stylesheet">

<!--Animate.css [ OPTIONAL ]-->
<link
	href="<c:url value='/resources/plugins/animate-css/animate.min.css'/> "
	rel="stylesheet">

<!--Bootstrap Validator [ OPTIONAL ]-->
<link
	href="<c:url value='/resources/plugins/bootstrap-validator/bootstrapValidator.min.css'/> "
	rel="stylesheet">



<!--JAVASCRIPT-->
<!--=================================================-->

<!--jQuery [ REQUIRED ]-->
<script src="<c:url value='/resources/js/jquery-3.2.1.js'/> "></script>

<script src="<c:url value='/resources/js/common.js'/>"></script>

<!--BootstrapJS [ RECOMMENDED ]-->
<script src="<c:url value='/resources/js/bootstrap.min.js'/>"></script>

<!--NiftyJS [ RECOMMENDED ]-->
<script src="<c:url value='/resources/js/nifty.min.js'/>"></script>

<!--Bootbox Modals [ OPTIONAL ]-->
<script src="<c:url value='/resources/plugins/bootbox/bootbox.min.js'/> "></script>

<!--=================================================-->

<!-- 구글 번역기  -->
<script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>

<!--================================-->

<script type="text/javascript">
	var ctx = '<%=request.getContextPath()%>';
	
	$(document).ready(function() {
		// home.do 접속 시 최초 보여줄 컨텐츠 URL
		movePage(null, "/blank.do");

		$('#loginBtn').click(function() {
			window.location.href = ctx + "/goLogin.do"
		})

		$('#logoutBtn').click(function() {
			window.location.href = ctx + "/logout.do"
		})
		
		
	}); // $(documnet).ready end
	
	function editProfile(){
		var pw = $('#password').val();
		
		$.ajax({
			url: '<c:url value="/user/pwCheck.do"/>',
			data: {'password':pw},
			success: function(data, textStatus, XMLHTtpRequest){
				console.log(data);
				if(data.code == "correct"){
					 bootbox.confirm("Do you wanna go to profile edit page?", function(result) {
				            if (result) {
				               movePage(this, '/goEditProfile.do');
				            }else{
				                $.niftyNoty({
				                    type: 'warning',
				                    icon : 'pli-cross icon-2x',
				                    message : 'Canceled.',
				                    container : 'floating',
				                    timer : 5000
				                });
				            };
				        });		// bootbox.confirm end
   				}
	   			if(data.code == "incorrect"){
	   				bootbox.alert("Wrong Password. Please enter your password again.", function(){
	   					$(document).on('hidden.bs.modal', '.bootbox', function() {
	   						$('#password').focus();
	   					});
	   				});
	   			}
			}
		})
	}
	
	// google translator function
	function googleTranslateElementInit() {
		  new google.translate.TranslateElement({pageLanguage: 'ko', includedLanguages: 'de,en,zh-CN'}, 'google_translate_element');
		}

	// 회원탈퇴 버튼
	function doDelete() {
		bootbox.prompt("If you really want to delete your account, enter your password again.",
						function(result) {
							if (result) {
								$.ajax({
										url : '<c:url value="/withdraw.do"/>',
										type : 'post',
										data : {'password' : result},
										success : function(data, textStatus, XMLHttpRequest) {
											console.log(data);
											if (data.code == "delete") {
												$.niftyNoty({	
													type : 'success',
													message : 'Bye Bye.',
													container : 'floating',
													timer : 10000
												});
												window.location.href = ctx+ "/index.do";
												
											} else if (data.code == "wrongPw") {
												$.niftyNoty({
													type : 'warning',
													message : 'Wrong Password. Please try again.',
													container : 'floating',
													timer : 3000
												});
											}
										},
									error : function(XMLHttpRequest, textStatus, errorThrown) {
										bootbox.alert(XMLHttpRequest.responseText);
										}
									});
							} else {
								$.niftyNoty({
									type : 'info',
									message : 'Good Choice :)',
									container : 'floating',
									timer : 3000
								});
							}
							;
						});
	}	// function doDelete() end

	// adminCheck popup창 뜨게 하는 function
	function adminCheck() {
		// admin != 1이거나 userId == null 일때 다른 팝업창 보이게 하기
		$.ajax({
			url: '<c:url value="/isAdmin.do"/>',
			success: function(data, textStatus, XMLHttpRequest){
				console.log(data);	// log
				
				bootbox.alert(data.msg, function(){
					
					if(data.code == 'admin'){
						bootbox.dialog({
							title : "Administrator-Password",
							message : '<div class="media"><div class="media-left"></div><div class="media-body"> '
									+ '<p class="text-semibold text-main">To Go To the List of Members</p> '
									+ '</div></div> '
									+ '<input id="adminPw" name="adminPw" type="password" placeholder="Password" class="form-control input-md">',
							buttons : {
								success : {
									label : "ENTER",
									className : "btn-purple",
									callback : function() {
										
										var adminPw = $('#adminPw').val();

										if (adminPw.length == 0) { // 빈칸인 경우
											bootbox.alert("You didn't put anything in the box.");
											return;
										}

										$.ajax({
											url : '<c:url value="/adminChk.do"/>',
											type : 'POST',
											data : {"adminPw" : adminPw},
											success : function(data, textStatus, XMLHttpRequest) {
												bootbox.alert(data.msg);
												if (data.code == "okay") { // 로그인 한 후 글쓰기 버튼 눌렀을 때
													movePage(null, '/user/list.do');
												} else if (data.code == "no") { // 로그인 안한상태에서 글쓰기 버튼 눌렀을 때
													movePage(null, '/error.do', {
														'nextLocation' : "/goLogin.do"
													}); //this가 아니라 null?
												} else if (data.code == "wrong") { // adminPw 불일치하는 경우, 원래 페이지 유지
													// movePage(null, '/home.do');
												}
											},
											error : function(XMLHttpRequest, textStatus, errorThrown) {
												bootbox.alert(XMLHttpRequest.responseText);
											}
										});		//ajax end
									}	// callback end
								}	// success end
							}	// buttons end
						});		// bootbox.dialog end
						
					} else if(data.code == 'notAdmin'){
						movePage(null, '/home.do');
					} else{
						window.location.href = '/wpf/goLogin.do';
					}
				});
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				bootbox.alert(XMLHttpRequest.responseText);
			}
		});
	}	// function adminChk() end
	
	
	
</script>
</head>

<!--TIPS-->
<!--You may remove all ID or Class names which contain "demo-", they are only used for demonstration. -->
<body>
	<div id="container" class="effect aside-float aside-bright mainnav-lg">

		<!--NAVBAR-->
		<!--===================================================-->
		<header id="navbar">
		<div id="navbar-container" class="boxed">

			<!--Brand logo & name-->
			<!--================================-->
			<div class="navbar-header">
				<a href="<c:url value='/home.do'/>" class="navbar-brand">
					<div>
						<img src="<c:url value='/resources/img/logo.png'/>"
							alt="Nifty Logo" class="brand-icon" />
					</div>
					<div class="brand-title">
						<span class="brand-text" style="color: rgb(253, 235, 48);">RyunKyung</span>
					</div>
				</a>
			</div>
			<!--================================-->
			<!--End brand logo & name-->


			<!--Navbar-->
			<!--================================-->
			<div class="navbar-content">
				<ul class="nav navbar-top-links">
					<!-- MENU Navigation toogle button -->
					<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
					<li class="tgl-menu-btn">
						<a class="mainnav-toggle" href="<c:url value='/home.do'/>">
							<font style="color: rgb(253, 235, 48); font-weight: 600;" size="4"><i class="demo-pli-list-view"></i></font>
						</a>
					</li>
					<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->

					<!-- ASIDE goJoin & Profile -->
					<li>
						<c:if test="${sessionScope.userId != null }">
							<a class="aside-toggle"> 
								<font style="color: rgb(253, 235, 48); font-weight: 500;" size="4">
								<i class="demo-pli-male icon-lg icon-fw" style="font-weight: 600;"></i></font>
							</a>
						</c:if> 
						<c:if test="${sessionScope.userId == null }">
							<a href="/wpf/goJoin.do" class="add-tooltip" data-toggle="tooltip" data-container="body"
								data-placement="bottom" data-original-title="Go to Join Page">
								<font style="color: rgb(253, 235, 48); font-weight: 500;" size="4"> 
								<i class="pli-add-user icon-lg icon-fw" style="font-weight: 600;"></i></font>
							</a>
						</c:if>
					</li>
					<!-- aside Profile -->

					<!-- Login/out Button-->
					<!--===================================================-->
					<li>
						<c:if test="${sessionScope.userId == null }">
							<a><button id="loginBtn" style="background-color: transparent; border: 2.5px solid;"
									class="btn btn-warning btn-rounded btn-labeled">
								<font style="font-weight: 650;"><i class="btn-label ion-power"></i> Login </font>
							</button></a>
						</c:if> 
						<c:if test="${sessionScope.userId != null }">
							<a><button id="logoutBtn" style="background-color: transparent; border: 2.5px solid;"
									class="btn btn-warning btn-rounded btn-labeled">
								<font style="font-weight: 650;"><i class="btn-label ion-power"></i> Logout </font>
							</button></a>
						</c:if>
					</li>
					<!--===================================================-->

				</ul>
			</div>
			<!--================================-->
			<!--End Navbar-->

		</div>
		</header>
		<!--===================================================-->
		<!--END NAVBAR-->

		<div class="boxed">

			<!--CONTENT CONTAINER-->
			<!--===================================================-->
			<div id="content-container">
				<!-- controller에서 읽어온 jsp view를 띄워줌 -->
			</div>
			<!--===================================================-->
			<!--END CONTENT CONTAINER-->

			<!--ASIDE MENU 로그인 했을때만 나옴 -->
			<!--===================================================-->
			<aside id="aside-container">
			<div id="aside" style="background-color: rgba(255, 255, 255, 0.9);">
				<div class="nano">
					<div class="nano-content">

						<!--Nav tabs-->
						<!--================================-->
						<ul class="nav nav-tabs nav-justified">
							<li class="active"><a href="#demo-asd-tab-1" data-toggle="tab"> <i class="pli-mail"></i> Messages </a></li>
							<li><a href="#demo-asd-tab-2" data-toggle="tab"> <i class="pli-profile"></i> Profile </a></li>
						</ul>
						<!--================================-->
						<!--End nav tabs-->


						<!-- Tabs Content -->
						<!--================================-->
						<div class="tab-content">

							<!-- Second tab (Contact list)-->
							<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
							<div class="tab-pane fade in active" id="demo-asd-tab-1">

								<hr>
								<p class="pad-all text-main text-sm text-uppercase text-bold">
									<span class="pull-right badge badge-success">Offline</span>
									Friends
								</p>

								<!--Works-->
								<div class="list-group bg-trans">
									<a href="#" class="list-group-item"> <span
										class="badge badge-purple badge-icon badge-fw pull-left"></span>
										Joey K. Greyson
									</a> <a href="#" class="list-group-item"> <span
										class="badge badge-info badge-icon badge-fw pull-left"></span>
										Andrea Branden
									</a> <a href="#" class="list-group-item"> <span
										class="badge badge-success badge-icon badge-fw pull-left"></span>
										Johny Juan
									</a> <a href="#" class="list-group-item"> <span
										class="badge badge-danger badge-icon badge-fw pull-left"></span>
										Susan Sun
									</a>
								</div>

							</div>
							<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
							<!--End Second tab (Contact list)-->

							<!-- Third tab (Settings)-->
							<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
							<div class="tab-pane fade" id="demo-asd-tab-2">
								<ul class="list-group bg-trans">
									<li class="pad-top list-header">
										<p class="text-main text-sm text-uppercase text-bold mar-no">Account Info</p>
									</li>
									<li class="list-group-item"><strong>ID</strong> :
										<c:out value="${user.userId}" />
									</li>
									<li class="list-group-item"><strong>Name</strong> :
										<c:out value="${user.userName}" />
									</li>
									<li class="list-group-item"><strong>Nickname</strong> :
										<c:out value="${user.nickname}" />
									</li>
									<li class="list-group-item"><strong>Email Address</strong> :<br />
										<c:out value="${user.email}" />
									</li>
									<li class="list-group-item"><strong>Registered Date</strong> :<br />
										<c:out value="${user.createDate}" />
									</li>
									<li class="list-group-item"><strong>Password to Edit Profile</strong><br/>
										<div class="form-group">
											<input type="password" class="form-control" id="password" placeholder="password">
										</div>							
									</li>
									
								</ul>

									<button type="button" onclick="editProfile()" class="finish btn btn-block btn-default" name="editProfile">
										<div class="media-left"><i class="pli-pen-4 icon-2x"></i></div>
										<div class="media-body"><font size="3.2">EDIT PROFILE</font></div>
									</button>
								</form>

								<hr>

								<button class="btn btn-block btn-primary" onclick="doDelete()">

									<div class="media-left">
										<i class="ion-ios-close-outline icon-2x"></i>
									</div>
									<div class="media-body">
										<font size="3.2">DELETE ACCOUNT</font>
									</div>

								</button>

								<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
								<!-- End Third tab (Settings)-->
							</div>
						</div>
					</div>
				</div>
			</div>
			</aside>
			<!--===================================================-->
			<!--END ASIDE-->


			<!--MAIN NAVIGATION-->
			<!--===================================================-->
			<nav id="mainnav-container">
			<div id="mainnav">

				<!--Menu-->
				<!--================================-->
				<div id="mainnav-menu-wrap">
					<div class="nano">
						<div class="nano-content">

							<!--Profile Widget-->
							<!--================================-->
							<div id="mainnav-profile" class="mainnav-profile">
								<div class="profile-wrap text-center">
									<!-- 프로필 이미지 아이콘 -->
									<c:if test="${sessionScope.userId != null }">
										<div class="pad-btm">
											<font size="6em"> <i class="icon-lg pli-witch"></i>
											</font>
										</div>
									</c:if>
									<c:if test="${sessionScope.userId == null }">
										<div class="pad-btm">
											<font size="6em"> <i class="icon-lg pli-ghost"></i>
											</font>
										</div>
									</c:if>

									<!-- 프로필 명, 로그인-id, 로그오프-Login or Join -->
									<a href="#profile-nav" class="box-block" data-toggle="collapse"
										aria-expanded="false">
										<p class="mnp-name text-center">
											<c:if test="${sessionScope.userId != null }">
											${sessionScope.userId }
											</c:if>
											<c:if test="${sessionScope.userId == null }">
											Login required for full access ;)
											</c:if>
										</p>
									</a>
								</div>
							</div>

							<ul id="mainnav-menu" class="list-group">

								<!-- 대메뉴-->
								<li class="list-header">MENU</li>

								<!-- 중메뉴 -->
								<li><a style="cursor: pointer;"
									onclick="movePage(this, '/blank.do')"> <span
										class="menu-title"> Home </span>
								</a></li>

								<!--중메뉴 + 소메뉴 -->
								<li><a style="cursor: pointer;"> <span
										class="menu-title">Board</span> <i class="arrow"></i>
								</a>
									<ul class="collapse">
										<li><a style="cursor: pointer;"
											onclick="movePage(this, '/bbs/free/list.do')">Freeboard</a></li>
										<li><a style="cursor: pointer;"
											onclick="movePage(this, '/showAlbum.do')">Album</a></li>
									</ul></li>

								<li class="list-divider"></li>

								<!-- Admin MENU : adminID아니면 알람뜨기 -->
								<!-- 대메뉴 -->
								<li class="list-header">ADMIN Menu</li>

								<!--중메뉴 + 소메뉴 -->
								<li><a style="cursor: pointer;"> <span
										class="menu-title">Members</span> <i class="arrow"></i>
								</a> <!--Submenu-->
									<ul class="collapse">
										<li><a style="cursor: pointer;" onclick="adminCheck()">List
												& Manage</a></li>
									</ul></li>

								<!-- google translator -->
								<!--================================-->
								<!-- 								<li> -->
								<!-- 								<div id="google_translate_element" align="center"></div> -->
								<!-- 								</li> -->


							</ul>

							<!--Widget-->
							<!--================================-->
							<div class="mainnav-widget">

								<!-- Show the button on collapsed navigation -->
								<div class="show-small">
									<a href="" data-toggle="menu-widget"
										data-target="#demo-wg-server"> <i
										class="demo-pli-monitor-2"></i>
									</a>
								</div>
								<!--================================-->
								<!--End widget-->

							</div>
						</div>
					</div>
					<!--================================-->
					<!--End menu-->
				</div>
			</nav>
			<!--===================================================-->
			<!--END MAIN NAVIGATION-->

		</div>

		<!-- FOOTER -->
		<!--===================================================-->
		<footer id="footer"> <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
		<!-- Remove the class "show-fixed" and "hide-fixed" to make the content always appears. -->
		<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
		<p class="pad-lft">&#0169; 2018 KIM RYUN KYUNG</p>

		</footer>
		<!--===================================================-->
		<!-- END FOOTER -->

		<!-- SCROLL PAGE BUTTON -->
		<!--===================================================-->
		<button class="scroll-top btn">
			<i class="pci-chevron chevron-up"></i>
		</button>
		<!--===================================================-->

	</div>
	<!--===================================================-->
	<!-- END OF CONTAINER -->
</body>
</html>