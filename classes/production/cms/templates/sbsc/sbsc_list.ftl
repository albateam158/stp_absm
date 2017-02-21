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
                    <li><a>Sbsc</a></li>
                    <li><a class="active">List</a></li>
                </ul>
                <!-- END BREADCRUMB -->
            </div>
            <div class="row">
                <div class="panel panel-transparent">
                    <div class="panel-header">
                        <div class="no-padding m-b-10">
                            <h3>청약 목록</h3>
                            <p>WiCrowd 청약 목록을 보는 페이지 입니다.</p>
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
                        <div class="pull-left">
                            <select name="state" class="cs-select cs-skin-slide m-r-15" data-init-plugin="cs-select">
                                <option value="">--- 청약 상태 ---</option>
                                <option value="realtime_ok">청약금액 지불 완료</option>
                                <option value="ksd_cancel">KSD 취소 완료</option>
                                <option value="cancel">청약 취소 완료</option>
                                <option value="pay_complete">청약 완료</option>
                            </select>
                        </div>

                        <div class="col-xs-4" style="padding-left:0;">
                            <div class="datepicker-component input-daterange input-group">
                                <input type="text" class="form-control" name="sbscStDt" placeholder="1970-01-01" data-format="yyyy-mm-dd"/>
                                <span class="input-group-addon">to</span>
                                <input type="text" class="form-control" name="sbscNdDt" placeholder="1970-01-01" data-format="yyyy-mm-dd"/>
                            </div>
                        </div>

                        <div class="col-xs-2" style="padding-left:0;">
                            <input type="text" class="form-control" name="keyword" placeholder="투자자이름">
                        </div>

                        <div class="col-xs-1" style="padding-left:0;">
                            <button class="btn btn-primary btn-cons m-b-10 search" type="submit">
                                <i class="pg-search"></i> <span>Search</span>
                            </button>
                        </div>
                    </div>
                </form>

                <div id="sbsc_list_div" class="table-responsive m-t-30">
                    <div class="col-sm-12 text-center" style="padding:100px 0;">
                        <div class="progress-circle-indeterminate"></div>
                    </div>
                </div>

                <div class="clearfix m-t-20">
                    <#--<div class="pull-left">-->
                        <#--<button class="btn btn-danger btn-cons pull-left delete" style="min-width:100px;">-->
                            <#--<i class="pg-trash"></i> <span>Delete</span>-->
                        <#--</button>-->
                    <#--</div>-->

                    <div class="pull-right">
                        <a href="/sbsc/form" class="btn btn-info btn-cons pull-right" style="min-width:100px;">
                            <i class="fa fa-plus"></i> <span>Add Subscription</span>
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
        var mainId = 5, subId = 0;
        $( document ).ready(function() {

            var paging = new Paging('#sbsc_list_div', '#sbsc_list_table', '/sbsc/list_div', 'reg_date', 'desc', '#search_form', function(){

            });

            paging.initPaging();


            // 보도자료 삭제 버튼
            $("button.delete").click(function()
            {
                var sbsc_ids = "";
                var sbsc_count = 0;

                $("#sbsc_list_table tbody .unit").each(function() {
                    if($(this).is(':checked'))
                    {
                        if(sbsc_count == 0) {
                            sbsc_ids = $(this).parent().parent().parent().attr('sbsc_id');
                        } else {
                            sbsc_ids += ',' + $(this).parent().parent().parent().attr('sbsc_id');
                        }
                        sbsc_count++;
                    }
                });

                if(sbsc_count == 0) {
                    NoticeCommon.Dialog.alert('체크박스를 선택해주세요.');
                    return false;
                } else {
                    NoticeCommon.Dialog.confirm({
                        content: '선택된 보도자료를 삭제하시겠습니까?'
                        ,ok: function(){
                            $.ajax({
                                url: "/sbsc?sbscIds="+sbsc_ids,
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