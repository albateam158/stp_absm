<@layout.extends name="layouts/base.ftl">

    <@layout.put block="head">
    </@layout.put>


    <@layout.put block="contents">

    <div class="contents_wrap">
        <div class="content_box">
            <div class="step_box mypage">
                <h2 class="active">FAQ</h2>
                <ul>
                    <li>
                        <a href="/notice/list"><p>공지사항</p></a>
                    </li>
                    <li>
                        <a href="/faq/list?faqType=invest">
                            <p <#if faqType='invest'> class="active"><i class="icon ic_check"></i</#if>>투자자 FAQ</p>
                        </a>
                    </li>
                    <li class="t-c">
                        <a href="/faq/list?faqType=publisher">
                            <p <#if faqType='publisher'> class="active"><i class="icon ic_check"></i</#if>>발행기업 FAQ</p>
                        </a>
                    </li>
                    <li class="t-c">
                        <a href="/qna"><p>1:1문의</p></a>
                    </li>
                    <li class="t-r">
                        <a href="/news/list"><p>보도자료</p></a>
                    </li>
                </ul>
            </div>

            <div class="form_box faq">
                <h2>투자자 FAQ</h2>
                <div class="top">
                    <div id="faqListDiv" class="faq_box"></div>
                </div>
            </div>
        </div>
    </div>

    </@layout.put>


    <@layout.put block="script">
    <script>
        var faqType = '${(faqType)?default('invest') !}';
    </script>
    <script type="text/javascript" src="/js/faq/faq.js"></script>
    </@layout.put>

</@layout.extends>