<@layout.extends name="layout/modalBase.ftl">

    <@layout.put block="contents">
        <!-- MODAL dialog  -->
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header clearfix ">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <i class="pg-close fs-14"></i>
                    </button>
                    <h4 class="category-title p-b-5"></h4>
                </div>

                <form role="form" name="frmProjectRelative" class="chkData" autocomplete="off">
                    <div class="modal-body">
                        <p class="small-text">연고자 신청 정보입니다.</p>
                        <input type="hidden" name="relativeId" value="${(projectRelative.relativeId) !}" />
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group form-group-default required">
                                    <label>모집명</label>
                                    <input type="text" name="project_name" class="form-control" readonly value="${(projectRelative.project.sbscIssNm) !}" required>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group form-group-default required">
                                    <label>신청인</label>
                                    <input type="text" name="user_name" class="form-control" readonly value="${(projectRelative.user.name) !}" required>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group form-group-default required">
                                    <label>첨부파일</label>
                                    <input type="text" name="file" class="form-control" readonly value="${(projectRelative.file.filename) !}" required>
                                    <a href="/file/${(projectRelative.file.fileId) !}">[다운로드]</a>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group form-group-default required">
                                    <label>상태</label>
                                    <input type="radio" name="status" value="approved" id="status01" <#if (projectRelative.status)?default('approved') == "approved">checked</#if> />
                                    <label style="display: inline-block;" for="status01">승인</label>
                                    <input type="radio" style="margin-left: 30px;" name="status" value="unapproved" id="status02" <#if (projectRelative.status)?default('approved') == "unapproved">checked</#if> />
                                    <label style="display: inline-block;" for="status02">미승인</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input type="button" id="btn_relative_submit" class="btn btn-primary" style="margin-right:0;" value="Submit" />
                    </div>
                </form>
            </div>
            <!-- /.modal-content -->
        </div>

        <div class="modal-dialog extra-dialog none">
            <div class="modal-content">
                <div class="modal-header clearfix ">
                    <button type="button" class="close">
                        <i class="pg-close fs-14"></i>
                    </button>
                    <h4 class="p-b-5"><span class="semi-bold">Project</span> List</h4>
                </div>
                <div class="modal-body" id="project_list_div"></div>
            </div>
        </div>
    </@layout.put>


    <@layout.put block="script">
    <script type="text/javascript">
        $( document ).ready(function() {
            var categoryId = $("input[name='category_id']").val();

            // 연고자 신청 수정
            $("#btn_relative_submit").click(function()
            {
                $.ajax({
                    url: '/project/relative_form',
                    type: 'POST',
                    dataType: 'json',
                    data: $('form').serialize(),
                    async: false,
                    cache: false,
                    success: function (result) {
                        location.reload();
                    }
                });
            });

            $('.modal-dialog.extra-dialog button.close').click(function()
            {
                $('.modal-dialog.extra-dialog').addClass('none');
            });

        });
    </script>
    </@layout.put>

</@layout.extends>