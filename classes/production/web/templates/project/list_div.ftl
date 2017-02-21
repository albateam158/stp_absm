<#if projects?has_content>
    <h3>펀딩 진행중</h3>
    <ul class="card_list">
        <#list projects as project>
            <#function fnSubscribeTypeName subscribeType>
                <#if subscribeType == "1"><#return "공모"><#else><#return "사모"></#if>
            </#function>
            <li>
                <a href="/project/${project.projectId}">
                    <div class="category">
                        <div>
                            <i class="icon">${(project.category.name) !}</i>
                            ${(fnSubscribeTypeName(project.subscribeType)) !}/${(project.location) !}
                        </div>
                        <#if project.taxDeduction?default('N') == 'Y'>
                            <span class="ic_deduction">소득공제</span>
                        </#if>
                    </div>
                    <div class="thum">
                        <p class="image" style="background-image:url(${(project.mainImageUrl)?default('/images/sample.jpg') !});"></p>
                        <p class="blockUi"></p>
                        <div class="desc">
                            <h4>
                                D-${(project.dday)! } <br/>
                                목표금액 ${(project.targetAmt?default(0)) !}원
                                <p>${(project.comment?default(""))!}</p>
                            </h4>
                        </div>
                    </div>
                    <div class="info">
                        <div class="title">
                            <h4>${(project.name) !}</h4>
                        </div>
                        <p class="firm">${(project.user.userPublisher.corpName) !}</p>
                        <p><span>${(project.dday)! }</span>일 남음</p>
                        <p class="mb5">현재 <span>${(project.sbscCount) !}</span>명</p>
                        <p class="price"><span>${(project.sbscAmt?default(0)) !}</span>원</p>
                        <#assign percent = (project.sbscAmt / project.targetAmt) * 100>
                        <#if (percent > 100)>
                            <#assign percent = percent?string("0")>
                        <#else>
                            <#assign percent = percent?string("0.#")>
                        </#if>
                        <p class="graph circleGraphic" data-form="${percent}"></p>
                    </div>
                </a>
            </li>
        </#list>
    </ul>
</#if>

<#if projectReady?has_content>
    <h3 class="mt30">진행 예정 펀딩</h3>
    <ul class="card_list">
        <#list projectReady as project>
            <#function fnSubscribeTypeName subscribeType>
                <#if subscribeType == "1"><#return "공모"><#else><#return "사모"></#if>
            </#function>
            <li>
                <a href="/project/${project.projectId}">
                    <div class="category">
                        <div>
                            <i class="icon">${(project.category.name) !}</i>
                        ${(fnSubscribeTypeName(project.subscribeType)) !}/${(project.location) !}
                        </div>
                        <#if project.taxDeduction?default('N') == 'Y'>
                            <span class="ic_deduction">소득공제</span>
                        </#if>
                    </div>
                    <div class="thum">
                        <p class="image" style="background-image:url(${(project.mainImageUrl)?default('/images/sample.jpg') !});"></p>
                        <p class="blockUi"></p>
                        <div class="desc">
                            <h4 class="line1">
                                <#if project.readyDay?exists>
                                    청약대기 D-${((project.readyDay)-1) !}
                                <#else>
                                    청약 대기중
                                </#if>
                            </h4>
                        </div>
                    </div>
                    <div class="info">
                        <div class="title">
                            <h4>${(project.name) !}</h4>
                        </div>
                        <p class="firm">${(project.user.userPublisher.corpName) !}</p>
                        <p class="state">청약 대기중</p>
                        <#if project.readyDay?exists>
                            <p>D-${(project.readyDay)-1 !}</p>
                            <p class="price target">목표금액: ${(project.targetAmt?default(0)) !}원</p>
                        </#if>
                    </div>
                </a>
            </li>
        </#list>
    </ul>
</#if>

<#if projectFinish?has_content>
    <h3 class="mt30">펀딩 종료</h3>
    <ul class="card_list">
        <#list projectFinish as project>
            <#function fnSubscribeTypeName subscribeType>
                <#if subscribeType == "1"><#return "공모"><#else><#return "사모"></#if>
            </#function>
            <li>
                <a href="/project/${project.projectId}">
                    <div class="category">
                        <div>
                            <i class="icon">${(project.category.name) !}</i>
                        ${(fnSubscribeTypeName(project.subscribeType)) !}/${(project.location) !}
                        </div>
                        <#if project.taxDeduction?default('N') == 'Y'>
                            <span class="ic_deduction">소득공제</span>
                        </#if>
                    </div>
                    <div class="thum">
                        <p class="image" style="background-image:url(${(project.mainImageUrl)?default('/images/sample.jpg') !});"></p>
                        <p class="blockUi"></p>
                        <div class="desc">
                            <h4>
                                <p>${(project.sbscNdDt?date("yyyyMMdd")?string("yyyy.MM.dd")) !} 청약 모집 종료</p>
                                <div class="mt10">
                                    <dl>
                                        <dt>목표금액</dt>
                                        <dd>
                                            <p><span>${(project.targetAmt?default(0)) !}</span>원 중</p>
                                            <p><span>${(project.sbscAmt?default(0)) !}</span>원 모집</p>
                                        </dd>
                                    </dl>
                                </div>
                            </h4>
                        </div>
                    </div>
                    <div class="info">
                        <div class="title">
                            <h4>${(project.name) !}</h4>
                        </div>
                        <#if project.successState == 'success'>
                            <p class="firm">축하합니다!</p>
                            <h2 class="fc-red">펀딩 성공!</h2>
                        <#else>
                            <p class="firm">아쉽습니다.</p>
                            <h2>펀딩 종료</h2>
                        </#if>
                        <p class="mb5"<span>${(project.sbscCount) !}</span>명</p>
                        <p class="price"><span>${(project.sbscAmt?default(0)) !}</span>원</p>
                        <#assign percent = (project.sbscAmt / project.targetAmt) * 100>
                        <#if (percent > 100)>
                            <#assign percent = percent?string("0")>
                        <#else>
                            <#assign percent = percent?string("0.#")>
                        </#if>
                        <p class="graph circleGraphic" data-form="${percent}"></p>
                    </div>
                </a>
            </li>
        </#list>
    </ul>
</#if>

<script type="text/javascript">
    $( document ).ready(function() {
        $('.circleGraphic').circleGraphic();
    });
</script>