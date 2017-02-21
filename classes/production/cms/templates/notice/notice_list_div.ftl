<table id="notice_list_table" class="table basic table-striped dataTable">
    <thead>
    <tr>
        <th style="width:1%" class="v-align-middle text-left">
            <div class="checkbox">
                <input type="checkbox" id="checkbox0" class="unit all">
                <label for="checkbox0"></label>
            </div>
        </th>
        <th class="sort" sort="title" style="width:20%">제목</th>
        <th class="sort" sort="reg_date" style="width:16%">등록일</th>
    </tr>
    </thead>
    <tbody>
    <#if notices?has_content>
        <#list notices as notice>
        <tr notice_id="${(notice.noticeId) !}">
            <td class="v-align-middle">
                <div class="checkbox">
                    <input type="checkbox" id="checkbox${notice_index+1}" class="unit">
                    <label for="checkbox${notice_index+1}"></label>
                </div>
            </td>
            <td class="v-align-middle text-center">
                <p><a href="/notice/form?noticeId=${(notice.noticeId) !}">${notice.title}</a></p>
            </td>
            <td class="v-align-middle text-center">
                <p>${notice.regDate?datetime}</p>
            </td>
        </tr>
        </#list>
    <#else>
    <tr>
        <td colspan="3" class="text-center" style="padding: 50px 0;">등록된 데이터가 없습니다.</td>
    </tr>
    </#if>
    </tbody>
</table>
${paging !}
