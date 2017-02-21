<table cellpadding="0" cellspacing="0" id="newsList" class="web">
    <thead>
    <tr>
        <th width="6%">No.</th>
        <th>제목</th>
        <th width="12%">등록일</th>
    </tr>
    </thead>
    <tbody>
    <#if news?has_content>
        <#assign num1 = num>
        <#list news as row>
            <tr>
                <td>${num1}</td>
                <td class="t-l"><a href="/news/${row.newsId}">${row.title}</a></td>
                <td>${row.regDate?date?string('yyyy. MM. dd')}</td>
            </tr>
            <#assign num1 = num1-1>
        </#list>
    <#else>
    <tr>
        <td colspan="3">
            <p class="no_data">등록된 보도자료가 없습니다.</p>
        </td>
    </tr>
    </#if>
    </tbody>
</table>
<table cellpadding="0" cellspacing="0" id="newsList" class="mobile">
    <tbody>
    <#if news?has_content>
        <#list news as row>
        <tr>
            <td>
                <dl>
                    <dt>No.${num}</dt>
                    <dd>
                        <a href="/news/${row.newsId}"> <h3>${row.title}</h3></a>
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
            <p class="no_data">등록된 보도자료가 없습니다.</p>
        </td>
    </tr>
    </#if>
    </tbody>
</table>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<#if news?has_content>
${paging !}
</#if>