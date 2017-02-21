<table id="record_list_table" class="table basic table-striped dataTable">
    <thead>
    <tr>
        <th style="width:10%">항목</th>
        <th style="width:5%">일자</th>
        <th style="width:10%">부서</th>
        <th style="width:10%">상품</th>
        <th style="width:10%">계정</th>
        <th style="width:10%">금액</th>
        <th style="width:10%">보전부서</th>
        <th style="width:10%">보전금액</th>
        <th style="width:10%">보전받은금액</th>
        <th style="width:10%">정산수익</th>
    </tr>
    </thead>
    <tbody>
    <#if kPlLists?has_content>
        <#list kPlLists as kPlList>
        <tr>
            <#if kPlList.level == '1'>
                <td class="v-align-middle text-right">
                    <p>상품별합계</p>
                </td>
            <#elseif kPlList.level == '2'>
                <td class="v-align-middle text-right">
                    <p>부서별합계</p>
                </td>
            <#elseif kPlList.level == '3' >
                <td class="v-align-middle text-right">
                    <p>일별합계</p>
                </td>
            <#elseif kPlList.level == '4' >
                <td class="v-align-middle text-right">
                    <p>기간합계</p>
                </td>
            <#else>
                <td class="v-align-middle text-center">
                    <p></p>
                </td>
            </#if>
            <td class="v-align-middle text-center">
                <p>${(kPlList.dt) !}</p>
            </td>
            <td class="v-align-middle text-center">
                <p>${(kPlList.deptNm) !}</p>
            </td>

            <td class="v-align-middle text-center">
                <p>${(kPlList.prodNm) !}</p>
            </td>

            <td class="v-align-middle text-center">
                <p>${(kPlList.accNm) !}</p>
            </td>

            <td class="v-align-middle text-right">
                <p class="result price mt10">${(kPlList.amt) !}</p>
            </td>

            <td class="v-align-middle text-center">
                <p>${(kPlList.fixDeptNm) !}</p>
            </td>
            <td class="v-align-middle text-right">
                <p class="result price mt10">${(kPlList.amt1) !}</p>
            </td>
            <td class="v-align-middle text-right">
                <p class="result price mt10">${(kPlList.fixAmt) !}</p>
            </td>
            <td class="v-align-middle text-right">
                <p class="result price mt10">${(kPlList.amt2) !}</p>
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
${paging !}
