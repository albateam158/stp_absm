<table id="unlisted_update_list_table" class="table basic table-striped dataTable">
    <thead>
    <tr>
        <th style="width:1%" class="v-align-middle text-left">
            <div class="checkbox">
                <input type="checkbox" id="checkbox0" class="unit all">
                <label for="checkbox0"></label>
            </div>
        </th>
        <th style="width:20%">#</th>
        <th class="sort" sort="title" style="width:29%">제목</th>
        <th style="width:29%">댓글 수</th>
        <th style="width:29%">상태</th>
        <th class="sort" sort="regDate" style="width:15%">등록일</th>
    </tr>
    </thead>
    <tbody>
        <#if unlistedUpdates?has_content>
            <#list unlistedUpdates as update>
                <tr update_id="${(update.updateId) !}">
                    <td class="v-align-middle">
                        <div class="checkbox">
                            <input type="checkbox" id="checkbox${update_index+1}" class="unit">
                            <label for="checkbox${update_index+1}"></label>
                        </div>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${update.updateId}</p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p><a href="/unlisted/${(update.unlistedId) !}/update/${(update.updateId) !}">${update.title}</a></p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${update.commentCount}</p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p><#if update.adminDeleteDate?has_content>삭제<#else>정상</#if></p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${update.regDate?datetime}</p>
                    </td>
                </tr>
            </#list>
        <#else>
            <tr>
                <td colspan="7" class="text-center" style="padding: 50px 0;">등록된 데이터가 없습니다.</td>
            </tr>
        </#if>
    </tbody>
</table>
${paging !}