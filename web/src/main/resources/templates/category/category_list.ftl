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
                    <li><a class="active">Category</a></li>
                </ul>
                <!-- END BREADCRUMB -->
            </div>
            <div class="row">
                <div class="panel panel-transparent">
                    <div class="panel-header">
                        <div class="no-padding m-b-10">
                            <h3>Category</h3>
                            <p>카테고리 목록및 등록/수정을 할 수 있는 페이지입니다.</p>
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
                <div id="category_list_div" class="table-responsive m-t-20"></div>

                <div class="clearfix m-t-20">
                    <div class="pull-left">
                        <button class="btn btn-danger btn-cons pull-left delete" style="min-width:100px;">
                            <i class="pg-trash"></i> <span>Delete</span>
                        </button>
                    </div>

                    <div class="pull-right">
                        <button id="btn_add_category" class="btn btn-info btn-cons pull-right">
                            <i class="fa fa-plus"></i> <span>Add Category</span>
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
        var mainId = 3, subId = 0;
        $( document ).ready(function() {
            //Make diagnosis table sortable
//            $("#category_list tbody").sortable({
//                helper: fixHelperModified,
//                stop: function(event,ui) {renumber_table('#category_list')}
//            }).disableSelection();
//
//            //Helper function to keep table row from collapsing when being sorted
//            var fixHelperModified = function(e, tr) {
//                var $originals = tr.children();
//                var $helper = tr.clone();
//                $helper.children().each(function(index)
//                {
//                    $(this).width($originals.eq(index).width())
//                });
//                return $helper;
//            };

            // 카테고리 등록 버튼
            $("#btn_add_category").click(function()
            {
                $("#modalDiv").load("/category/form", function(responseTxt, statusTxt, xhr){
                    if(statusTxt == "success") {
                        $('#modalDiv').modal('show');
                        $('#modalDiv h4.category-title').html('<span class="semi-bold">New</span> Category');
                    }
                    //alert("External content loaded successfully!");
                    if(statusTxt == "error")
                        alert("Error: " + xhr.status + ": " + xhr.statusText);
                });
            });

            // 카테고리 수정 버튼
            $(document).on("click", "button.modify", function()
            {
                var category_id = $(this).parent().parent().attr('category_id');

                $("#modalDiv").load("/category/form?categoryId=" + category_id, function(responseTxt, statusTxt, xhr){
                    if(statusTxt == "success") {

                        $('#modalDiv').modal('show');
                        $('#modalDiv h4.category-title').html('<span class="semi-bold">Update</span> Category');
                    }

                    //alert("External content loaded successfully!");
                    if(statusTxt == "error")
                        alert("Error: " + xhr.status + ": " + xhr.statusText);
                });
            });

            // 카테고리 삭제 버튼
            $("button.delete").click(function()
            {
                var category_ids = "";
                var category_count = 0;

                $("#category_list_table tbody .unit").each(function() {
                    if($(this).is(':checked'))
                    {
                        if(category_count == 0) {
                            category_ids = $(this).parent().parent().parent().attr('category_id');
                        } else {
                            category_ids += ',' + $(this).parent().parent().parent().attr('category_id');
                        }
                        category_count++;
                    }
                });

                if(category_count == 0) {
                    NoticeCommon.Dialog.alert('체크박스를 선택해주세요.');
                    return false;
                } else {
                    NoticeCommon.Dialog.confirm({
                        content: '카테고리를 삭제하시겠습니까?'
                        ,ok: function(){
                            $.ajax({
                                url: "/category?categoryIds="+category_ids,
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

            var paging = new Paging('#category_list_div', '#category_list_table', '/category/list_div', 'category_id', 'asc', null, function(){

//                // 테이블 정렬
//                var sort = new Sort('#category_list_table', paging.sortField, paging.sortOrder, function(sortField, sortOrder){
//
//                    paging.sortField = sortField;
//                    paging.sortOrder = sortOrder;
//                    paging.url = '/category/list_div?sort=' +sortField + "," + sortOrder;
//                    paging.goPage();
//                });
//
//                sort.initSort();
            });

            paging.initPaging();

        });

        //Renumber table rows
        function renumber_table(tableID) {

            var order_nos = "" ;

            $(tableID + " tr").each(function() {

                count = $(this).parent().children().index($(this)) + 1;
                $(this).find('.order_no').text(count);

                var order_no = $(this).find('.order_no').text();

                if( order_no ){
                    order_nos += order_no + ",";
                }
            });

            $.ajax({
                url : "/category/order",
                type: "POST",
                dataType:'json',
                data: { order_no: order_nos }
            });
        }
    </script>
    </@layout.put>

</@layout.extends>