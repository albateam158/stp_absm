<table id="mail_list_table" class="table basic table-striped dataTable">
    <thead>
    <tr>
        <th style="width:1%" class="v-align-middle text-left">
            <div class="checkbox">
                <input type="checkbox" id="checkbox0" class="unit all">
                <label for="checkbox0"></label>
            </div>
        </th>
        <th class="sort" sort="project_id" style="width: 15%;">모집</th>
        <th class="sort" sort="title">제목</th>
        <th class="sort" sort="mail_state" style="width:20%">상태</th>
        <th style="width:10%">성공 수</th>
        <th style="width:10%">실패 수</th>
        <th class="sort" sort="reg_date" style="width:16%">등록일</th>
    </tr>
    </thead>
    <tbody>
    <#if mails?has_content>
        <#list mails as mail>
        <tr mail_id="${(mail.mailId) !}">
            <td class="v-align-middle">
                <div class="checkbox">
                    <input type="checkbox" id="checkbox${mail_index+1}" class="unit">
                    <label for="checkbox${mail_index+1}"></label>
                </div>
            </td>
            <td class="v-align-middle text-center">
                <p>${mail.project.name}</p>
            </td>
            <td class="v-align-middle text-center">
                <p><a href="/mail/form?mailId=${(mail.mailId) !}">${mail.title}</a></p>
            </td>
            <td class="v-align-middle text-center">
                <#function fnMailStateName mailState>
                    <#switch mailState>
                        <#case "ing">
                            <#return "전송중">
                            <#break>
                        <#case "complete">
                            <#return "전송완료">
                            <#break>
                        <#default> <!--ready-->
                            <#return "전송대기">
                    </#switch>
                </#function>
                <p>${fnMailStateName(mail.mailState)}</p>
            </td>
            <td class="v-align-middle text-center">
                <p>${mail.successCount?default(0)}</p>
            </td>
            <td class="v-align-middle text-center">
                <p>${mail.failCount?default(0)}</p>
            </td>
            <td class="v-align-middle text-center">
                <p>${mail.regDate?datetime}</p>
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
