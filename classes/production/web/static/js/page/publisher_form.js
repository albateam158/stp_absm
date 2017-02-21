$( document ).ready(function() {
    $('.icon.mn2, .menu li:nth-child(2) a').addClass('on');

    $('#btn_submit').click(function() {
        var dataValidationCount = 0;
        var fileValidationCount = 0;
        var form_data = new FormData($('#frmData')[0]);
        var itemName = '';

        $.each($('input.data:visible'), function(){
            val = $(this).val();

            if(!val) {
                $(this).parent().prev().addClass('required');

                if(itemName == '') {
                    itemName = $(this).parent().prev().text();
                }
                dataValidationCount++;
            }
        });

        $.each($('.upload_hidden:visible'), function (i, v) {
            if($(v)[0].files[0] == undefined) {

                if($(this).hasClass('chkFile')) {
                    $(v).parent().parent().prev().addClass('required');
                    fileValidationCount++;
                }

                if(itemName == '') {
                    itemName = $(v).parent().parent().prev().text();
                }
            }

            form_data.append("file"+(i+1), v.files[0]);
        });

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

        if(dataValidationCount==0 && fileValidationCount==0) {

            //이메일 유효성체크
            chk = checkEmail($('input[name=managerEmail]').val());
            if( !chk ) return false;

            if(chk) {
                $.ajax({
                    url: "/publisher",
                    type: "POST",
                    data: form_data,
                    processData: false,
                    contentType: false,
                    error:function(result){
                        console.log(result);
                    },
                    success: function (result) {
                        console.log(result);
                        if(result.success) {
                            NoticeCommon.Dialog.complete({
                                title: '발행 요청완료!',
                                content: '<p class="fw-b">발행 요청이 성공적으로 접수되었습니다.</p><p class="fs-13 fc-grey mt15">서류 검토후 1 영업일 이내에<br />담당자가 연락 드리도록 하겠습니다.<br />감사합니다.</p><p class="fs-12 fc-lightgrey mt20">문의: 02-560-6300 wicrowd@kasset.co.kr</p>'
                                ,ok: function(){
                                    document.location.href = '/main';
                                }
                            });
                        }
                        else {
                            NoticeCommon.Dialog.confirm({
                                title: '발행 요청완료!',
                                cancel: '재시도'
                                ,again: function(){
                                    document.location.reload();
                                },
                                content: '<p class="fw-b">발행 요청이 실패하였습니다.</p><p class="fs-13 fc-grey mt15">알수없는 오류로 인해<br />발행 요청이 접수되지 않았습니다.</p><p class="fs-12 fc-lightgrey mt20">문의: 02-560-6300 wicrowd@kasset.co.kr</p>'
                                ,ok: function(){
                                    document.location.href = '/main';
                                }
                            });
                        }
                    }
                });
            }
        }
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
            $('#btn_submit').click();
        }
    });


});