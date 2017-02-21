/**
 * Created by sj on 16. 3. 7..
 */
$( document ).ready(function() {

    var email = Cookies.get('email');
    if(email != undefined && email != 'undefined') {
        //아이디에 쿠키값을 담는다
        $("input[name=username]").val(email);
        //아이디저장 체크박스 체크를 해놓는다
        $("#remember").prop("checked",true);
    }

    if(error) {
        if(error == 'duplicationEmail') {
            NoticeCommon.Dialog.alert('이메일이 중복되었습니다.');
        }
    }

    $('.find_pass').click(function() {


        var msg = '이메일을 입력하신 후 확인 버튼을 눌려주세요. <br />';
        msg += '가입 당시 메일주소로 임시비밀번호를 발급해 드립니다. <br />';
        msg += '인터넷 환경에 따라 메일수신이 늦어질 수도 있습니다. <br />';
        msg += '만약 메일을 받지 못할 경우<br />';
        msg += '고객센터 1:1 문의하기 게시판을 이용해주세요.';
        $('.find_msg').html(msg);
        $('.find_msg').css('color', '#787878');
        $('.pop_box.find_pw').removeClass('none');
    });

    $('.btn_cancel').click(function() {
        $('.pop_box.find_pw').addClass('none');
    });

    $('.btn_sendEmail').click(function() {
        var sendEmail = $('input[name=sendEmail]').val();

        if(!sendEmail) {
            $('.find_msg').text('이메일을 입력해주세요.');
            $('.find_msg').css('color', '#D4145A');
            $('input[name=sendEmail]').focus();
            return false;
        } else {
            $.ajax({
                url: "/findpassword",
                type: "POST",
                dataType: 'json',
                data: 'email='+sendEmail,
                error:function(result){
                    console.log(result);
                },
                success: function (result) {
                    console.log(result);
                    if(result.success) {
                        Cookies.set('email', result.userEmail);
                        $('.pop_box.find_pw').addClass('none');
                        NoticeCommon.Dialog.complete('비밀번호를 발급했습니다.\r\n이메일을 확인해주시기 바랍니다.');
                    }
                    else {
                        NoticeCommon.Dialog.alert('이메일을 확인해주세요.');
                    }
                }
            });
        }
    });

    $('#btn_login').click(function() {
        var dataValidationCount = 0;
        var itemName = '', val = '';
        var frmForm = $('#frmLogin input.data');

        $.each(frmForm, function(){
            val = $(this).val();

            if($(this).attr('type') == 'checkbox') {
                if($(this).is(':checked')) {
                    val = $(this).val();
                } else {
                    val = '';
                }
            }

            if($(this).hasClass('requir') && !val) {
                $('.essential_text').removeClass('none');
                $(this).parent().prev().addClass('required');

                $(this).focus();

                if(itemName == '') {
                    itemName = $(this).parent().prev().text();
                }

                dataValidationCount++;
            }


        });

        if(dataValidationCount > 0) {
            NoticeCommon.Dialog.alert({
                content: itemName + '은(는) 필수 항목입니다.'
            });
        }
        else {
            $.ajax({
                url: "/login",
                type: "POST",
                dataType: 'json',
                data: $('#frmLogin').serialize()+'&password='+ $.md5($('input[name=passwordString]').val()),
                error:function(result){
                    console.log(result);
                },
                success: function (result) {
                    console.log(result);
                    if(result.success) {
                        if(result.userEmail != undefined) {
                            Cookies.set('email', result.userEmail);
                        }

                        if( result.returnUrl == undefined || result.returnUrl == "" ){

                            location.replace('/main');
                        }else{

                            location.href=result.returnUrl;
                        }



                    } else {
                        //$('.essential_text').removeClass('none').text(result.message);
                        NoticeCommon.Dialog.alert(result.message);
                    }
                }
            });
        }
    });

    $('input').on('keyup', function(e) {
        if($(this).parent().prev().hasClass('required') && $(this).val().length > 0) {
            $(this).parent().prev().removeClass('required');
        }

        if (e.which == 13) {
            $('#btn_login').click();
        }
    });
});
