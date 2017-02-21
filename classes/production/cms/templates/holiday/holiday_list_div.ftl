<table id="holiday_list_table" class="table basic table-striped dataTable">
    <thead>
    <tr>
        <th style="width:1%" class="v-align-middle text-left">
            <div class="checkbox">
                <input type="checkbox" id="checkbox0" class="unit all">
                <label for="checkbox0"></label>
            </div>
        </th>
        <th class="sort" sort="title" style="width:30%">제목</th>
        <th class="sort" sort="holiday_date" style="width:30%">휴일</th>
        <th class="sort" sort="reg_date" style="width:16%">등록일</th>
    </tr>
    </thead>
    <tbody>
    <#if holidays?has_content>
        <#list holidays as holiday>
        <tr holiday_id="${(holiday.holidayId) !}">
            <td class="v-align-middle">
                <div class="checkbox">
                    <input type="checkbox" id="checkbox${holiday_index+1}" class="unit">
                    <label for="checkbox${holiday_index+1}"></label>
                </div>
            </td>
            <td class="v-align-middle text-center">
                <p>${holiday.title}</p>
            </td>
            <td class="v-align-middle text-center">
                <p>${holiday.holidayDate?date("yyyyMMdd")?string("yyyy.MM.dd")}</p>
            </td>
            <td class="v-align-middle text-center">
                <p>${holiday.regDate?datetime}</p>
            </td>
        </tr>
        </#list>
    <#else>
    <tr>
        <td colspan="4" class="text-center" style="padding: 50px 0;">등록된 데이터가 없습니다.</td>
    </tr>
    </#if>
    </tbody>
</table>
${paging !}
