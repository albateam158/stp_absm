<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="content-type" content="text/html;charset=UTF-8" />
    <meta charset="utf-8" />
    <title>KOREA ASSET MANAGEMENT SYSTEM</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <link rel="apple-touch-icon" href="pages/ico/60.png">
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
    <link href="/assets/plugins/switchery/css/switchery.min.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="/pages/css/pages-icons.css" rel="stylesheet" type="text/css">
    <link class="main-stylesheet" href="/pages/css/pages.css" rel="stylesheet" type="text/css" />
    <link href="/assets/css/style.css" rel="stylesheet" type="text/css">
    <!--[if lte IE 9]>
    <link href="/pages/css/ie9.css" rel="stylesheet" type="text/css" />
    <![endif]-->
    <script type="text/javascript">
        window.onload = function()
        {
            // fix for windows 8
            if (navigator.appVersion.indexOf("Windows NT 6.2") != -1)
                document.head.innerHTML += '<link rel="stylesheet" type="text/css" href="/pages/css/windows.chrome.fix.css" />'
        }
    </script>
</head>
<body class="fixed-header   ">
<!-- START PAGE-CONTAINER -->
<div class="login-wrapper ">
    <!-- START Login Background Pic Wrapper-->
    <div class="bg-pic">
        <!-- START Background Pic-->
        <img src="/assets/img/intro-bg3.jpg" data-src="/assets/img/intro-bg3.jpg" data-src-retina="/assets/img/intro-bg3.jpg" alt="" class="lazy">
        <!-- END Background Pic-->
        <!-- START Background Caption-->
        <#--<div class="bg-caption pull-bottom sm-pull-bottom text-white p-l-20 m-b-20">-->
            <#--<h2 class="semi-bold text-white">-->
                <#--Pages make it easy to enjoy what matters the most in the life</h2>-->
            <#--<p class="small">-->
                <#--images Displayed are solely for representation purposes only, All work copyright of respective owner, otherwise © 2013-2014 REVOX.-->
            <#--</p>-->
        <#--</div>-->
        <!-- END Background Caption-->
    </div>
    <!-- END Login Background Pic Wrapper-->
    <!-- START Login Right Container-->
    <div class="login-container bg-white">
        <div class="p-l-50 m-l-20 p-r-50 m-r-20 p-t-50 m-t-30 sm-p-l-15 sm-p-r-15 sm-p-t-40">
            <img src="/assets/img/logo.png" alt="logo" data-src="/assets/img/logo.png" data-src-retina="/assets/img/logo.png" width="200">
            <#--<p class="p-t-35">Sign into your pages account</p>-->
            <!-- START Login Form -->
            <form id="form-login" action="/auth" method="post" class="p-t-15" role="form" autocomplete="off">
                <!-- START Form Control-->
                <div class="form-group form-group-default">
                    <label>Login</label>
                    <div class="controls">
                        <input type="text" name="username" placeholder="이메일" class="form-control" required>
                    </div>
                </div>
                <!-- END Form Control-->
                <!-- START Form Control-->
                <div class="form-group form-group-default">
                    <label>Password</label>
                    <div class="controls">
                        <input type="password" name="password" placeholder="비밀번호" class="form-control" required>
                    </div>
                </div>

                <#if message?exists >
                <div class="row">
                    <p class="warning"><i class="fa fa-warning"></i> ${message}</p>
                </div>
                </#if>
                <!-- START Form Control-->
                <div class="row">
                    <div class="col-md-6 no-padding">
                        <div class="checkbox ">
                            <input type="checkbox" name="remember-me" id="remember-me">
                            <label for="remember-me">로그인유지</label>
                        </div>
                    </div>
                    <#--<div class="col-md-6 text-right">-->
                        <#--<a href="#" class="text-info small">Help? Contact Support</a>-->
                    <#--</div>-->
                </div>
                <!-- END Form Control-->
                <input type="submit" class="btn btn-primary m-t-10" value="Sign in">
            </form>
            <!--END Login Form-->
            <#--<div class="pull-bottom sm-pull-bottom">-->
                <#--<div class="m-b-30 p-r-80 sm-m-t-20 sm-p-r-15 sm-p-b-20 clearfix">-->
                    <#--<div class="col-sm-3 col-md-2 no-padding m-r-10">-->
                        <#--<img alt="" class="m-t-5" data-src="/assets/img/pages_icon.png" data-src-retina="/assets/img/pages_icon_2x.png" height="60" src="/assets/img/pages_icon.png" width="60">-->
                    <#--</div>-->
                    <#--<div class="col-sm-9 no-padding">-->
                        <#--<p><small>-->
                            <#--Create a pages account. If you have a facebook account, log into it for this process. Sign in with <a href="#" class="text-info">Facebook</a> or <a href="#" class="text-info">Google</a></small>-->
                        <#--</p>-->
                    <#--</div>-->
                <#--</div>-->
            <#--</div>-->
        </div>
    </div>
    <!-- END Login Right Container-->
</div>
<!-- END PAGE CONTAINER -->
<!-- BEGIN VENDOR JS -->
<script src="/assets/plugins/pace/pace.min.js" type="text/javascript"></script>
<script src="/assets/plugins/jquery/jquery-1.11.1.min.js" type="text/javascript"></script>
<script src="/assets/plugins/modernizr.custom.js" type="text/javascript"></script>
<script src="/assets/plugins/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
<script src="/assets/plugins/boostrapv3/js/bootstrap.min.js" type="text/javascript"></script>
<script src="/assets/plugins/jquery/jquery-easy.js" type="text/javascript"></script>
<script src="/assets/plugins/jquery-unveil/jquery.unveil.min.js" type="text/javascript"></script>
<script src="/assets/plugins/jquery-bez/jquery.bez.min.js"></script>
<script src="/assets/plugins/jquery-ios-list/jquery.ioslist.min.js" type="text/javascript"></script>
<script src="/assets/plugins/jquery-actual/jquery.actual.min.js"></script>
<script src="/assets/plugins/jquery-scrollbar/jquery.scrollbar.min.js"></script>
<script src="/assets/plugins/bootstrap-select2/select2.min.js" type="text/javascript"></script>
<script src="/assets/plugins/classie/classie.js" type="text/javascript"></script>
<script src="/assets/plugins/switchery/js/switchery.min.js" type="text/javascript"></script>
<script src="/assets/plugins/jquery-validation/js/jquery.validate.min.js" type="text/javascript"></script>
<!-- END VENDOR JS -->
<!-- BEGIN CORE TEMPLATE JS -->
<script src="/pages/js/pages.min.js"></script>
<!-- END CORE TEMPLATE JS -->
<!-- BEGIN PAGE LEVEL JS -->
<script src="/assets/js/scripts.js" type="text/javascript"></script>
<!-- END PAGE LEVEL JS -->
<script>
    $(function() {
        $('#form-login').validate();
    })
</script>
</body>
</html>