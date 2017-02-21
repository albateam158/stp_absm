<@layout.extends name="layouts/base.ftl">

    <@layout.put block="head">
    </@layout.put>


    <@layout.put block="contents">

    <div class="contents_wrap">
        <div class="content_box">
            <div class="step_box mypage">
                <h2 class="active">투자 내역</h2>
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
                        <a href="/mypage/project"><p class="active"><i class="icon ic_check"></i>투자 내역</p></a>
                    </li>
                    <li class="t-r">
                        <a href="/mypage/qna"><p>1:1문의내역</p></a>
                    </li>
                </ul>
            </div>

            <div class="form_box noline_bottom faq">
                <h2>투자 내역</h2>
            </div>

            <div class="form_box mypage">
                <div class="top">
                    <div class="mypage" id="projectListDiv">

                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="pop_box cancel_project none" >
        <div>
            <div class="pop_wrap">
                <div class="pop_con">
                    <form>
                        <input type="hidden" name="sbscId" />
                        <div class="pop_header">
                            <input type="button" class="close btn_cancel"/>
                            <h2>투자내역 취소하기</h2>
                        </div>
                        <div class="top">
                           <textarea rows="4" name="cancelReason" class="mt10" placeholder="취소사유를 적어주세요." maxlength="200" /></textarea>
                            <p class="msg mt20">
                                정상적으로 처리가 되지 않았을 경우,<br />
                                고객센터 1:1 문의하기 게시판을 이용해주세요.
                            </p>
                            <p class="essential_text mt20 none fc-red"></p>
                        </div>
                        <div class="bottom">
                            <ul>
                                <li class="fl t-r"><a class="btn_type02 dark btn_cancel">취소</a></li>
                                <li class="fr t-l"><a class="btn_type03 btn_submit">확인</a></li>
                            </ul>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    </@layout.put>


    <@layout.put block="script">
    <script>

    </script>

    <script type="text/javascript" src="/js/mypage/project.js"></script>

    </@layout.put>

</@layout.extends>