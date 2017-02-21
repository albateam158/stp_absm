/**
 * Created by sj on 16. 3. 4..
 */
$( document ).ready(function() {

    $('.all_wrap').addClass('sub');

    $('.content_box .step_box h2').click(function(){
        $(this).toggleClass('active');
        $(this).next().toggle();
    });


    $('input, textarea').keyup(function() {
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


    $('.form_box .select_box select').change(function(e){
        var val = $(this).parent().find('select :selected').text();
        $(this).parent().find('label').text(val);

        if($(this).val() != 0) {
            $(this).parents('dd').prev().removeClass('required');
        }
    });


    $('#btn_submit').click(function () {
        var dataValidationCount = 0;
        var form_data = new FormData($('#frmData')[0]);
        var itemName = '';

        $.each($('*[required="true"]'), function(){
            val = $(this).val();
            if(!val || val == 0) {
                if($(this)[0].tagName == 'SELECT') {
                    $(this).parents('dd').prev().addClass('required');

                    if(itemName == '') {
                        itemName = $(this).parent().prev().text();
                        itemName = $(this).parents('dd').prev().text();
                    }
                }
                else {
                    $(this).parent().prev().addClass('required');

                    if(itemName == '') {
                        itemName = $(this).parent().prev().text();
                    }
                }



                dataValidationCount++;
            }
            else {
                if($(this)[0].tagName == 'SELECT') {
                    $(this).parents('dd').prev().removeClass('required');
                }
                else {
                    $(this).parent().prev().removeClass('required');
                }

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

            if(isNaN($('input[name=phone]').val())) {
                $('input[name=phone]').parent().prev().addClass('required');
                NoticeCommon.Dialog.alert('전화번호는 숫자만 입력가능합니다.');

                return false;
            }

            $.ajax({
                type:'post',
                url: '/qna',
                data: $('#frmData').serialize(),
                dataType: 'json',
                error: function(data) {
                    console.log(data);
                },
                success: function(data) {
                    console.log(data);
                    NoticeCommon.Dialog.complete({
                        content: '1:1문의 등록이 성공하였습니다.',
                        ok : function(){
                            location.replace('/mypage/qna');
                        }
                    });
                }
            });
        }














        //var title = $('input[name=title]').val();
        //var qnaType = $('select[name=qnaType]').val();
        //var phone = $('input[name=phone]').val();
        //var email = $('input[name=email]').val();
        //var content = $('textarea[name=content]').val();
        //var chk = true;
        //
        //if(title == '') {
        //    $('input[name=title]').parent().prev().css('color', 'red')
        //    NoticeCommon.Dialog.alert('제목을 입력해주세요.');
        //    chk = false;
        //    return false;
        //}
        //
        //if(qnaType == '0') {
        //    console.log($('select[name=qnaType]').closest('.qna_box'));
        //    $('select[name=qnaType]').closest('.qna_box').prev('div').find('h3').css('color', 'red');
        //    NoticeCommon.Dialog.alert('문의 유형을 선택해주세요.');
        //    chk = false;
        //    return false;
        //}
        //
        //
        //if(phone == '') {
        //    $('input[name=phone]').closest('.qna_box').prev('div').find('h3').css('color', 'red');
        //    NoticeCommon.Dialog.alert('연락처를 입력해주세요.');
        //    chk = false;
        //    return false;
        //}
        //
        //if(email == '') {
        //    $('input[name=email]').closest('.qna_box').prev('div').find('h3').css('color', 'red');
        //    NoticeCommon.Dialog.alert('이메일을 입력해주세요.');
        //    chk = false;
        //    return false;
        //}
        //
        //if(content == '') {
        //    $('textarea[name=content]').closest('.qna_box').prev('div').find('h3').css('color', 'red');
        //    NoticeCommon.Dialog.alert('문의 내용을 입력해주세요.');
        //    chk = false;
        //    return false;
        //}
        //
        //if(chk) {
        //    console.log($('#frm').serialize());
        //
        //
        //}
        //
        //return false;
    });

});