<@layout.extends name="layout/modalBase.ftl">

    <@layout.put block="contents">
    <!-- MODAL dialog  -->
    <div class="modal-dialog" style="width: 800px;">
        <div class="modal-content">
            <div class="modal-header clearfix ">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    <i class="pg-close fs-14"></i>
                </button>
                <h4 class="p-b-5"></h4>
            </div>

            <form role="form" name="frmCategory" class="chkData" autocomplete="off">
                <div class="modal-body">
                    <!-- START PANEL -->
                    <div class="panel panel-transparent">
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped" id="stripedTable" style="text-align: center;">
                                    <thead>
                                    <tr>
                                        <!-- NOTE * : Inline Style Width For Table Cell is Required as it may differ from user to user
                                                    Comman Practice Followed
                                                    -->
                                        <th style="width:20%;text-align: center;"></th>
                                        <th style="width:20%;text-align: center;">유형</th>
                                        <th style="width:10%;text-align: center;">결과 코드</th>
                                        <th style="width:40%;text-align: center;">결과 메시지</th>
                                        <th style="width:10%;text-align: center;">청약 날짜</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <#function fnApiTypeName apiType>
                                        <#if apiType == "01">
                                            <#return "청약신청">
                                        <#elseif apiType == "02">
                                            <#return "투자자유형확인청약신청">
                                        <#elseif apiType == "09">
                                            <#return "청약취소">
                                        <#elseif apiType == "91">
                                            <#return "위탁계좌정보통보">
                                        <#elseif apiType == "0200" || apiType == "0210">
                                            <#return "실시간계좌이체 결제">
                                        <#elseif apiType == "0420" || apiType == "0430">
                                            <#return "실시간계좌이체 취소">
                                        <#elseif apiType == "0400" || apiType == "0410">
                                            <#return "실시간계좌이체 환불">
                                        <#elseif apiType == "0500" || apiType == "0510">
                                            <#return "가상계좌이체 요청">
                                        <#elseif apiType == "0600" || apiType == "0610">
                                            <#return "가상계좌이체 입금 통보">
                                        <#else>
                                            <#return "">
                                        </#if>
                                    </#function>
                                    <#if sbscLogs?has_content>
                                        <#list sbscLogs as sbscLog>
                                        <tr>
                                            <td class="v-align-middle">
                                                <p>${sbscLog.logType}</p>
                                            </td>
                                            <td class="v-align-middle">
                                                <p>${(fnApiTypeName(sbscLog.apiType)) !}</p>
                                            </td>
                                            <td class="v-align-middle">
                                                <p>${(sbscLog.resultCode) !}</p>
                                            </td>
                                            <td class="v-align-middle">
                                                <p>${(sbscLog.resultMessage) !}</p>
                                            </td>
                                            <td class="v-align-middle">
                                                <p>${(sbscLog.regDate?datetime?string("yyyy.MM.dd HH:mm:ss")) !}</p>
                                            </td>
                                        </tr>
                                        </#list>
                                    </#if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- END PANEL -->
                    </div>
                </div>

            </form>
        </div>
        <!-- /.modal-content -->
    </div>
    </@layout.put>


    <@layout.put block="script">
    <script type="text/javascript">
        $( document ).ready(function() {
            //$('form.chkData').validate();

            // 카테고리 등록/수정
            $("#btn_cancel_submit").click(function()
            {
                var payType = '${(payType) !}';

                if(payType == 'bankpay') {
                    $('input[name=reqTpcd]').val('bankpay');
                }
                else {
                    $('input[name=reqTpcd]').val('09');
                }


                console.log($('#frmData').serialize());

                var form_data = new FormData($('#frmData')[0]);
                form_data.append('cancelCd', $('select[name=cancelCd]').val());
                form_data.append('cancelMsg', $('input[name=cancelMsg]').val());

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
                        $('#modalDiv').modal('hide');

                        if(result != undefined && result != null) {
                            if (result.success) {
                                NoticeCommon.Dialog.alert('청약취소 성공하였습니다.');

                                document.location.href = '/sbsc/list';
                            }
                            else {
                                NoticeCommon.Dialog.alert(result.message);
                            }
                        }
                        else {
                            NoticeCommon.Dialog.alert('청약취소 실패하였습니다.');
                        }
                    }
                });

                return false;
            });

        });
    </script>
    </@layout.put>

</@layout.extends>