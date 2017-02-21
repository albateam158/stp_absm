<@layout.extends name="layout/base.ftl">
    <@layout.put block="head">
    <style type="text/css">

    </style>
    </@layout.put>
    <@layout.put block="contents">
    <!-- START JUMBOTRON -->
    <div class="jumbotron" data-pages="parallax">
        <div class="container-fixed-lg">
            <div class="row">
                <!-- START BREADCRUMB -->
                <ul class="breadcrumb">
                    <li><a>Home</a></li>
                    <li><a>Sbsc</a></li>
                    <li><a class="active">Request</a></li>
                </ul>
                <!-- END BREADCRUMB -->
            </div>
            <div class="row">
                <div class="panel panel-transparent">
                    <div class="panel-header">
                        <div class="no-padding m-b-10">
                            <h3>Sbsc</h3>
                            <p>WiCrowd 청약 신청 페이지 입니다.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- END JUMBOTRON -->



    <div class="container-fluid container-fixed-lg">
        <#--정약 정보-->

        <form id="frmData" role="form" autocomplete="off">
            <input type="hidden" name="sbscId" value="">
            <input type="hidden" name="state" value="">
            <input type="hidden" name="secucoAcoacd" value="02" id="check2">
            <input type="hidden" name="secucoAcopseq" value="0000">
            <input type="hidden" name="totInvstLmtAmt" value="2000000" >
            <input type="hidden" name="payType" value="realtime" >

            <!-- START PANEL -->
            <div class="panel panel-default">
                <div class="panel-heading">

                </div>
                <div class="panel-body no-scroll ">
                    <label>모집</label><br/>
                    <select class="cs-select cs-skin-slide" name="projectId" data-init-plugin="cs-select">
                        <#list projects as project>
                            <option value="${project.projectId}" minSbscCount="${(project.minSbscCount)!}" stockQty="${(project.targetStockQty?c)!}" stockPrice="${(project.targetStockPrice?c)!}" >${project.name}</option>
                        </#list>
                    </select>
                    <br><br/>
                    <label>투자자</label><br/>
                    <select class="cs-select cs-skin-slide" name="userId" data-init-plugin="cs-select">
                        <option value="">선택안함</option>
                        <#list userInvestors as userInvestor>
                            <option value="${userInvestor.userId}">${userInvestor.username}</option>
                        </#list>
                    </select> &nbsp;&nbsp;&nbsp;
                    <label id="lmtLabel" style="display: none;">한도 : <span id="lmtAmt"></span></label>
                    <br><br/>
                    <label>청약 수량</label>
                    <input type="text" name="sbscQty" class="form-control chkNum" value="" required>
                    <br>
                    <label>청약 금액</label>
                    <input type="text" name="sbscAmt" readonly class="form-control" value="" required>
                    <br>
                    <label>투자자 유형</label><br/>
                    <select class="cs-select cs-skin-slide invSortCd" name="invSortCd" data-init-plugin="cs-select">
                        <option value="01">일반 투자자</option>
                        <option value="02">소득요건충족 투자자</option>
                        <option value="03">전문투자자</option>
                        <option value="04">연고자</option>
                    </select>
                    <br><br/>
                    <label>위탁 증권사</label><br/>
                    <select class="cs-select cs-skin-slide" name="secucoAcopno" data-init-plugin="cs-select">
                        <#list acoCodes as acoCode>
                            <option value="${acoCode.code}">${acoCode.codeName}</option>
                        </#list>
                    </select>
                    <br><br/>
                    <label>위탁 계좌번호</label>
                    <input type="text" name="invstrTrsacNo" class="form-control chkNum" value="" required>
                    <br>
                    <label>환불계좌 은행</label><br/>
                    <select class="cs-select cs-skin-slide" name="pblBnkCd" data-init-plugin="cs-select">
                        <#list bankCodes as bankCode>
                            <option value="${bankCode.code}">${bankCode.codeName}</option>
                        </#list>
                    </select>
                    <br><br/>
                    <label>환불계좌 예금주</label>
                    <input type="text" name="pblAcnoNm" class="form-control" value="" required>
                    <br>
                    <label>환불계좌번호</label>
                    <input type="text" name="pblAcno" class="form-control chkNum" value="" required>
                </div>
            </div>
            <div class="clearfix padding-10">
                <button class="btn btn-primary btn-cons pull-right m-b-10 go-list" type="button">
                    <i class="pg-form"></i>
                    <span class="bold">목록</span>
                </button>
                <button class="btn btn-primary btn-cons pull-right m-b-10" onClick="javascript:payRequestLink2(frmData);return false;" type="button">
                    <i class="pg-form"></i>
                    <span class="bold">청약 신청</span>
                </button>
            </div>
            <!-- END PANEL -->
        </form>
    </div>

    </@layout.put>


    <@layout.put block="script">

    <script src="/assets/plugins/boostrap-form-wizard/js/jquery.bootstrap.wizard.min.js" type="text/javascript"></script>
    <script src="/assets/js/form_wizard.js" type="text/javascript"></script>
    <script src="/assets/plugins/dropzone/dropzone.js" type="text/javascript"></script>
    <script src="/xeditor/js/xeditor.js"></script>
    <script type="text/javascript">
        var mainId = 5, subId = 0;

        $( document ).ready(function()
        {
            $('.go-list').click(function () {
                document.location.href = '/sbsc/list';
            });


            $('input').keyup(function(event) {
                if($(this).hasClass('required')) {
                    $(this).removeClass('required');
                }

                if($(this).hasClass('chkNum')){
                    var val = $(this).val();

                    if(isNaN(val)){//숫자가 아니면
                        NoticeCommon.Dialog.alert('숫자를 입력해 주시기 바랍니다.');
                        $(this).val('');
                        return false;
                    }

                    if($(this).attr('name') == 'sbscQty') {
                        var chkTotInvstLmtAmt = $('input[name=totInvstLmtAmt]').val(); //투자한도
                        var invSortCd = $('select[name=invSortCd]').val();
                        var chk = true;
                        var stockQty = $('select[name=projectId] option:selected').attr('stockQty');
                        var stockPrice = $('select[name=projectId] option:selected').attr('stockPrice');

                        if(val > parseInt(stockQty)) {
                            NoticeCommon.Dialog.alert('청약 신청한도 수를 넘었습니다. 다시 확인해 주시기 바랍니다.');
                            $('input[name=sbscAmt]').val('0');
                            $(this).val('');
                            return false;
                        }

                        if((val*parseInt(stockPrice)) > parseInt(chkTotInvstLmtAmt) && chkTotInvstLmtAmt != '0001') {
                            if(invSortCd != '04') {
                                NoticeCommon.Dialog.alert('투자한도 금액을 넘기셨습니다. 다시 확인해 주시기 바랍니다.');
                                $('input[name=sbscAmt]').val('0');
                                $(this).val('');
                                return false;
                            }
                        }

                        $('#sbscAmt').text(numberWithCommas(val*parseInt(stockPrice)));
                        $('input[name=sbscAmt]').val(val*parseInt(stockPrice));
                    }
                }
            });


            $('select[name=userId]').change(function () {
                var projectId = $('select[name=projectId]').val();
                var userId = $('select[name=userId]').val();

                $.ajax({
                    url: '/sbsc/reqLmtAmt',
                    type: 'GET',
                    dataType: 'json',
                    data: 'projectId='+projectId+'&userId='+userId,
                    async: false,
                    cache: false,
                    error: function (result) {
                        console.log(result);
                    },
                    success: function (result) {
                        if (result != undefined && result != null) {
                            if(result.success) {
                                $('#lmtLabel').css('display', 'inline-block');

                                if (result.reqLmtResultCd == '0000') {
                                    $("#lmtAmt").text('\ ' + numberWithCommas(result.issurInvstLmtAmt) + ' 원');
                                    $('input[name=totInvstLmtAmt]').val(result.issurInvstLmtAmt);
                                } else if (result.reqLmtResultCd == '0001') {
                                    $("#lmtAmt").text('한도제한없음');
                                    $('input[name=totInvstLmtAmt]').val('0001');
                                } else if (result.reqLmtResultCd == '0011') {
                                    $("#lmtAmt").text('미등록투자자');
                                    $('input[name=totInvstLmtAmt]').val(2000000);
                                } else {
                                    console.log(result);
                                    $("#lmtAmt").text('한도알수없음');
                                    $('input[name=totInvstLmtAmt]').val(2000000);
                                }
                            }
                            else {
                                NoticeCommon.Dialog.alert(result.message);
                                $("#lmtAmt").text(numberWithCommas(2000000));
                                $('input[name=totInvstLmtAmt]').val(2000000);
                            }
                        }
                        else {
                            NoticeCommon.Dialog.alert('한도조회 실패하였습니다.');


                            $("#lmtAmt").text(numberWithCommas(2000000));
                            $('input[name=totInvstLmtAmt]').val(2000000);

                        }
                    }
                });
            });




        });

        function setStringToNumber(val, sel) {
            return val.replace(/,/gi, '');
        }

        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
                    results = regex.exec(location.search);
            return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }

        function numberWithCommas(x) {
            return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }


        function  payRequestLink2(frm) {

            var form_data = new FormData($('#frmData')[0]);

            var minSbscCount = $('select[name=projectId] option:selected').attr('minSbscCount');

            if($('input[name=userId]').val() == '') {
                NoticeCommon.Dialog.alert('투자자를 선택해주세요.');
            }
            else if($('input[name=sbscQty]').val() == '') {
                NoticeCommon.Dialog.alert('청약 수량을 입력해주세요.');
            }
            else if($('input[name=invstrTrsacNo]').val() == '') {
                NoticeCommon.Dialog.alert('위탁 걔좌번호를 입력해주세요.');
            }
            else if($('input[name=pblAcnoNm]').val() == '') {
                NoticeCommon.Dialog.alert('환불계좌 예금주를 입력해주세요.');
            }
            else if($('input[name=pblAcno]').val() == '') {
                NoticeCommon.Dialog.alert('환불걔좌번호를 입력해주세요.');
            }
            else if(minSbscCount > $('input[name=sbscQty]').val()) {
                NoticeCommon.Dialog.alert('해당 모집의 최소 청약 수량은 ' + minSbscCount + '주 입니다.');
            }
            else {
                $.ajax({
                    url: '/sbsc',
                    type: 'POST',
                    data: form_data,
                    processData: false,
                    contentType: false,
                    error:function(result)
                    {
                        console.log(result);
                    },
                    success:function(result)
                    {
                        console.log(result);

                        if(result != undefined && result != null) {
                            if (result.success) {
                                NoticeCommon.Dialog.alert({
                                    content: '청약신청 성공하였습니다.',
                                    ok: function(){
                                        document.location.href = '/sbsc/form?sbscId=' + result.projectSbsc.sbscId;
                                    }
                                });
                            }
                            else {
                                NoticeCommon.Dialog.alert(result.message);
                            }
                        }
                        else {
                            NoticeCommon.Dialog.alert('청약신청 실패하였습니다.');
                        }
                    }
                });
            }
        }


    </script>
    </@layout.put>
</@layout.extends>