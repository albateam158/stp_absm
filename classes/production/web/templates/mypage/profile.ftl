<@layout.extends name="layouts/base.ftl">

    <@layout.put block="head">
    </@layout.put>


    <@layout.put block="contents">

    <div class="contents_wrap">
        <div class="content_box">
            <div class="step_box mypage">
                <h2 class="active">개인정보수정</h2>
                <ul>
                    <li>
                        <a href="/mypage/profile"><p class="active"><i class="icon ic_check"></i>개인정보 수정</p></a>
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
                        <a href="/mypage/qna"><p>1:1문의내역</p></a>
                    </li>
                </ul>
            </div>
            <div class="form_box faq">
                <form id="frmData" method="">
                    <h2>개인정보 수정</h2>
                    <div class="top">
                        <div class="login_box signup">
                            <div class="profile">
                                <div class="profile_thum">
                                    <#if (member.profileImageUrl)?has_content>
                                        <#assign pImg = (member.profileImageUrl)>
                                    <#else>
                                        <#assign pImg = "/images/img-person.jpg">
                                    </#if>
                                    <span style="background-image: url(${pImg});"></span>
                                    <div class="btn_add">
                                        <input type="file" name="profileImgFile" id="profileImgFile" accept="image/*" />
                                        <input type="hidden" name="profileImageUrl" value="${member.profileImageUrl}" placeholder="프로필 사진" class="data" />
                                    </div>
                                </div>
                            </div>
                            <#if member.userInvestor?has_content>
                                <div class="investor_type">
                                    <#function fnInvSortName invSortCd>
                                        <#switch invSortCd>
                                            <#case "02">
                                                <#return "소득요건충족 투자자">
                                                <#break>
                                            <#case "03">
                                                <#return "전문투자자">
                                                <#break>
                                            <#case "04">
                                                <#return "연고자">
                                                <#break>
                                            <#default> <#--01-->
                                                <#return "일반 투자자">
                                        </#switch>
                                    </#function>
                                    <p>${(fnInvSortName(member.userInvestor.invSortCd)) !}</p>
                                </div>
                            </#if>
                            <dl>
                                <dt>이름</dt>
                                <dd><input type="text" class="full" name="name" value="${member.name}" required="true" /></dd>
                            </dl>
                            <dl>
                                <dt>이메일</dt>
                                <dd><input type="text" class="full" readOnly value="${member.email}" /></dd>
                            </dl>
                            <dl>
                                <dt>휴대폰번호</dt>
                                <dd class="t-l">
                                    <input type="text" name="phone" class="full chkNum data requir" placeholder="번호만 입력해주세요" value="${member.phone}" maxlength="20" required="true" />
                                </dd>
                            </dl>
                            <p class="mt20 pb5 fr">
                                <input type="checkbox" name="recieveNews" id="recieveNews" value="1" class="data checkbox" <#if member.recieveNews?exists && member.recieveNews == 1>checked</#if>/>
                                <label for="recieveNews">뉴스레터 받기</label>
                                <a class="btn_leave">탈퇴하기</a>
                            </p>
                        </div>
                    </div>
                    <div class="bottom">
                        <input class="btn_type03" id="btn_submit" type="button" value="수정하기" />
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="pop_box leave_site none" >
        <div>
            <div class="pop_wrap">
                <div class="pop_con">
                    <form>
                        <div class="pop_header">
                            <input type="button" class="close btn_cancel"/>
                            <h2>탈퇴 하기</h2>
                        </div>
                        <div class="top">
                            <textarea rows="4" name="leaveReason" class="mt25" placeholder="탈퇴사유를 적어주세요." maxlength="200" /></textarea>
                            <p class="msg mt20">
                                정상적으로 처리가 되지 않았을 경우,<br />
                                고객센터 1:1 문의하기 게시판을 이용해주세요.
                            </p>
                            <p class="agree_msg mt20">
                                <input id="agree" type="checkbox" class="data checkbox" value="Y">
                                <label for="agree">
                                    탈퇴를 하시면 같은 ID로 재가입을 할 수 없습니다.<br />다시 한번 확인해 주세요.
                                </label>
                            </p>
                        </div>
                        <div class="bottom">
                            <ul>
                                <li class="fl t-r"><a class="btn_type02 dark btn_cancel">취소</a></li>
                                <li class="fr t-l"><a class="btn_type03 btn_submit">확인</a></li>
                            </ul>
                        </div>
                        <div class="loading"><img src="/images/bx_loader.gif" /></div>
                        <p class="blockUi none"></p>
                    </form>
                </div>
            </div>
        </div>
    </div>

    </@layout.put>


    <@layout.put block="script">
    <script>

    </script>

    <script type="text/javascript" src="/js/mypage/profile.js"></script>

    </@layout.put>

</@layout.extends>