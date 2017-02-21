<@layout.extends name="layouts/base.ftl">

    <@layout.put block="head">
    </@layout.put>


    <@layout.put block="contents">

    <div class="contents_wrap">
        <div class="content_box">
            <div class="form_box">
                <h2>회원가입</h2>
                <div class="top">
                    <div class="login_box signup">
                        <form id="frmData" role="form" enctype='multipart/form-data'>
                            <div class="profile">
                                <div class="profile_thum">
                                    <span></span>
                                    <div class="btn_add">
                                        <input type="file" name="profileImgFile" id="profileImgFile" accept="image/*" />
                                        <input type="hidden" name="profileImageUrl" value="" placeholder="프로필 사진" class="data" />
                                    </div>
                                </div>
                            </div>
                            <dl>
                                <dt>이름</dt>
                                <dd><input type="text" name="name" class="full data requir" value="" maxlength="20" required="true" /></dd>
                            </dl>
                            <dl>
                                <dt>이메일</dt>
                                <dd><input type="text" name="email" class="full data requir" value="" maxlength="100" required="true" /></dd>
                            </dl>
                            <dl>
                                <dt>비밀번호</dt>
                                <dd><input type="password" id="passwordString" class="full data requir" maxlength="20" required="true" /></dd>
                            </dl>
                            <dl>
                                <dt>비밀번호 재입력</dt>
                                <dd><input type="password" id="passwordString2" class="full data requir" maxlength="20" required="true" /></dd>
                            </dl>
                            <dl>
                                <dt>휴대폰번호</dt>
                                <dd class="t-l">
                                    <input type="text" name="phone" class="chkNum data requir" placeholder="번호만 입력해주세요" maxlength="20" required="true" />
                                    <div class="fr">
                                        <input class="btn_type02" id="btn_reAsk" style="display: none" type="button" value="재전송" />
                                        <input class="btn_type03" id="btn_certifyNumAsk" type="button" value="인증번호전송" />
                                    </div>
                                </dd>
                            </dl>
                            <dl id="auth_form" style="display: none;">
                                <dt>인증번호 입력</dt>
                                <dd class="t-l">
                                    <input type="text" name="certifyNum" class="chkNum data requir" placeholder="번호만 입력해주세요" maxlength="20" required="true" />
                                    <div class="fr">
                                        <span class="timer">3:00</span>
                                        <input class="btn_type03 ml5" id="btn_certifyNumChk" type="button" value="인증하기" />
                                        <p class="complete_txt fc-r" id="certifyComplete" style="display: none;">인증완료</p>
                                    </div>
                                </dd>
                            </dl>
                            <p class="fs-11 fc-grey mt10 t-r">* 해외거주자 및 휴대폰 인증이 어려우신 분은 고객센터 <span class="fs-12 fw-b fc-black">+82-2-560-6300</span> 으로 문의하여 주세요.</p>
                            <p class="mt20 pb5 fr">
                                <input type="checkbox" name="recieveNews" id="recieveNews" value="1" class="data checkbox" />
                                <label for="recieveNews">이메일로 뉴스레터 받기</label>
                            </p>
                        </form>
                    </div>
                </div>
                <div class="bottom">
                    <a href="/page/policy_term">회원가입 기본약관</a>, <a href="/page/policy_privacy">개인정보 취급방침</a>에 동의하고 회원가입을 하겠습니다.
                    <p class="mt20 mb10">
                        <input class="btn_type03" id="btn_signup" type="button" value="회원가입" />
                    </p>
                </div>
            </div>
        </div>
    </div>

    </@layout.put>


    <@layout.put block="script">

    <script type="text/javascript" src="/js/user/signup.js"></script>

    </@layout.put>

</@layout.extends>