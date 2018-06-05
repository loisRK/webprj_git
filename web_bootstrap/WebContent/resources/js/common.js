
function movePage(target, url, params){
 	if(console){
 		console.log(target);
 		console.log(url);
 		console.log(params);
 	}
	if(params == undefined) params = {};
	if(target != null){
		// 기존에 선택한 중메뉴(li) 선택 상태 배경색 제거
		$('ul#mainnav-menu li.active-sub').removeClass('active-sub');
		
		// 기존에 선택한 소메뉴(li) 선택 해제 상태로
		$('ul#mainnav-menu li.active-link').removeClass('active-link');
		
		// 선택한 중메뉴(li) 클릭한 상태로 
		$(target).parent().parent().parent().addClass('active-sub');
		// 선택한 소메뉴(li) 클릭한 상태로
		$(target).parent().addClass('active-link');
	}
	
	$.ajax({
		url: ctx+url,
		data : params,
		success : function (data, textStatus, XMLHttpRequest) {
			// 갤러리 때문에 추가..
			jQuery('div.ug-gallery-wrapper.ug-lightbox').remove();
			$("div#content-container").html( data );
		},
		error : function (XMLHttpRequest, textStatus, errorThrown) {
			console.log(XMLHttpRequest.responseText);
		}
	});
}