$(document).ready(function() {
	//navi
	$('li.navi_has').mouseenter(function(){
		$(this).addClass('on');
		$(this).find('.navi_sub').show();
    });
	 $('li.navi_has').mouseleave(function(){
		$(this).removeClass('on');
		$(this).find('.navi_sub').hide();
    });
	//버튼 클릭시 그래프2영역 사라짐

	$('.graph_btn').click(function(e){    		
		if ($(this).text() === '그래프2 보기') {
         $(this).text('그래프2 닫기');
		 $(this).css({'background-color':'#faac31','border-color':'#ef9d1b'});
		 $('.graph_box1').css('width','609px');
		 $('.graph_box2').show();		
		}
		else {
			$(this).text('그래프2 보기');
			$(this).css({'background-color':'#ea2424','border-color':'#ce4c35'});
			$('.graph_box2').hide();
			$('.graph_box1').css('width','1229px');
		}
	});
});