<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<@layout.block name="head">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0">
    <meta name="naver-site-verification" content="9f2d89beb5b4cd0bebda07f3cf51924540018e80"/>
    <meta name="description" content="위크라우드">
    <link rel="shortcut icon" href="/images/favicon.ico" />
    <title>Korea Asset WiCrowd</title>
    <meta name="author" content="Korea Asseet" />

    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/fonts.css" />
    <link rel="stylesheet" type="text/css" href="/css/layout.css" />
    <link rel="stylesheet" type="text/css" href="/css/style.css" />

</@layout.block>
</head>
<body class="windows">
<div class="all_wrap">
    <div class="menu">
        <p class="blockUi"></p>
        <div>
            <ul>
                <li class="mobile">
                    <a href="/" class="img mobile_logo" title="WiCrowd">WiCrowd</a>
                    <p class="img btn_close"></p>
                </li>
                <li>
                    <a href="/projects">투자하기</a>
                </li>
                <li>
                    <a href="/page/publisher_notice">투자받기</a>
                </li>
                <li>
                    <a href="/updates">펀딩뉴스</a>
                </li>
                <li>
                    <a href="/community">커뮤니티</a>
                </li>
                <li class="last">
                    <a href="/stats">통계보기</a>
                </li>
            <#if user??>
                <li class="mobile">
                    <a href="/logout">로그아웃</a>
                </li>
                <li class="mobile">
                    <a href="/mypage/profile">마이페이지</a>
                </li>
            <#else>
                <li class="mobile">
                    <a href="/login">로그인</a>
                </li>
                <li class="mobile">
                    <a href="/signup">회원가입</a>
                </li>
            </#if>
                <li class="mobile">
                    <a href="/notice/list">고객센터</a>
                </li>
            </ul>
        </div>
    </div>
    <div class="inner_wrap">
        <div class="header_bg">
            <div class="header_wrap">
                <div class="header_gnb">
                    <p class="btn_menu_more">메뉴 더보기</p>
                    <div class="fl">
                        <div class="logo fl">
                            <p><a href="/" title="WiCrowd">WiCrowd</a></p>
                        </div>
                        <#--<div class="menu">-->
                            <#--<div>-->
                                <#--<ul>-->
                                    <#--<li>-->
                                        <#--<a href="/projects"><i class="icon mn1"></i>투자하기</a>-->
                                    <#--</li>-->
                                    <#--<li>-->
                                        <#--<a href="/page/publisher_notice"><i class="icon mn2"></i>투자받기</a>-->
                                    <#--</li>-->
                                    <#--<li>-->
                                        <#--<a href="/updates"><i class="icon mn3"></i>펀딩뉴스</a>-->
                                    <#--</li>-->
                                    <#--<li class="last">-->
                                        <#--<a href="/community"><i class="icon mn4"></i>커뮤니티</a>-->
                                    <#--</li>-->
                                <#--</ul>-->
                            <#--</div>-->
                        <#--</div>-->
                    </div>

                    <div class="top_menu fr">
                        <ul>
                            <#if user??>
                                <li>
                                    <a href="/logout">로그아웃</a>
                                </li>
                                <li>
                                    <a href="/mypage/profile">마이페이지</a>
                                </li>
                            <#else>
                                <li>
                                    <a href="/login">로그인</a>
                                </li>
                                <li>
                                    <a href="/signup">회원가입</a>
                                </li>
                            </#if>
                            <li>
                                <a href="/notice/list">고객센터</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="menu">
                <div>
                    <ul>
                        <li>
                            <a href="/projects"><i class="icon mn1"></i>투자하기</a>
                        </li>
                        <li>
                            <a href="/page/publisher_notice"><i class="icon mn2"></i>투자받기</a>
                        </li>
                        <li>
                            <a href="/updates"><i class="icon mn3"></i>펀딩뉴스</a>
                        </li>
                        <li>
                            <a href="/community"><i class="icon mn4"></i>커뮤니티</a>
                        </li>
                        <li class="last">
                            <a href="/stats"><i class="icon mn6"></i>통계보기</a>
                        </li>
                        <#--<li>-->
                            <#--<a href="#"><i class="icon mn5"></i>투자그룹</a>-->
                        <#--</li>-->
                    </ul>
                </div>
            </div>
        </div>


        <!-- START CONTENTS -->
        <@layout.block name="contents">
        </@layout.block>




        <!-- START FOOTER -->
        <div class="footer_bg">
            <div class="footer">
                <div class="footer_wrap">
                    <div class="footer_gnb">
                        <p class="logo fl"><a href="/" title="WiCrowd">WiCrowd</a></p>
                        <ul class="footer_menu fr">
                            <li>
                                <p><a href="/page/policy">이용약관</a></p>
                            </li>
                            <li>
                                <p><a href="/page/policy_term">회원가입 이용약관</a></p>
                            </li>
                            <li>
                                <p><a href="/page/policy_privacy">개인정보취급방침</a></p>
                            </li>
                            <li>
                                <p><a href="/page/investor_info">투자자 절차안내</a></p>
                            </li>
                            <li>
                                <p><a href="/page/publisher_info">발행기업 절차안내</a></p>
                            </li>
                            <li>
                                <p><a href="http://www.kasset.co.kr" target="_blank">회사소개</a></p>
                            </li>
                        </ul>
                    </div>
                    <div class="footer_info fl">
                        <p class="logo fl"><a href="/" title="WiCrowd">WiCrowd</a></p>
                        <div>
                            <span>서울특별시 영등포구 여의나루로 57, 12층 (여의도동 신송센터빌딩)</span>
                            <span>Tel: 02-560-6300 Fax: 02-560-6390</span>
                            <a href="mailto:wicrowd@kasset.co.kr" target="_blank">wicrowd@kasset.co.kr</a>
                            <p class="copyright">ⓒ 2016 KOREA ASSET INVESTMENT SECURITIES CO.,LTD. <span>ALL RIGHT RESERVED.</span></p>
                        </div>
                    </div>
                    <div class="footer_banner">
                        <a href="https://www.crowdnet.or.kr/" target="_blank"><img src="/images/btn_crowdnet.png"></a>
                    </div>
                </div>
            </div>
        </div>



        <p class="scroll_top img none"><a href="#top"></a></p>
    </div>

</div>

<div class="loading wrap none">
    <p class="blockUi"></p>
    <div><img src="/images/loader.gif" /></div>
</div>

<!-- 모달 다이얼로그 시작 -->
<@layout.block name="modal">
</@layout.block>


<!-- Script 시작 -->
<@layout.block name="script">
<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bxslider/4.2.5/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.9.2/jquery-ui.min.js" charset="utf-8"></script>
<script type="text/javascript" src="/js/jquery.circleGraphic.js"></script>
<script type="text/javascript" src="/js/jquery.cookie.js"></script>
<script type="text/javascript" src="/js/more.paging.js"></script>
<script type="text/javascript" src="/js/jquery.md5.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript" src="/js/paging.js"></script>
<script type="text/javascript" src="/js/modal.js"></script>
<script>
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
            m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

    ga('create', 'UA-75228069-1', 'auto');
    ga('send', 'pageview');

</script>
</@layout.block>
</body>
</html>