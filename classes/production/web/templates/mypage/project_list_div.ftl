<table cellpadding="0" cellspacing="0" id="projectList" class="web">
    <thead>
    <tr>
        <th>No.</th>
        <th>[청약상태] 모집명</th>
        <th>청약금액</th>
        <th>모집상태</th>
        <th>취소신청</th>
        <th>청약 마감일</th>
        <th>청약 신청일</th>
        <th>결과출력</th>
    </tr>
    </thead>
    <tbody>
    <#if sbscs?has_content>
        <#assign num1 = num>
        <#list sbscs as sbsc>
            <tr>
                <td>${num1}</td>
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
                        <#case "cancel">
                            <#return "청약 취소 완료">
                            <#break>
                        <#default> <#--pay_complete-->
                            <#return "청약 완료">
                    </#switch>
                </#function>
                <td class="t-l">[${(fnStateName(sbsc.state)) !}<#if sbsc.state == 'cancel' && sbsc.cancelMsg?exists && sbsc.cancelMsg != ''>:${sbsc.cancelMsg !}</#if>] ${sbsc.project.name}</td>
               <td>${sbsc.sbscAmt}원</td>
                <#function fnSuccessStateName successState>
                    <#switch successState>
                        <#case "success">
                            <#return "성공">
                            <#break>
                        <#case "fail">
                            <#return "실패">
                            <#break>
                        <#case "finish">
                            <#return "마감">
                            <#break>
                        <#default> <#--ing-->
                            <#return "진행중">
                    </#switch>
                </#function>
                <td>${fnSuccessStateName(sbsc.project.successState)}</td>
                <td>
                    <#if (sbsc.state) == 'pay_complete' && (sbsc.project.successState) == 'ing'>
                    <input type="button" class="btn_type02 crs_cancel" sbsc_id="${(sbsc.sbscId) !}" value="청약취소">
                    </#if>
                </td>
                <td>${(sbsc.project.sbscNdDt?date("yyyyMMdd")?string("yyyy.MM.dd")) !}</td>
                <td>${sbsc.regDate?date?string('yyyy. MM. dd')}</td>
                <td>
                    <#if (sbsc.state) == 'pay_complete'>
                    <input type="button" class="btn_type02 print" sbsc_id="${(sbsc.sbscId) !}" value="청약 신청서">
                    </#if>
                </td>
            </tr>
            <#assign num1 = num1-1>
        </#list>
    <#else>
        <tr>
            <td colspan="8">
                <p class="no_data">투자 지원한 내역이 없습니다.</p>
            </td>
        </tr>
    </#if>
    </tbody>
</table>
<table cellpadding="0" cellspacing="0" id="projectList" class="mobile">
<tbody>
    <#if sbscs?has_content>
        <#list sbscs as sbsc>
            <tr>
                <td>
                    <dl>
                        <dt>No.${num}</dt>
                        <dd>
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
                                    <#case "cancel">
                                        <#return "청약 취소 완료">
                                        <#break>
                                    <#default> <#--pay_complete-->
                                        <#return "청약 완료">
                                </#switch>
                            </#function>
                            <p>
                                <span>
                                    [${(fnStateName(sbsc.state)) !}]
                                    <#if (sbsc.state) == 'pay_complete'>
                                        <input type="button" class="btn_type01 grey crs_cancel" sbsc_id="${(sbsc.sbscId) !}" value="청약취소">
                                    </#if>
                                </span>
                            </p>
                            <h3>${sbsc.project.name}</h3>
                        </dd>
                    </dl>
                    <ul>
                        <li>
                            <span>청약금액</span> ${sbsc.sbscAmt}원
                        </li>
                        <li>
                            <span>모집상태</span>
                            <#function fnSuccessStateName successState>
                                <#switch successState>
                                    <#case "success">
                                        <#return "성공">
                                        <#break>
                                    <#case "fail">
                                        <#return "실패">
                                        <#break>
                                    <#default> <#--ing-->
                                        <#return "진행중">
                                </#switch>
                            </#function>
                            ${fnSuccessStateName(sbsc.project.successState)}
                        </li>
                        <li>
                            <span>청약 마감일</span> ${(sbsc.project.sbscNdDt?date("yyyyMMdd")?string("yyyy.MM.dd")) !}
                        </li>
                        <li>
                            <span>청약 신청일</span> ${sbsc.regDate?date?string('yyyy. MM. dd')}
                        </li>
                    </ul>
                    <#if (sbsc.state) == 'pay_complete'>
                        <input type="button" class="btn_type01 grey print" sbsc_id="" value="청약신청서">
                    </#if>
                </td>
            </tr>
            <#assign num = num-1>
        </#list>
    <#else>
        <tr>
            <td>
                <p class="no_data">투자 지원한 내역이 없습니다.</p>
            </td>
        </tr>
    </#if>
</tbody>
</table>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<#if sbscs?has_content>
${paging !}
</#if>