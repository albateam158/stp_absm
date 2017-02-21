/**
 * Created by sj on 16. 3. 10..
 */
$( document ).ready(function() {

    $('.all_wrap').addClass('sub');

    $('.content_box .step_box h2').click(function(){
        $(this).toggleClass('active');
        $(this).next().toggle();
    });

    $('input').keyup(function() {
        if($(this).hasClass('chkNum')){
            var val = $(this).val();

            if(isNaN(val)){//숫자가 아니면
                NoticeCommon.Dialog.alert('숫자만 입력해주세요.');
                $(this).val('');
                return false;
            }
        }

        if($(this).parent().prev().hasClass('required') && $(this).val().length > 0) {
            $(this).parent().prev().removeClass('required');
        }
    });


    $('#profileImgFile').change(function()
    {
        var form_data = new FormData();
        form_data.append("file", $(this)[0].files[0]);

        var xhr = createCORSRequest('POST', 'https://wicrowd.co.kr/upload');
        xhr.onreadystatechange = function (data) {
            if(xhr.readyState == 4) {
                if(xhr.status == 200) {
                    temp = xhr.responseText;
                    var data = JSON.parse(temp);

                    $(".profile_thum > span").css("background-image","url("+data.url+")");
                    $("input[name=profileImageUrl]").val(data.url);
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
            var result = xhr.send(form_data);
        }
    });



    $('#btn_submit').click(function () {
        var dataValidationCount = 0;
        var form_data = new FormData($('#frmData')[0]);
        var itemName = '';

        $.each($('input[required="true"]'), function () {
            val = $(this).val();

            if (!val) {
                $(this).parent().prev().addClass('required');

                if (itemName == '') {
                    itemName = $(this).parent().prev().text();
                }
                dataValidationCount++;
            }
            else {
                $(this).parent().prev().removeClass('required');
            }
        });

        if (dataValidationCount > 0) {
            NoticeCommon.Dialog.alert({
                content: itemName + '은(는) 필수 항목입니다.'
            });

            if ($('.essential_text').hasClass('none')) {
                $('.essential_text').removeClass('none');
            }
        }
        else {
            if (isNaN($('input[name=phone]').val())) {
                $('input[name=phone]').parent().prev().addClass('required');
                NoticeCommon.Dialog.alert('전화번호는 숫자만 입력가능합니다.');

                return false;
            }

            console.log($('#frmData').serialize());

            $.ajax({
                url: "/mypage/profile",
                type: "POST",
                data: $('#frmData').serialize(),
                dataType: 'json',
                error: function (result) {
                    console.log(result);
                    //NoticeCommon.Dialog.alert(result.statusText);
                },
                success: function (result) {
                    console.log(result);
                    if (result != undefined && result != null) {

                        if (result.message) {
                            NoticeCommon.Dialog.alert(result.message);
                        }
                        else {
                            NoticeCommon.Dialog.alert({
                                content: '회원정보 수정이 완료되었습니다.'
                            });
                        }
                    }
                }
            });
        }

    });

    $(document).on('click', '.btn_leave,.btn_cancel', function() {
        $('#agree').next('label').removeClass('required');
        $('.pop_box').toggleClass('none');
    });

    $('.pop_box.leave_site .btn_submit').click(function()
    {
        var chk = $('.agree_msg input[type=checkbox]:checked').val();

        if(!chk) {
            $('#agree').next('label').addClass('required');
            return false;
        } else {
            $('.pop_box .blockUi').removeClass('none');
            $('.pop_box .loading').show();

            var content = $('textarea[name=leaveReason]').val();

            $.ajax({
                type:'post',
                url: '/resign',
                data: 'content='+content,
                dataType: 'json',
                error: function(data) {
                    console.log(data);
                    $('.pop_box .blockUi, textarea[name=leaveReason], .pop_box .agree_msg').addClass('none');
                    $('.pop_box .loading').hide();
                    $('.msg').addClass('essential_text').html('서버 오류입니다.<br />관리자에게 문의 주시기 바랍니다.');
                    $('.pop_box .bottom').html('<a class="btn_type03 btn_cancel">확인</a>');
                },
                success: function(data) {
                    console.log(data);
                    $('.pop_box .blockUi, textarea[name=leaveReason], .pop_box .agree_msg').addClass('none');
                    $('.pop_box .loading').hide();

                    if(data.success) {
                        $('.msg').html('정상적으로 회원탈퇴가 되었습니다.<br />(투자 이력이 있는 경우는 5년간 개인정보 및 투자, 결제 내역등이 보관되며,투자이력이 없는 경우 3개월 이후 모든</br> 개인정보가 삭제됩니다.');
                        $('.pop_box .bottom').html('<a href="/logout" class="btn_type03">확인</a>');
                    } else {
                        $('.msg').addClass('required').html('서버 오류입니다.<br />관리자에게 문의 주시기 바랍니다.');
                        $('.pop_box .bottom').html('<a class="btn_type03 btn_cancel">확인</a>');
                    }
                }
            });
        }
    });
});