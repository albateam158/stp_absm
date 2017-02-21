<table id="user_list" class="table basic table-striped dataTable">
    <thead>
    <tr>
        <th style="width:1%" class="v-align-middle text-left">
            <div class="checkbox">
                <input type="checkbox" id="checkbox0" class="unit all">
                <label for="checkbox0"></label>
            </div>
        </th>
        <th style="width:10%">부서</th>
        <th style="width:20%">사원번호</th>
        <th class="sort" sort="name" style="width:20%">이름</th>
        <th style="width:29%">전화번호</th>
        <th style="width:10%">사용자 타입</th>
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
                        <p>
                        ${user.dept !}
                        </p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>
                        ${user.empNo !}
                        </p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p class="link"><a href="/user/form?userId=${user.userId}">${user.name !}</a></p>
                        <#--<p class="link">${user.name !}</p>-->
                    </td>

                    <td class="v-align-middle text-center">
                        <p>${user.phone !}</p>
                    </td>

                    <td class="v-align-middle text-center">
                        <p>
                        ${user.adminType !}
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