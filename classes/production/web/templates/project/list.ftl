<@layout.extends name="layouts/base.ftl">

    <@layout.put block="head">
    <link href="/css/jquery.tagit.css" rel="stylesheet" type="text/css">
    <link href="/css/tagit.ui-zendesk.css" rel="stylesheet" type="text/css">
    </@layout.put>


    <@layout.put block="contents">
    <div class="banner">
        <p class="img" style="background-image: url('/images/bg-banner.jpg')"></p>
        <div class="info price">
            <div>
                <p id="crowdTotal" data-price="${(sbscAmtSum?replace(',','')) !}"></p>
                <div class="mt20">
                    <p>크라우드 펀딩 기업수: <span>${(projectCount?default(0)) !}</span>개</p>
                    <p>THE CROWD IS WISER</p>
                </div>
            </div>
        </div>
    </div>

    <div class="contents_wrap sub">
        <div class="content_box">
            <div class="funding_box">
                <p class="t-c mb50"><a href="/page/investor_info" class="btn_type02 dark">투자자 절차 안내</a></p>
                <#--<div class="funding_list">-->
                    <#--<h3>기획펀딩 모아보기</h3>-->
                    <#--<ul>-->
                        <#--<li><a href="#"><img src="/images/sample-fund1.jpg" /></a></li>-->
                        <#--<li><a href="#"><img src="/images/sample-fund2.jpg" /></a></li>-->
                        <#--<li><a href="#"><img src="/images/sample-fund3.jpg" /></a></li>-->
                    <#--</ul>-->
                <#--</div>-->
            </div>

            <div class="search_box">
                <input type="hidden" name="tags" id="mySingleField" disabled="true">
                <input type="hidden" name="categoryIds" id="category_id" disabled="true">
                <input type="hidden" name="secnTpcds" id="secn_tpcd" disabled="true">
                <input type="hidden" name="successStates" id="success_state" disabled="true">
                <input type="hidden" name="publisherStage" id="publisher_stage" disabled="true">
                <ul id="singleFieldTags"></ul>
                <p class="tags_txt">선택된 항목 없음</p>
                <input type="button" class="btn_search clear none" value="필터 초기화">
                <#--<input type="button" class="btn_search setting" value="알림설정">-->
                <div class="search_keys">
                    <ul>
                        <li>
                            <h2>기업단계<i class="icon ic_arrow"></i></h2>
                            <ul class="sub none">
                                <#if stgCodes?has_content>
                                    <#list stgCodes as stgCode>
                                        <li>
                                            <input type="checkbox" name="publisher_stage" id="publisher_stage_${stgCode.code}" data="${stgCode.code}" value="${stgCode.codeName}" class="data checkbox" />
                                            <label for="publisher_stage_${stgCode.code}">${stgCode.codeName}</label>
                                        </li>
                                    </#list>
                                </#if>
                            </ul>
                        </li>
                        <li>
                            <h2>청약형태<i class="icon ic_arrow"></i></h2>
                            <ul class="sub none">
                                <li>
                                    <input type="checkbox" name="secn_tpcd" id="secn_tpcd11" data="11" value="채권" class="data checkbox" />
                                    <label for="secn_tpcd11">채권</label>
                                </li>
                                <li>
                                    <input type="checkbox" name="secn_tpcd" id="secn_tpcd21" data="21" value="주식" class="data checkbox" />
                                    <label for="secn_tpcd21">주식</label>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <h2>산업별<i class="icon ic_arrow"></i></h2>
                            <ul class="sub none">
                                <#if categories?has_content>
                                    <#list categories as category>
                                        <li>
                                            <input type="checkbox" name="category_id" id="category${category_index}" data="${category.categoryId}" value="${category.name}" class="data checkbox" />
                                            <label for="category${category_index}">${category.name}</label>
                                        </li>
                                    </#list>
                                </#if>
                            </ul>
                        </li>
                        <#--<li>-->
                            <#--<h2>청약상태<i class="icon ic_arrow"></i></h2>-->
                            <#--<ul class="sub none">-->
                                <#--<li>-->
                                    <#--<input type="checkbox" name="success_state" id="success_state_ready" data="ready" value="대기" class="data checkbox" />-->
                                    <#--<label for="success_state_ready">대기</label>-->
                                <#--</li>-->
                                <#--<li>-->
                                    <#--<input type="checkbox" name="success_state" id="success_state_ing" data="ing" value="진행중" class="data checkbox" />-->
                                    <#--<label for="success_state_ing">진행중</label>-->
                                <#--</li>-->
                                <#--<li>-->
                                    <#--<input type="checkbox" name="success_state" id="success_state_success" data="success" value="성공" class="data checkbox" />-->
                                    <#--<label for="success_state_success">성공</label>-->
                                <#--</li>-->
                                <#--<li>-->
                                    <#--<input type="checkbox" name="success_state" id="success_state_fail" data="fail" value="실패" class="data checkbox" />-->
                                    <#--<label for="success_state_fail">실패</label>-->
                                <#--</li>-->
                            <#--</ul>-->
                        <#--</li>-->
                    </ul>
                </div>
            </div>

            <div class="thum_wrap project sub_index">

            </div>
        </div>
    </div>

    </@layout.put>


    <@layout.put block="script">
    <script type="text/javascript" src="/js/project/jquery.animateNumber.min.js"></script>
    <script type="text/javascript" src="/js/tag-it.js"></script>
    <script type="text/javascript" src="/js/project/list.js"></script>

    </@layout.put>

</@layout.extends>