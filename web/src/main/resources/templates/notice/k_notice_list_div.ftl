<table id="notice_list_table" class="table table-bordered table-hover dataTable" role="grid" aria-describedby="notice_list_table_info">
    <thead>
    <tr>
        <td style="width:6%;bold;" align="center" valign="middle">번호</td>
        <td style="width:64%;bold;" align="center" valign="middle">제목</td>
        <td style="width:10%;bold;" align="center" valign="middle">작성자</td>
        <td style="width:10%;bold;" align="center" valign="middle">작성일</td>
        <td style="width:6%;bold;" align="center" valign="middle">조회</td>
    </tr>
    </thead>
    <tbody>
    <#if notices?has_content>
        <#list notices as notice>
        <tr notice_id="${(notice.uid) !}">
            <td align="center" valign="middle">
                ${(notice.displayId) !}
            </td>
            <td align="left" valign="middle">
                <a href="/knotice/read_form/${(boardId)!}?uid=${(notice.uid) !}">
                    ${(notice.title) !}
                </a>
            </td>
            <td align="center" valign="middle">
            ${(notice.memberDisplay) !}
            </td>
            <td align="center" valign="middle">
            ${(notice.update?datetime("yyyyMMddHHmmss")?string("yyyy-MM-dd HH:mm:ss"))  !}
            </td>
            <td align="center" valign="middle">
            ${(notice.view?default(0)) !}
            </td>
        </tr>
        </#list>
    <#else>
    <tr>
        <td colspan="5" style="padding: 50px 0;">등록된 데이터가 없습니다.</td>
    </tr>
    </#if>
    </tbody>
</table>
${paging !}