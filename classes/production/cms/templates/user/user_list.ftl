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
                    <li><a class="active">List</a></li>
                </ul>
                <!-- END BREADCRUMB -->
            </div>
            <div class="row">
                <div class="panel panel-transparent">
                    <div class="panel-header">
                        <div class="no-padding m-b-10">
                            <h3>User</h3>
                            <p>WiCrowd 회원 목록을 보는 페이지 입니다.</p>
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

                        <div class="col-sm-5" style="padding-left:0;">
                            <div class="pull-left">
                                <select name="adminType" class="cs-select cs-skin-slide m-r-15" data-init-plugin="cs-select">
                                    <option value="">사용자 타입</option>
                                    <option value="EMP">일반</option>
                                    <option value="DEPT">부서관리자</option>
                                    <option value="HR">인사관리자</option>
                                    <option value="RECORD">실적관리자</option>
                                    <option value="ADMIN">시스템관리자</option>
                                </select>
                            </div>

                            <div class="datepicker-component input-daterange input-group">
                                <input type="text" class="form-control" name="regStDt" placeholder="${.now?string("yyyy-MM-dd")}" data-format="yyyy-mm-dd"/>
                                <span class="input-group-addon">to</span>
                                <input type="text" class="form-control" name="regNdDt" placeholder="${.now?string("yyyy-MM-dd")}" data-format="yyyy-mm-dd"/>
                            </div>
                        </div>

                        <div class="col-sm-2" style="padding-left:0;">
                            <input type="text" class="form-control" name="keyword" placeholder="Search">
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

                <div class="clearfix m-t-20">
                    <div class="pull-left">
                        <button class="btn btn-danger btn-cons pull-left delete" style="min-width:100px;">
                            <i class="pg-trash"></i> <span>Delete</span>
                        </button>
                    </div>

                    <div class="pull-right">
                        <a href="/user/form" class="btn btn-info btn-cons pull-right" style=" min-width:100px;">
                            <i class="fa fa-plus"></i> <span>Add User</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <!-- END PANEL -->
    </div>
    </@layout.put>


    <@layout.put block="script">
    <script type="text/javascript">
        var mainId = 1, subId = 1;
        $( document ).ready(function() {


            var paging = new Paging('#paging_div', '#user_list', '/user/list_div', 'reg_date', 'desc', '#search_form', function(){

            });

            paging.initPaging();


            $('#search_form').submit(function(){

                paging.params = $(this).serialize();
                paging.url = '/user/list_div?sort='+paging.sortField+','+paging.sortOrder;
                paging.loadDiv();

                return false;
            });

            $(document).on('click', '#user_list .link', function(){
                var user_id = $(this).parent().parent().attr('user_id');
                location.replace('/user/form?userId='+user_id);
            });

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