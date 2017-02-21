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
                    <li><a>사내 규정</a></li>
                    <li><a class="active">조회</a></li>
                </ul>
                <!-- END BREADCRUMB -->
            </div>
            <div class="row">
                <div class="panel panel-transparent">
                    <div class="panel-header">
                        <div class="no-padding m-b-10">
                            <h3>Internal Regulation</h3>
                            <p>사내 규정 조회 페이지 입니다.</p>
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

                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label>구분</label><br/>

                                    <select name="groupId" id="groupId" class="form-control" style="padding: 2px 2px 2px 9px">
                                    <#--<select class="cs-select cs-skin-slide" name="deptCd" data-init-plugin="cs-select" required>-->
                                        <option value="">전체</option>
                                        <#list IRGs as IRG>
                                            <option value="${IRG.data1}" <#if inRule?exists  && inRule.groupId == IRG.data1>selected</#if> >${IRG.codeName}</option>
                                        </#list>
                                    </select>
                                </div>
                            </div>

                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label>소구분</label><br/>

                                    <select name="docGroup" id="docGroup" class="form-control" style="padding: 2px 2px 2px 9px">
                                    <#--<select class="cs-select cs-skin-slide" name="deptCd" data-init-plugin="cs-select" required>-->
                                        <option value="">전체</option>
                                        <#list RDGs as RDG>
                                            <option value="${RDG.data1}" <#if inRule?exists  && inRule.docGroup == RDG.data1>selected</#if> >${RDG.codeName}</option>
                                        </#list>
                                    </select>
                                </div>
                            </div>

                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label>소관부서</label><br/>

                                    <select name="deptCd" id="deptCd" class="form-control" style="padding: 2px 2px 2px 9px">
                                        <option value="">부서</option>
                                        <#list dzDepts as dzDept>
                                            <option value="${dzDept.deptCd}" <#if member?exists  && member.deptCd == dzDept.deptCd>selected</#if> >${dzDept.deptNm}</option>
                                        </#list>
                                    </select>
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label>최근개정일</label><br/>
                                    <div class="datepicker-component input-daterange input-group">
                                        <input type="text" class="form-control" name="stDt" id="stDt" placeholder="${.now?string("yyyy-MM-dd")}" data-format="yyyy-mm-dd"/>
                                        <span class="input-group-addon">to</span>
                                        <input type="text" class="form-control" name="ndDt" id="ndDt"  placeholder="${.now?string("yyyy-MM-dd")}" data-format="yyyy-mm-dd"/>
                                    </div>
                                </div>
                            </div>



                        </div>

                        <#--<div class="col-sm-2" style="padding-left:0;">-->
                            <#--<input type="text" class="form-control" name="keyword" id="keyword" placeholder="사번/이름">-->
                        <#--</div>-->
                        <#--<div class="col-sm-2" style="padding-left:0;">-->
                            <#--<input type="text" class="form-control" name="keyword1" id="keyword1" placeholder="경력사항">-->
                        <#--</div>-->
                        <div class="col-sm-3">
                            <div class="form-group">
                                <br>
                                <button class="btn btn-primary btn-cons m-b-10 search" type="submit">
                                    <i class="pg-search"></i> <span>Search</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
                <div class="col-sm-12" style="padding-right:0;">
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
        var mainId = 3, subId = 1;
        $( document ).ready(function() {


            var paging = new Paging('#paging_div', '#record_list_table', '/inter_rule/list_div', 'docId', 'desc', '#frmData', function(){
            });

            paging.initPaging();

            $( "#stDt" ).datepicker( "setDate", getNowTimeStamp() );
            $( "#ndDt" ).datepicker( "setDate", getNowTimeStamp() );

            $('#search_form').submit(function(){

                paging.params = $(this).serialize();
                paging.url = '/inter_rule/list_div?sort='+paging.sortField+','+paging.sortOrder;
                paging.loadDiv();

                return false;
            });


        });

    </script>
    </@layout.put>

</@layout.extends>