$( document ).ready(function() {
    // 상단 메뉴 on
    $('.icon.mn1, .menu li:nth-child(1) a').addClass('on');

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

        var formData = new FormData($('#frmData')[0]);
        formData.append("content", content);

        if(updateId) {
            formData.append("updateId", updateId);
            msg = '글이 수정되었습니다.';
        }

        if(!$('input[name=title]').val()) {
            NoticeCommon.Dialog.alert('제목을 입력해주세요.');
            $('input[name=title]').addClass('required');
            return false;
        }

        if(!content) {
            NoticeCommon.Dialog.alert('내용을 입력해주세요.');
            return false;
        }

        $.ajax({
            url: '/project/'+projectId+'/update_form',
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
                            location.href = "/project/"+projectId+'?tabId=update';
                        }
                    });
                }
            }
        });
        return false;
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