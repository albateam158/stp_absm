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

    $('select').on('change', function(e) {
        $(this).parents('dd').prev().removeClass('required');
    });


    $('.form_box .select_box select').change(function(e){
        var val = $(this).parent().find('select :selected').text();

        $(this).parent().find('label').text(val);
        if($(this).prev('label').hasClass('required')) {
            $(this).prev('label').removeClass('required');
        }

        if($(this).attr('name') == 'secucoAcopno') {
            console.log($(this).children("option:selected").attr('secucoAcopseq'));
            $('input[name=secucoAcopseq]').val($(this).children("option:selected").attr('secucoAcopseq'));
        }

        $(this).removeClass('arrow_up');
    });



    $('#btn_submit').click(function () {
        var dataValidationCount = 0;
        var form_data = new FormData($('#frmData')[0]);
        var itemName = '';

        $.each($('.data:visible'), function () {
            val = $(this).val();

            if(!val || val == 0) {
                if($(this)[0].tagName == 'SELECT') {
                    $(this).parents('dd').prev().addClass('required');

                    if(itemName == '') {
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
                $(this).parent().prev().removeClass('required');
            }
        });

        if (dataValidationCount > 0) {
            NoticeCommon.Dialog.alert({
                content: itemName + '은(는) 필수 항목입니다.'
            });
        }
        else {
            //이메일 유효성체크
            if(invSortCd == '03') {
                chk = checkEmail($('input[name=managerEmail]').val());
                if( !chk ) {
                    $('input[name=managerEmail]').parent().prev().addClass('required');
                    return false;
                }

                if (isNaN($('input[name=managerPhone]').val())) {
                    $('input[name=managerPhone]').parent().prev().addClass('required');
                    NoticeCommon.Dialog.alert('전화번호는 숫자만 입력가능합니다.');

                    return false;
                }
            }

            console.log($('#frmData').serialize());

            $.ajax({
                url: "/mypage/investor",
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
                                content: '투자자정보 수정이 완료되었습니다.'
                            });
                        }
                    }
                }
            });
        }

    });
});