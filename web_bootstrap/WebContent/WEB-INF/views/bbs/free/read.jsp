<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- fmt tag -> 숫자 포맷씌우기 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!--X-editable [ OPTIONAL ]-->
<script
	src="<c:url value='/resources/plugins/x-editable/js/bootstrap-editable.min.js'/>"></script>

<!--Bootstrap Table [ OPTIONAL ]-->
<script
	src="<c:url value='/resources/plugins/bootstrap-table/bootstrap-table.min.js'/>"></script>

<!--Bootstrap Table Extension [ OPTIONAL ]-->
<script
	src="<c:url value='/resources/plugins/bootstrap-table/extensions/editable/bootstrap-table-editable.js'/>"></script>

<script type="text/javascript">
	function noty(msg, status){
		$.niftyNoty({
			type : status,
			message : msg,
			container : 'floating',
			timer : 4000
		});
	}
	
	
	function deleteCom(){
		var comNum = $('#comNum').val();
		var currentPageNo = $('#currentPageNo').val();
		var postNum = $('#postNum').val();
		
		console.log(comNum, postNum);
		$.ajax({
			url: '/wpf/bs/comDelete.do',
			data: {'comNum' : comNum, 'postNum' : postNum},
			success: function(data, textStatus, XMLHttpRequest){
				if(data == 1){
					movePage(null, '/read.do', {'postNum' : postNum, 'currentPageNo' : currentPageNo});
					noty("Comment deleted.", "warning");
				}
				else if(data == 0){
					noty("Error: Couldn't delete your comment.", "danger");
				}
			},
			error: function(XMLHttpRequest, textStatus, errorThrown) {
				alert(XMLHttpRequest.responseText);
			}
		})
		
	}
	
	// jQuery를 이용해서 입력되게 해줌
	$(document).ready(function() {
		
		$('#comEdit').click(function(){
			
				var currentPageNo = $('#currentPageNo').val();
				var postNum = $('#postNum').val();
				var comNum = $('#comNum').val();
				var comment = $('#editComment').val();
				var edit = 1;
				
				if(comment == ''){
					noty("Write your comment.", "danger");
					$('#editComment').focus();
					return;
				}
				
				var params = {};
				
				params.currentPageNo = currentPageNo;
				params.postNum = postNum;
				params.comNum = comNum;
				params.comment = comment;
				
				$.ajax({
					url: '/wpf/bs/comEdit.do',
					data: params,
					success: function(data, textStatus, XMLHttpRequest){
						console.log(data);
						movePage(null, '/read.do', {'currentPageNo':currentPageNo, 'postNum':postNum});
					},
					error: function(XMLHttpRequest, textStatus, errorThrown) {
						alert(XMLHttpRequest.responseText);
					}
					
				})
		});	// comEdit 버튼 end

		$('#btnComment').click(function() {
			
			var comment = $('#comment').val();
			var currentPageNo = $('#currentPageNo').val();
			var postNum = $('#postNum').val();

			if (comment == '') {
				noty("Write your comment.");
				$('#comment').focus();
				return;
			}

			var params = {};
			params.comment = comment; // 댓글내용
			params.postNum = postNum; // 글번호 
			params.currentPageNo = currentPageNo; // 현재 페이지 넘버
			params = JSON.stringify(params); // json으로 바꿔야 함.

			$.ajax({
				url : '<c:url value="/bs/comment.do"/>',
				type : 'POST',
				data : params,
				dataType : "json",
				contentType : "application/json",
				mimeType : "application/json",
				success : function(data, textStatus, XMLHttpRequest) {
					console.log(data);
					if (data.code == "ok") {
						noty(data.msg, "success");
						movePage(null, '/read.do', {'postNum' : postNum, 'currentPageNo' : currentPageNo});
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					alert(XMLHttpRequest.responseText);
				}
			});
		});	// btnComment 버튼 end
		
	});
</script>


<div id="page-head">

	<!--Page Title-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<div id="page-title">
		<h1 class="page-header text-overflow">Freeboard</h1>
	</div>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--End page title-->


	<!--Breadcrumb-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<ol class="breadcrumb">
		<li><i class="pli-haunted-house"></i></li>
		<li>Freeboard</li>
		<li class="active">ReadPage</li>
	</ol>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--End breadcrumb-->
</div>

<!--Page content-->
<!--===================================================-->
<div id="page-content">
	<div class="panel">
		<div class="panel-body">
			<div class="panel">

				<input type="hidden" id="currentPageNo" name="currentPageNo" value="${currentPageNo }" />
				<input type="hidden" id="postNum" name="postNum" value="${board.postNum }" />
				<input type="hidden" id="userId" name="userId" value="${board.userId }" />

				<!-- readForm -->
				<!--===================================================-->
				<div class="mar-btm pad-btm bord-btm">
					<h1 class="page-header text-overflow">
						<c:out value="${board.title }" />
					</h1>
				</div>

				<div class="row">

					<div class="col-sm-7 toolbar-left">

						<!--작성자 정보-->
						<div class="media">
							<span class="media-left"> <img
								src="resources/img/profile-photos/8.png"
								class="img-circle img-sm" alt="Profile Picture">
							</span>
							<div class="media-body text-left">
								<div class="text-bold">
									<c:out value="${board.writer }" />
								</div>
								<small class="text-muted"><c:out value="${email }" /></small>
							</div>
						</div>
					</div>

					<div class="col-sm-5 toolbar-right">

						<!--Details Information-->
						<!-- 날짜 -->
						<p class="mar-no">
							<small class="text-muted"><c:out
									value="${board.postDate }" /></small>
						</p>
						<!-- 조회수 -->
						Read by <strong><c:out value="${board.viewCnt }" /></strong>
						people
					</div>
				</div>

				<!-- 수정, 삭제, 목록 버튼 -->
				<div class="row pad-top">
					<div class="col-sm-7 toolbar-left">
						<div class="btn-group btn-group">
							<c:if test="${sessionScope.userId == board.userId}">
								<!-- 수정버튼 -->
								<a onclick="movePage(this, '/goUpdate.do', 
								{currentPageNo : '<c:out value="${currentPageNo}"/>', postNum : '<c:out value="${postNum}"/>'})">
									<button class="btn btn-default" type="button">
										<i class="fa fa-edit icon-lg"></i> Edit
									</button>
								</a>
								<!-- 삭제버튼 -->
								<a onclick="movePage(this, '/delete.do',
										 {currentPageNo : '<c:out value="${currentPageNo}"/>', postNum : '<c:out value="${postNum}"/>'})">
									<button class="btn btn-default" type="button">
										<i class="fa fa-trash-o icon-lg"></i> Delete
									</button>
								</a>
							</c:if>
						</div>
					</div>

					<!-- 목록으로 -->
					<div class="col-sm-5 toolbar-right">
						<!--Reply & forward buttons-->
						<div class="btn-group btn-group">
							<a class="btn btn-default"
								onclick="movePage(this, '/bbs/free/list.do', 
								{currentPageNo : '<c:out value="${currentPageNo}"/>'} )">
								<i class="ion-navicon-round"></i>
							</a>
						</div>
					</div>
				</div>

				<!--Context-->
				<!--===================================================-->
				<div class="mail-message">${board.contents }</div>
				<!--===================================================-->
				<!--End Context-->

				<!-- Attach Files-->
				<!--===================================================-->
				<div class="pad-ver">
					<p class="text-main text-bold box-inline">
						<i class="demo-psi-paperclip icon-fw"></i> Attachments 
						<!-- 파일갯수 -->
						<span>
							<c:if test="${totalAttach != 0 }">
								(${totalAttach }) 
							</c:if>
						</span>
					</p>
<!-- 					<a href="#" class="btn-link">Download all</a> | <a href="#"	class="btn-link">View all images</a> -->

					<ul class="file-list">
						<!--File list item-->
						<c:forEach items="${attachFile }" var="a">
							<li style="width: 424px;"><a
								href="<c:url value='/bbs/free/fileDownload.do?attachSeq=${a.attachSeq}'/>"
								class="file-details">
									<div class="media-block">
										<div class="media-left">
											<i class="fa fa-file"></i>
										</div>
										<div class="media-body">
											<p class="file-name">${a.filename }</p>
											<small>${a.createDate } | <fmt:formatNumber
													pattern="#,##0" value="${a.fileSize/1024}" /> KB
											</small>
										</div>
									</div>
							</a></li>
						</c:forEach>
					</ul>
				</div>
				<!--===================================================-->
				<!-- End Attach Files-->

				<!--===================================================-->
				<!-- readForm end -->

				<c:if test="${sessionScope.userId != null }">
					<!-- 댓글 남기기 form -->
					<!--===================================================-->
					<p class="text-lg text-main text-bold text-uppercase">Leave a comment</p>
					<div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<div class="col-md-12" style="padding-bottom: 10px;">
									<textarea class="form-control" rows="3" id="comment" name="comment" placeholder="Your comment"></textarea>
								</div>
								<div class="col-md-4">
									<button type="button" id="btnComment" class="btn btn-success btn-block">
										<i class="fa fa-comment"></i> Submit comment
									</button>
								</div>
							</div>
						</div>
					</div>
					<!--===================================================-->
					<!-- End 댓글 남기기 form -->
				</c:if>

				<hr class="new-section-sm">
				<p class="text-lg text-main text-bold text-uppercase pad-btm">Comments</p>

				<!-- 댓글 보여주기 -->
				<!--===================================================-->
				<c:forEach items="${comments}" var="c">
					<input type="hidden" id="comNum" value="${c.comNum }"/>
					<div class="comments media-block">
						<a class="media-left" href="#"><img class="img-circle img-sm" alt="Profile Picture"
							src="<c:url value='/resources/img/profile-photos/8.png'/>"></a>
						<div class="media-body">
							<div class="comment-header">
							
								<!-- 삭제, 대댓 버튼 -->
								<div align="right">
								<c:if test="${(sessionScope.userId == c.userId || sessionScope.isAdmin == 1) && edit != 1}">
									<a class="btn btn-xs btn-default" onclick="deleteCom()"><i class="icon-lg pli-broom"></i> Delete</a>
									<a class="btn btn-xs btn-default" onclick="movePage(this, '/read.do', 
												{currentPageNo:'${currentPageNo}', postNum:'${postNum}', edit:'1', comNum:'<c:out value="${c.comNum }"/>'})" >
										<i class="icon-lg pli-wizard"></i> Edit
									</a>
								</c:if>
<!-- 								<a class="btn btn-xs btn-default"><i class="icon-lg pli-candy"></i> Reply 4</a> -->
								</div>
								
								<c:out value='${c.userId}' />
								<div class="text-muted text-sm">
									<c:out value='${c.comDate}' />
								</div>
								
							</div>
							
							<!-- 댓글내용 -->
							<p>
								<c:choose>
									<c:when test="${edit == 1 && comNum == c.comNum }">
										<div class="col-md-12">
											<div class="col-md-10" style="padding-bottom: 10px;">
												<textarea class="form-control" rows="3" id="editComment" name="editComment" placeholder="${c.comContents }"></textarea>
											</div>
											<div class="col-md-2">
												<button type="button" id="comEdit" class="btn btn-success btn-block">Save</button>
											</div>
										</div>
									</c:when>
									<c:otherwise>
										<c:out value='${c.comContents}' />
									</c:otherwise>
								</c:choose>
							</p>

							<!-- 대댓 포맷 -->
<!-- 							<div class="comment-body"> -->
<!-- 								<div class="comment-content media"> -->
<!-- 									<a class="media-left" href="#"><img -->
<!-- 										class="img-circl  img-xs" alt="Profile Picture" -->
<%-- 										src="<c:url value='/resources/img/profile-photos/5.png'/>"></a> --%>
<!-- 									<div class="media-body"> -->
<!-- 										<div class="comment-header"> -->
<!-- 											Bobby Marz <small class="text-muted">7 min ago</small> -->
<!-- 										</div> -->
<!-- 										대댓내용 -->
<!-- 										Sed diam nonummy nibh euismod. -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
						</div>
					</div>
				</c:forEach>
				<!--===================================================-->
				<!-- End Comments -->

			</div>
		</div>
	</div>
</div>
<!--===================================================-->
<!--End page content-->