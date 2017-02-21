<table id="faq_list_table" class="table basic table-striped dataTable dataListTable">
    <thead>
    <tr>
        <th style="width:3%" class="v-align-middle text-left">
            <div class="checkbox">
                <input type="checkbox" id="checkbox0" class="unit all">
                <label for="checkbox0"></label>
            </div>
        </th>
        <th class="sort" sort="faq_type" style="width:15%">문의 유형</th>
        <th class="sort" sort="question">질문</th>
        <th class="sort" sort="reg_date" style="width:15%">등록일</th>
    </tr>
    </thead>
    <tbody>
    <#if faqs?has_content>
        <#list faqs as faq>
        <tr faq_seq="${(faq.faqSeq) !}">
            <td class="v-align-middle">
                <div class="checkbox">
                    <input type="checkbox" id="checkbox${faq_index+1}" class="unit">
                    <label for="checkbox${faq_index+1}"></label>
                </div>
            </td>
            <td class="v-align-middle text-center">
                <#if faq.faqType == 'invest'>
                    투자자
                <#else>
                    발행기업
                </#if>
            </td>
            <td class="v-align-middle text-center">
                <a href="/faq/form?faqSeq=${(faq.faqSeq) !}">${faq.question}</a>
            </td>
            <td class="v-align-middle text-center">${faq.regDate?datetime}</td>
        </tr>
        </#list>
    <#else>
    <tr>
        <td colspan="4" class="text-center" style="padding: 50px 0;">등록된 데이터가 없습니다.</td>
    </tr>
    </#if>
    </tbody>
</table>