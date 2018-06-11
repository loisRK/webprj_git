<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!--STYLESHEET-->
<!--=================================================-->
<!--Bootstrap Table [ OPTIONAL ]-->
<link
	href="<c:url value='/resources/plugins/bootstrap-table/bootstrap-table.min.css'/> "
	rel="stylesheet">

<!--Font Awesome [ OPTIONAL ]-->
<link
	href="<c:url value='/resources/plugins/font-awesome/css/font-awesome.min.css'/> "
	rel="stylesheet">

<!--X-editable [ OPTIONAL ]-->
<link
	href="<c:url value='/resources/plugins/x-editable/css/bootstrap-editable.css'/> "
	rel="stylesheet">

<!--Animate.css [ OPTIONAL ]-->
<link
	href="<c:url value='/resources/plugins/animate-css/animate.min.css'/> "
	rel="stylesheet">

<!--=================================================-->


<!--JAVASCRIPT-->
<!--=================================================-->

<!--Demo script [ DEMONSTRATION ]-->
<script src="<c:url value='/resources/js/demo/nifty-demo.min.js'/> "></script>


<!--X-editable [ OPTIONAL ]-->
<script
	src="<c:url value='/resources/plugins/x-editable/js/bootstrap-editable.min.js'/> "></script>


<!--Bootstrap Table [ OPTIONAL ]-->
<script
	src="<c:url value='/resources/plugins/bootstrap-table/bootstrap-table.min.js'/> "></script>


<!--Bootstrap Table Extension [ OPTIONAL ]-->
<script
	src="<c:url value='/resources/plugins/bootstrap-table/extensions/editable/bootstrap-table-editable.js'/> "></script>

<!--=================================================-->

<script type="text/javascript">
$(document).ready(function(){
	//X-EDITABLE USING FONT AWESOME ICONS
	// =================================================================
	// Require X-editable
	// http://vitalets.github.io/x-editable/
	//
	// Require Font Awesome
	// http://fortawesome.github.io/Font-Awesome/icons/
	// =================================================================
	$.fn.editableform.buttons = '<button type="submit" class="btn btn-primary editable-submit">'
			+ '<i class="fa fa-fw fa-check"></i>'
			+ '</button>'
			+ '<button type="button" class="btn btn-default editable-cancel">'
			+ '<i class="fa fa-fw fa-times"></i>' + '</button>';

	//EDITABLE - COMBINATION WITH X-EDITABLE
	// =================================================================
	// Require X-editable
	// http://vitalets.github.io/x-editable/
	//
	// Require Bootstrap Table
	// http://bootstrap-table.wenzhixin.net.cn/
	//
	// Require X-editable Extension of Bootstrap Table
	// http://bootstrap-table.wenzhixin.net.cn/
	// =================================================================
	
	function setGridParam(params){
		params.key = 'value';	
		params['key2'] = 'value';
		return params;
	}
	
	$('#demo-editable').bootstrapTable({
		idField : 'seq',	// 가져올 테이블 PK
		url : '/wpf/user/getUserData.do',	// 데이터 가져오는 메서드주소
		queryParams: setGridParam,	// 추가적인 파라미터
		dataField: 'rows',	// Key in incoming json containing rows data list.
		totalField: 'total',	// Key in incoming json containing "total" data .
		sidePagination: 'server',
		pagination: true,	// True to show a pagination toolbar on table bottom.
		pageNumber: 1,		// When set pagination property, initialize the page number.
		pageSize: 10,		// When set pagination property, initialize the page size.
		search: true,
		showFilter: true,
		columns : [ {
			field : 'seq',	// dto명
			align : 'center',
			title : 'UserNum',	// 페이지에 보여지는 컬럼 명
			sortable: true
		}, {
			field : 'userId',
			align : 'center',
			title : 'UserId',
            sortable: true
		}, {
			field : 'userName',
			align : 'center',
			title : 'UserName',
			editable : {
				type : 'text'
			},
            sortable: true
		}, {
			field : 'nickname',
			align : 'center',
			title : 'Nickname',
			editable : {
				type : 'text'
			},
            sortable: true
		}, {
			field : 'email',
			align : 'center',
			title : 'email',
			editable : {
				type : 'text',
				// 유효성 검사
				validate: function(value) {
				    if($.trim(value) == '') {	// 값 유효성검사
				        return 'This field is required';	
				    }
				}
			},
            sortable: true
		}, {
			field : 'isAdmin',
			align : 'center',
			title : 'isAdmin',
			editable : {
				type : 'text'
			}
		}, {
			field : 'createDate',
			align : 'center',
			title : 'CreateDate',
			searchable : false
		} 
		],
		// 저장되고 나면 호출되는 이벤트
		onEditableSave: function(field, row, oldValue, $el) {
        	console.log(field);
        	console.log(row);
        	console.log(oldValue);
            return false;
        }
	});
	
})
	
</script>

<div id="page-head">

	<!--Page Title-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<div id="page-title">
		<h1 class="page-header text-overflow"></h1>
	</div>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--End page title-->

	<!--Breadcrumb-->
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<ol class="breadcrumb">
		<li><a href="<c:url value='/home.do'/>"><i
				class="pli-haunted-house"></i></a></li>
		<li><a href="">Members</a></li>
		<li class="active">회원관리</li>
	</ol>
	<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
	<!--End breadcrumb-->
</div>


<!--Page content-->
<!--===================================================-->
<div id="page-content">
	<div class="panel">
		<div class="panel">

			<div class="panel-heading">
				<h3 class="panel-title">회원관리</h3>
			</div>

			<!--Editable - combination with X-editable-->
			<!--===================================================-->
			<div class="panel">
				<div class="panel-body">
					<table id="demo-editable"
						data-show-refresh="true"
						data-show-toggle="true" 
						data-show-columns="true"
						data-sort-name="seq"
						data-page-list="[5, 10, 20]" 
						data-multiple-search="true"
  						data-id-field="seq"		<%-- PK key --%>
						data-editable-url="<c:url value='/user/edit.do'/>"	<%-- 수정 후 ok 누르면 데이터 보낼 URL --%>
						data-show-pagination-switch="true">
					</table>
				</div>
			</div>

		</div>
	</div>
</div>
