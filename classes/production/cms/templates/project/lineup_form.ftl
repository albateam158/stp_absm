<@layout.extends name="layout/modalBase.ftl">

    <@layout.put block="contents">
        <!-- MODAL dialog  -->
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header clearfix ">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <i class="pg-close fs-14"></i>
                    </button>
                    <h5 class="text-left">프로젝트 정렬</h5>
                </div>

                <form role="form" name="frmLineup" class="chkData" autocomplete="off">
                    <input type="hidden" name="sorting" />
                    <div class="modal-body">
                        <p class="small-text">프로젝트 정렬 순서를 정해주세요.</p>
                        <div class="row">
                            <div class="col-sm-12">
                                <table id="project_sort" class="table basic table-striped dataTable dataListTable">
                                    <thead>
                                    <tr>
                                        <th style="width:5%" class="v-align-middle text-left">No.</th>
                                        <th>종목명</th>
                                        <th style="width:25%">발행인</th>
                                        <th style="width:12%">모집상태</th>
                                        <th style="width:15%" class="sort" sort="reg_date">등록일</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                        <#if projects?has_content>
                                            <#list projects as project>
                                            <tr projectId="${(project.projectId) !}">
                                                <td class="v-align-middle text-center num">${(project_index)+1 !}</td>
                                                <td class="v-align-middle">${(project.sbscIssNm) !}</td>
                                                <td class="v-align-middle text-center">${(project.name) !}</td>
                                                <td class="v-align-middle text-center">
                                                    <#function fnSuccessStateName successState>
                                                        <#switch successState>
                                                            <#case "ing">
                                                                <#return "진행중">
                                                                <#break>
                                                            <#case "finish">
                                                                <#return "마감">
                                                                <#break>
                                                            <#case "success">
                                                                <#return "성공">
                                                                <#break>
                                                            <#case "fail">
                                                                <#return "실패">
                                                                <#break>
                                                            <#default> <!--ready-->
                                                                <#return "대기">
                                                        </#switch>
                                                    </#function>
                                                    ${fnSuccessStateName(project.successState)}
                                                </td>
                                                <td class="v-align-middle text-center">${project.regDate?string("yyyy-MM-dd")}</td>
                                            </tr>
                                            </#list>
                                        <#else>
                                        <tr>
                                            <td colspan="5" class="text-center" style="padding: 50px 0;">등록된 데이터가 없습니다.</td>
                                        </tr>
                                        </#if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input type="button" id="btn_change" class="btn btn-primary" style="margin-right:0;" value="Submit" />
                    </div>
                </form>
            </div>
            <!-- /.modal-content -->
        </div>
    </@layout.put>


    <@layout.put block="script">
    <script type="text/javascript">
        $( document ).ready(function() {

            //Make diagnosis table sortable
            $("#project_sort tbody").sortable({
                helper: fixHelperModified,
                stop: function(event,ui) {renumber_table('#project_sort')}
            }).disableSelection();


            $('#btn_change').click(function(){
                var projectIds = $('input[name=sorting]').val();

                NoticeCommon.Dialog.confirm({
                    content: '변경된 순서로<br/>프로젝트를 정렬 하시겠습니까?'
                    ,ok: function(){
                        $.ajax({
                            url: "/project/lineup",
                            type: "POST",
                            dataType: 'json',
                            data: "projectIds="+projectIds,
                            error: function (result) {
                                console.log(result);
                            }
                        });
                    }
                });
            });
        });

        //Helper function to keep table row from collapsing when being sorted
        var fixHelperModified = function(e, tr) {
            var $originals = tr.children();
            var $helper = tr.clone();
            $helper.children().each(function(index)
            {
                $(this).width($originals.eq(index).width())
            });
            return $helper;
        };

        //Renumber table rows
        function renumber_table(tableID) {

            var project_ids = "";

            $(tableID + " tr").each(function()
            {
                var count = $(this).parent().children().index($(this)) + 1;
                $(this).find('.num').html(count);

                var projectId = $(this).attr('projectId');

                if(projectId) {
                    if(project_ids) project_ids += ",";
                    project_ids += projectId;
                }
            });

            $('input[name=sorting]').val(project_ids);
        }
    </script>
    </@layout.put>

</@layout.extends>