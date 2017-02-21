/**
 * Created by sj on 16. 3. 7..
 */
$( document ).ready(function() {
    $('.all_wrap').addClass('sub');

    // 그래프 초기화
    $('.graph').circleGraphic();


    $('#chk_all').click(function(){
        if($('#chk_all').is(':checked'))
        {
            $('.term_box input[type=checkbox]').not('.term_box input[name=useName]').prop('checked', true);
            $('.term_box input[type=checkbox]').val('Y');
            $('.term_box input[type=checkbox]').not('.term_box input[name=useName]').next().removeClass('required');

        }
        else
        {
            $('.term_box input[type=checkbox]').not('.term_box input[name=useName]').prop('checked', false);
            $('.term_box input[type=checkbox]').val('N');
        }
    });


    $('.data.checkbox').click(function () {
        if($(this).is(':checked'))
        {
            if($(this).next().hasClass('required')) {
                $(this).next().removeClass('required');
            }

            $(this).val('Y');
        }
        else
        {
            $(this).val('N');
        }

        var checkCount = 0;
        $('.data.checkbox').each(function (i, v) {
            if($(v).attr('name') != 'chk_all' && $(v).attr('name') != 'useName' && $(v).is(':checked')) {
                checkCount++;
            }
        });

        if(checkCount >= 7) {
            $('#chk_all').prop('checked', true);
        } else {
            $('#chk_all').prop('checked', false);
        }
    });



});



function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

if (isIE()) {
    InstallCertManager();
    SmartUpdate();
}

function isIE() {
    return ((navigator.appName == 'Microsoft Internet Explorer') || ((navigator.appName == 'Netscape') && (new RegExp("Trident/.*rv:([0-9]{1,}[\.0-9]{0,})").exec(navigator.userAgent) != null)));
}


function  payRequestLink2(frm) {

    if(!isIE()) { // No Chrome
        NoticeCommon.Dialog.alert('청약 신청은 익스플로러만 지원 가능 합니다.');
        return;
    }

    var validationCount = 0;
    $('.choice_y').each(function (i, v) {
        if($(v).val() != 'Y') {
            $(v).next().addClass('required');
            validationCount++;
        }
    });

    if(validationCount > 0) {
        NoticeCommon.Dialog.alert('약관에 동의해주시기 바랍니다.');
        return;
    }

    var form_data = new FormData($('#frmData')[0]);
    console.log($('#frmData').serialize());

    $('input[name=tx_amount]').val($('input[name=sbscAmt]').val());
    //$('input[name=ep_bank_code]').val($('select[name=pblBnkCd]').val());
    //$('input[name=ep_account_no]').val(KSFC.encode($('input[name=pblAcno]').val()));

    var data = '';


    $.ajax({
        url: '/sbsc/'+projectId,
        type: 'POST',
        data: $('#frmData').serialize(),
        dataType: 'JSON',
        error:function(result)
        {
            console.log(result);
        },
        success:function(result)
        {
            console.log(result);

            window.scrollTo(0,0);

            if(result != undefined && result != null)
            {
                if(result.success) {
                    var sbscId = result.sbscId;
                    $('input[name=sbscId]').val(result.sbscId);
                    $('input[name=resultSbscId]').val(result.sbscId);
                    $('input[name=tx_user_key]').val(result.moid);
                    $('input[name=tx_amount]').val(result.payAmt);
                    var resultBankPay = payRequestLink(frm);
                    console.log(result.sbscId);

                    if(resultBankPay) {
                        $.ajax({
                            url: '/sbsc/'+projectId,
                            type: 'POST',
                            data: $('#frmData').serialize(),
                            dataType: 'JSON',
                            error:function(result)
                            {
                                console.log(result);
                            },
                            success:function(result)
                            {
                                window.scrollTo(0,0);
                                console.log(result);

                                $('input[name=success]').val(result.success);

                                if(result.success) {
                                    //$('#resultTitle').text('신청 완료!');
                                    //$('#resultClass').attr('class', 'ic_completion');
                                    //$('#resultMessage').text('청약 신청이 성공적으로 완료되었습니다.');
                                    //$('#retry_btn').css('display', 'none');
                                    //
                                    //$('.pop_box').css('display', 'block');

                                    $('input[name=message]').val('청약 신청이 성공적으로 완료되었습니다.');
                                }
                                else {
                                    //NoticeCommon.Dialog.confirm({
                                    //    title: '신청 실패!',
                                    //    cancel: '재시도'
                                    //    ,again: function(){
                                    //        document.location.reload();
                                    //    },
                                    //    content: result.message
                                    //    ,ok: function(){
                                    //        document.location.href = '/project/' + projectId;
                                    //    }
                                    //});
                                    $('input[name=message]').val(result.message);
                                }

                                $('#resultForm').submit();
                            }
                        });
                    }
                    else {
                        $('input[name=sbscId]').val('');
                        $('input[name=resultSbscId]').val('');
                        $('input[name=tx_user_key]').val('');
                        $('input[name=tx_amount]').val('');
                        //$('input[name=success]').val(false);
                        //$('input[name=message]').val('BankPay 오류입니다.');

                        //$('#resultForm').submit();
                        //window.scrollTo(0,0);
                        //
                        //NoticeCommon.Dialog.confirm({
                        //    title: '신청 실패!',
                        //    cancel: '재시도'
                        //    ,again: function(){
                        //        document.location.reload();
                        //    },
                        //    content: 'BankPay 오류입니다.'
                        //    ,ok: function(){
                        //        document.location.href = '/project/' + projectId;
                        //    }
                        //});
                    }
                }
                else {
                    $('input[name=success]').val(false);
                    $('input[name=message]').val(result.message);

                    $('#resultForm').submit();
                }

            }
            else {
                $('input[name=success]').val(false);
                $('input[name=message]').val(result.message);

                $('#resultForm').submit();
                //window.scrollTo(0,0);
                //
                //NoticeCommon.Dialog.confirm({
                //    title: '신청 실패!',
                //    cancel: '재시도'
                //    ,again: function(){
                //        document.location.reload();
                //    },
                //    content: '알수없는 오류로 인해 발행 요청이<br />접수되지 않았습니다.'
                //    ,ok: function(){
                //        document.location.href = '/project/' + projectId;
                //    }
                //});
            }
        }
    });
}