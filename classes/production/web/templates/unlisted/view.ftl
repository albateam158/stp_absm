<@layout.extends name="layouts/base.ftl">

    <@layout.put block="head">
    </@layout.put>


    <@layout.put block="contents">

    <div class="contents_wrap">
        <div class="content_box">
            <div class="thum_wrap unlisted">
                <div class="title_div">
                    <h3>비상장 주식 매매</h3>
                </div>
                <div class="form_box detail">
                    <h2>기업 개요</h2>
                    <div class="top">
                        <div class="unlisted_wrap">
                            <div class="title_box">
                                <h4>개요 및 주식현황</h4>
                            </div>
                            <ul class="info">
                                <li>
                                    <dl>
                                        <dt>회사명</dt>
                                        <dd>${(unlisted.name) !}</dd>
                                        <dt>업종</dt>
                                        <dd>${(unlisted.businessType) !}</dd>
                                    </dl>
                                </li>
                                <li>
                                    <dl>
                                        <dt>대표이사</dt>
                                        <dd>${(unlisted.ceo) !}</dd>
                                        <dt>홈페이지</dt>
                                        <dd><#if unlisted.homepage == "-">${(unlisted.homepage) !}<#else><a href="http://${(unlisted.homepage?replace("http://", "")) !}" target="_blank">${(unlisted.homepage) !}</a></#if></dd>
                                    </dl>
                                </li>
                                <li>
                                    <dl>
                                        <dt>대표전화</dt>
                                        <dd>${(unlisted.phone) !}</dd>
                                        <dt>설립일</dt>
                                        <dd>${(unlisted.establishDate) !}</dd>
                                    </dl>
                                </li>
                                <li>
                                    <dl>
                                        <dt>본사주소</dt>
                                        <dd>${(unlisted.address) !}</dd>
                                        <dt>결산월</dt>
                                        <dd>${(unlisted.settlementMonth) !}월</dd>
                                    </dl>
                                </li>
                                <li>
                                    <dl>
                                        <dt>직원수</dt>
                                        <dd>${(unlisted.staff) !}명</dd>
                                        <dt>벤처기업</dt>
                                        <dd><#if unlisted.venture == "Y">지정<#elseif unlisted.venture == "N">미지정<#else>${(unlisted.venture) !}</#if></dd>
                                    </dl>
                                </li>
                            </ul>

                            <ul class="info mt20">
                                <li>
                                    <dl>
                                        <dt>전체 주식수</dt>
                                        <dd>${(unlisted.totalStock) !} 주</dd>
                                        <dt>액면가</dt>
                                        <dd>${(unlisted.faceValue) !}원</dd>
                                    </dl>
                                </li>
                                <li>
                                    <dl>
                                        <dt>자본금</dt>
                                        <dd>${(unlisted.capital) !}백만원</dd>
                                        <dt>주권구분</dt>
                                        <dd>${(unlisted.stockSection) !}</dd>
                                    </dl>
                                </li>
                            </ul>

                            <div class="title_box">
                                <h4>담당자</h4>
                            </div>

                            <ul class="info manager">
                                <li>
                                    <dl>
                                        <dt>${(unlisted.managerName) !}</dt>
                                        <dd>${(unlisted.managerPhone1) !}</dd>
                                        <dd>${(unlisted.managerEmail) !}</dd>
                                    </dl>
                                </li>
                            </ul>

                            <div class="title_box">
                                <h4>투자 게시판</h4>
                                <div class="fr">
                                    <#if member?? && (member.userType == "investor")>
                                        <a href="/unlisted/${unlistedId}/update_form" class="btn_type02">글쓰기</a>
                                    </#if>
                                    <a href="/unlisted/list" class="btn_type03">목록</a>
                                </div>
                            </div>

                            <div id="unlistedUpdateList"></div>

                            <div class="loading"><img src="/images/bx_loader.gif" style="width: 32px; height: 32px;"/></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    </@layout.put>


    <@layout.put block="script">
    <script>
        var unlistedId = '${unlistedId !}';
    </script>
    <script type="text/javascript" src="/js/unlisted/view.js"></script>
    </@layout.put>

</@layout.extends>