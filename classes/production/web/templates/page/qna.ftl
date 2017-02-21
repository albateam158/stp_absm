<@layout.extends name="layouts/base.ftl">

    <@layout.put block="head">
    </@layout.put>


    <@layout.put block="contents">

    <div class="contents_wrap">
        <div class="content_box">
            <div class="step_box mypage">
                <h2 class="active">1:1문의</h2>
                <ul>
                    <li>
                        <a href="/notice/list"><p>공지사항</p></a>
                    </li>
                    <li>
                        <a href="/faq/list?faqType=invest"><p>투자자 FAQ</p></a>
                    </li>
                    <li class="t-c">
                        <a href="/faq/list?faqType=publisher"><p>발행기업 FAQ</p></a>
                    </li>
                    <li class="t-c">
                        <a href="/qna"><p class="active"><i class="icon ic_check"></i>1:1문의</p></a>
                    </li>
                    <li class="t-r">
                        <a href="/news/list"><p>보도자료</p></a>
                    </li>
                </ul>
            </div>

            <div class="form_box faq">
                <form id="frmData" method="">
                    <h2>1:1문의</h2>
                    <div class="top">
                        <div class="login_box qna">
                            <dl>
                                <dt>문의제목</dt>
                                <dd><input type="text" name="title" class="full" maxlength="100" required="true"/></dd>
                            </dl>
                            <dl>
                                <dt>문의유형</dt>
                                <dd>
                                    <div class="select_box qnaType">
                                        <label>유형 선택</label>
                                        <select name="qnaType" class="data" text="유형 선택" required="true">
                                            <option value="0">유형 선택</option>
                                            <#list qnaCodes as qnaCode>
                                                <option value="${(qnaCode.code) !}">${(qnaCode.codeName) !}</option>
                                            </#list>
                                        </select>
                                    </div>
                                </dd>
                            </dl>
                            <dl>
                                <dt>연락처</dt>
                                <dd><input type="text" name="phone" class="full chkNum" placeholder="숫자만 입력해주세요." class="full" maxlength="20" required="true"/></dd>
                            </dl>
                            <dl>
                                <dt>이메일</dt>
                                <dd><input type="text" name="email" class="full" maxlength="100" required="true"/></dd>
                            </dl>
                            <dl>
                                <dt>문의내용</dt>
                                <dd><textarea name="content" rows="10" class="full" required="true"></textarea></dd>
                            </dl>
                        </div>
                    </div>
                    <div class="bottom">
                        <input class="btn_type03" id="btn_submit" type="button" value="확인" />
                    </div>
                </form>
            </div>
        </div>
    </div>


    </@layout.put>


    <@layout.put block="script">

    <script type="text/javascript" src="/js/page/qna.js"></script>

    </@layout.put>

</@layout.extends>