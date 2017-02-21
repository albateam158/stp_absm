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
                    <li><a>사내게시판</a></li>
                    <li><a class="active">공지사항</a></li>
                </ul>
                <!-- END BREADCRUMB -->
            </div>
            <div class="row">
                <div class="panel panel-transparent">
                    <div class="panel-header">
                        <div class="no-padding m-b-10">
                            <h3>공지사항</h3>
                            <p>사내 공지사항을 보는 페이지 입니다.</p>
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

                <div id="record_list_div" class="table-responsive m-t-30">
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
                        <a href="/record/form" class="btn btn-info btn-cons pull-right" style="min-width:100px;">
                            <i class="fa fa-plus"></i> <span>Add record</span>
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
        var mainId = 6, subId = 1;
        $( document ).ready(function() {

            var paging = new Paging('#record_list_div', '#record_list_table', '/records/list_div', 'reg_date', 'desc', '#search_form', function(){

            });

            paging.initPaging();


            // 공지사항 삭제 버튼
            $("button.delete").click(function()
            {
                var record_ids = "";
                var record_count = 0;

                $("#record_list_table tbody .unit").each(function() {
                    if($(this).is(':checked'))
                    {
                        if(record_count == 0) {
                            record_ids = $(this).parent().parent().parent().attr('record_id');
                        } else {
                            record_ids += ',' + $(this).parent().parent().parent().attr('record_id');
                        }
                        record_count++;
                    }
                });

                if(record_count == 0) {
                    NoticeCommon.Dialog.alert('체크박스를 선택해주세요.');
                    return false;
                } else {
                    NoticeCommon.Dialog.confirm({
                        content: '선택된 공지사항을 삭제하시겠습니까?'
                        ,ok: function(){
                            $.ajax({
                                url: "/record?recordIds="+record_ids,
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
        });
    </script>
    </@layout.put>

</@layout.extends>