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
                <input type="hidden" name="changeSecucoAcoacd" value="02">
                <input type="hidden" name="changeSecucoAcopseq" value="0000">
                <div class="modal-body">
                    <p class="small-text">위탁사 정보를 입력해주세요.</p>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group required">
                                <label>위탁 증권사</label><br/>
                                <select class="cs-select cs-skin-slide" name="changeSecucoAcopno" data-init-plugin="cs-select">
                                    <#list acoCodes as acoCode>
                                        <option value="${acoCode.code}">${acoCode.codeName}</option>
                                    </#list>
                                </select>
                            </div>
                            <div class="form-group required">
                                <label>위탁 증권 계좌번호</label>
                                <input type="text" name="changeInvstrTrsacNo" class="form-control" value="" required>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="btn_aco_submit" class="btn btn-primary" style="margin-right:0;">
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
            $("#btn_aco_submit").click(function()
            {
                if($('input[name=changeInvstrTrsacNo]').val() == '') {
                    NoticeCommon.Dialog.alert('위탁 증권 계좌번호를 입력해주세요.');
                }
                else {
                    $('input[name=reqTpcd]').val('91');

                    console.log($('#frmData').serialize());

                    var form_data = new FormData($('#frmData')[0]);
                    form_data.append('changeInvstrTrsacNo', $('input[name=changeInvstrTrsacNo]').val());
                    form_data.append('changeSecucoAcoacd', $('input[name=changeSecucoAcoacd]').val());
                    form_data.append('changeSecucoAcopseq', $('input[name=changeSecucoAcopseq]').val());
                    form_data.append('changeSecucoAcopno', $('select[name=changeSecucoAcopno]').val());

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
                                    NoticeCommon.Dialog.alert({
                                        content: '위탁계좌변경 신청 성공하였습니다.',
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
                                NoticeCommon.Dialog.alert('위탁계좌변경 신청 실패하였습니다.');
                            }
                        }
                    });
                }

                return false;
            });

        });
    </script>
    </@layout.put>

</@layout.extends>