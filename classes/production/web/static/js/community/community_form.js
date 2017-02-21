$( document ).ready(function() {
    $('.all_wrap').addClass('sub');

    // 상단 메뉴 on
    $('.icon.mn4, .menu li:nth-child(4) a').addClass('on');

    if(communityId) {
        var val = $('.select_box select :selected').text();
        $('.select_box label').text(val);
    }

    $('.select_box').click(function(){
        if($(this).hasClass('arrow_up')) {
            $(this).removeClass('arrow_up');
        } else {
            $(this).addClass('arrow_up');
        }
    });

    $('.select_box select').change(function(e){
        var val = $(this).parent().find('select :selected').text();
        $(this).parent().find('label').text(val);

        if($(this).prev('label').hasClass('required')) {
            $(this).prev('label').removeClass('required');
        }

        $(this).removeClass('arrow_up');
    });

    $('input').focus(function() {
        $(this).removeClass('required');
    });

    $('#summernote').summernote({
        onImageUpload : function(files, editor, welEditable)
        {
            var formData = new FormData();
            formData.append("file", files[0]);

            console.log(files[0]);

            var xhr = createCORSRequest('POST', 'https://wicrowd.co.kr/upload');
            xhr.onreadystatechange = function (data) {
                if(xhr.readyState == 4) {
                    if(xhr.status == 200) {
                        temp = xhr.responseText;
                        var data = JSON.parse(temp);

                        editor.insertImage(welEditable, data.url);
                    }
                    else {
                        NoticeCommon.Dialog.alert("파일 업로드가 실패 했습니다.<br/>다시 한번 시도해주시기 바랍니다.");
                    }
                }
            };
            if (!xhr) {
                throw new Error('CORS not supported');
            }
            else {
                var result = xhr.send(formData);
                console.log(result);
            }
        },
        oninit : function () {
            $('.note-editable').css('min-height','450px');
        }
    });

    $('.btn_submit').click(function(){
        var msg = '글이 성공적으로 등록되었습니다.';
        var content = $('#summernote').code();
        var chk = true;

        var formData = new FormData($('#frmData')[0]);
        formData.append("content", content);

        if(communityId) {
            formData.append("communityId", communityId);
            msg = '글이 수정되었습니다.';
        }

        if(!$('input[name=title]').val()) {
            NoticeCommon.Dialog.alert('제목을 입력해주세요.');
            $('input[name=title]').addClass('required');
            chk = false;
            return false;
        }
        if(!chk) return false;

        var val = $('.select_box select').parent().find('select :selected').val();
        if(!val) {
            NoticeCommon.Dialog.alert('카테고리를 선택해주세요.');
            $('.select_box > label').addClass('required');
            chk = false;
            return false;
        }
        if(!chk) return false;

        if(!content) {
            NoticeCommon.Dialog.alert('내용을 입력해주세요.');
            chk = false;
            return false;
        }
        if(!chk) return false;

        $.ajax({
            url: '/community/form',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            error: function (result) {
                console.log(result);
            },
            success: function (result) {
                console.log(result);

                if(result) {
                    NoticeCommon.Dialog.complete({
                        content: msg,
                        ok: function(){
                            location.href = "/community";
                        }
                    });
                }
            }
        });
    });
});

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