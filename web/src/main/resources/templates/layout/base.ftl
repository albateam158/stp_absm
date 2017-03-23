<!DOCTYPE HTML>
<html lang="ko">
<head>
<@layout.block name="head">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>교통연구원 시안 | 기초자료 및 개인특성 자료 입력</title>
    <link rel="icon" href="/images/favicon.png">
    <link rel="stylesheet" href="/css/reset.css" />
    <link rel="stylesheet" href="/css/font.css" />
    <link rel="stylesheet" href="/css/common.css" />
    <link rel="stylesheet" href="/css/jsgrid.css" />
    <link rel="stylesheet" href="/css/jquery-ui.css" />
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</@layout.block>
</head>
<body>
    <!-- header -->
    <header>
        <div class="inner_box">
            <h1>
                <a href="#"><img src="/images/logo2.gif" alt="홈" /></a>
            </h1>
            <!-- navigation -->
            <nav class="navi">
                <ul>
                    <li class="navi_has">
                        <a href="#"><span class="navi_icon1"></span>자료 입력</a>
                        <div class="navi_sub">
                            <ul>
                                <li><a href="/input/baseline" >기초자료 및 개인특성 자료 입력</a></li>
                                <li><a href="/input/biosignal" >생체신호 측정자료 입력</a></li>
                                <li><a href="/input/event" >이벤트 자료 입력</a></li>
                                <li><a href="/input/video" >동영상 자료 입력</a></li>
                            </ul>
                        </div>
                    </li>
                    <li><a href="/search/search" ><span class="navi_icon2"></span>자료 조회</a></li>
                    <li><a href="/result/result" ><span class="navi_icon3"></span>결과 보기</a></li>
                </ul>
            </nav><!-- //navigation -->
        </div>
    </header>

<!-- END SIDEBAR -->
<!-- END SIDEBPANEL-->
    <!-- Content Wrapper. Contains page content -->
    <div class="content">
    <@layout.block name="contents">
    </@layout.block>
    </div>

        <!-- START COPYRIGHT -->
        <!-- START CONTAINER FLUID -->
    <@layout.block name="footer">

    <footer>
        <div class="inner_box">
            <img src="/images/footer_logo.gif" alt="한국교통안전연구원 로고" />
            <address>(우)30147 세종특별자치시 시청대로 370 세종국책연구단지 과학인프라동(B)&nbsp;&nbsp;|&nbsp;&nbsp;TEL : 044-211-3114&nbsp;&nbsp;|&nbsp;&nbsp;FAX : 044-211-3222<br>Copyright© 2017 THE KOREA TRANSPORT INSTITUTE All rights reserved </address>
        </div>
    </footer>
    </@layout.block>


<@layout.block name="modal">
</@layout.block>

    <!-- jQuery 2.2.3 -->
    <script type="text/javascript" src="/js/jquery-2.2.3.min.js"></script>
    <script src="/js/common.js"></script>
    <script src="/js/app.js"></script>
    <!-- FLOT CHARTS -->
    <script src="/js/jquery.flot.min.js"></script>
    <!-- FLOT RESIZE PLUGIN - allows the chart to redraw when the window is resized -->
    <script src="/js/jquery.flot.resize.min.js"></script>
    <!-- FLOT CATEGORIES PLUGIN - Used to draw bar charts -->
    <script src="/js/jquery.flot.categories.min.js"></script>
    <!-- http://js-grid.com/ -->
    <script src="/js/jsgrid.min.js"></script>
    <!-- 20170316 추가 datepicker -->
    <script src="/js/jquery-ui.min.js"></script>

<@layout.block name="script">
</@layout.block>
</body>
</html>