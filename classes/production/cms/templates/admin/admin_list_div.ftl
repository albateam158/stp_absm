<table id="user_list" class="table basic table-striped dataTable">
    <thead>
    <tr>
        <th style="width:1%" class="v-align-middle text-left">
            <div class="checkbox">
                <input type="checkbox" id="checkbox0" class="unit all">
                <label for="checkbox0"></label>
            </div>
        </th>
        <th class="sort" sort="name" style="width:20%">이름</th>
        <th style="width:20%">사업자번호(실명번호)</th>
        <th style="width:29%">이메일</th>
        <th style="width:10%">타입</th>
        <th style="width:10%">상태</th>
        <th class="sort" sort="reg_date" style="width:15%">등록일</th>
    </tr>
    </thead>
    <tbody>
        <#if users?has_content>
            <#list users as user>
                <tr user_id="${user.userId !}">
                    <td class="v-align-middle">
                        <div class="checkbox">
                            <input type="checkbox" id="checkbox${user_index+1}" class="unit">
                            <label for="checkbox${user_index+1}"></label>
                        </div>
                    </td>
                    <td class="v-align-middle text-center">
                        <#--<p><a href="/user/form?userId=${user.userId}">${user.name !}</a></p>-->
                        <p class="link">${user.name !}</p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>
                            <#if user.userType == "publisher">
                                ${(user.userPublisher.buzno) !}
                            <#elseif user.userType == "investor">
                                ${(user.userInvestor.realnmno) !}
                            <#else>
                                -
                            </#if>
                        </p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${user.email !}</p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${user.userType !}</p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>
                            <#if user.userInvestor?exists>
                                <#if user.userInvestor.status?exists>
                                    <#if user.userInvestor.status == "approved">
                                        승인 투자자
                                    <#else>
                                        미승인 투자자
                                    </#if>
                                <#else>
                                    정상
                                </#if>
                            <#else>
                                정상
                            </#if>
                        </p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${user.regDate?datetime !}</p>
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

${paging}