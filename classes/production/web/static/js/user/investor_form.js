$(window).ready(function(){
    /* tab */
    $('.tab_container > div, .publisher_form.form_list > div').hide();
    $('.tab_container > div:first, .publisher_form.form_list > div:first').show();

    $('ul.tab_box li').click(function () {
        $('ul.tab_box li').removeClass('active');
        $(this).addClass('active');
        $('.tab_container > div').hide();

        var activeTab = $(this).attr('rel');
        $('#' + activeTab).show();
        $('.publisher_form.form_list > div').hide();
        $('#' + activeTab + '_form').show();

        $('input[name=invSortCd]').val($(this).attr('type'));
        $('.data').parent().prev().removeClass('required');
        $('.filebox .upload_hidden').parents().parents().prev().removeClass('required');
        $('select').prev().removeClass('required');
        $('.choice_y').prop('checked', false).next().removeClass('required');
    });

    $('.popup_investor, .btn_cancel').click(function() {
        $('.pop_box.investor').toggleClass('none');
    });

    $('.select_box').click(function(){
        if($(this).hasClass('arrow_up')) {
            $(this).removeClass('arrow_up');
        } else {
            $(this).addClass('arrow_up');
        }
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

    $('#submitButton').click(function()
    {
        $('#frm_' + $('input[name=invSortCd]').val()).submit();
    });

    $('form').submit(function () {

        var dataValidationCount = 0;
        var fileValidationCount = 0;
        var validationCount = 0;
        var form_data = new FormData($(this)[0]);
        var itemName = '';

        $.each($(this).find('.data:visible'), function(){

            val = $(this).val();

            if(!val) {

                if($(this).hasClass('select')) {
                    $(this).prev().addClass('required');
                } else {
                    $(this).parent().prev().addClass('required');
                }

                if(itemName == '') {
                    itemName = $(this).attr('text');
                }

                dataValidationCount++;
            }
        });

        $.each($('.upload_hidden:visible'), function (i, v) {
            if($(v)[0].files[0] == undefined) {

                $(this).parent().parent().prev().addClass('required');
                fileValidationCount++;

                if(itemName == '') {
                    itemName = $(v).parent().parent().prev().text();
                }
            }

            form_data.append("file"+(i+1), v.files[0]);
        });

        if(!$('.choice_y').is(':checked')) {
            $('.choice_y').next().addClass('required');
            validationCount++;
        }

        if(dataValidationCount > 0) {
            NoticeCommon.Dialog.alert({
                content: itemName + '은(는) 필수 항목입니다.'
            });
            return false;
        }
        if(fileValidationCount > 0) {
            NoticeCommon.Dialog.alert({
                content: itemName + ' 파일을 업로드해주세요.'
            });
            return false;
        }

        if(validationCount > 0) {
            NoticeCommon.Dialog.alert('개인정보 제공 약관에 동의해주시기 바랍니다.');
            return false;
        }

        if(dataValidationCount==0 && fileValidationCount==0 && validationCount==0) {

            if ($('input[name=invSortCd]').val() != "03") {


                if (ssnCheck($(this).find('input[name=jumin]').val()) == false) {
                    NoticeCommon.Dialog.alert('유효한 주민등록번호를 입력하여주세요.');
                } else {

                    $.ajax({
                        type: 'post',
                        url: '/user/investor_private',
                        data: form_data,
                        processData: false,
                        contentType: false,
                        error: function (data) {
                            console.log(data);
                        },
                        success: function (data) {
                            console.log(data);
                            //$('.pop_box').css('display', 'block');

                            complete();
                        }
                    });
                }
            }
            else {
                //이메일 유효성체크
                chk = checkEmail($(this).find('input[name=managerEmail]').val());
                if (!chk) {
                    $(this).find('input[name=managerEmail]').parent().prev().addClass('required');
                    return false;
                }

                var specialFormData = $(this);
                console.log($(specialFormData).serialize());

                $.ajax({
                    type: 'post',
                    url: '/user/investor_corp',
                    data: $(specialFormData).serialize(),
                    dataType: 'JSON',
                    error: function (data) {
                        console.log(data);
                    },
                    success: function (data) {
                        console.log(data);
                        complete();
                    }
                });
            }
        }

        return false;
    });

    $('input').on('keyup', function(e) {

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

        if (e.which == 13) {
            $('#submitButton').click();
        }
    });

    $('select').on('change', function(e) {
        $(this).prev().removeClass('required');
    });

    $('.choice_y').on('click', function(e) {
        if($(this).is(':checked')) {
            $(this).next().removeClass('required');
        }
    });
});

function complete(){

    var url = "/main";

    if( projectId != '' ){

        url = "/project/" + projectId;
    }

    if($('input[name=invSortCd]').val() == "01") {
        NoticeCommon.Dialog.complete({
            title: '알림',
            content: '투자자전환이 완료되었습니다.'
            ,ok: function(){
                location.href = url;
            }
        });
    }
    else {
        NoticeCommon.Dialog.complete({
            title: '알림',
            content: '투자자변경에 따른 인증 승인이 필요합니다. 문의:02-560-6300'
            ,ok: function(){
                location.href = url;
            }
        });
    }


}