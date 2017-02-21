<table id="unlisted_list_table" class="table basic table-striped dataTable">
    <thead>
    <tr>
        <th style="width:1%" class="v-align-middle text-left">
            <div class="checkbox">
                <input type="checkbox" id="checkbox0" class="unit all">
                <label for="checkbox0"></label>
            </div>
        </th>
        <th class="sort" sort="name">종목명</th>
        <th class="sort" sort="section">분류</th>
        <th style="width:10%">자본금(백만)</th>
        <th style="width:10%">자산총계(백만)</th>
        <th style="width:10%">부채총계(백만)</th>
        <th style="width:10%">매출액(백만)</th>
        <th style="width:10%">영업이익(백만)</th>
        <th style="width:10%">당기순이익(백만)</th>
        <th class="sort" sort="reg_date" style="width:10%">등록일</th>
        <th style="width:5%"></th>
    </tr>
    </thead>
    <tbody>
        <#if unlisteds?has_content>
            <#list unlisteds as unlisted>
                <tr unlisted_id="${(unlisted.unlistedId) !}">
                    <td class="v-align-middle">
                        <div class="checkbox">
                            <input type="checkbox" id="checkbox${unlisted_index+1}" class="unit">
                            <label for="checkbox${unlisted_index+1}"></label>
                        </div>
                    </td>
                    <td class="v-align-middle text-center">
                        <p><a href="/unlisted/form?unlistedId=${(unlisted.unlistedId) !}" class="urlLink">${(unlisted.name) !}</a></p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${(unlisted.sectionName) !}</p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>
                            ${(unlisted.capital) !}
                        </p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>
                            ${(unlisted.totalCapital) !}
                        </p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>
                        ${(unlisted.totalLiability) !}
                        </p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>
                        ${(unlisted.sales) !}
                        </p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>
                        ${(unlisted.businessProfits) !}
                        </p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>
                        ${(unlisted.termProfits) !}
                        </p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${unlisted.regDate?datetime}</p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p><a href="/unlisted/${(unlisted.unlistedId) !}/update"><button class="btn btn-default btn-xs m-t-10">Update</button></a></p>
                    </td>
                </tr>
            </#list>
        <#else>
            <tr>
                <td colspan="9" class="text-center" style="padding: 50px 0;">등록된 데이터가 없습니다.</td>
            </tr>
        </#if>
    </tbody>
</table>
${paging !}