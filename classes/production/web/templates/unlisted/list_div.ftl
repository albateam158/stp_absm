<#if unlisteds?has_content>
    <#list unlisteds as unlisted>
        <tr unlistedId="${(unlisted.unlistedId)!}" class="web">
            <td>
                <strong>${(unlisted.sectionName) !}</strong>
            </td>
            <td>
                <h4>${(unlisted.name)!}</h4>
                <p class="fc-lightgrey fs-13 mt5">${(unlisted.businessType)!}</p>
            </td>
            <td>
                <strong>${(unlisted.capital) !}</strong>
            </td>
            <td>
                <strong>${(unlisted.totalCapital) !}</strong>
            </td>
            <td>
                <strong>${(unlisted.totalLiability) !}</strong>
            </td>
            <td>
                <strong>${(unlisted.sales) !}</strong>
            </td>
            <td>
                <strong>${(unlisted.businessProfits) !}</strong>
            </td>
        </tr>
    </#list>
<#else>
   <tr class="web">
        <td colspan="7" class="no_data">
            <p>등록된 비상장기업이 없습니다.</p>
        </td>
    </tr>
</#if>

<#if unlisteds?has_content>
    <#list unlisteds as unlisted>
        <tr unlistedId="${(unlisted.unlistedId)!}" class="mobile">
            <td colspan="7">
                <div>
                    <div>
                        <dl>
                            <dt>종목명</dt>
                            <dd>
                                <h4>${(unlisted.name)!}</h4>
                                <span class="fc-lightgrey fs-13 ml10">${(unlisted.businessType)!}</span>
                            </dd>
                        </dl>
                    </div>
                    <div class="info">
                        <dl>
                            <dt>분류</dt>
                            <dd><strong>${(unlisted.sectionName) !}</strong></dd>
                        </dl>
                        <dl>
                            <dt>자본금(백만)</dt>
                            <dd><strong>${(unlisted.capital) !}</strong></dd>
                        </dl>
                        <dl>
                            <dt>자산총계(백만)</dt>
                            <dd><strong>${(unlisted.totalCapital) !}</strong></dd>
                        </dl>
                        <dl>
                            <dt>부채총계(백만)</dt>
                            <dd><strong>${(unlisted.totalLiability) !}</strong></dd>
                        </dl>
                        <dl>
                            <dt>매출액(백만)</dt>
                            <dd><strong>${(unlisted.sales) !}</strong></dd>
                        </dl>
                        <dl>
                            <dt>영업이익(백만)</dt>
                            <dd><strong>${(unlisted.businessProfits) !}</strong></dd>
                        </dl>
                    </div>
                </div>
            </td>
        </tr>
    </#list>
<#else>
    <tr class="mobile">
        <td colspan="7" class="no_data">
            <p>등록된 비상장기업이 없습니다.</p>
        </td>
    </tr>
</#if>

<script type="text/javascript">
    $( document ).ready(function() {
        $('a.plus.more').attr('totalPage', ${totalPage?default(1) !});
        $('a.plus.more').attr('page', ${page?default(0) + 1 !});

        var page = parseInt($('a.plus.more').attr('page'));
        var totalPage = parseInt($('a.plus.more').attr('totalPage'));

        if(page == totalPage) {
            $('a.plus.more').parent().hide();
        }
        else {
            $('a.plus.more').parent().show();
        }
    });
</script>