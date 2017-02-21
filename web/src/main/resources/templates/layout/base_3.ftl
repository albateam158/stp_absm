<!DOCTYPE html>
<html>
<head>
<@layout.block name="head">
    <meta http-equiv="content-type" content="text/html;charset=UTF-8" />
    <meta charset="utf-8" />
    <title>KOREA ASSET MANAGEMENT SYSTEM</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <link rel="apple-touch-icon" href="/pages/ico/60.png">
    <link rel="apple-touch-icon" sizes="76x76" href="/pages/ico/76.png">
    <link rel="apple-touch-icon" sizes="120x120" href="/pages/ico/120.png">
    <link rel="apple-touch-icon" sizes="152x152" href="/pages/ico/152.png">
    <link rel="icon" type="image/x-icon" href="/assets/img/favicon.ico" />
    <link rel="shortcut icon" type="image/x-icon" href="/assets/img/favicon.ico" />
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-touch-fullscreen" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="default">
    <meta content="" name="description" />
    <meta content="" name="author" />
    <link href="/assets/plugins/pace/pace-theme-flash.css" rel="stylesheet" type="text/css" />
    <link href="/assets/plugins/boostrapv3/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/assets/plugins/font-awesome/css/font-awesome.css" rel="stylesheet" type="text/css" />
    <link href="/assets/plugins/jquery-scrollbar/jquery.scrollbar.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="/assets/plugins/bootstrap-select2/select2.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="/assets/plugins/jquery-datatable/media/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <link href="/assets/plugins/jquery-datatable/extensions/FixedColumns/css/dataTables.fixedColumns.min.css" rel="stylesheet" type="text/css" />
    <link href="/assets/plugins/datatables-responsive/css/datatables.responsive.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="/assets/plugins/dropzone/css/dropzone.css" rel="stylesheet" type="text/css" />
    <link href="/assets/plugins/bootstrap-datepicker/css/datepicker3.css" rel="stylesheet" type="text/css" media="screen">
    <link href="/assets/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css" rel="stylesheet" type="text/css" media="screen">
    <link href="/assets/plugins/bootstrap3-wysihtml5/bootstrap3-wysihtml5.min.css" rel="stylesheet" type="text/css" />
    <link href="/assets/plugins/summernote/css/summernote.css" rel="stylesheet" type="text/css" media="screen">
    <link href="/assets/plugins/font-awesome/css/font-awesome.css" rel="stylesheet" type="text/css" />
    <link href="/pages/css/pages-icons.css" rel="stylesheet" type="text/css">
    <link href="/pages/css/pages.css" class="main-stylesheet" rel="stylesheet" type="text/css" />
    <link href="/assets/css/style.css" rel="stylesheet" type="text/css">
    <link href="/assets/plugins/switchery/css/switchery.min.css" rel="stylesheet" type="text/css" media="screen" />
    <link rel="stylesheet" href="/xeditor/css/xeditor.css">
    <link rel="stylesheet" href="/assets/local_css/common.css">
    <!--[if lte IE 9]>
    <link href="/pages/css/ie9.css" rel="stylesheet" type="text/css" />
    <![endif]-->
    <!--[if lt IE 9]>
    <link href="/assets/plugins/mapplic/css/mapplic-ie.css" rel="stylesheet" type="text/css" />
    <![endif]-->
    <script type="text/javascript">
        window.onload = function()
        {
            // fix for windows 8
            if (navigator.appVersion.indexOf("Windows NT 6.2") != -1)
                document.head.innerHTML += '<link rel="stylesheet" type="text/css" href="/pages/css/windows.chrome.fix.css" />'
        }
    </script>
</@layout.block>
</head>
<body class="fixed-header  dashboard ">
<!-- BEGIN SIDEBPANEL-->
<nav class="page-sidebar" data-pages="sidebar">
    <!-- BEGIN SIDEBAR MENU HEADER-->
    <div class="sidebar-header">
        <img src="/assets/img/cms_logo2.png" alt="logo" class="brand m-t-10" data-src="/assets/img/cms_logo2.png" data-src-retina="/assets/img/cms_logo2.png" width="100">
        <div class="sidebar-header-controls">
            <#--<button type="button" class="btn btn-xs sidebar-slide-toggle btn-link m-l-20" data-pages-toggle="#appMenu">-->
                <#--<i class="fa fa-angle-down fs-16"></i>-->
            <#--</button>-->
            <button type="button" class="btn btn-link visible-lg-inline" data-toggle-pin="sidebar">
                <i class="fa fs-12"></i>
            </button>
        </div>
    </div>

    <!-- END SIDEBAR MENU -->
</nav>
<!-- END SIDEBAR -->
<!-- END SIDEBPANEL-->

<!-- START PAGE-CONTAINER -->
<div class="page-container">
    <!-- START HEADER -->
    <div class="header ">
        <!-- START MOBILE CONTROLS -->
        <!-- LEFT SIDE -->
        <div class="pull-left full-height visible-sm visible-xs">
            <!-- START ACTION BAR -->
            <div class="sm-action-bar">
                <a href="#" class="btn-link toggle-sidebar" data-toggle="sidebar">
                    <span class="icon-set menu-hambuger"></span>
                </a>
            </div>
            <!-- END ACTION BAR -->
        </div>
        <!-- RIGHT SIDE -->
        <div class="pull-right full-height visible-sm visible-xs">
            <!-- START ACTION BAR -->
            <div class="sm-action-bar">
                <a href="#" class="btn-link" data-toggle="quickview" data-toggle-element="#quickview">
                    <span class="icon-set menu-hambuger-plus"></span>
                </a>
            </div>
            <!-- END ACTION BAR -->
        </div>
        <!-- END MOBILE CONTROLS -->
        <div class=" pull-left sm-table">
            <div class="header-inner">
                <div class="brand inline">
                    <img src="/assets/img/logo.png" alt="logo" data-src="/assets/img/logo.png" data-src-retina="/assets/img/logo.png" width="100">
                </div>
            </div>
        </div>
        <div class=" pull-right">
            <!-- START User Info-->
            <div class="visible-lg visible-md m-t-20">
            </div>
            <!-- END User Info-->
        </div>
    </div>
    <!-- END HEADER -->

    <!-- START PAGE CONTENT WRAPPER -->
    <div class="page-content-wrapper">
        <!-- START PAGE CONTENT -->
        <div class="content sm-gutter">
            <!-- START CONTAINER FLUID -->
            <div class="container-fluid padding-25 sm-padding-10">
                <div class="row">
                <@layout.block name="contents">
                </@layout.block>
                </div>
            </div>
            <!-- END CONTAINER FLUID -->
        </div>
        <!-- END PAGE CONTENT -->

        <!-- START COPYRIGHT -->
        <!-- START CONTAINER FLUID -->
    <@layout.block name="footer">
        <div class="container-fluid container-fixed-lg footer">
            <div class="copyright sm-text-center">
                <p class="small no-margin pull-left sm-pull-reset">
                    <span class="hint-text">Copyright © 2016 </span>
                    <span class="font-montserrat">KOREA ASSET MANAGEMENT SYSTEM</span>.
                    <span class="hint-text">All rights reserved. </span>
                </p>
                <div class="clearfix"></div>
            </div>
        </div>
    </@layout.block>
        <!-- END COPYRIGHT -->
    </div>
    <!-- END PAGE CONTENT WRAPPER -->
</div>
<!-- END PAGE CONTAINER -->

<#--Modal Up-->
<div class="modal fade stick-up" id="modalDiv" tabindex="-1" role="dialog" aria-labelledby="addNewAppModal" aria-hidden="true">
</div>

<#--Modal Center-->
<div class="modal fade slide-up disable-scroll" id="modalSlideUpDiv" tabindex="-1" role="dialog" aria-hidden="false">
</div>

<!-- Modal -->
<div class="modal fade slide-up disable-scroll" id="adminFormDiv" tabindex="-1" role="dialog" aria-hidden="false">
    <div class="modal-dialog ">
        <div class="modal-content-wrapper">
            <div class="modal-content">
                <div class="modal-header clearfix text-left">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="pg-close fs-14"></i>
                    </button>
                    <h5>관리자 정보 수정</h5>
                </div>
                <div class="modal-body">
                    <form role="form">
                        <input type="hidden" name="adminId" value="${(user.adminId) !}">
                        <div class="form-group-attached">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group form-group-default">
                                        <label>이름</label>
                                        <input type="text" class="form-control" name="adminName" value="${(user.name) !}">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group form-group-default">
                                        <label>비밀번호</label>
                                        <input type="password" class="form-control" name="adminPassword">
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group form-group-default">
                                        <label>비밀번호 확인</label>
                                        <input type="password" class="form-control" name="adminPasswordCheck">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    <div class="row">
                        <div class="col-sm-8">
                            <div class="p-t-20 clearfix p-l-10 p-r-10">
                                <div class="pull-left">

                                </div>
                                <div class="pull-right">

                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4 m-t-10 sm-m-t-10">
                            <button type="button" class="btn btn-primary btn-block m-t-5 btn_admin_submit">확인</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
</div>

<#--<div class="loading wrap none">-->
    <#--<p class="blockUi"></p>-->
    <#--<div><img src="/assets/img/bx_loader.gif" /></div>-->
<#--</div>-->


<@layout.block name="modal">
</@layout.block>


<!-- BEGIN VENDOR JS -->
<script src="/assets/plugins/pace/pace.min.js" type="text/javascript"></script>
<script src="/assets/plugins/jquery/jquery-1.11.1.min.js" type="text/javascript"></script>
<script src="/assets/plugins/modernizr.custom.js" type="text/javascript"></script>
<script src="/assets/plugins/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
<script src="/assets/plugins/boostrapv3/js/bootstrap.min.js" type="text/javascript"></script>
<script src="/assets/plugins/jquery/jquery-easy.js" type="text/javascript"></script>
<script src="/assets/plugins/jquery-scrollbar/jquery.scrollbar.min.js" type="text/javascript"></script>
<script src="/assets/plugins/bootstrap-select2/select2.min.js" type="text/javascript"></script>
<script src="/assets/plugins/classie/classie.js" type="text/javascript"></script>
<script src="/assets/plugins/jquery-inputmask/jquery.inputmask.min.js" type="text/javascript"></script>
<script src="/assets/plugins/jquery-validation/js/jquery.validate.js" type="text/javascript"></script>
<script src="/assets/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js" type="text/javascript"></script>
<script src="/assets/plugins/bootstrap-daterangepicker/daterangepicker.js" type="text/javascript"></script>
<script src="/assets/plugins/summernote/js/summernote.js" type="text/javascript"></script>
<script src="/assets/plugins/bootstrap3-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
<script src="/assets/plugins/switchery/js/switchery.min.js" type="text/javascript"></script>
<script src="/assets/js/md5.min.js"></script>
<script src="/assets/js/jquery.hc-sticky.js"></script>
<!-- END VENDOR JS -->
<!-- BEGIN CORE TEMPLATE JS -->
<script src="/pages/js/pages.min.js"></script>
<!-- END CORE TEMPLATE JS -->
<!-- BEGIN PAGE LEVEL JS -->
<@layout.block name="script">
<script src="/assets/local_js/common.js" type="text/javascript"></script>
<script src="/assets/local_js/paging.js" type="text/javascript"></script>
<script src="/assets/local_js/x_upload.js" type="text/javascript"></script>

<script>
    $(document).ready(function () {
        $('#adminForm').click(function() {
            $('#adminFormDiv').modal('show');
        });


        $('.btn_admin_submit').click(function () {
            var adminId = $('input[name=adminId]').val()
            var name = $('input[name=adminName]').val();
            var password = $('input[name=adminPassword]').val();
            var passwordCheck = $('input[name=adminPasswordCheck]').val();

            if(name == '') {
                NoticeCommon.Dialog.alert('이름을 입력해주세요.');
            }
            else if(password == '') {
                NoticeCommon.Dialog.alert('비밀번호를 입력해주세요.');
            }
            else if(passwordCheck == '') {
                NoticeCommon.Dialog.alert('비밀번호 확인란을 입력해주세요.');
            }
            else if(password != passwordCheck) {
                NoticeCommon.Dialog.alert('비밀번호가 서로 다릅니다.');
            }
            else {
                $.ajax({
                    url : '/admin/form',
                    type : 'post',
                    data : 'adminId='+adminId+'&name='+name+'&password='+ password,
                    success : function(data) {
                        console.log(data);
                        NoticeCommon.Dialog.alert('수정되었습니다.');
                        $('#adminFormDiv').modal('hide');
                        $('#adminForm').text(name);
                    }
                });
            }
        });
    });
</script>
</@layout.block>
<!-- END PAGE LEVEL JS -->
</body>
</html>