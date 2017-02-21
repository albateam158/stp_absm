<table id="record_list_table" class="table basic table-striped dataTable">
    <thead>
    <tr>
        <th style="width:1%" class="v-align-middle text-left">
            <div class="checkbox">
                <input type="checkbox" id="checkbox0" class="unit all">
                <label for="checkbox0"></label>
            </div>
        </th>
        <th class="sort" sort="dt" style="width:5%">일자</th>
        <th class="sort" sort="deptNm" style="width:10%">부서</th>
        <th class="sort" sort="prodNm" style="width:10%">상품</th>
        <th class="sort" sort="accNm" style="width:10%">계정</th>
        <th class="sort" sort="amt" style="width:16%">금액</th>
        <th class="sort" sort="fixDeptCd" style="width:10%">보전본부</th>
        <th class="sort" sort="fixAmt" style="width:10%">조정금액</th>
    </tr>
    </thead>
    <tbody>
    <#if kPlLists?has_content>
        <#list kPlLists as kPlList>
        <tr record_id="${(kPlList.id) !}">
            <td class="v-align-middle">
                <div class="checkbox">
                    <input type="checkbox" id="checkbox${kPlList.id}" class="unit">
                    <label for="checkbox${kPlList.id}"></label>
                </div>
            </td>
            <td class="v-align-middle text-center">
                <p>${kPlList.dt}</p>
            </td>
            <td class="v-align-middle text-center">
                <p>${kPlList.deptNm}</p>
            </td>

            <td class="v-align-middle text-center">
                <p><a href="/record/form?id=${(kPlList.id) !}" class="urlLink">${kPlList.prodNm}</a></p>
            </td>

            <td class="v-align-middle text-center">
                <p>${kPlList.accNm}</p>
            </td>

            <td class="v-align-middle text-center">
                <p>${kPlList.amt}</p>
            </td>

            <td class="v-align-middle text-center">
                <p>${kPlList.fixDeptNm}</p>
            </td>
            <td class="v-align-middle text-center">
                <p>${kPlList.fixAmt}</p>
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
${paging !}
