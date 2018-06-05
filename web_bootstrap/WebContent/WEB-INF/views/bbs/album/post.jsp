<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!--Dropzone [ OPTIONAL ]-->
<link href="<c:url value='/resources/plugins/dropzone/dropzone.min.css'/> " rel="stylesheet">


<div class="panel">
	<div class="panel-body">
		<p class="text-main text-bold mar-no">Ã·ºÎÆÄÀÏ</p>
		<br />
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
