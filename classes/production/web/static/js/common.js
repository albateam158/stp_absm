$(window).ready(function(){
	var $window = $(window),
		$html = $('html');
		$window.resize(function resize() {
		if ($window.width() < 640) {
			return $html.addClass('mobile');
		}
		$html.removeClass('mobile');
	}).trigger('resize');

	$(window).scroll(function() {
		if($(window).scrollTop() > 0) {
        	$('.scroll_top').removeClass('none');
        } else {
			$('.scroll_top').addClass('none');
        }


	});

	/* filebox */
	var fileTarget = $('.filebox .upload_hidden');

	fileTarget.on('change', function(){
		if(window.FileReader){
			var filename = $(this)[0].files[0].name;
		} else {
			var filename = $(this).val().split('/').pop().split('\\').pop();
		}

		var fileType = $(this).attr('data-type');
		var chk = true;

		if(fileType == 'image') {
			var extenArr = filename.split('.');
			var extension = extenArr[(extenArr.length)-1];
			if(extension != 'jpg' && extension != 'jpeg' && extension != 'png' && extension != 'pdf') {
				$(this).val('');
				NoticeCommon.Dialog.alert('업로드 불가능한 확장자입니다');
				chk = false;
				return false;
			}
		}
		if (!chk) return false;

		$(this).parents().parents().prev().removeClass('required');
		$(this).siblings('.upload_name').val(filename);
	});

	$('.btn_menu_more').click(function(){
		$('html, body').addClass( "slideout-open");
		$('.all_wrap > .menu').css("z-index","10100").show();
		$('.all_wrap > .menu .blockUi').show();
		setTimeout(function() {
			$('.all_wrap > .menu > div').css({
				"transition" : "0.3s",
				"transform" : "translateX(256px)",
				"-webkit-transition" : "0.3s",
				"-webkit-transform" : "translateX(256px)",
				"-moz-transition" : "0.3s",
				"-moz-transform" : "translateX(256px)",
				"-ms-transition" : "0.3s",
				"-ms-transform" : "translateX(256px)"
			});
		}, 200);

	});

	$('.all_wrap > .menu .btn_close, .all_wrap > .menu .blockUi').click(function(){
		closeMobileMenu();
		setTimeout("$('.all_wrap > .menu').css('z-index','0').hide();", 300);
	});

	$(document).bind('touchmove', '.all_wrap > .menu .blockUi', function(e) {
		closeMobileMenu();
		setTimeout("$('.all_wrap > .menu').css('z-index','0').hide();", 300);
	});
});

function closeMobileMenu() {
	$('html, body').removeClass( "slideout-open");
	$('.all_wrap > .menu .blockUi').hide();
	$('.all_wrap > .menu > div').css({
		"transition" : "0.3s",
		"transform" : "translateX(0px)",
		"-webkit-transition" : "0.3s",
		"-webkit-transform" : "translateX(0px)",
		"-moz-transition" : "0.3s",
		"-moz-transform" : "translateX(0px)",
		"-ms-transition" : "0.3s",
		"-ms-transform" : "translateX(0px)"
	});
}



$.ajaxSetup({
	global: true,
	beforeSend: function(xhr) {
		$('.loading.wrap').removeClass('none');
		xhr.setRequestHeader("AJAX", true);
	},
	complete: function(jqXHR, textStatus) {
		$('.loading.wrap').addClass('none');
	}
});


$( document ).ajaxError(function( event, jqxhr, settings, thrownError ) {
	if( jqxhr.status == 0 ) return;

	if (jqxhr.status == 401 ||jqxhr.status == 403 ) {
		NoticeCommon.Dialog.alert({
			title: '경고',
			content: '세션이 만료가 되었습니다. 로그인 페이지로 이동합니다.'
			,ok: function(){
				location.href = "/login";
			}
		});

	} else if(jqxhr.status == 400){

		var msg = '요청 파라미터 검증 오류입니다.';

		if( jqxhr.responseJSON.message ){

			msg = jqxhr.responseJSON.message;
		}
		if( jqxhr.responseJSON.errorMessage ){

			msg = jqxhr.responseJSON.errorMessage;
		}
		NoticeCommon.Dialog.alert({
			title: '경고',
			content: msg
		});
	} else {

		NoticeCommon.Dialog.alert({
			title: '경고',
			content: '서버 오류가 발생하였습니다. 관리자에게 문의하여 주십시오.'
		});

	}
});

function checkEmail(email) {
	var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;

	if(regex.test(email) === false) {
		NoticeCommon.Dialog.alert('잘못된 이메일 형식입니다.');
		return false;
	}

	return true;
}


function logout() {
	NoticeCommon.Dialog.confirm({
		title: '로그아웃',
		cancel: '취소'
		,again: function(){

		},
		content: '정말로 로그아웃하시겠습니까?'
		,ok: function(){
			$.ajax({
				url: "/logout",
				type: "POST",
				dataType: 'json',
				data: '',
				error:function(result){
					console.log(result);
				},
				success: function (result) {
					document.location.href = '/project/' + projectId;
				}
			});
		}
	});
}

//비밀번호 유효성체크
function checkPwd(str) {
	var pw = str;
	var num = pw.search(/[0-9]/g);
	var eng = pw.search(/[a-z]/ig);
	var spe = pw.search(/['~!@@#$%^&*|\\\'\";:\/?]/gi);



	if(pw.length < 8 || pw.length > 16) {
		NoticeCommon.Dialog.alert('비밀번호는 8~20자리로 입력해주세요.');
		return false;
	} else	if(pw.search(/\s/) != -1) {
		NoticeCommon.Dialog.alert('비밀번호는 공백없이 입력해주세요.');
		return false;
	//} else	if(num < 0 || eng < 0 || spe <0) {
	} else	if(num < 0 || eng < 0 ) {
		NoticeCommon.Dialog.alert('영문, 숫자 혼합하여 입력해주세요.');
		return false;
	}

	return true;
}


function createCORSRequest(method, url) {
	var xhr = new XMLHttpRequest();
	if ("withCredentials" in xhr) {

		// Check if the XMLHttpRequest object has a "withCredentials" property.
		// "withCredentials" only exists on XMLHTTPRequest2 objects.
		xhr.open(method, url, true);

	} else if (typeof XDomainRequest != "undefined") {

		// Otherwise, check if XDomainRequest.
		// XDomainRequest only exists in IE, and is IE's way of making CORS requests.
		xhr = new XDomainRequest();
		xhr.open(method, url);

	} else {

		// Otherwise, CORS is not supported by the browser.
		xhr = null;

	}
	return xhr;
}


//주민번호 유효성 검사
function ssnCheck(value){
	var checkNum = [2,3,4,5,6,7,8,9,2,3,4,5];

	var sum = 0;
	for(var i=0; i< checkNum.length ; i++){
		var tmp = value.charAt(i)*checkNum[i];
		//alert(value.charAt(i)+":"+checkNum[i]+":"+tmp);
		sum += tmp;
	}

	var pin = 11-(sum%11);
	if(pin>=10) pin = pin-10;

	if(value.charAt(12)==pin){
		return true;
	}else{
		return false;
	}
}