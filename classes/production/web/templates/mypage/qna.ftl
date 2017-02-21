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

            <div class="form_box noline_bottom faq">
                <h2 class="qna">
                    <span>1:1문의내역</span>
                    <a href="/qna" class="btn_type02 fr">1:1문의하기</a>
                </h2>
            </div>

            <div class="form_box mypage">
                <div class="top">
                    <div class="mypage" id="qnaListDiv"></div>
                </div>
            </div>
        </div>
    </div>

    </@layout.put>


    <@layout.put block="script">
    <script>

    </script>

    <script type="text/javascript" src="/js/mypage/qna.js"></script>

    </@layout.put>

</@layout.extends>