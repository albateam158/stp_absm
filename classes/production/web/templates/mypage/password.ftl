<@layout.extends name="layouts/base.ftl">

    <@layout.put block="head">
    </@layout.put>


    <@layout.put block="contents">

    <div class="contents_wrap">
        <div class="content_box">
            <div class="step_box mypage">
                <h2 class="active">비밀번호 변경</h2>
                <ul>
                    <li>
                        <a href="/mypage/profile"><p>개인정보 수정</p></a>
                    </li>
                    <li class="t-c">
                        <a href="/mypage/investor"><p>투자자 정보</p></a>
                    </li>
                    <li class="t-c">
                        <a href="/mypage/password"><p class="active"><i class="icon ic_check"></i>비밀번호 변경</p></a>
                    </li>
                    <li class="t-c">
                        <a href="/mypage/project"><p>투자 내역</p></a>
                    </li>
                    <li class="t-r">
                        <a href="/mypage/qna"><p>1:1문의내역</p></a>
                    </li>
                </ul>
            </div>
            <div class="form_box faq">
                <form id="frmData" method="">
                    <h2>비밀번호 변경</h2>
                    <div class="top">
                        <div class="login_box signup">
                            <dl>
                                <dt>현재 비밀번호</dt>
                                <dd><input type="password" name="oldPassword" id="old_password" class="full" maxlength="20"/></dd>
                            </dl>
                            <dl>
                                <dt>신규 비밀번호</dt>
                                <dd><input type="password" name="newPassword" id="new_password" class="full" maxlength="20"/></dd>
                            </dl>
                            <dl>
                                <dt>신규 비밀번호 재입력</dt>
                                <dd><input type="password" name="newPassword2" id="new_password2" class="full" maxlength="20"/></dd>
                            </dl>
                        </div>
                    </div>
                    <div class="bottom">
                        <input class="btn_type03" id="btn_submit" type="button" value="수정하기" />
                    </div>
                </form>
            </div>
        </div>
    </div>

    </@layout.put>


    <@layout.put block="script">
    <script>

    </script>

    <script type="text/javascript" src="/js/mypage/password.js"></script>

    </@layout.put>

</@layout.extends>