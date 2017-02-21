<input type="hidden" class="currentPage" name="currentPage" value="${(page + 1) !}" />
<ul class="card_list">
    <#if projects?has_content>
        <#list projects as project>

            <#function fnSubscribeTypeName subscribeType>
                <#if subscribeType == "1"><#return "공모"><#else><#return "사모"></#if>
            </#function>
            <#assign endDate = project.sbscNdDt?datetime("yyyyMMdd")?long >
            <#assign nowDate = .now?string.yyyyMMdd?datetime("yyyyMMdd")?long >
            <#assign dDay = ((endDate - nowDate) / (1000 * 60 * 60 * 24))?int >
            <li>
                <a href="/project/${(project.projectId) !}">
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
                        <p class="image" style="background-image:url(<#if project.mainImageUrl?exists >${project.mainImageUrl}<#else>'images/sample.jpg'</#if>);"></p>
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
    </#if>
</ul>

<script type="text/javascript">
$( document ).ready(function() {
    $('.circleGraphic').circleGraphic();
    $('.card_list .graph').removeClass('circleGraphic');
    $('.thum_wrap.project a.plus.more').attr('totalPage', ${totalPage?default(1) !});

    var page = parseInt($('.thum_wrap.project a.plus.more').attr('page'));
    var totalPage = parseInt($('.thum_wrap.project a.plus.more').attr('totalPage'));

    if(page == totalPage) {
        $('.thum_wrap.project a.plus.more').parent().remove();
    }
});
</script>
