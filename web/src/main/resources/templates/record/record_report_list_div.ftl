<table id="record_list_table" class="table basic table-striped dataTable">
    <thead>
    <tr>
        <th style="width:10%">부문</th>
        <th style="width:10%">본부</th>
        <th style="width:10%">당일수익</th>
        <th style="width:10%">월누계</th>
        <th style="width:10%">기누계</th>

    </tr>
    </thead>
    <tbody>
    <#if kPlLists?has_content>
        <#list kPlLists as kPlList>
        <tr>
            <td class="v-align-middle text-center">
                <#if kPlList.level == '2'>
                    <p>${(kPlList.sectNm) !}</p>
                <#elseif kPlList.level == '3'>
                    <p>소계</p>
                <#elseif kPlList.level == '4'>
                    <p>총합계</p>
                </#if>
            </td>
            <td class="v-align-middle text-center">
                <#if kPlList.level == '2'>
                    <p>${(kPlList.deptNm) !}</p>
                </#if>
            </td>
            <td class="v-align-middle text-right">
                <p class="result price mt10">${(kPlList.amt1) !}</p>
            </td>
            <td class="v-align-middle text-right">
                <p class="result price mt10">${(kPlList.amt2) !}</p>
            </td>
            <td class="v-align-middle text-right">
                <p class="result price mt10">${(kPlList.amt3) !}</p>
            </td>

        </tr>
        </#list>
    <#else>
    <tr>
        <td colspan="11" class="text-center" style="padding: 50px 0;">등록된 데이터가 없습니다.</td>
    </tr>
    </#if>
    </tbody>
</table>
