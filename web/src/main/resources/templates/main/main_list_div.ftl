<table id="main_list_table" class="table basic table-striped dataTable">
    <thead>
    <tr>
        <th style="width:1%" class="v-align-middle text-left">
            <div class="checkbox">
                <input type="checkbox" id="checkbox0" class="unit all">
                <label for="checkbox0"></label>
            </div>
        </th>
        <th style="width:20%">이미지</th>
        <th style="width:10%">프로젝트</th>
        <th class="sort" sort="name" style="width:20%">제목</th>
        <th style="width:10%">상태</th>
        <th class="sort" sort="reg_date" style="width:16%">등록일</th>
    </tr>
    </thead>
    <tbody>
        <#if mainProjects?has_content>
            <#list mainProjects as main>
                <tr main_id="${(main.mainId) !}">
                    <td class="v-align-middle">
                        <div class="checkbox">
                            <input type="checkbox" id="checkbox${main_index+1}" class="unit">
                            <label for="checkbox${main_index+1}"></label>
                        </div>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>
                            <img src="${(main.image) !}" style="max-width: 120px;" />
                        </p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${(main.project.name) !}</p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p><a href="/main/form?mainId=${(main.mainId) !}">${main.title}</a></p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p><#if main.deleteDate?exists>삭제<#else>정상</#if></p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${main.regDate?datetime}</p>
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
