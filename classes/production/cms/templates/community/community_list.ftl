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
                    <li><a href="/community/list">Community</a></li>
                    <li><a class="active">List</a></li>
                </ul>
                <!-- END BREADCRUMB -->
            </div>
            <div class="row">
                <div class="panel panel-transparent">
                    <div class="panel-header">
                        <div class="no-padding m-b-10">
                            <h3>Community List</h3>
                            <p>WiCrowd 커뮤니티 목록을 보는 페이지 입니다.</p>
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

                <div id="community_list_div" class="table-responsive m-t-30">
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
            </div>
        </div>
        <!-- END PANEL -->
    </div>
    </@layout.put>


    <@layout.put block="script">
    <script type="text/javascript">
        var mainId = 10, subId = 0;
        $( document ).ready(function() {

            var paging = new Paging('#community_list_div', '#community_list_table', '/community/list_div', 'reg_date', 'desc', '#search_form', function(){

            });

            paging.initPaging();

            // 프로젝트 삭제 버튼
            $("button.delete").click(function()
            {
                var community_ids = "";
                var community_count = 0;

                $("#community_list_table tbody .unit").each(function() {
                    if($(this).is(':checked'))
                    {
                        if(community_count == 0) {
                            community_ids = $(this).parent().parent().parent().attr('community_id');
                        } else {
                            community_ids += ',' + $(this).parent().parent().parent().attr('community_id');
                        }
                        community_count++;
                    }
                });

                if(community_count == 0) {
                    NoticeCommon.Dialog.alert('체크박스를 선택해주세요.');
                    return false;
                } else {
                    NoticeCommon.Dialog.confirm({
                        content: '선택된 커뮤니티를 삭제하시겠습니까?'
                        ,ok: function(){
                            $.ajax({
                                url: "/community?communityIds="+community_ids,
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
                document.location.href = '/community/list';
            });
        });
    </script>
    </@layout.put>

</@layout.extends>