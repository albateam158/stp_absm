<@layout.extends name="layouts/base.ftl">

    <@layout.put block="head">
    </@layout.put>


    <@layout.put block="contents">

    <div class="contents_wrap">
        <div class="content_box">
            <div class="form_box">
                <h2>로그인</h2>
                <div class="top">

                    <!-- 예전 로그인 스타일 //-->
                    <div class="login_box">
                        <form id="frmLogin" action="/login" method="post">
                            <dl>
                                <dt class="t-l">이메일</dt>
                                <dd><input type="text" name="username" class="full data requir" value="" maxlength="100" required="true" /></dd>
                            </dl>
                            <dl>
                                <dt class="t-l">비밀번호</dt>
                                <dd><input type="password" name="passwordString" class="full data requir" maxlength="20" required="true" /></dd>
                            </dl>
                            <div class="mt15 t-r">
                                <input type="checkbox" name="remember" id="remember" value="Y" class="data checkbox" />
                                <label for="remember">아이디 저장</label>
                                <a class="find_pass">비밀번호 찾기</a>
                            </div>
                            <p class="login_btn mt15">
                                <input class="btn_type03" id="btn_login" type="button" value="로그인" />
                            </p>
                        </form>
                    </div>

                    <!-- SNS 로그인 스타일 //-->
                    <#--<div class="login_box login">-->
                        <#--<form id="frmLogin" action="/login" method="post">-->
                            <#--<div class="fl">-->
                                <#--<div class="overflow-h">-->
                                    <#--<div class="input_box fl">-->
                                        <#--<dl>-->
                                            <#--<dt>이메일</dt>-->
                                            <#--<dd><input type="text" name="username" class="full data requir" value="" maxlength="100" required="true" /></dd>-->
                                        <#--</dl>-->
                                        <#--<dl>-->
                                            <#--<dt>비밀번호</dt>-->
                                            <#--<dd><input type="password" name="passwordString" class="full data requir" maxlength="20" required="true" /></dd>-->
                                        <#--</dl>-->
                                    <#--</div>-->
                                    <#--<p class="login_btn fr">-->
                                        <#--<input class="btn_type03" id="btn_login" type="button" value="로그인" />-->
                                    <#--</p>-->
                                <#--</div>-->
                                <#--<div class="login_opt">-->
                                    <#--<input type="checkbox" name="remember" id="remember" value="Y" class="data checkbox" />-->
                                    <#--<label for="remember">아이디 저장</label>-->
                                    <#--<a class="find_pass">비밀번호 찾기</a>-->
                                <#--</div>-->
                            <#--</div>-->
                            <#--<div class="fr">-->
                                <#--<div class="overflow-h">-->
                                    <#--<ul class="sns_list">-->
                                        <#--<li><a class="ic_sns fbook" onclick="document.facebook.submit();"></a></li>-->
                                        <#--<li><a class="ic_sns google" onclick="document.google.submit();"></a></li>-->
                                        <#--<li><a class="ic_sns katalk" onclick="document.kakao.submit();"></a></li>-->
                                    <#--</ul>-->
                                <#--</div>-->
                                <#--<p class="mt25">SNS 계정으로 간편하게 로그인 하세요.</p>-->
                            <#--</div>-->
                            <#--<p class="or">OR</p>-->
                        <#--</form>-->

                        <#--<form action="/auth/facebook" name="facebook">-->
                            <#--<input type="hidden" name="scope" value="email"/>-->
                        <#--</form>-->
                        <#--<form action="/auth/kakao" name="kakao">-->
                        <#--</form>-->
                        <#--<form action="/auth/google" name="google">-->
                            <#--<input type="hidden" name="scope" value="email"/>-->
                        <#--</form>-->
                    <#--</div>-->
                </div>
                <div class="bottom">
                    위크라우드
                    <a href="/signup" class="ml10">회원가입</a>
                </div>
            </div>
        </div>
        <div class="pop_box find_pw none" >
            <div>
                <div class="pop_wrap">
                    <div class="pop_con">
                        <form>
                            <div class="pop_header">
                                <input type="button" class="close btn_cancel"/>
                                <h2>비밀번호 찾기</h2>
                            </div>
                            <div class="top">
                                <div class="clearfix">
                                    <dl>
                                        <dt>이메일</dt>
                                        <dd><input type="text" name="sendEmail" class="full" value="" maxlength="100" /></dd>
                                    </dl>
                                </div>
                                <p class="find_msg mt30">
                                    이메일을 입력하신 후 확인 버튼을 눌려주세요. <br />
                                    가입 당시 메일주소로 임시비밀번호를 발급해 드립니다. <br />
                                    인터넷 환경에 따라 메일수신이 늦어질 수도 있습니다. <br />
                                    만약 메일을 받지 못할 경우<br />
                                    고객센터 1:1 문의하기 게시판을 이용해주세요.
                                </p>
                            </div>
                            <div class="bottom">
                                <ul>
                                    <li class="fl t-r"><a class="btn_type02 dark btn_cancel">취소</a></li>
                                    <li class="fr t-l"><a class="btn_type03 btn_sendEmail">확인</a></li>
                                </ul>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    </@layout.put>


    <@layout.put block="script">
    <script>
        var error = '${(error) !}';
    </script>

    <script type="text/javascript" src="/js/user/login.js"></script>

    </@layout.put>

</@layout.extends>