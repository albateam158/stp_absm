<@layout.extends name="layout/modalBase.ftl">

    <@layout.put block="contents">
        <!-- MODAL dialog  -->
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header clearfix ">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <i class="pg-close fs-14"></i>
                    </button>
                    <h5 class="text-left">비상장주식 정렬</h5>
                </div>

                <form role="form" name="frmLineup" class="chkData" autocomplete="off">
                    <input type="hidden" name="sorting" />
                    <div class="modal-body">
                        <p class="small-text">비상장주식 정렬 순서를 정해주세요.</p>
                        <div class="row">
                            <div class="col-sm-12">
                                <table id="unlisted_sort" class="table basic table-striped dataTable dataListTable">
                                    <thead>
                                    <tr>
                                        <th style="width:5%" class="v-align-middle text-left">No.</th>
                                        <th>종목명</th>
                                        <th style="width:25%">분류</th>
                                        <th style="width:12%">업종</th>
                                        <th style="width:15%" class="sort" sort="reg_date">등록일</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                        <#if unlisteds?has_content>
                                            <#list unlisteds as unlisted>
                                            <tr unlistedId="${(unlisted.unlistedId) !}">
                                                <td class="v-align-middle text-center num">${(unlisted_index)+1 !}</td>
                                                <td class="v-align-middle">${(unlisted.name) !}</td>
                                                <td class="v-align-middle text-center">${(unlisted.sectionName) !}</td>
                                                <td class="v-align-middle text-center">
                                                    ${(unlisted.businessType)}
                                                </td>
                                                <td class="v-align-middle text-center">${unlisted.regDate?string("yyyy-MM-dd")}</td>
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
            $("#unlisted_sort tbody").sortable({
                helper: fixHelperModified,
                stop: function(event,ui) {renumber_table('#unlisted_sort')}
            }).disableSelection();


            $('#btn_change').click(function(){
                var unlistedIds = $('input[name=sorting]').val();

                NoticeCommon.Dialog.confirm({
                    content: '변경된 순서로<br/>비상장주식을 정렬 하시겠습니까?'
                    ,ok: function(){
                        $.ajax({
                            url: "/unlisted/lineup",
                            type: "POST",
                            dataType: 'json',
                            data: "unlistedIds="+unlistedIds,
                            error: function (result) {
                                console.log(result);
                            },
                            success: function (result) {
                                location.reload();
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

            var unlisted_ids = "";

            $(tableID + " tr").each(function()
            {
                var count = $(this).parent().children().index($(this)) + 1;
                $(this).find('.num').html(count);

                var unlistedId = $(this).attr('unlistedId');

                if(unlistedId) {
                    if(unlisted_ids) unlisted_ids += ",";
                    unlisted_ids += unlistedId;
                }
            });

            $('input[name=sorting]').val(unlisted_ids);
        }
    </script>
    </@layout.put>

</@layout.extends>