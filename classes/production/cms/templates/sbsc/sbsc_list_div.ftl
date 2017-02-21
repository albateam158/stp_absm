<table id="sbsc_list_table" class="table basic table-striped dataTable">
    <thead>
    <tr>
        <th style="width:1%" class="v-align-middle text-left">
            <div class="checkbox">
                <input type="checkbox" id="checkbox0" class="unit all">
                <label for="checkbox0"></label>
            </div>
        </th>
        <th class="sort" sort="name" style="width:30%">종목명</th>
        <th class="sort" sort="username" style="width:10%">투자자</th>
        <th style="width:15%">투자자 유형</th>
        <th style="width:15%">청약수량(금액)</th>
        <th style="width:15%">상태</th>
        <th class="sort" sort="reg_date" style="width:10%">청약일</th>
        <th style="width:20%"></th>
    </tr>
    </thead>
    <tbody>
    <#if sbsc?has_content>
        <#list sbsc as row>
        <tr sbsc_id="${(row.sbscId) !}">
            <td class="v-align-middle">
                <div class="checkbox">
                    <input type="checkbox" id="checkbox${row_index+1}" class="unit">
                    <label for="checkbox${row_index+1}"></label>
                </div>
            </td>
            <td class="v-align-middle text-center">
                <p>${row.project.sbscIssNm}</p>
            </td>
            <td class="v-align-middle text-center">
                <p>${row.user.name}</p>
            </td>
            <td class="v-align-middle text-center">
                <#function fnInvCodeName invSortCd>
                    <#switch invSortCd>
                        <#case "02">
                            <#return "계약전문 투자자">
                            <#break>
                        <#case "03">
                            <#return "소득요건충족 투자자">
                            <#break>
                        <#case "04">
                            <#return "전문 투자자">
                            <#break>
                        <#case "05">
                            <#return "연고">
                            <#break>
                        <#default>
                            <#return "일반 투자자">
                    </#switch>
                </#function>
                <p>${fnInvCodeName(row.invSortCd)}</p>
            </td>
            <td class="v-align-middle text-center">
                <p>${row.sbscQty}주 (${row.sbscAmt})</p>
            </td>
            <td class="v-align-middle text-center">
                <#function fnStateName state>
                    <#switch state>
                        <#case "init_ok">
                            <#return "청약정보 등록 완료">
                            <#break>
                        <#case "realtime_ok">
                            <#return "청약금액 지불 완료">
                            <#break>
                        <#case "ksd_cancel">
                            <#return "KSD 취소 완료">
                            <#break>
                        <#case "acc_waiting">
                            <#return "가상걔좌 입금 대기">
                            <#break>
                        <#case "acc_ok">
                            <#return "가상걔좌 입금 완료">
                            <#break>
                        <#case "cancel">
                            <#return "청약 취소 완료">
                            <#break>
                        <#default> <#--pay_complete-->
                            <#return "청약 완료">
                    </#switch>
                </#function>
                <p>${fnStateName(row.state)}</p>
            </td>
            <td class="v-align-middle text-center">
                <p>${row.regDate?datetime}</p>
            </td>
            <td class="v-align-middle text-center">
                <button class="btn btn-success btn-cons pull-left modify" style="min-width:100px;" onclick="javascript:location.href='/sbsc/form?sbscId=${(row.sbscId) !}'">
                    <i class="fs-14 pg-comment"></i> <span>보기</span>
                </button>
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
${paging !}
