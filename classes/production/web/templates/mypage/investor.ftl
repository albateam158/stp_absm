<@layout.extends name="layouts/base.ftl">

    <@layout.put block="head">
    </@layout.put>


    <@layout.put block="contents">

    <div class="contents_wrap">
        <div class="content_box">

            <div class="step_box mypage">
                <h2 class="active">투자자 정보</h2>
                <ul>
                    <li>
                        <a href="/mypage/profile"><p>개인정보 수정</p></a>
                    </li>
                    <li class="t-c">
                        <a href="/mypage/investor"><p class="active"><i class="icon ic_check"></i>투자자 정보</p></a>
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
                <h2>투자자 정보 수정</h2>

                <#if member.userInvestor?has_content>
                    <div class="top">
                        <div class="publisher_box">
                            <div class="publisher_form form_list">
                                <div id="tab1_form" class="tab_form">
                                    <form id="frm_${statics["net.xenix.wicrowd.type.InvSortCdType"].NORMAL}" method="post" action="" enctype="multipart/form-data">
                                        <input type="hidden" name="invSortCd" value="${statics["net.xenix.wicrowd.type.InvSortCdType"].NORMAL}" />
                                        <input type="hidden" name="uploadFile" value="" />

                                        <#--전문 투자자-->
                                        <#if member.userInvestor.invSortCd == '${statics["net.xenix.wicrowd.type.InvSortCdType"].SPECIAL}'>
                                            <div>
                                                <h3>투자자 정보</h3>
                                                    <dl>
                                                        <dt>법인명</dt>
                                                        <dd><input type="text" value="${(member.userInvestor.corpName) !}" class="full" disabled /></dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>사업자 등록번호</dt>
                                                        <dd><input type="text" value="${(member.userInvestor.buzno) !}" class="full" disabled /></dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>법인번호</dt>
                                                        <dd><input type="text" value="${(member.userInvestor.realnmno) !}" class="full" disabled /></dd>
                                                    </dl>
                                                    <#--<dl>-->
                                                        <#--<dt>사업자등록증사본</dt>-->
                                                        <#--<dd>-->
                                                            <#--<input type="text" class="full" value="${(member.userInvestor.fileId1.filename) !}" disabled="disabled">-->
                                                            <#--<span><a href="/file/${(member.userInvestor.fileId1.fileId)!}">[다운받기]</a></span>-->
                                                        <#--</dd>-->
                                                    <#--</dl>-->
                                                    <#--<dl>-->
                                                        <#--<dt>대표자 신분증사본</dt>-->
                                                        <#--<dd>-->
                                                            <#--<input type="text" class="full" value="${(member.userInvestor.fileId2.filename) !}" disabled="disabled">-->
                                                            <#--<span><a href="/file/${(member.userInvestor.fileId2.fileId)!}">[다운받기]</a></span>-->
                                                        <#--</dd>-->
                                                    <#--</dl>-->
                                                    <#--<dl>-->
                                                        <#--<dt class="line2">법인등기부등본<br/>(주주명부)</dt>-->
                                                        <#--<dd>-->
                                                            <#--<input type="text" class="full" value="${(member.userInvestor.fileId3.filename) !}" disabled="disabled">-->
                                                            <#--<span><a href="/file/${(member.userInvestor.fileId3.fileId)!}">[다운받기]</a></span>-->
                                                        <#--</dd>-->
                                                    <#--</dl>-->
                                            </div>
                                            <div class="mt50">
                                                <h3>담당자 정보</h3>
                                                <dl>
                                                <dt>이름</dt>
                                                <dd><input type="text" name="managerName" value="${(member.userInvestor.managerName) !}" class="full data" maxlength="100" required="true" /></dd>
                                            </dl>
                                                <dl>
                                                    <dt>연락처</dt>
                                                    <dd><input type="text" name="managerPhone" value="${(member.userInvestor.managerPhone) !}" class="full chkNum data" placeholder="숫자만 입력해주세요." maxlength="100" required="true" /></dd>
                                                </dl>
                                                <dl>
                                                    <dt>이메일</dt>
                                                    <dd><input type="text" name="managerEmail" value="${(member.userInvestor.managerEmail) !}" class="full data" maxlength="100" required="true" /></dd>
                                                </dl>
                                            </div>
                                        <#--일반 투자자 & 소득전문투자자-->
                                        <#else>
                                            <div>
                                                <h3>투자자 정보</h3>

                                                <dl>
                                                    <dt>이름</dt>
                                                    <dd><input type="text" class="full" value="${(member.name) !}" maxlength="20" disabled /></dd>
                                                </dl>
                                                <dl>
                                                    <dt>주민등록번호</dt>
                                                    <dd><input type="text" class="full" value="${(member.userInvestor.realnmno?substring(0, 6)) !}-${(member.userInvestor.realnmno?substring(6, 13)?replace("1|2|3|4|5|6|7|8|9|0", "*", "r")) !}" disabled /></dd>
                                                </dl>
                                                <dl>
                                                    <dt>핸드폰 번호</dt>
                                                    <dd><input type="text" class="full" value="${(member.phone) !}" maxlength="50" disabled /></dd>
                                                </dl>
                                                <dl>
                                                    <dt>신분증 사본</dt>
                                                    <dd>
                                                        <input type="text" class="full" value="${(member.userInvestor.fileId1.filename)!}" disabled="disabled">
                                                        <#--<span><a href="/file/${(member.userInvestor.fileId1.fileId)!}">[다운받기]</a></span>-->
                                                    </dd>
                                                </dl>
                                                <#if member.userInvestor.invSortCd == '${statics["net.xenix.wicrowd.type.InvSortCdType"].INCOME}'>
                                                    <dl>
                                                        <dt>증빙자료</dt>
                                                        <dd>
                                                            <input type="text" class="full" value="${(member.userInvestor.fileId2.filename)!}" disabled="disabled">
                                                            <#--<span><a href="/file/${(member.userInvestor.fileId2.fileId)!}">[다운받기]</a></span>-->
                                                        </dd>
                                                    </dl>
                                                </#if>
                                            </div>
                                        </#if>
                                        <div class="mt50">

                                            <div class="tab_form">
                                                <h3>계좌 정보</h3>
                                                <ul>
                                                    <li>
                                                        <dl>
                                                            <dt class="pl10">증권사</dt>
                                                            <dd>
                                                                <div class="select_box secucoAcopno">
                                                                    <label><#if member.userInvestor.secucoAcopno?exists>${(secucoAcopName)!}<#else>증권사 선택</#if></label>
                                                                    <select name="secucoAcopno" class="data select" text="증권사 선택" required="true">
                                                                        <option value="0">증권사 선택</option>
                                                                        <#list acoCodes as acoCode>
                                                                            <option value="${acoCode.code}" <#if member.userInvestor.secucoAcopno == acoCode.code>selected</#if>>${acoCode.codeName}</option>
                                                                        </#list>
                                                                    </select>
                                                                </div>
                                                            </dd>
                                                        </dl>
                                                    </li>
                                                    <li>
                                                        <dl>
                                                            <dt>계좌번호</dt>
                                                            <dd>
                                                                <input type="text" name="invstrTrsacNo" class="full chkNum data" value="${(member.userInvestor.invstrTrsacNo) !}" text="계좌번호" maxlength="100" required="true" />
                                                            </dd>
                                                        </dl>
                                                    </li>
                                                </ul>
                                            </div>


                                            <div class="tab_form">
                                                <h3>관심 카테고리 선택</h3>
                                                <ol>
                                                    <#list categories as category>
                                                        <li>
                                                            <#assign isChecked = "">
                                                            <#if categoryArray?exists>
                                                                <#list categoryArray as dbCategory>
                                                                    <#if category.categoryId?string == dbCategory>
                                                                        <#assign isChecked = "checked">
                                                                        <#break>
                                                                    </#if>
                                                                </#list>
                                                            </#if>
                                                            <input type="checkbox" name="categories" id="in_category${category_index}" ${isChecked} value="${category.categoryId}" class="data checkbox" />
                                                            <label for="in_category${category_index}">${category.name}</label>
                                                        </li>
                                                    </#list>
                                                </ol>
                                            </div>
                                        </div>
                                    </form>
                                </div>

                                <div class="tab_form">
                                    <p class="mt10 mb50"><a href="/mypage/investor_relations" class="btn_type02 dark">연고자 모집 신청</a></p>
                                    <#if projectRelatives?has_content>
                                        <h3>연고자 등록 리스트</h3>
                                        <table cellpadding="0" cellspacing="0">
                                            <tbody>
                                                <#list projectRelatives as prList>
                                                    <tr>
                                                        <td>
                                                            <div>
                                                                <div class="title">
                                                                    <div>
                                                                        <div>
                                                                            <p class="img" style="background-image:url(${(prList.project.mainImageUrl)?default('/images/sample.jpg') !});"></p>
                                                                        </div>
                                                                        <div>
                                                                            <h3>${(prList.project.name) !}</h3>
                                                                            <h5>${(prList.project.user.userPublisher.corpName) !}</h5>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="info">
                                                                    <#if prList.project.successState == "ing">
                                                                        <p class="mb5"><span>${(prList.project.dday)! }</span>일 남음</p>
                                                                        <p class="mb5"><span>${(prList.project.sbscCount) !}</span>명</p>
                                                                    <#elseif prList.project.successState == "ready">
                                                                        <p class="mb5"><span>D-${(prList.project.readyDay)-1 !}</span></p>
                                                                        <p class="mb5">현재 <span>${(prList.project.sbscCount) !}</span>명</p>
                                                                    <#else>
                                                                        <p class="mb5"><span>${(prList.project.sbscCount) !}</span>명</p>
                                                                    </#if>
                                                                    <p class="price"><span>${(prList.project.sbscAmt?default(0)) !}</span>원</p>
                                                                </div>
                                                                <div class="state">
                                                                    <#if prList.project.successState == "ing">
                                                                        <p>진행중</p>
                                                                    <#elseif prList.project.successState == "ready">
                                                                        <p class="fc-lightgrey">준비중</p>
                                                                     <#else>
                                                                        <p class="fc-lightgrey">마감</p>
                                                                    </#if>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <#if prList.status == 'approved'>
                                                                <p>승인</p>
                                                            <#else>
                                                                <p class="fc-lightgrey">미승인</p>
                                                            </#if>
                                                        </td>
                                                    </tr>
                                                </#list>
                                            </tbody>
                                        </table>
                                    </#if>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="bottom">
                        <input class="btn_type03" id="btn_submit" type="button" value="확인" />
                    </div>
                <#else>
                    <#--before login-->
                    <div class="top">
                        <div class="login_box signup mypage">
                            <div class="investor_notice">
                                <h3>투자자에게 제공하는 서비스 입니다.</h3>
                                <p class="mt10">WiCrowd는 온라인소액투자중개업자로 크라우드 펀딩으로 자금을 모을 수 있는 서비스를 제공합니다.</p>
                            </div>
                        </div>
                    </div>
                    <div class="bottom">
                        <a href="/user/investor_form" class="btn_type03">투자자 지원하기</a>
                    </div>
                </#if>
                </form>
            </div>

        </div>

    </div>

    </@layout.put>


    <@layout.put block="script">
    <script>
        var invSortCd = '${(member.userInvestor.invSortCd) !}';
    </script>

    <script type="text/javascript" src="/js/mypage/investor.js"></script>

    </@layout.put>

</@layout.extends>