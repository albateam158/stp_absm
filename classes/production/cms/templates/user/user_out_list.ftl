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
                    <li><a>Home</a></li>
                    <li><a>User</a></li>
                    <li><a>Out</a></li>
                    <li><a class="active">List</a></li>
                </ul>
                <!-- END BREADCRUMB -->
            </div>
            <div class="row">
                <div class="panel panel-transparent">
                    <div class="panel-header">
                        <div class="no-padding m-b-10">
                            <h3>User Out</h3>
                            <p>WiCrowd 탈퇴 회원 목록을 보는 페이지 입니다.</p>
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

                        <div class="col-sm-4" style="padding-left:0;">
                            <div class="datepicker-component input-daterange input-group">
                                <input type="text" class="form-control" name="regStDt" placeholder="${.now?string("yyyy-MM-dd")}" data-format="yyyy-mm-dd"/>
                                <span class="input-group-addon">to</span>
                                <input type="text" class="form-control" name="regNdDt" placeholder="${.now?string("yyyy-MM-dd")}" data-format="yyyy-mm-dd"/>
                            </div>
                        </div>

                        <div class="col-sm-2" style="padding-left:0;">
                            <input type="text" class="form-control" name="keyword" placeholder="Name">
                        </div>

                        <div class="col-sm-1" style="padding-left:0;">
                            <button class="btn btn-primary btn-cons m-b-10 search" type="submit">
                                <i class="pg-search"></i> <span>Search</span>
                            </button>
                        </div>
                    </div>
                </form>

                <div id="paging_div" class="table-responsive m-t-30">
                    <div class="col-sm-12 text-center" style="padding:100px 0;">
                        <div class="progress-circle-indeterminate"></div>
                    </div>
                </div>
            </div>
        </div>
        <!-- END PANEL -->
    </div>
    </@layout.put>


    <@layout.put block="script">
    <script type="text/javascript">
        var mainId = 1, subId = 2;
        $( document ).ready(function() {


            var paging = new Paging('#paging_div', '#user_list', '/user/out/list_div?sort=out_date,desc', 'out_date', 'desc', '#search_form', function(){

            });

            paging.initPaging();


//            $('#search_form').submit(function(){
//
//                paging.setParams($(this).serialize());
//                paging.url = '/user/out/list_div?sort='+paging.sortField+','+paging.sortOrder;
//                paging.goPage();
//
//                return false;
//            });

            // 발행인 삭제 버튼
            $("button.delete").click(function()
            {
                var user_ids = "";
                var user_count = 0;

                $("#user_list tbody .unit").each(function() {
                    if($(this).is(':checked'))
                    {
                        if(user_count == 0) {
                            user_ids = $(this).parent().parent().parent().attr('user_id');
                        } else {
                            user_ids += ',' + $(this).parent().parent().parent().attr('user_id');
                        }
                        user_count++;
                    }
                });

                if(user_count == 0) {
                    NoticeCommon.Dialog.alert('체크박스를 선택해주세요.');
                    return false;
                } else {
                    NoticeCommon.Dialog.confirm({
                        content: '선택된 사용자를 삭제하시겠습니까?'
                        ,ok: function(){
                            $.ajax({
                                url: "/user?userIds=" + user_ids,
                                type: "DELETE",
                                dataType: 'json',
                                success: function (result) {
                                    location.reload();
                                }
                            });
                        }
                    });
                }
            });
        });
    </script>
    </@layout.put>

</@layout.extends>