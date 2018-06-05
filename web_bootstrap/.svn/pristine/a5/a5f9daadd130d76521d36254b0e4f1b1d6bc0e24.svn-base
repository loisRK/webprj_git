<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!--Summernote [ OPTIONAL ]-->
<link href="<c:url value='/resources/plugins/summernote/summernote.min.css'/> " rel="stylesheet">

<!--Dropzone [ OPTIONAL ]-->
<link href="<c:url value='/resources/plugins/dropzone/dropzone.min.css'/> " rel="stylesheet">

<!--Summernote [ OPTIONAL ]-->
<script src="<c:url value='/resources/plugins/summernote/summernote.min.js'/>"></script>

<!--Dropzone [ OPTIONAL ]-->
<script src="<c:url value='/resources/plugins/dropzone/dropzone.min.js'/>"></script>

<!--Form File Upload [ SAMPLE ]-->
<script src="<c:url value='/resources/js/demo/form-file-upload.js'/>"></script>

<!--Custom script [ DEMONSTRATION ]-->
<!--===================================================-->
<script type="text/javascript">
	// 첨부파일 업로드 결과 저장하는 배열
	var uploadedFile = [];	
	$(document).ready(function() {
		// DROPZONE.JS
		// =================================================================
		// Require Dropzone
		// http://www.dropzonejs.com/
		// =================================================================
		$('#demo-dropzone').dropzone({
			url: '<c:url value="/fileUpload.do?docType=free"/>',
			//autoProcessQueue: false,
			uploadMultiple: true,
			maxFilesize: 10,	// MB
			addRemoveLinks : true,
			parallelUploads: 5,
			maxFiles : 5,
			init : function() {
				var myDropzone = this;
				myDropzone.on('maxfilesexceeded', function(file) {
					this.removeAllFiles();
					this.addFile(file);
			        //  Here's the change from enyo's tutorial...
			        //  $("#submit-all").click(function (e) {
			        //  e.preventDefault();
			        //  e.stopPropagation();
			        //  myDropzone.processQueue();
			        // }
			        //
				});
				myDropzone.on("addedfile", function(file){ });
				// remove 누르면 removdfile
				myDropzone.on("removedfile", function(file){
					// 삭제한 파일을 배열에서 찾아 배열을 재구성한다.
					uploadedFile = $.grep(uploadedFile, function(e){
						return e.filename != file.name;
					});
				});
				// 첨부파일이 임시 폴더에 저장이 되면 complete
				myDropzone.on("complete", function(result){
					// {attachSeq: 0, attachDocType: "free", attachDocSeq: 0, filename: "SQL.Salaries.xml", fakeName: "0d52fc09-a55f-40f7-b045-1def00c93c10", …}
					uploadedFile = $.parseJSON(result.xhr.response);
				});
			}
		});

		// SUMMERNOTE
		// =================================================================
		// Require Summernote
		// http://hackerwins.github.io/summernote/
		// =================================================================
		$('#demo-summernote, #demo-summernote-full-width').summernote({
			height : '300px'
		});
		
		// 저장 버튼 클릭
		$('#btnSave').click(function(){
			// summernote api어케 찾아오는지...
			var content = $('#demo-summernote, #demo-summernote-full-width').summernote('code');
			if(content.length == 0){
				bootbox.alert("Please fill out all blanks.");
				return;
			}
			
			var title = $('#title').val();
			if(title.length == 0){
				bootbox.alert("Please fill out all blanks.");
				return;
			}
			// 컨트롤러로 보낼 파라미터 설정
			var params = {};
			params.title = title;	// 글제목
			params.content = content;	// 글내용 
			params.attaches = uploadedFile;	// 드래그앤드랍으로 첨부한 파일정보
			params = JSON.stringify(params); // json으로 바꿔야 함, 첨부파일이 있는 경우에만 추가해 주고, 이게 있으면 controller에서 @RequestParam으로 값을 못받아옴

			// 글쓰기
			$.ajax({
				url: '<c:url value="/bs/write.do"/>',
				type:'POST',
				data : params,
				dataType:"json",	// 파라미터를 json으로 했기 때문에 data type json으로
				contentType:"application/json",
				mimeType:"application/json",
				success : function (data, textStatus, XMLHttpRequest) {
					bootbox.alert(data.msg);
					if(data.code == "ok"){	// 로그인 한 후 글쓰기 버튼 눌렀을 때
						movePage(null, '/bbs/free/list.do');
					}
					else if(data.code == "no"){	// 로그인 안한상태에서 글쓰기 버튼 눌렀을 때
						movePage(null, '/error.do', {'nextLocation':"/goLogin.do"});
					}
				},
				error : function (XMLHttpRequest, textStatus, errorThrown) {
					bootbox.alert(XMLHttpRequest.responseText);
				}
			});
		});

	});
</script>


<div id="page-head">

	<!--Page Title-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<div id="page-title">
		<h1 class="page-header text-overflow">WritePage</h1>
	</div>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--End page title-->

	<!--Breadcrumb-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<ol class="breadcrumb">
		<li><i class="pli-haunted-house"></i></li>
		<li>Freeboard</li>
		<li class="active">WritePage</li>
	</ol>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--End breadcrumb-->
</div>


<!--Page content-->
<!--===================================================-->
<div id="page-content">

	<!-- Contact Toolbar -->
	<!---------------------------------->
	<div class="row pad-btm">
		<div class="col-sm-6 col-sm-offset-6 toolbar-right text-right">
			<a onclick="movePage(this, '/bbs/free/list.do')">
				<button class="btn btn-default">Cancel</button>
			</a>
			<button class="btn btn-pink" id="btnSave">Save &amp; Publish</button>
		</div>
	</div>
	<!---------------------------------->

	<div class="fixed-fluid">
		<div class="fluid">
			<div class="form-group">
				<input type="text" id="title" placeholder="Article Title" class="form-control input-lg" autofocus>
			</div>
			<div class="panel">
				<div class="panel-body">
					<!--Summernote-->
					<div id="demo-summernote">
						<!-- 입력 한 글 contents부분 -->
					</div>
					<!-- End Summernote -->
				</div>
			</div>
		
			<div class="panel">
			    <div class="panel-body">
			    	<p class="text-main text-bold mar-no">첨부파일</p>
			        <br/>
			        <!--Dropzonejs-->
			        <!--===================================================-->
			        <form id="demo-dropzone" action="#" class="dropzone">
			            <div class="dz-default dz-message">
			                <div class="dz-icon">
			                    <i class="demo-pli-upload-to-cloud icon-5x"></i>
			                </div>
			                <div>
			                    <span class="dz-text">Drop files to upload</span>
			                    <p class="text-sm text-muted">or click to pick manually</p>
			                </div>
			            </div>
			            <div class="fallback">
			                <input name="file[]" type="file" multiple>
			            </div>
			        </form>
			        <!--===================================================-->
			        <!-- End Dropzonejs -->
			    </div>
			</div>
		</div>
	</div>
</div>

<!--===================================================-->
<!--End page content-->
