<table id="request_list_table" class="table basic table-striped dataTable">
    <thead>
    <tr>
        <th style="width:1%" class="v-align-middle text-left">
            <div class="checkbox">
                <input type="checkbox" id="checkbox0" class="unit all">
                <label for="checkbox0"></label>
            </div>
        </th>
        <th class="sort" sort="corp_name" style="width:20%">회사이름</th>
        <th style="width:20%">위치</th>
        <th style="width:10%">매니저 이름</th>
        <th style="width:10%">매니저 전화번호</th>
        <th style="width:10%">매니저 이메일</th>
        <th class="sort" sort="reg_date" style="width:16%">등록일</th>
    </tr>
    </thead>
    <tbody>
    <#if publisherRequests?has_content>
        <#list publisherRequests as publisherRequest>
        <tr request_id="${(publisherRequest.requestId) !}">
            <td class="v-align-middle">
                <div class="checkbox">
                    <input type="checkbox" id="checkbox${publisherRequest_index+1}" class="unit">
                    <label for="checkbox${publisherRequest_index+1}"></label>
                </div>
            </td>
            <td class="v-align-middle text-center">
                <p><a href="/request/form?requestId=${(publisherRequest.requestId) !}">${publisherRequest.corpName}</a></p>
            </td>
            <td class="v-align-middle text-center">
                <p>${publisherRequest.location}</p>
            </td>
            <td class="v-align-middle text-center">
                <p>${publisherRequest.managerName}</p>
            </td>
            <td class="v-align-middle text-center">
                <p>${publisherRequest.managerPhone}</p>
            </td>
            <td class="v-align-middle text-center">
                <p>${publisherRequest.managerEmail}</p>
            </td>
            <td class="v-align-middle text-center">
                <p>${publisherRequest.regDate?datetime}</p>
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
