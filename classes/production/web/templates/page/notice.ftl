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

            <div class="form_box faq noline_bottom">
                <h2>공지사항</h2>
            </div>

            <div class="form_box mypage">
                <div class="top">
                    <div class="mypage" id="noticeListDiv">

                    </div>
                </div>
            </div>
        </div>
    </div>

    </@layout.put>


    <@layout.put block="script">

    <script type="text/javascript" src="/js/page/notice.js"></script>

    </@layout.put>

</@layout.extends>