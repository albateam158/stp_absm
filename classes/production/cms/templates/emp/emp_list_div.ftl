<table id="emp_list" class="table basic table-striped dataTable">
    <thead>
    <tr>
        <th style="width:15%">부서</th>
        <th style="width:10%">직위</th>
        <th style="width:5%">사번</th>
        <th style="width:10%">이름</th>
        <th style="width:10%">내선번호</th>
        <th style="width:10%">휴대번호</th>
        <th style="width:10%">이메일</th>
        <th style="width:20%">비고</th>
    </tr>
    </thead>
    <tbody>
        <#if emps?has_content>
            <#list emps as emp>
                <tr emp_cd="${emp.empCd !}">
                    <td class="v-align-middle text-center">
                        <#--<p><a href="/emp/form?empId=${emp.empId}">${emp.name !}</a></p>-->
                        <p>${emp.deptNm !}</p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${emp.hclsNm !}</p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${emp.empCd !}</p>
                        <#--<p class="link">${emp.empCd !}</p>-->
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${emp.korNm !}</p>
                        <#--<p class="link">${emp.korNm !}</p>-->
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${emp.tel !}</p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${emp.hp !}</p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>${emp.emalAdd !}</p>
                    </td>
                    <td class="v-align-middle text-center">
                        <p>
                        <#if emp.hplcNm?has_content >
                        ${emp.hplcNm !}
                        <#else>
                        ${emp.hrspNm !}
                        </#if></p>
                    </td>
                </tr>
            </#list>
        <#else>
            <tr>
                <td colspan="8" class="text-center" style="padding: 50px 0;">등록된 데이터가 없습니다.</td>
            </tr>
        </#if>
    </tbody>
</table>

${paging}