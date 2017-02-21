<table id="record_list_table" class="table basic table-striped dataTable">
    <thead>
    <tr>
        <th style="width:10%">구분</th>
        <th style="width:15%">사규명</th>
        <th style="width:15%">제정일</th>
        <th style="width:15%">최근개정일</th>
        <th style="width:15%">다운로드</th>
        <th style="width:15%">소관부서</th>
        <th style="width:15%">지난사규</th>
    </tr>
    </thead>
    <tbody>
    <#if kIRLists?has_content>
        <#list kIRLists as kIRList>
        <tr rule_id="${(kIRList.ruleId) !}">

            <td class="v-align-middle text-center">
                <p>${kIRList.data2}. ${kIRList.groupNm}</p>
            </td>
            <td class="v-align-middle text-center">
                <p>${kIRList.ruleNm}</p>
            </td>

            <td class="v-align-middle text-center">
                <p>${kIRList.establishDt?date("yyyyMMdd")?string("yyyy-MM-dd") !}</p>
            </td>

            <td class="v-align-middle text-center">
                <#assign reformDt = "${(kIRList.reformDt)?default('')}">

                <p><#if reformDt?has_content> ${kIRList.reformDt?date("yyyyMMdd")?string("yyyy-MM-dd") !}<#else>-</#if></p>
            </td>

            <td class="v-align-middle text-center">
                <p><a href="/ruleFile/${(kIRList.recentFile)!}"  download="${(kIRList.recentFileName)!}">${(kIRList.recentFileName)!}</a> </p>
            </td>

            <td class="v-align-middle text-center">
                <p>${(kIRList.chargeDeptNm)!} ${(kIRList.chargeDeptDetail)!}</p>
            </td>
            <td class="v-align-middle text-center">
                <p><a href="/ruleFile/${(kIRList.beforeFile)!}"   download="${(kIRList.beforeFileName)!}">${(kIRList.beforeFileName)!}</a> </p>
            </td>

        </tr>
        </#list>
    <#else>
    <tr>
        <td colspan="12" class="text-center" style="padding: 50px 0;">등록된 데이터가 없습니다.</td>
    </tr>
    </#if>
    </tbody>
</table>
<#--${paging !}-->
