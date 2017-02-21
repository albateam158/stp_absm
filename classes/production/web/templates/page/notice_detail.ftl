<@layout.extends name="layouts/base.ftl">

    <@layout.put block="head">
    </@layout.put>


    <@layout.put block="contents">

    <div class="contents_wrap">
        <div class="content_box">
            <div class="step_box mypage">
                <h2 class="active">공지사항</h2>
                <ul>
                    <li>
                        <a href="/notice/list"><p class="active"><i class="icon ic_check"></i>공지사항</p></a>
                    </li>
                    <li>
                        <a href="/faq/list?faqType=invest"><p>투자자 FAQ</p></a>
                    </li>
                    <li class="t-c">
                        <a href="/faq/list?faqType=publisher"><p>발행기업 FAQ</p></a>
                    </li>
                    <li class="t-c">
                        <a href="/qna"><p>1:1문의</p></a>
                    </li>
                    <li class="t-r">
                        <a href="/news/list"><p>보도자료</p></a>
                    </li>
                </ul>
            </div>

            <div class="form_box detail">
                <h2>${notice.title}</h2>
                <div class="top">
                    <div class="mypage">
                        <div class="board_view top">
                            <div class="overflow-h">
                                <p class="fr full t-r">
                                    <span>등록일</span>
                                    ${notice.regDate?date}
                                </p>
                            </div>
                        </div>
                        <div class="board_view noline_bottom editor_view">
                            <div>
                            ${(notice.content)!}
                            </div>
                        </div>
                    </div>
                </div>
                <div class="bottom">
                    <a href="/notice/list" class="btn_type03">목록</a>
                </div>
            </div>
        </div>
    </div>

    </@layout.put>


    <@layout.put block="script">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <script type="text/javascript" src="/js/page/notice_detail.js"></script>
    <script>

    </script>

    </@layout.put>

</@layout.extends>