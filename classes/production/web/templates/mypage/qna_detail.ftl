<@layout.extends name="layouts/base.ftl">

    <@layout.put block="head">
    </@layout.put>


    <@layout.put block="contents">

    <div class="contents_wrap">
        <div class="content_box">
            <div class="step_box mypage">
                <h2 class="active">1:1문의내역</h2>
                <ul>
                    <li>
                        <a href="/mypage/profile"><p>개인정보 수정</p></a>
                    </li>
                    <li class="t-c">
                        <a href="/mypage/investor"><p>투자자 정보</p></a>
                    </li>
                    <li class="t-c">
                        <a href="/mypage/password"><p>비밀번호 변경</p></a>
                    </li>
                    <li class="t-c">
                        <a href="/mypage/project"><p>투자 내역</p></a>
                    </li>
                    <li class="t-r">
                        <a href="/mypage/qna"><p class="active"><i class="icon ic_check"></i>1:1문의내역</p></a>
                    </li>
                </ul>
            </div>

            <div class="form_box detail">
                <h2>${qna.title}</h2>
                <div class="top">
                    <div class="mypage">
                        <div class="board_view top">
                            <div class="overflow-h">
                                <p class="fl">
                                    <span>질문유형</span>
                                    <#list qnaCodes as qnaCode>
                                        <#if (qnaCode.code) == (qna.qnaType)>
                                            ${(qnaCode.codeName) !}
                                        </#if>
                                    </#list>
                                </p>
                                <p class="fr">
                                    <span>등록일</span>
                                    ${qna.regDate?date}
                                </p>
                            </div>
                        </div>
                        <div class="board_view <#if !(qna.answer?has_content)>noline_bottom</#if>">
                            <div>
                                ${(qna.content)?replace('\r\n', '<br>')!}
                            </div>
                        </div>
                        <#if qna.answer?has_content>
                            <div class="board_view reply">
                                <h3>문의하신 질문에 대한 답변입니다.</h3>
                                <div>
                                    ${(qna.answer)?replace('\r\n', '<br>')!}
                                </div>
                            </div>
                        </#if>
                    </div>
                </div>
                <div class="bottom">
                    <a href="/mypage/qna" class="btn_type03">목록</a>
                </div>
            </div>
        </div>
    </div>

    </@layout.put>


    <@layout.put block="script">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <script type="text/javascript" src="/js/mypage/qna_detail.js"></script>
    <script>

    </script>

    </@layout.put>

</@layout.extends>