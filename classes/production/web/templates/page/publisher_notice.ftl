<@layout.extends name="layouts/base.ftl">

    <@layout.put block="head">
    </@layout.put>


    <@layout.put block="contents">

    <div class="contents_wrap">
        <div class="content_box">
            <div class="step_box notice">
                <img src="/images/bg_step.png" class="web" />
                <img src="/images/bg_m_step.png" class="mobile" />
            </div>
            <div class="form_box">
                <form method="">
                    <h2>코리아에셋투자증권은 창업가 · 벤처기업 · 중소기업과 함께 가겠습니다.</h2>
                    <div class="top">
                        <div class="publisher_box sbsc">
                            <div class="notice_wrap">
                                <div>
                                    <p class="mb5 fw-b">중소벤처기업 금융센터</p>
                                    <dl class="fl">
                                        <dt>담당직원</dt>
                                        <dd>
                                            <p>김재성 사원 560-6300</p>
                                            <p>안진철 상무 550-6274</p>
                                            <p>박희동 부장 550-6308</p>
                                        </dd>
                                    </dl>
                                    <dl class="fr">
                                        <dt>센터장</dt>
                                        <dd>
                                            <p>이태일 전무 550-6269</p>
                                            <p>박준규 이사 550-6307</p>
                                            <p>최민혁 과장 550-6314</p>
                                        </dd>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="bottom">
                        <a href="/page/publisher_form" class="btn_type03">투자 접수</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    </@layout.put>


    <@layout.put block="script">
    <script type="text/javascript" src="/js/page/publisher_notice.js"></script>
    </@layout.put>

</@layout.extends>