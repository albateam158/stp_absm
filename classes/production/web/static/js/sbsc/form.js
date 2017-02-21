/**
 * Created by sj on 16. 3. 7..
 */
$( document ).ready(function() {
    $('.all_wrap').addClass('sub');

    // 그래프 초기화
    $('.graph').circleGraphic();


    // 한도 조회
    var totInvstLmtAmt = 2000000; //투자 한도 금액
    if(invSortCd == '02') {
        totInvstLmtAmt = 10000000;
    }
    else if(invSortCd == '03') {
        totInvstLmtAmt = -1;
    }

    $.ajax({
        url: '/sbsc/'+projectId+'/reqLmtAmt',
        type: 'GET',
        dataType: 'json',
        data: '',
        async: false,
        cache: false,
        error: function (result) {
            console.log(result);
        },
        success: function (result) {
            console.log(result);

            if(result.projectRelative) {
                $(".totInvstLmtAmtString").html('해당 모집의 <b>연고자</b>입니다. 투자 한도 제한이 없습니다.');

                $('input[name=totInvstLmtAmt]').val(-1);
            }
            else {
                if (result != undefined && result != null) {
                    if(result.success) {
                        var dbInvSortCdInt = parseInt(invSortCd);
                        var ksdInvSortCdInt = 0;

                        if (result.reqLmtResultCd == '0000') {
                            ksdInvSortCdInt = parseInt(result.invstrSortTpcd);

                            // DB 투자자유형 예탁원 투자자유형 보다 작으면 예탁원 투자자 우선
                            if(dbInvSortCdInt <= ksdInvSortCdInt) {
                                totInvstLmtAmt = result.issurInvstLmtAmt;
                            }

                            if(totInvstLmtAmt == -1) {
                                $(".totInvstLmtAmtString").html('크라우드펀딩 동일 기업당 투자 한도 제한이 없습니다.');
                            }
                            else {
                                $(".totInvstLmtAmtString").html('크라우드펀딩 동일 기업당 투자 한도 <strong class="price"><span>'+numberWithCommas(totInvstLmtAmt)+'원</span></strong> 까지 투자 할 수 있습니다.');
                            }


                            $('input[name=totInvstLmtAmt]').val(totInvstLmtAmt);

                        } else if (result.reqLmtResultCd == '0001') {
                            $(".totInvstLmtAmtString").html('크라우드펀딩 동일 기업당 투자 한도 제한이 없습니다.');

                            totInvstLmtAmt = -1;

                            $('input[name=totInvstLmtAmt]').val(totInvstLmtAmt);
                        } else if (result.reqLmtResultCd == '0011') {
                            if(totInvstLmtAmt == -1) {
                                $(".totInvstLmtAmtString").html('크라우드펀딩 동일 기업당 투자 한도 제한이 없습니다.');
                            }
                            else {
                                $(".totInvstLmtAmtString").html('미등록투자자입니다. 크라우드펀딩 동일 기업당 투자 한도 <strong class="price"><span>'+numberWithCommas(totInvstLmtAmt)+'원</span></strong> 까지 투자 할 수 있습니다.');
                            }

                            $('input[name=totInvstLmtAmt]').val(totInvstLmtAmt);
                        } else {
                            console.log(result);
                            if(totInvstLmtAmt == -1) {
                                $(".totInvstLmtAmtString").html('크라우드펀딩 동일 기업당 투자 한도 제한이 없습니다.');
                            }
                            else {
                                $(".totInvstLmtAmtString").html('크라우드펀딩 동일 기업당 투자 한도를 알 수 없습니다. <strong class="price"><span>'+numberWithCommas(totInvstLmtAmt)+'원</span></strong> 까지 투자 할 수 있습니다.');
                            }

                            $('input[name=totInvstLmtAmt]').val(totInvstLmtAmt);
                        }

                        if(result.invstrSortTpcd) {
                            $('input[name=invstrSortTpcd]').val(result.invstrSortTpcd);
                        }

                    }
                    else {
                        if(totInvstLmtAmt == -1) {
                            $(".totInvstLmtAmtString").html('크라우드펀딩 동일 기업당 투자 한도 제한이 없습니다.');
                        }
                        else {
                            $(".totInvstLmtAmtString").html('크라우드펀딩 동일 기업당 투자 한도 <strong class="price"><span>'+numberWithCommas(totInvstLmtAmt)+'원</span></strong> 까지 투자 할 수 있습니다.');
                        }

                        $('input[name=totInvstLmtAmt]').val(totInvstLmtAmt);
                    }
                }
                else {
                    if(totInvstLmtAmt == -1) {
                        $(".totInvstLmtAmtString").html('크라우드펀딩 동일 기업당 투자 한도 제한이 없습니다.');
                    }
                    else {
                        $(".totInvstLmtAmtString").html('크라우드펀딩 동일 기업당 투자 한도 <strong class="price"><span>'+numberWithCommas(totInvstLmtAmt)+'원</span></strong> 까지 투자 할 수 있습니다.');
                    }

                    $('input[name=totInvstLmtAmt]').val(totInvstLmtAmt);
                }
            }
        }
    });

    // 동의 버튼 클릭
    $('#btn_submit').click(function () {
        var sbscQty = $('input[name=sbscQty]').val();

        if(sbscQty == '') {
            NoticeCommon.Dialog.alert('청약 수량을 입력해주세요.');
        }
        else {
            var stockMinPrice = numberWithCommas(parseInt(minSbscCount)*parseInt(targetStockPrice)); //최소금액
            var chkTotInvstLmtAmt = $('input[name=totInvstLmtAmt]').val(); //투자한도

            if(sbscQty < parseInt(minSbscCount)) {
                NoticeCommon.Dialog.alert('투자가능 최소단위는 '+minSbscCount+'주 입니다.<br />다시 확인해 주시기 바랍니다.');
                // 청약 금액
                $('.result_price > span').text(numberWithCommas(stockMinPrice));
                // 청약 수량
                $('#sbscCount').text(numberWithCommas(minSbscCount));
                $('input[name=sbscQty]').val(minSbscCount);

                return;
            }

            if(sbscQty > parseInt(targetStockQty)) {
                NoticeCommon.Dialog.alert('청약 신청한도 수를 넘었습니다. 다시 확인해 주시기 바랍니다.');
                // 청약 금액
                $('.result_price > span').text(numberWithCommas(stockMinPrice));
                // 청약 수량
                $('#sbscCount').text(numberWithCommas(minSbscCount));
                $('input[name=sbscQty]').val(minSbscCount);

                return;
            }

            if((sbscQty*parseInt(targetStockPrice)) > parseInt(chkTotInvstLmtAmt) && chkTotInvstLmtAmt != -1) {
                if(invSortCd != '03') {
                    NoticeCommon.Dialog.alert('투자한도 금액을 넘기셨습니다. 다시 확인해 주시기 바랍니다.');
                    // 청약 금액
                    $('.result_price > span').text(numberWithCommas(stockMinPrice));
                    // 청약 수량
                    $('#sbscCount').text(numberWithCommas(minSbscCount));
                    $('input[name=sbscQty]').val(minSbscCount);

                    return;
                }
            }

            //console.log($('#frmData').serialize());
            //document.location.href = '/sbsc/'+projectId+'/transfer?' + $('#frmData').serialize();
            $('#frmData').submit();
        }
    });



    $('input').bind('keyup input', function() {
        if($(this).hasClass('chkNum')){
            var val = $(this).val();

            if(isNaN(val)){//숫자가 아니면
                NoticeCommon.Dialog.alert('숫자만 입력해주세요.');
                $(this).val('');
                return false;
            }
        }

        if($(this).hasClass('sbscQty')){
            var val = ($(this).val())?$(this).val():0;
            var sbscPrice = parseInt(targetStockPrice) * parseInt(val);
            var totalTargetAmt = sbscPrice + parseInt(sbscAmt);

            if(totalTargetAmt > parseInt(targetAmt)) {
                $('.target_over').removeClass('none');
            }
            else {
                $('.target_over').addClass('none');
            }

            // 청약 금액
            $('.result_price > span').text(numberWithCommas(sbscPrice));

            // 청약 수량
            $('#sbscCount').text(numberWithCommas(val));

            // 배정지분율
            //$('#shareRatio').text(((val / maxSbscCount) / 100).toFixed(6));
            var ratio = (shareRatio * sbscPrice) / targetAmt;

            if(isNaN(ratio)) {
                ratio = 0;
            }
            $('#shareRatio').text((ratio).toFixed(6));
        }


    });



});



function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}