<@layout.extends name="layout/base.ftl">
    <@layout.put block="head">

    </@layout.put>
    <@layout.put block="contents">
    <!-- START JUMBOTRON -->
    <div class="jumbotron" data-pages="parallax">
        <div class="container-fixed-lg">
            <div class="row">
                <!-- START BREADCRUMB -->
                <ul class="breadcrumb">
                    <li><a href="/">Home</a></li>
                    <li><a href="/project/list">Project</a></li>
                    <li><a class="active">Update List</a></li>
                </ul>
                <!-- END BREADCRUMB -->
            </div>
            <div class="row">
                <div class="panel panel-transparent">
                    <div class="panel-header">
                        <div class="no-padding m-b-10">
                            <h3>Update List</h3>
                            <p>WiCrowd ${(project.name) !} 업데이트 목록을 보는 페이지 입니다.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- END JUMBOTRON -->

    <!-- START CONTAINER FLUID -->
    <div class="container-fluid container-fixed-lg bg-white">
        <!-- START PANEL -->
        <div class="panel panel-transparent">
            <div class="panel-body">
                <form id="search_form">
                    <div class="clearfix p-t-20">
                        <div class="col-xs-4" style="padding-left:0;">
                            <div class="datepicker-component input-daterange input-group">
                                <input type="text" class="form-control" name="sbscStDt" placeholder="1970-01-01" data-format="yyyy-mm-dd"/>
                                <span class="input-group-addon">to</span>
                                <input type="text" class="form-control" name="sbscNdDt" placeholder="1970-01-01" data-format="yyyy-mm-dd"/>
                            </div>
                        </div>

                        <div class="col-xs-2" style="padding-left:0;">
                            <input type="text" class="form-control" name="keyword" placeholder="Search">
                        </div>

                        <div class="col-xs-1" style="padding-left:0;">
                            <button class="btn btn-primary btn-cons m-b-10 search" type="submit">
                                <i class="pg-search"></i> <span>Search</span>
                            </button>
                        </div>
                    </div>
                </form>

                <div id="project_update_list_div" class="table-responsive m-t-30">
                    <div class="col-sm-12 text-center" style="padding:100px 0;">
                        <div class="progress-circle-indeterminate"></div>
                    </div>
                </div>

                <div class="clearfix m-t-20">
                    <div class="pull-left">
                        <button class="btn btn-danger btn-cons pull-left delete" style="min-width:100px;">
                            <i class="pg-trash"></i> <span>Delete</span>
                        </button>
                    </div>
                </div>

                <div class="clearfix padding-10">
                    <button class="btn btn-primary btn-cons pull-right m-b-10 go-list" type="button">
                        <i class="pg-form"></i>
                        <span class="bold">List</span>
                    </button>
                </div>
            </div>
        </div>
        <!-- END PANEL -->
    </div>
    </@layout.put>


    <@layout.put block="script">
    <script type="text/javascript">
        var mainId = 2, subId = 0;
        var projectId = ${(project.projectId?default("0")) !};
        $( document ).ready(function() {

            var paging = new Paging('#project_update_list_div', '#project_update_list_table', '/project/'+projectId+'/update/list', 'regDate', 'desc', '#search_form', function(){

            });

            paging.initPaging();

            // 프로젝트 삭제 버튼
            $("button.delete").click(function()
            {
                var project_update_ids = "";
                var project_update_count = 0;

                $("#project_update_list_table tbody .unit").each(function() {
                    if($(this).is(':checked'))
                    {
                        if(project_update_count == 0) {
                            project_update_ids = $(this).parent().parent().parent().attr('update_id');
                        } else {
                            project_update_ids += ',' + $(this).parent().parent().parent().attr('update_id');
                        }
                        project_update_count++;
                    }
                });

                if(project_update_count == 0) {
                    NoticeCommon.Dialog.alert('체크박스를 선택해주세요.');
                    return false;
                } else {
                    NoticeCommon.Dialog.confirm({
                        content: '선택된 프로젝트 업데이트를 삭제하시겠습니까?'
                        ,ok: function(){
                            $.ajax({
                                url: "/project/"+projectId+"/update?projectUpdateIds="+project_update_ids,
                                type: "DELETE",
                                dataType: 'json',
                                data: '',
                                success: function (result) {
                                    paging.initPaging();
                                },
                                error: function (result) {
                                    console.log(result);
                                }
                            });
                        }
                    });
                }
            });

            $('.go-list').click(function () {
                document.location.href = '/project/list';
            });
        });
    </script>
    </@layout.put>

</@layout.extends>