<@layout.extends name="layout/base.ftl">
    <@layout.put block="head">
    <style type="text/css">

    </style>
    </@layout.put>
    <@layout.put block="contents">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            ${kamsBoardSetting.boardName}
            <small>목록</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li><a href="#">${kamsBoardSetting.category1List}</a></li>
            <li class="active">${kamsBoardSetting.boardName}</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-xs-12">
                <div class="box">
                    <div class="box-header">
                        <h3 class="box-title">${kamsBoardSetting.boardName}</h3>
                        <form id="search_form">
                            <input type="hidden" id="boardId" value="${boardId}">

                            <div class="box-tools pull-right">
                                <div class="has-feedback">
                                    <input type="text" class="form-control input-sm" name="keyword"  placeholder="Search">
                                    <span class="glyphicon glyphicon-search form-control-feedback"></span>
                                </div>
                            </div>
                        </form>
                    </div>

                    <!-- /.box-header -->
                    <div class="box-body">
                        <div id="notice_list_div" class="dataTables_wrapper form-inline dt-bootstrap">
                            <div style="padding:100px 0;">
                                <div class="progress-circle-indeterminate"></div>
                            </div>
                        </div>
                    </div>
                    <!-- /.box-body -->
                    <div class="box-footer">
                        <div class="pull-right">
                            <button type="button" class="btn btn-default"><i class="fa fa-pencil"></i> 글수정</button>
                            <button type="button" class="btn btn-primary go-add"><i class="fa fa-envelope-o"></i> 글쓰기</button>
                        </div>
                        <button type="reset" class="btn btn-default"><i class="fa fa-times"></i> 글삭제</button>
                    </div>


                </div>
                <!-- /.box -->

            </div>
            <!-- /.col -->
        </div>
        <!-- /.row -->
    </section>
    <!-- /.content -->

    </@layout.put>





    <@layout.put block="script">
    <!-- DataTables -->

    <script src="/assets/local_js/paging.js" type="text/javascript"></script>
    <script src="/xeditor/js/xeditor.js"></script>
    <script src="/plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="/plugins/datatables/dataTables.bootstrap.min.js"></script>
    <script>
        var cat = "${kamsBoardSetting.category2List}";
        var cats = cat.split("^");
        var boardId = "${boardId}";
        var mainId = cats[0], subId = cats[1];
        $( document ).ready(function() {
            var paging = new Paging('#notice_list_div', '#notice_list_table', '/knotice/list_div/'+boardId, 'date', 'desc', '#search_form', function(){

            });

            paging.initPaging();

            $('#search_form').submit(function(){

                paging.setParams($(this).serialize());
                paging.url = '/knotice/list_div/'+boardId+'?sort='+paging.sortField+','+paging.sortOrder;
                paging.goPage();

                return false;
            });

//            // 공지사항 삭제 버튼
//            $("button.delete").click(function()
//            {
//                var notice_ids = "";
//                var notice_count = 0;
//
//                $("#notice_list_table tbody .unit").each(function() {
//                    if($(this).is(':checked'))
//                    {
//                        if(notice_count == 0) {
//                            notice_ids = $(this).parent().parent().parent().attr('notice_id');
//                        } else {
//                            notice_ids += ',' + $(this).parent().parent().parent().attr('notice_id');
//                        }
//                        notice_count++;
//                    }
//                });
//
//                if(notice_count == 0) {
//                    NoticeCommon.Dialog.alert('체크박스를 선택해주세요.');
//                    return false;
//                } else {
//                    NoticeCommon.Dialog.confirm({
//                        content: '선택된 공지사항을 삭제하시겠습니까?'
//                        ,ok: function(){
//                            $.ajax({
//                                url: "/notice?noticeIds="+notice_ids,
//                                type: "DELETE",
//                                dataType: 'json',
//                                data: '',
//                                success: function (result) {
//                                    paging.initPaging();
//                                },
//                                error: function (result) {
//                                    console.log(result);
//                                }
//                            });
//                        }
//                    });
//                }
//            });


            $(function () {
                $('#notice_list_table').DataTable({
                    "paging": true,
                    "lengthChange": false,
                    "searching": false,
                    "ordering": true,
                    "info": true,
                    "autoWidth": false
                });
            });
            $('.go-add').click(function () {

                location.href = '/knotice/form/'+boardId;

                return false;
            });


        });


    </script>
    </@layout.put>
</@layout.extends>