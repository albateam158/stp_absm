<@layout.extends name="layouts/base.ftl">

    <@layout.put block="head">
    <link href="/css/jquery.mCustomScrollbar.css" rel="stylesheet" type="text/css" />
    <link href="/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    </@layout.put>


    <@layout.put block="contents">

    <div class="contents_wrap">
        <div class="content_box">

            <div class="thum_wrap project">
                <h3>
                    펀딩 진행중
                    <a href="/projects">더보기 <i class="fa fa-angle-right"></i></a>
                </h3>
                <div id="main_project_list"></div>
                <p class="more_btn mb20"><a class="plus more" page="1" totalPage="1" href="#"><i></i></a></p>
            </div>

            <div class="unlisted_div">
                <a href="/unlisted/list">
                    <div class="unlisted_box box1">
                        <p class="triangle"></p>
                        <div>
                            <p class="icon ic_chart1"></p>
                            <div>
                                <p>금융위 선정 중기 특화 증권사 코리아에셋투자증권</p>
                                <ul id="unlistedScrollTxt">
                                    <li>크라우드펀딩에서 비상장 주식 매매, M&A까지</li>
                                    <li>기업 성장 단계별 IB 솔루션 제공</li>
                                    <li>기관투자자 대상 비상장주식 매매 전문</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="unlisted_box box2">
                        <p class="triangle"></p>
                        <div>
                            <p class="icon ic_chart2"></p>
                            <div>
                                <img src="/images/unlisted_txt.png" width="368" height="40" />
                            </div>
                        </div>
                    </div>
                </a>
            </div>

            <div class="thum_wrap post mt30">
                <h3>
                    스타트업 뉴스
                    <a href="http://www.venturesquare.net/" target="_blank">더보기 <i class="fa fa-angle-right"></i></a>
                </h3>
                <div id="main_news_list"></div>
                <p class="more_btn"><a class="plus more" page="1" totalPage="1" href="#"><i></i></a></p>
            </div>
        </div>
    </div>

    </@layout.put>


    <@layout.put block="script">
    <script type="text/javascript" src="/js/jquery.newsTicker.js"></script>
    <script type="text/javascript" src="/js/main/main.js"></script>
    </@layout.put>

</@layout.extends>