<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!--Chosen [ OPTIONAL ]-->
<link href="<c:url value="/resources/plugins/chosen/chosen.min.css"/> "	rel="stylesheet">
<!--Chosen [ OPTIONAL ]-->
<script	src="<c:url value='/resources/plugins/chosen/chosen.jquery.min.js'/> "></script>

<script type="text/javascript">

$(document).ready(function(){
	
	
	// onclick없이 함수 실행할 수 있는 방법
	$('#btnSearch').click(function(){
		// id=searchType의 option값을 가져와라
		var type = $('#searchType option:selected').val();
		var text = $('#searchText').val();
		
		movePage(this, '/bbs/free/list.do', {'searchType':type, 'searchText':text});
	});
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
		<li><a href="<c:url value='/home.do'/>"><i
				class="pli-haunted-house"></i></a></li>
		<li><a href="">Board</a></li>
		<li class="active">Freeboard</li>
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
				<h3 class="panel-title">Freeboard</h3>
			</div>

			<!-- List Search Group -->
			<!--===================================================-->
			<div class="panel" style="margin-bottom: 0px !important;">
				<form name="searchForm">
					<!--Panel heading-->
					<div class="panel-heading">
						<div class="panel-control">
							<div class="input-group-wrap" style="max-width: 400px !important;">
								<div class="input-group" style="width: 400px !important;">
									<select class="form-control" style="width: 30% !important;" id="searchType" name="searchType" title="searchType">
										<option value="all"	<c:if test="${searchType == 'all' }">selected</c:if>>ALL</option>
										<option value="writer" <c:if test="${searchType == 'writer' }">selected</c:if>>Writer</option>
										<option value="title" <c:if test="${searchType == 'title' }">selected</c:if>>Title</option>
									</select>
									<input type="text" id="searchText"  name="searchText" value="${searchText}" placeholder="Search" class="form-control" style="width: 70% !important;">
									<span class="input-group-btn">
										<button class="btn btn-primary" type="button" id="btnSearch" title="btnSearch">Search</button>
									</span>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<!--===================================================-->
			<!--End List Search Group-->

			<!-- List Table -->
			<!--===================================================-->
			<div class="panel-body">
				<table class="table table-hover table-vcenter">
					<thead style="font-size: 15px;">
						<tr>
							<th class="min-width">번호</th>
							<th>글 제목</th>
							<th class="text-center">작성자</th>
							<th class="text-center">작성일</th>
							<th class="text-center">조회수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${result }" var="c">
							<tr>
								<td class="text-center"><c:out value='${c.postNum }' /></td>
								<td><span class="text-main text-semibold"> 
									<a style="cursor: pointer;" onclick="movePage(this, '/read.do', {postNum:'${c.postNum}', currentPageNo:'${currentPageNo}'})">
											<c:out value='${c.title }' />
											<c:if test="${c.hasFile == 1 }"><i class="demo-psi-paperclip icon-fw"></i></c:if>
											<c:if test="${c.hasComment != 0 }">
											<font class="text-info">(<c:out value='${c.hasComment }'/>)</font></c:if>
									</a>
								</span></td>
								<td class="text-center"><c:out value='${c.writer }' /></td>
								<td class="text-center"><c:out value='${c.postDate }' /></td>
								<td class="text-center"><span
									class="text-success text-semibold"><c:out
											value='${c.viewCnt }' /></span></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<!--===================================================-->
			<!-- End List Table -->



			<!-- Pager -->
			<!--===================================================-->
			<div class="panel-body text-center"
				style="padding: 0 0 0 0 !important;">

				<!--Pagination-->
				<!--===================================================-->

				<ul class="pagination">
					<!-- 첫페이지로 이동 -->
					<c:if test="${currentPageNo != 1 }">
						<li><a style="cursor: pointer;"
							onclick="movePage(this, '/bbs/free/list.do', {currentPageNo:'1',searchType:'<c:out value="${searchType}"/>',
							 searchText:'<c:out value="${searchText}"/>'})">
								« Start</a></li>
					</c:if>

					<!-- [이전] tag & 하이퍼링크 달기 -->
					<c:if test="${pageBlockStart != 1 }">
						<li><a style="cursor: pointer;"
							onclick="movePage(this, '/bbs/free/list.do', {currentPageNo:'<c:out value="${pageBlockStart-1}"/>', 
							searchType:'<c:out value="${searchType}"/>', searchText:'<c:out value="${searchText}"/>'})"
							class="demo-pli-arrow-left"></a></li>
					</c:if>

					<c:forEach var="i" begin="${pageBlockStart }"
						end="${pageBlockEnd }" step="1">
						<li><a style="cursor: pointer;"
							onclick="movePage(this, '/bbs/free/list.do', {currentPageNo:${i}, 
								searchType:'<c:out value="${searchType}"/>', searchText:'<c:out value="${searchText}"/>'})">
								<c:choose>
									<c:when test="${i == currentPageNo }">
										<strong>${i }</strong>
									</c:when>
									<c:otherwise>
											${i }
										</c:otherwise>
								</c:choose>
						</a></li>
					</c:forEach>

					<!-- [다음]tag & 하이퍼링크  달기-->
					<c:if test="${pageBlockStart + pageBlockSize <= totalPage }">
						<li><a style="cursor: pointer;"
							onclick="movePage(this, '/bbs/free/list.do', {currentPageNo:'<c:out value="${pageBlockEnd + 1 }"/>', 
							searchType:'<c:out value="${searchType}"/>', searchText:'<c:out value="${searchText}"/>'})"
							class="demo-pli-arrow-right"></a></li>
					</c:if>

					<!-- 끝페이지로 이동 -->
					<c:if test="${currentPageNo < totalPage }">
						<li><a style="cursor: pointer;"
							onclick="movePage(this, '/bbs/free/list.do', {currentPageNo:'<c:out value="${totalPage }"/>', 
							searchType:'<c:out value="${searchType}"/>', searchText:'<c:out value="${searchText}"/>'})">
								End »</a></li>
					</c:if>
				</ul>
				<!--===================================================-->
				<!--End Default Pagination-->


				<!--글쓰기 버튼-->
				<!--===================================================-->
				<div class="panel-body text-right">
					<a onclick="movePage(this, '/writePage.do')" >
						<button class="btn btn-mint btn-icon" type="button"><i class="demo-psi-pen-5 icon-lg"></i></button>
					</a>
				</div>
				<!--===================================================-->

			</div>
			<!--===================================================-->
			<!--End Pager-->


		</div>
	</div>
</div>