<table id="qna_list_table" class="table basic table-striped dataTable">
    <thead>
    <tr>
        <th style="width:1%" class="v-align-middle text-left">
            <div class="checkbox">
                <input type="checkbox" id="checkbox0" class="unit all">
                <label for="checkbox0"></label>
            </div>
        </th>
        <th style="width:20%">문의 유형</th>
        <th class="sort" sort="title" style="width:20%">제목</th>
        <th style="width:20%">작성자</th>
        <th style="width:20%">답변 여부</th>
        <th class="sort" sort="reg_date" style="width:16%">등록일</th>
    </tr>
    </thead>
    <tbody>
    <#if qnas?has_content>
        <#list qnas as qna>
        <tr qna_id="${qna.qnaId !}">
            <td class="v-align-middle">
                <div class="checkbox">
                    <input type="checkbox" id="checkbox${qna_index+1}" class="unit">
                    <label for="checkbox${qna_index+1}"></label>
                </div>
            </td>
            <td class="v-align-middle text-center">${(qna.codeName) !}</td>
            <td class="v-align-middle text-center">
                <a href="/qna/form?qnaId=${(qna.qnaId) !}">${qna.title}</a>
            </td>
            <td class="v-align-middle text-center">${(qna.userName) !}</td>
            <td class="v-align-middle text-center"><#if qna.answer?exists>Y<#else>N</#if></td>
            <td class="v-align-middle text-center">${qna.regDate?datetime}</td>
        </tr>
        </#list>
    <#else>
    <tr>
        <td colspan="6" class="text-center" style="padding: 50px 0;">등록된 데이터가 없습니다.</td>
    </tr>
    </#if>
    </tbody>
</table>
${paging}