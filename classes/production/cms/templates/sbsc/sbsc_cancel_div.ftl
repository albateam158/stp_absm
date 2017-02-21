<@layout.extends name="layout/modalBase.ftl">

    <@layout.put block="contents">
    <!-- MODAL dialog  -->
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header clearfix ">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    <i class="pg-close fs-14"></i>
                </button>
                <h4 class="p-b-5"></h4>
            </div>

            <form role="form" name="frmCategory" class="chkData" autocomplete="off">
                <div class="modal-body">
                    <p class="small-text">청약 취소 사유를 입력해주세요.</p>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group required">
                                <label>취소 사유 코드</label><br/>
                                <select class="cs-select cs-skin-slide" name="cancelCd" data-init-plugin="cs-select">
                                    <#list cancelReasonCodes as cancelReasonCode>
                                        <option value="${cancelReasonCode.code}">${cancelReasonCode.codeName}</option>
                                    </#list>
                                </select>
                            </div>
                            <div class="form-group required">
                                <label>취소 사유</label>
                                <input type="text" name="cancelMsg" class="form-control" value="" required>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="btn_cancel_submit" class="btn btn-primary" style="margin-right:0;">
                        Submit
                    </button>
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