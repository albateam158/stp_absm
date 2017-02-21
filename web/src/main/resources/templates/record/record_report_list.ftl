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
                    <li><a>실적</a></li>
                    <li><a class="active">보고서</a></li>
                </ul>
                <!-- END BREADCRUMB -->
            </div>
            <div class="row">
                <div class="panel panel-transparent">
                    <div class="panel-header">
                        <div class="no-padding m-b-10">
                            <h3>실적보고서</h3>
                            <p>실적보고서 페이지 입니다.</p>
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

                        <div class="col-sm-9" style="padding-left:0;">
                            <div class="col-sm-3" style="padding-left:0;">
                                <div class="datepicker-component input-daterange input-group">
                                <input type="text" class="form-control" name="dt" id="dt" placeholder="${.now?string("yyyy-MM-dd")}" data-format="yyyy-mm-dd"/>
                                </div>
                            </div>
                            <div class="col-sm-2" style="padding-left:0;">
                            <#--<select name="deptCd" id="deptCd" class="cs-select cs-skin-slide m-r-15" data-init-plugin="cs-select">-->
                                <select name="deptCd" id="deptCd" class="form-control" style="padding: 2px 2px 2px 9px">
                                    <#list dzDepts as dzDept>
                                        <option value="${dzDept.deptCd}" <#if member?exists  && member.deptCd == dzDept.deptCd>selected</#if> >${dzDept.deptNm}</option>
                                    </#list>
                                </select>
                            </div>

                        </div>

                        <#--<div class="col-sm-2" style="padding-left:0;">-->
                            <#--<input type="text" class="form-control" name="keyword" id="keyword" placeholder="사번/이름">-->
                        <#--</div>-->
                        <#--<div class="col-sm-2" style="padding-left:0;">-->
                            <#--<input type="text" class="form-control" name="keyword1" id="keyword1" placeholder="경력사항">-->
                        <#--</div>-->

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
        var mainId = 5, subId = 3;
        $( document ).ready(function() {


            var paging = new Paging('#paging_div', '#record_list_table', '/record/reportList_div', 'dt', 'desc', '#search_form', function(){

            });
            paging.initPaging();

            $( "#dt" ).datepicker( "setDate", getNowTimeStamp() );

            $('#search_form').submit(function(){

                paging.params = $(this).serialize();
                paging.url = '/record/reportList_div?sort='+paging.sortField+','+paging.sortOrder;
                paging.loadDiv();

                return false;
            });

            $(document).on('click', '#record_list_table .link', function(){
                var emp_cd = $(this).parent().parent().attr('emp_cd');
                location.replace('/record/form?empCd='+emp_cd+'&page=' + paging.sortField );
            });
//            $("#keyword").bind("keydown", function(){
//                alert("1");
//                $('#deptCd').val("");
//            });
//
//            $("#keyword").bind("click", function(){
//                $('#deptCd').val("");
//            });
//            $("#keyword1").bind("click", function(){
//                $('#deptCd').val("");
//            });

        });
    </script>
    </@layout.put>

</@layout.extends>