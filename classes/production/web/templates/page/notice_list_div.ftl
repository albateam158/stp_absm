<table cellpadding="0" cellspacing="0" id="noticeList" class="web">
    <thead>
    <tr>
        <th width="6%">No.</th>
        <th>제목</th>
        <th width="12%">등록일</th>
    </tr>
    </thead>
    <tbody>
    <#if notices?has_content>
        <#assign num1 = num>
        <#list notices as notice>
        <tr>
            <td>${num1}</td>
            <td class="t-l"><a href="/notice/${notice.noticeId}">${notice.title}</a></td>
            <td>${notice.regDate?date?string('yyyy. MM. dd')}</td>
        </tr>
            <#assign num1 = num1-1>
        </#list>
    <#else>
    <tr>
        <td colspan="3">
            <p class="no_data">등록된 공지사항이 없습니다.</p>
        </td>
    </tr>
    </#if>
    </tbody>
</table>
<table cellpadding="0" cellspacing="0" id="noticeList" class="mobile">
    <tbody>
    <#if notices?has_content>
        <#list notices as row>
        <tr>
            <td>
                <dl>
                    <dt>No.${num}</dt>
                    <dd>
                        <a href="/notice/${row.noticeId}"> <h3>${row.title}</h3></a>
                    </dd>
                </dl>
                <ul>
                    <li class="full">
                        <span>등록일</span>
                    ${row.regDate?date?string('yyyy. MM. dd')}
                    </li>
                </ul>
            </td>
        </tr>
            <#assign num = num-1>
        </#list>
    <#else>
    <tr>
        <td>
            <p class="no_data">등록된 공지사항이 없습니다.</p>
        </td>
    </tr>
    </#if>
    </tbody>
</table>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<#if notices?has_content>
${paging !}
</#if>