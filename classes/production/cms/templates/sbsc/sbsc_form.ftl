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
                    <li><a class="active">View</a></li>
                </ul>
                <!-- END BREADCRUMB -->
            </div>
            <div class="row">
                <div class="panel panel-transparent">
                    <div class="panel-header">
                        <div class="no-padding m-b-10">
                            <h3>Sbsc</h3>
                            <p>WiCrowd 청약 수정 페이지 입니다.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- END JUMBOTRON -->



    <div class="container-fluid container-fixed-lg">
        <div class="row">
            <div class="col-md-6" style="padding-right:0;">
                <div class="panel panel-default">

                    <#--모집 정보-->

                    <div class="panel-heading">
                        <div class="panel-title">
                            모집 정보
                        </div>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="row">
                                <label for="fname" class="col-sm-3 control-label" style="font-weight: bold;font-size: 11px;">이름</label>
                                <div class="col-sm-9">
                                    <p>${(sbsc.project.name) !}</p>
                                </div>
                                <label for="fname" class="col-sm-3 control-label" style="font-weight: bold;font-size: 11px;">요약</label>
                                <div class="col-sm-9">
                                    <p>${(sbsc.project.summary?html) !}</p>
                                </div>
                                <#--<div class="col-sm-3">-->
                                    <#--<div class="form-group">-->
                                        <#--<label>이름</label>-->
                                        <#--<input type="text" name="projectName" readonly class="form-control" value="${(sbsc.project.name) !}" required>-->
                                    <#--</div>-->
                                <#--</div>-->
                                <#--<div class="col-sm-6">-->
                                    <#--<div class="form-group">-->
                                        <#--<label>요약</label>-->
                                        <#--<input type="text" name="projectSummary" readonly class="form-control" value="${(sbsc.project.summary?html) !}" required>-->
                                    <#--</div>-->
                                <#--</div>-->
                            </div>
                            <br/>
                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>목표금액</label>
                                        <input type="text" name="targetAmt" readonly class="form-control" value="${(sbsc.project.targetAmt) !}원" required>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>유치금액</label>
                                        <input type="text" name="sbscAtm" readonly class="form-control" value="${(sbsc.project.sbscAmt) !}원" required>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>청약수량</label>
                                        <input type="text" name="sbscCount" readonly class="form-control" value="${(sbsc.project.sbscCount) !}명" required>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>달성률</label>
                                        <input type="text" name="pRate" readonly class="form-control" value="${(pRate) !}%" required>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>기업가치</label>
                                        <input type="text" name="companyValue" readonly class="form-control" value="${(sbsc.project.companyValue) !}" required>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>배당지분율</label>
                                        <input type="text" name="shareRatio" readonly class="form-control" value="${(sbsc.project.shareRatio) !}" required>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>주당 인수 희망가격</label>
                                        <input type="text" name="targetStockPrice" readonly class="form-control" value="${(sbsc.project.targetStockPrice) !}원" required>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>시작일</label>
                                        <input type="text" name="sbscStDt" readonly class="form-control" value="${(sbsc.project.sbscStDt?date("yyyyMMdd")?string("yyyy.MM.dd")) !}" required>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>마감일</label>
                                        <input type="text" name="sbscNdDt" readonly class="form-control" value="${(sbsc.project.sbscNdDt?date("yyyyMMdd")?string("yyyy.MM.dd")) !}" required>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>발행예정일</label>
                                        <input type="text" name="issueDate" readonly class="form-control" value="${(sbsc.project.issueDate?date("yyyyMMdd")?string("yyyy.MM.dd")) !}" required>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>현재주식수</label>
                                        <input type="text" name="corpStock" readonly class="form-control" value="${(sbsc.project.corpStock) !}주" required>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>주당가격</label>
                                        <input type="text" name="targetStockPrice" readonly class="form-control" value="${(sbsc.project.targetStockPrice) !}원" required>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>투자가능 최소단위</label>
                                        <input type="text" name="minSbscCount" readonly class="form-control" value="${(sbsc.project.minSbscCount) !}주" required>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>투자가능 금액</label>
                                        <input type="text" name="minSbscPrice" readonly class="form-control" value="${(sbsc.project.minSbscCount * sbsc.project.targetStockPrice) !}원" required>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>발행 후 배정지분율</label>
                                        <input type="text" name="shareRatio" readonly class="form-control" value="${(sbsc.project.shareRatio) !}" required>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6" style="padding-right:0;">
                <div class="panel panel-default">

                    <#--투자자 정보-->

                    <div class="panel-heading">
                        <div class="panel-title">
                            투자자 정보
                        </div>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="row">
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>이름</label>
                                        <input type="text" name="userName" readonly class="form-control" value="${(sbsc.user.name) !}" required>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>투자자 구분</label>
                                        <input type="text" name="realnmnoTpcd" readonly class="form-control" value="<#if investor.realnmnoTpcd == "11">개인<#else>법인</#if>" required>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label>상태</label>
                                        <input type="text" name="status" readonly class="form-control" value="<#if investor?exists && investor.status == "approved">승인<#else>미승인</#if>" required>
                                    </div>
                                </div>
                            </div>
                            <#if investor.realnmnoTpcd == "11">
                                <div class="row">
                                    <div class="col-sm-3">
                                        <div class="form-group">
                                            <label>실명번호</label>
                                            <input type="text" name="realnmno" readonly class="form-control" value="${(investor.realnmno) !}" required>
                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <div class="form-group">
                                            <label>법인번호</label>
                                            <input type="text" name="buzno" readonly class="form-control" value="${(investor.buzno) !}" required>
                                        </div>
                                    </div>
                                </div>
                            <#else>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <div class="form-group">
                                            <label>회사이름</label>
                                            <input type="text" name="corpName" readonly class="form-control" value="${(investor.corpName) !}" required>
                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <div class="form-group">
                                            <label>매니저이름</label>
                                            <input type="text" name="managerName" readonly class="form-control" value="${(investor.managerName) !}" required>
                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <div class="form-group">
                                            <label>매니저 전화번호</label>
                                            <input type="text" name="managerPhone" readonly class="form-control" value="${(investor.managerPhone) !}" required>
                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <div class="form-group">
                                            <label>매니저 이메일</label>
                                            <input type="text" name="managerEmail" readonly class="form-control" value="${(investor.managerEmail) !}" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <div class="form-group">
                                            <label>사업자등록증</label><br/>
                                        ${(investor.fileId1.filename) !} <a href="/file/${(investor.fileId1.fileId) !}">[다운로드]</a>
                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <div class="form-group">
                                            <label>대표자 신분증</label><br/>
                                        ${(investor.fileId2.filename) !} <a href="/file/${(investor.fileId2.fileId) !}">[다운로드]</a>
                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <div class="form-group">
                                            <label>법인등기부등본 또는 주주명부</label><br/>
                                        ${(investor.fileId3.filename) !} <a href="/file/${(investor.fileId3.fileId) !}">[다운로드]</a>
                                        </div>
                                    </div>
                                </div>
                            </#if>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <#--정약 정보-->

        <form id="frmData" role="form" autocomplete="off">
            <input type="hidden" name="userId" value="${(sbsc.user.userId) !}">
            <input type="hidden" name="projectId" value="${(sbsc.project.projectId) !}">
            <input type="hidden" name="sbscId" value="${(sbsc.sbscId) !}">
            <input type="hidden" name="invSortCd" value="${(sbsc.invSortCd) !}">
            <input type="hidden" name="state" value="${(sbsc.state) !}">
            <input type="hidden" name="secucoAcoacd" value="02" id="check2">
            <input type="hidden" name="secucoAcopno" value="${(sbsc.secucoAcopno) !}" >
            <input type="hidden" name="secucoAcopseq" value="${(sbsc.secucoAcopseq) !}">
            <input type="hidden" name="pblBnkCd" value="${(sbsc.pblBnkCd) !}" >
            <input type="hidden" name="reqTpcd" value="01" > <!-- 01.청약신청/02.투자자유형확인청약신청/09.청약취소/91.위탁계좌정보통보 -->
            <input type="hidden" name="sbscQty" value="${(sbsc.sbscQty?c) !}" >
            <input type="hidden" name="sbscAmt" value="${(sbsc.sbscAmt?c) !}" >

            <!-- START PANEL -->
            <div class="panel panel-default">
                <div class="panel-heading">

                </div>
                <div class="panel-body no-scroll ">
                    <label>청약 수량</label>
                    <input type="text" name="sbscQtyString" readonly class="form-control" value="${(sbsc.sbscQty) !}주" required>
                    <br>
                    <label>청약 금액</label>
                    <input type="text" name="sbscAmtString" readonly class="form-control" value="${(sbsc.sbscAmt) !}원" required>
                    <br>
                    <label>청약 상태</label>
                    <#function fnStateName state>
                        <#switch state>
                            <#case "init_ok">
                                <#return "청약정보 등록 완료">
                                <#break>
                            <#case "realtime_ok">
                                <#return "청약금액 지불 완료">
                                <#break>
                            <#case "ksd_cancel">
                                <#return "KSD 취소 완료">
                                <#break>
                            <#case "acc_waiting">
                                <#return "가상걔좌 입금 대기">
                                <#break>
                            <#case "acc_ok">
                                <#return "가상걔좌 입금 완료">
                                <#break>
                            <#case "cancel">
                                <#return "청약 취소 완료">
                                <#break>
                            <#default> <#--pay_complete-->
                                <#return "청약 완료">
                        </#switch>
                    </#function>
                    <input type="text" name="stateName" readonly class="form-control" value="${(fnStateName(sbsc.state)) !}" required>
                    <br>
                    <label>투자자 유형</label>
                    <#function fnInvSortName invSortCd>
                        <#switch invSortCd>
                            <#case "02">
                                <#return "소득요건충족 투자자">
                                <#break>
                            <#case "03">
                                <#return "전문투자자">
                                <#break>
                            <#case "04">
                                <#return "연고자">
                                <#break>
                            <#default> <#--01-->
                                <#return "일반 투자자">
                        </#switch>
                    </#function>
                    <input type="text" name="invSortName" readonly class="form-control" value="${(fnInvSortName(sbsc.invSortCd)) !}" required>
                    <br>
                    <label>위탁 증권사</label>
                    <input type="text" name="secucoAcopName" readonly class="form-control" value="${(secucoAcopName.codeName) !}" required>
                    <br>
                    <label>위탁 계좌번호</label>
                    <input type="text" name="invstrTrsacNo" readonly class="form-control" value="${(sbsc.invstrTrsacNo) !}" required>
                    <br>
                    <label>위탁 계좌번호 유효성 여부</label>
                    <input type="text" name="accValid" readonly class="form-control" value="<#if sbsc.accValid == 1>유효<#else>무효</#if>" required>
                    <br>
                    <label>증권금융에서 생성한 거래고유번호</label>
                    <input type="text" name="trIdnId" readonly class="form-control" value="${(bankpayResponse.trIdnId) !}" required>
                    <br>
                    <#if sbsc.fileId1?exists>
                    <label>소득증명원</label><br/>
                    ${(sbsc.fileId1.filename) !} <a href="/file/${(sbsc.fileId1.fileId) !}">[다운로드]</a>
                    </#if>
                    <#if sbsc.state == "cancel">
                        <label>취소 사유 코드</label>
                        <input type="text" name="cancelReasonName" readonly class="form-control" value="${(cancelReasonName.codeName) !}" required>
                        <br>
                        <label>취소 사유</label>
                        <input type="text" name="cancelReasonMsg" readonly class="form-control" value="${(sbsc.cancelMsg) !}" required>
                        <br>
                    </#if>
                </div>
            </div>
            <div class="clearfix padding-10">
                <button class="btn btn-primary btn-cons pull-right m-b-10 go-list" type="button">
                    <i class="pg-form"></i>
                    <span class="bold">청약 목록</span>
                </button>
                <button class="btn btn-primary btn-cons pull-right m-b-10 log" type="button">
                    <i class="pg-form"></i>
                    <span class="bold">청약 내역</span>
                </button>
                <#if sbsc.state == "pay_complete">
                    <button class="btn btn-primary btn-cons pull-right m-b-10 change-type" type="button">
                        <i class="pg-form"></i>
                        <span class="bold">투자자 유형 변경</span>
                    </button>
                    <button class="btn btn-primary btn-cons pull-right m-b-10 change-aco" type="button">
                        <i class="pg-form"></i>
                        <span class="bold">위탁사 계좌 변경</span>
                    </button>
                    <button class="btn btn-primary btn-cons pull-right m-b-10 cancel" type="button">
                        <i class="pg-form"></i>
                        <span class="bold">청약 취소</span>
                    </button>
                </#if>
                <#if sbsc.state == "realtime_ok">
                    <button class="btn btn-primary btn-cons pull-right m-b-10" onClick="javascript:payRequestLink2(frmData);return false;" type="button">
                        <i class="pg-form"></i>
                        <span class="bold">KSD 청약 재신청</span>
                    </button>
                    <button class="btn btn-primary btn-cons pull-right m-b-10 realtime" type="button">
                        <i class="pg-form"></i>
                        <span class="bold">실시간계좌이체 취소</span>
                    </button>
                </#if>
                <#if sbsc.state == "cancel">
                </#if>
                <#if sbsc.state == "ksd_cancel">
                    <button class="btn btn-primary btn-cons pull-right m-b-10 realtime" type="button">
                        <i class="pg-form"></i>
                        <span class="bold">실시간계좌이체 취소</span>
                    </button>
                </#if>
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
        var sbscId = '${(sbsc.sbscId) !}';

        $( document ).ready(function()
        {
            $('.go-list').click(function () {
                document.location.href = '/sbsc/list';
            });


            // 청약 취소
            $(document).on("click", "button.cancel", function()
            {
                NoticeCommon.Dialog.confirm({
                    content: '해당 청약을 취소하시겠습니까?'
                    ,ok: function(){
                        $("#modalDiv").load("/sbsc/"+sbscId+"/cancel/ksd", function(responseTxt, statusTxt, xhr){
                            if(statusTxt == "success") {

                                $('#modalDiv').modal('show');
                                $('#modalDiv h4').html('청약취소');
                            }

                            //alert("External content loaded successfully!");
                            if(statusTxt == "error")
                                alert("Error: " + xhr.status + ": " + xhr.statusText);
                        });
                    }
                });
            });


            // 청약 내역
            $(document).on("click", "button.log", function()
            {
                $("#modalDiv").load("/sbsc/"+sbscId+"/log_div", function(responseTxt, statusTxt, xhr){
                    if(statusTxt == "success") {

                        $('#modalDiv').modal('show');
                        $('#modalDiv h4').html('청약내역');
                    }

                    //alert("External content loaded successfully!");
                    if(statusTxt == "error")
                        alert("Error: " + xhr.status + ": " + xhr.statusText);
                });
            });



            // KSD 재시도
            $(document).on("click", "button.ksd-retry", function()
            {
                NoticeCommon.Dialog.confirm({
                    content: '해당 청약을 재신청하시겠습니까?'
                    ,ok: function(){
                        var form_data = new FormData($('#frmData')[0]);

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
                                            content: '청약 재신청 성공하였습니다.',
                                            ok: function(){
                                                location.reload();
                                            }
                                        });
                                    }
                                    else {
                                        NoticeCommon.Dialog.alert(result.message);
                                    }
                                }
                                else {
                                    NoticeCommon.Dialog.alert('청약 재신청 실패하였습니다.');
                                }
                            }
                        });
                    }
                });
            });

            // 투자자 유형 변경
            $(document).on("click", "button.change-type", function()
            {
                $("#modalDiv").load("/sbsc/"+sbscId+"/type_div", function(responseTxt, statusTxt, xhr){
                    if(statusTxt == "success") {

                        $('#modalDiv').modal('show');
                        $('#modalDiv h4').html('투자자 유형 변경');

                        $('input[name=reqTpcd]').val('02');
                    }

                    //alert("External content loaded successfully!");
                    if(statusTxt == "error")
                        alert("Error: " + xhr.status + ": " + xhr.statusText);
                });
            });

            // 위탁계좌 변경
            $(document).on("click", "button.change-aco", function()
            {
                $("#modalDiv").load("/sbsc/"+sbscId+"/aco_div", function(responseTxt, statusTxt, xhr){
                    if(statusTxt == "success") {

                        $('#modalDiv').modal('show');
                        $('#modalDiv h4').html('위탁사 계좌 변경');

                        $('input[name=reqTpcd]').val('91');
                    }

                    //alert("External content loaded successfully!");
                    if(statusTxt == "error")
                        alert("Error: " + xhr.status + ": " + xhr.statusText);
                });
            });

            // 실시간 계좌이체 취소 및 환불
            $(document).on("click", "button.realtime", function()
            {
                NoticeCommon.Dialog.confirm({
                    content: '해당 실시간 계좌이체를 취소하시겠습니까?'
                    ,ok: function(){
                        $("#modalDiv").load("/sbsc/"+sbscId+"/cancel/bankpay", function(responseTxt, statusTxt, xhr){
                            if(statusTxt == "success") {

                                $('#modalDiv').modal('show');
                                $('#modalDiv h4').html('청약취소');
                            }

                            //alert("External content loaded successfully!");
                            if(statusTxt == "error")
                                alert("Error: " + xhr.status + ": " + xhr.statusText);
                        });
                    }
                });
            });


        });


        function  payRequestLink2(frm) {

            NoticeCommon.Dialog.confirm({
                content: '해당 청약을 재신청하시겠습니까?'
                ,ok: function(){
                    var form_data = new FormData($('#frmData')[0]);

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
            });
        }


        function setStringToNumber(val, sel) {
            return val.replace(/,/gi, '');
        }

        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
                    results = regex.exec(location.search);
            return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }


    </script>
    </@layout.put>
</@layout.extends>