<table cellpadding="0" cellspacing="0" id="qnaList" class="web">
    <thead>
        <tr>
            <th width="6%">No.</th>
            <th>제목</th>
            <th width="17%">질문유형</th>
            <th width="12%">등록일</th>
            <th width="7%">답변</th>
        </tr>
    </thead>
    <tbody>
    <#if qnas?has_content>
        <#assign num1 = num>
        <#list qnas as qna>
            <tr>
                <td>${num1}</td>
                <td class="t-l"><a href="/qna/${qna.qnaId}">${qna.title}</a></td>
                <td>${qna.codeName}</td>
                <td>${qna.regDate?date?string('yyyy. MM. dd')}</td>
                <td><#if qna.answer?exists>O<#else>X</#if></td>
            </tr>
            <#assign num1 = num1-1>
        </#list>
    <#else>
        <tr>
            <td colspan="5">
                <p class="no_data">문의 내역이 없습니다.</p>
            </td>
        </tr>
    </#if>

    </tbody>
</table>
<table cellpadding="0" cellspacing="0" id="qnaList" class="mobile">
    <tbody>
    <#if qnas?has_content>
        <#list qnas as qna>
        <tr>
            <td>
                <dl>
                    <dt>No.${num}</dt>
                    <dd>
                        <a href="/qna/${qna.qnaId}">
                            <h3>
                                ${qna.title}
                                <#if qna.answer?exists><p class="answer">답변완료</p><#else><p>미답변</p></#if>
                            </h3>
                        </a>
                    </dd>
                </dl>
                <ul>
                    <li>
                        <span>질문유형</span> ${qna.codeName}
                    </li>
                    <li>
                        <span>등록일</span>
                        ${qna.regDate?date?string('yyyy. MM. dd')}
                    </li>
                </ul>
            </td>
        </tr>
            <#assign num = num-1>
        </#list>
    <#else>
    <tr>
        <td>
            <p class="no_data">문의 내역이 없습니다.</p>
        </td>
    </tr>
    </#if>
    </tbody>
</table>
<p class="pl10 pr10 mobile"><a href="/qna" class="btn btn_type03">1:1문의하기</a></p>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">

<#if qnas?has_content>
${paging !}
</#if>