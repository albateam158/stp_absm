<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0">
    <link rel="icon" type="image/x-icon" href="/images/favicon.jpg" />
    <link rel="shortcut icon" type="image/x-icon" href="/images/favicon.jpg" />
    <title>KOREA ASSET WICROWD - 청약신청서</title>
    <meta name="author" content="UCANSTART" />

    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/fonts.css" />
    <link rel="stylesheet" type="text/css" href="/css/custom.css" />

    <script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="/js/jquery.PrintArea.js" /></script>
    <script type="text/javascript">
            $(function() {
                $('.btn_print').click(function(){
                    $('.print_wrap').printArea();
                    return false;
                });
            });
    </script>
</head>
<body>
<div class="print_wrap">
    <a class="btn_print"></a>
    <h2>청약 신청서</h2>

    <table cellpadding="0" cellspacing="0">
        <col style="width:20%;">
        <col style="width:30%;">
        <col style="width:20%;">
        <col style="width:30%;">
        <tbody>
        <tr>
            <th>구 &nbsp; &nbsp; &nbsp; 분</th>
            <td colspan="3">청 &nbsp; &nbsp; 약 &nbsp; &nbsp; 내 &nbsp; &nbsp; 용</td>
        </tr>
        <tr>
            <th>종 &nbsp;목 &nbsp;명</th>
            <td colspan="3">${(project.sbscIssNm) !}</td>
        </tr>
        <tr>
            <th>청약 주수</th>
            <td colspan="3">${(projectSbsc.sbscQty) !} 주</td>
        </tr>
        <tr class="sbscQty none">
            <th>배정 주수</th>
            <td colspan="3">${(projectSbsc.sbscQty) !} 주</td>
        </tr>
        <tr>
            <th>청약 증거금</th>
            <td colspan="3">
                금 <span>${(projectSbsc.sbscAmt) !}</span> 원</li>
            </td>
        </tr>
        <tr>
            <th>실명번호 구분</th>
            <td>
            <#if userInvestor.realnmnoTpcd == '11'>
                주민등록번호
            <#elseif userInvestor.realnmnoTpcd == '12'>
                법인등록번호
            <#elseif userInvestor.realnmnoTpcd == '21'>
                외국인(여권번호)
            <#elseif userInvestor.realnmnoTpcd == '22'>
                외국인(투자자등록번호)
            <#else>
                외국인(외국인등록증)
            </#if>
            </td>
            <th class="noLineLeft">투자자 유형</th>
            <td>
            <#if projectSbsc.invSortCd == '01'>
                일반투자자
            <#elseif projectSbsc.invSortCd == '02'>
                소득요건충족 투자자
            <#elseif projectSbsc.invSortCd == '03'>
                전문투자자
            <#elseif projectSbsc.invSortCd == '04'>
                연고자
            <#else>
                계약전문 투자자
            </#if>
            </td>
        </tr>
        <tr>
            <th>입고 계좌</th>
            <td>
            <#list acoCodes as acoCode>
                    <#if acoCode.code == projectSbsc.secucoAcopno>
            ${(acoCode.codeName) !}
                <#break >
            </#if>
                </#list>
            </td>
            <th class="noLineLeft">계좌 번호</th>
            <td>${(projectSbsc.invstrTrsacNo) !}</td>
        </tr>
        <tr>
            <th class="last">환불 계좌</th>
            <td class="last">
            <#list bankCodes as bankCode>
                    <#if projectSbsc.pblBnkCd?exists && bankCode.code == projectSbsc.pblBnkCd>
                        ${(bankCode.codeName) !}
                        <#break >
                    </#if>
            </#list>
            </td>
            <th class="noLineLeft last">계좌 번호</th>
            <td class="last">${(projectSbsc.pblAcno) !}</td>
        </tr>
        </tbody>
    </table>

    <p class="info"><strong>□ 발행되는 증권을 예탁하는 경우</strong>(공모주식, 공모사채)</p>

    <div class="chkAgree_div">
        <ol>
            <li>
                <p>
                    청약이 완료된 후 청약자가 배정받은 증권은 「자본시장과 금융투자업에 관한 법률」
                    (이하 "자본시장법"이라 한다) 제117조의10제7항 및 제309조제5항에 따라 한국예탁결제원의 명의로
                    일괄발행(등록)되고 동 증권은 청약자가 제출한 증권회사 계좌로 입고됨
                </p>
                <p class="mt10">
                    -----------------------------------------------------------------------------------------------------------
                    <input type="checkbox"> 동의
                </p>
            </li>
            <li>
                <p>
                    청약이 완료된 후 청약자가 교부받은 증권은 자본시장법 제117조의10제7항에 따라 해당
                    증권을 예탁일부터 1년 동안 매도 • 양도를 제한하기 위해 배정된 증권이
                    청약자의 증권회사 계좌로 입고된 후 의무보유예탁(종목처분제한)으로 처리됨
                </p>
                <p class="mt10">
                    -----------------------------------------------------------------------------------------------------------
                    <input type="checkbox"> 동의
                </p>
            </li>
            <li>
                <p>
                    청약자가 증권을 교부받은 날부터 1년이 경과되거나 자본시장법 제117조의10제7항
                    단서에 따라 예외적 매도 • 양도 사유가 발생하여 의무보유예탁(종목처분제한) 상태의
                    증권을 매도 • 양도하려는 경우에는 청약자가 예외적 매도 관련 서류(매매 계약서,
                    매수자의 전문투자자등 확인 서류 등)을 첨부하여 증권회사를 통하여 해당
                    의무보유예탁(종목처분제한) 해제를 신청하여야 함
                </p>
                <p class="mt10">
                    -----------------------------------------------------------------------------------------------------------
                    <input type="checkbox"> 동의
                </p>
            </li>
            <li>
                <p>
                    (전문투자자 등 전매제한계약분) 전문투자자 등이 법시행령 제118조의15제2항에
                    따른 조치를 하는 경우 그 전문투자자 등에게 배정된 증권은 교부일로부터 1년 동안
                    그 증권을 인출하거나 다른 자에게 매도하지 못 함(자본시장법 제117조의10제7항 단서 적용 제외)
                </p>
                <p class="mt10">
                    -----------------------------------------------------------------------------------------------------------
                    <input type="checkbox"> 동의
                </p>
            </li>
        </ol>
    </div>

    <p class="date t-c">귀사의 약관 및 청약서 기재사항을 확인하고 위와 같이 청약 합니다.</p>

    <p class="date">${(projectSbsc.regDate)?date?string("yyyy년 MM월 dd일") !}</p>

    <div class="investor_div">
        <ul>
            <li>청약인</li>
            <li>
                <dl>
                    <dt>주민(사업자)등록번호</dt>
                    <dd>
                    <#if userInvestor.realnmnoTpcd == '11'>
                    ${(userInvestor.realnmno)?substring(0,6) !}-${(userInvestor.realnmno)?substring(6,13) !}
                    <#else>
                    ${(userInvestor.realnmno) !}
                    </#if>
                    </dd>
                </dl>
                <dl>
                    <dt>주 소</dt>
                    <dd>
                    <#if (member.zipcode)?has_content >
                        (${(member.zipcode) !}) ${(member.addr1) !} ${(member.addr2) !}
                    </#if>
                    </dd>
                </dl>
                <dl>
                    <dt>성 명</dt>
                    <dd>${(member.name) !}<span>(인)</span></dd>
                </dl>
            </li>
        </ul>
    </div>

    <p class="copyright">주식회사 코리아에셋 위크라우드 대표이사 귀중</p>
</div>
</body>
</html>