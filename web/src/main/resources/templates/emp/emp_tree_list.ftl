<@layout.extends name="layout/base_1.ftl">
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
                    <li><a>사내연락망</a></li>
                    <li><a class="active">조직도</a></li>
                </ul>
                <!-- END BREADCRUMB -->
            </div>
            <div class="row">
                <div class="panel panel-transparent">
                    <div class="panel-header">
                        <div class="no-padding m-b-10">
                            <h3>사내연락망</h3>
                            <p>조직도 페이지 입니다.</p>
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
                                <#--<select name="deptCd" id="deptCd" class="cs-select cs-skin-slide m-r-15" data-init-plugin="cs-select">-->
                                <select name="deptCd" id="deptCd" class="form-control" style="padding: 2px 2px 2px 9px">
                                    <option value="">부서</option>
                                    <#list dzDepts as dzDept>
                                    <option value="${dzDept.deptCd}" <#if member?exists  && member.deptCd == dzDept.deptCd>selected</#if> >${dzDept.deptNm}</option>
                                    </#list>
                                </select>
                            </div>

                            <#--<div class="datepicker-component input-daterange input-group">-->
                                <#--<input type="text" class="form-control" name="joinStDt" placeholder="${.now?string("yyyy-MM-dd")}" data-format="yyyy-mm-dd"/>-->
                                <#--<span class="input-group-addon">to</span>-->
                                <#--<input type="text" class="form-control" name="joinNdDt" placeholder="${.now?string("yyyy-MM-dd")}" data-format="yyyy-mm-dd"/>-->
                            <#--</div>-->
                        </div>

                        <div class="col-sm-2" style="padding-left:0;">
                            <input type="text" class="form-control" name="keyword" id="keyword" placeholder="사번/이름">
                        </div>
                        <div class="col-sm-2" style="padding-left:0;">
                            <input type="text" class="form-control" name="keyword1" id="keyword1" placeholder="경력사항">
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
        var mainId = 3, subId = 2;
        $( document ).ready(function() {


            var paging = new Paging('#paging_div', '#emp_list', '/emp/list_div', 'join_dt', 'desc', '#search_form', function(){

            });

            paging.initPaging();


            $('#search_form').submit(function(){

                paging.params = $(this).serialize();
                paging.url = '/emp/list_div?sort='+paging.sortField+','+paging.sortOrder;
                paging.loadDiv();

                return false;
            });

            $(document).on('click', '#emp_list .link', function(){
                var emp_cd = $(this).parent().parent().attr('emp_cd');
                location.replace('/emp/form?empCd='+emp_cd+'&page=' + paging.sortField );
            });
//            $("#keyword").bind("keydown", function(){
//                alert("1");
//                $('#deptCd').val("");
//            });

            $("#keyword").bind("click", function(){
//                alert(  $("#deptCd option").index($("#deptCd option:selected")));
                //$("#deptCd").val("부서").attr("selected", "selected");
//                $("#deptCd option:eq(0)").attr("selected", "selected");
//                $(".cs-selected").removeClass("cs-selected");
//                $(this).attr('data-value').addClass("cs-selected");
//                $("#deptCd option:eq(0)").attr("selected", true);
                //$("ul li:eq(0)").addClass("cs-selected");
//                $("p:last").addClass("cs-selected");
                $('#deptCd').val("");
            });
            $("#keyword1").bind("click", function(){
                $('#deptCd').val("");
            });

        });
    </script>
    </@layout.put>

</@layout.extends>