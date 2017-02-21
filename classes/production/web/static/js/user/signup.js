/**
 * Created by sj on 16. 3. 7..
 */

$( document ).ready(function() {
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

    var count = 180;
    var counter = null;

    function timer() {
        count = count - 1;
        if (count == -1) {
            clearInterval(counter);
            NoticeCommon.Dialog.alert({
                content: '인증시간이 지났습니다. 다시 재전송 버튼을 클릭해주세요.'
            });
            return;
        }

        var seconds = count % 60;
        var minutes = Math.floor(count / 60);
        var hours = Math.floor(minutes / 60);
        var timeString = '';
        minutes %= 60;
        hours %= 60;

        $('.timer').text(minutes+":"+seconds);
    }

    function set_code(flag, phoneno) {
        $.ajax({
            url: "/sms",
            type: "GET",
            dataType: 'json',
            data: 'phoneno='+phoneno,
            error:function(result){
                console.log(result);
            },
            success: function (result) {
                console.log(result);
                if(result.success) {
                    $('#btn_reAsk').show();
                    $('#auth_form').show();
                    $('#btn_certifyNumAsk').hide();

                    if(flag == 're') {
                        count = 180;
                        clearInterval(counter);
                    }

                    counter = setInterval(timer, 1000); //1000 will  run it every 1 second
                }
                else {
                    NoticeCommon.Dialog.alert('전화번호를 확인해주세요.');
                }
            }
        });
    }

    // 인증번호 재전송
    $('#btn_reAsk').click(function () {
        var phoneno = $('input[name=phone]').val();

        set_code('re', phoneno);
    });

    // 인증번호 전송
    $('#btn_certifyNumAsk').click(function () {
        var phoneno = $('input[name=phone]').val();

        if(phoneno == '') {
            NoticeCommon.Dialog.alert({
                content: '전화번호를 입력해주세요.',
                ok: function() {
                    $('input[name=phone]').focus();
                }
            });
        }
        else {
            set_code('', phoneno);
        }
    });

    // 인증번호 확인
    $('#btn_certifyNumChk').click(function () {
        var code = $('input[name=certifyNum]').val();
        var phoneno = $('input[name=phone]').val();

        if(code == '') {
            NoticeCommon.Dialog.alert({
                content: '인증번호를 입력해주세요.',
                ok: function() {
                    $('input[name=certifyNum]').focus();
                }
            });
        }
        else {
            $.ajax({
                url: "/sms",
                type: "POST",
                dataType: 'json',
                data: 'phoneno='+phoneno+'&code='+code,
                error:function(result){
                    console.log(result);
                },
                success: function (result) {
                    console.log(result);
                    if(result.success) {
                        clearInterval(counter);

                        $('#btn_reAsk').hide();
                        $('#btn_certifyNumChk').hide();
                        $('.timer').hide();
                        $('#certifyComplete').show();
                    }
                    else {
                        NoticeCommon.Dialog.alert('인증번호를 확인해주세요.');
                    }
                }
            });
        }
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

    $('#btn_signup').click(function()
    {
        var dataValidationCount = 0;
        var form_data = new FormData($('#frmData')[0]);
        var itemName = '';

        $.each($('input[required="true"]'), function(){
            val = $(this).val();

            if(!val) {
                $(this).parent().prev().addClass('required');

                if(itemName == '') {
                    itemName = $(this).parent().prev().text();
                }
                dataValidationCount++;
            }
            else {
                $(this).parent().prev().removeClass('required');
            }
        });

        if(dataValidationCount > 0) {
            NoticeCommon.Dialog.alert({
                content: itemName + '은(는) 필수 항목입니다.'
            });

            if($('.essential_text').hasClass('none')) {
                $('.essential_text').removeClass('none');
            }
        }
        else {
            //이메일 유효성체크
            chk = checkEmail($('input[name=email]').val());
            if( !chk ) {
                $('input[name=email]').parent().prev().addClass('required');
                return false;
            }

            //비밀번호 유효성체크
            chk = checkPwd($('#passwordString').val());
            if( !chk ) {
                $('#passwordString').parent().prev().addClass('required');
                return false;
            }

            if($('#passwordString').val() != $('#passwordString2').val()) {
                $('#passwordString2').parent().prev().addClass('required');
                NoticeCommon.Dialog.alert('비밀번호가 서로 다릅니다. 확인해 주시기 바랍니다.');

                return false;
            }

            if(isNaN($('input[name=phone]').val())) {
                $('input[name=phone]').parent().prev().addClass('required');
                NoticeCommon.Dialog.alert('전화번호는 숫자만 입력가능합니다.');

                return false;
            }
            if($('#certifyComplete').css('display') == 'none') {
                $('input[name=certifyNum]').parent().prev().addClass('required');
                NoticeCommon.Dialog.alert('인증을 완료해 주시기 바랍니다.');

                return false;
            }
            else {
                $.ajax({
                    url: "/signup",
                    type: "POST",
                    data: $('#frmData').serialize()+'&password='+ $.md5($('#passwordString').val()),
                    dataType: 'json',
                    error:function(result){
                        console.log(result);
                        //NoticeCommon.Dialog.alert(result.statusText);
                    },
                    success: function (result) {
                        console.log(result);
                        if(result != undefined && result != null) {

                            if(result.message) {
                                NoticeCommon.Dialog.alert(result.message);
                            }
                            else {
                                NoticeCommon.Dialog.confirm({
                                    headerCloseBtn: false
                                    ,title: '알림'
                                    ,okTxt: '투자자 정보 입력'
                                    ,cancel: '메인으로'
                                    ,again: function(){
                                        document.location.href = '/main';
                                    }
                                    ,content: '회원가입이 완료되었습니다.'
                                    ,ok: function(){
                                        document.location.href = '/user/investor_form';
                                    }
                                });
                            }
                        }
                    }
                });
            }
        }

    });
});