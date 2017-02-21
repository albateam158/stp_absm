<table id="relative_list_table" class="table basic table-striped dataTable">
    <thead>
    <tr>
        <th style="width:1%" class="v-align-middle text-left">
            <div class="checkbox">
                <input type="checkbox" id="checkbox0" class="unit all">
                <label for="checkbox0"></label>
            </div>
        </th>
        <th style="width:20%;" class="sort" sort="name">종목명</th>
        <th style="width:8%">신청인</th>
        <th style="width:8%">상태</th>
        <th class="sort" sort="reg_date" style="width:10%">등록일</th>
        <th style="width:10%"></th>
    </tr>
    </thead>
    <tbody>
        <#if projectRelatives?has_content>
            <#list projectRelatives as projectRelative>
                <tr relative_id="${(projectRelative.relativeId) !}">
                    <td class="v-align-middle">
                        <div class="checkbox">
                            <input type="checkbox" id="checkbox${projectRelative_index+1}" class="unit">
                            <label for="checkbox${projectRelative_index+1}"></label>
                        </div>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${(projectRelative.project.sbscIssNm) !}</p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${(projectRelative.user.name) !}</p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p><#if projectRelative.status == "approved">승인<#else>미승인</#if></p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${projectRelative.regDate?datetime}</p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p><button class="btn btn-default btn-xs m-t-10 view-btn">보기</button></p>
                    </td>
                </tr>
            </#list>
        <#else>
            <tr>
                <td colspan="6" class="text-center" style="padding: 50px 0;">등록된 데이터가 없습니다.</td>
            </tr>
        </#if>
    </tbody>
</table>
${paging !}