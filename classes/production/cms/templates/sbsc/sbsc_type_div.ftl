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
                    <p class="small-text">투자자 유형을 선택해주세요.</p>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group required">
                                <label>투자자 유형</label><br/>
                                <select class="cs-select cs-skin-slide" name="changeInvSortCd" data-init-plugin="cs-select">
                                    <option value="01">일반 투자자</option>
                                    <option value="02">소득요건충족 투자자</option>
                                    <option value="03">전문투자자</option>
                                    <option value="04">연고자</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="btn_type_submit" class="btn btn-primary" style="margin-right:0;">
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
            $("#btn_type_submit").click(function()
            {
                $('input[name=reqTpcd]').val('02');

                console.log($('#frmData').serialize());

                var form_data = new FormData($('#frmData')[0]);

                form_data.append('changeInvSortCd', $('select[name=changeInvSortCd]').val());

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
                                    content: '투자자 유형변경 신청 성공하였습니다.',
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
                            NoticeCommon.Dialog.alert('투자자 유형변경 신청 실패하였습니다.');
                        }
                    }
                });

                return false;
            });

        });
    </script>
    </@layout.put>

</@layout.extends>