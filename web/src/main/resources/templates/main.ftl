<@layout.extends name="layout/base.ftl">
    <@layout.put block="head">

    </@layout.put>
    <@layout.put block="contents">
    <!-- START JUMBOTRON -->
    <div class="jumbotron" data-pages="parallax">
        <div class="container-fluid container-fixed-lg sm-p-l-20 sm-p-r-20">
            <div class="row">
                <!-- START BREADCRUMB -->
                <ul class="breadcrumb">
                    <li><a>Home</a></li>
                    <li><a>Application</a></li>
                    <li><a class="active">List</a></li>
                </ul>
                <!-- END BREADCRUMB -->
            </div>
            <div class="row">
                <div class="panel panel-transparent">
                    <div class="panel-header">
                        <div class="no-padding m-b-10">
                            <h3>Application</h3>
                            <p>WiCrowd 투자모집 목록을 보는 페이지 입니다.</p>
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
                <h5>#투자모집 목록</h5>

                <div class="clearfix p-t-20">
                    <div class="col-xs-4" style="padding-left:0;">
                        <div class="datepicker-component input-daterange input-group">
                            <input type="text" class="form-control" name="start_date" data-format="yyyy-mm-dd"/>
                            <span class="input-group-addon">to</span>
                            <input type="text" class="form-control" name="end_date" data-format="yyyy-mm-dd"/>
                        </div>
                    </div>

                    <div class="col-xs-2" style="padding-left:0;">
                        <input type="text" class="form-control" name="search_word" placeholder="Search">
                    </div>

                    <div class="col-xs-1" style="padding-left:0;">
                        <button class="btn btn-primary btn-cons m-b-10 search" type="button">
                            <i class="pg-search"></i> <span>Search</span>
                        </button>
                    </div>
                </div>

                <div id="paging_div" class="table-responsive m-t-30">
                    <div class="col-sm-12 text-center" style="padding:100px 0;">
                        <div class="progress-circle-indeterminate"></div>
                    </div>
                </div>

                <div class="clearfix">
                    <div class="pull-left">
                        <button class="btn btn-danger btn-cons pull-left delete" style="min-width:100px;">
                            <i class="pg-trash"></i> <span>Delete</span>
                        </button>
                    </div>

                    <div class="pull-right">
                        <a id="add_theme_button" href="#" class="btn btn-info btn-cons pull-right" style="min-width:100px;">
                            <i class="fa fa-plus"></i> <span>Add Theme</span>
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
        $( document ).ready(function() {

            var paging = new Paging('#paging_div', '/project/list_div');
            paging.initPaging();
        });
    </script>
    </@layout.put>

</@layout.extends>