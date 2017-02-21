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
        <th style="width:29%">이메일</th>
        <th style="width:10%">사유</th>
        <th style="width:10%">상태</th>
        <th class="sort" sort="out_date" style="width:15%">탈퇴일</th>
        <th class="sort" sort="outed_date" style="width:15%">영구 탈퇴일</th>
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
                        <p>${user.name !}</p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${user.email !}</p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${user.content !}</p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>
                            <#if user.userState?exists>
                                <#if user.userState == "out">
                                    탈퇴
                                <#else>
                                    영구 탈퇴
                                </#if>
                            <#else>
                                정상
                            </#if>
                        </p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${user.outDate?datetime !}</p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${(user.outedDate?datetime) !}</p>
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