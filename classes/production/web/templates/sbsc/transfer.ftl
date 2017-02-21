<@layout.extends name="layouts/base.ftl">

    <@layout.put block="head">
    </@layout.put>


    <@layout.put block="contents">

    <div class="contents_wrap">
        <div class="content_box sbsc overflow-h">
            <div class="step_box">
                <ol>
                    <li>
                        <p><i class="icon ic_check"></i> 청약신청</p>
                    </li>
                    <li class="t-c">
                        <p class="active"><i class="icon ic_check"></i> 청약 증거금 이체</p>
                    </li>
                    <li class="t-r">
                        <p><i class="icon ic_check"></i> 투자완료</p>
                    </li>
                </ol>
            </div>

            <form id="frmData" method="post">

                <input type="hidden" name="sbscId">
                <input type="hidden" name="payType" value="realtime">
                <input type="hidden" name="hd_pi" value=""/>
                <input type="hidden" name="has_encrypt" value="${hasEncrypt}"/> <!-- 운영 -->
                <input type="hidden" name="hd_ep_type" value="${hdEpType}"/> <!-- 운영 -->
                <#--<input type="hidden" name="hd_ep_type" value="CERT"/> <!-- 개발 &ndash;&gt;-->
                <input type="hidden" name="hd_firm_name" value="한국증권금융" />
                <input type="hidden" name="hd_approve_no" value="15201418"/>
                <input type="hidden" name="hd_serial_no" value="0000000"/>
                <input type="hidden" name="invSortCd">
                <input type="hidden" name="invstrSortTpcd" value="${(invstrSortTpcd) !}">
                <input type="hidden" name="sbscQty" value="${(sbscQty) !}">
                <input type="hidden" name="sbscAmt" value="${sbscAmt?c}">
                <#--<input type="hidden" name="hd_personal" value="${(userInvestor.getBaseEncodedBuzno()) !}"/>-->
                <input type="hidden" name="ep_account_no" value="" />
                <input type="hidden" name="tx_amount" value=""/>
                <input type="hidden" name="tx_user_key" value=""/>

                <div class="thum_wrap post">
                    <div class="form_box">
                        <h2>청약 증거금 이체</h2>
                        <div class="top">
                            <div class="publisher_box sbsc">
                                <div class="publisher_header">
                                    <h1><span>${(project.name)}</span>의 주식 발행에 대한 청약 신청</h1>
                                    <p class="mt20">청약증거금을 이체하고 청약 주문 접수를 완료하세요</p>
                                </div>
                            </div>
                        </div>
                        <div class="bottom investor">
                            <h2>청약신청</h2>
                            <p class="result price mt10">
                                주식 <span>${(sbscQty) !}</span>주  &nbsp; &nbsp;
                                <span>${sbscAmt}</span>원
                            </p>
                        </div>
                    </div>
                    <div class="term_box">
                        <div class="mb20">
                            <input type="checkbox" name="chk_all" id="chk_all" class="data checkbox" />
                            <label for="chk_all">전체 동의함</label>
                        </div>
                        <div class="mb10">
                            <input type="checkbox" name="a1" id="chk_1" class="data checkbox choice_y" value="N" />
                            <label for="chk_1">이용약관에 따라 청약 주문하는 것에 동의합니다.</label>
                            <a href="/page/policy" target="_blank">이용약관 확인하기</a>
                        </div>
                        <div class="mb10">
                            <input type="checkbox" name="a2" id="chk_2" class="data checkbox choice_y" value="N" />
                            <label for="chk_2">증권의 일괄예탁 등에 대하여 동의합니다.</label>
                            <a href="/page/policy" target="_blank">증권 청약 시 예탁관련 필수 동의 사항 확인하기 (이용약관)</a>
                        </div>
                        <div class="mb10">
                            <input type="checkbox" name="a5" id="chk_5" class="data checkbox choice_y" value="N" />
                            <label for="chk_5">
                                청약이 완료된 후 청약자가 배정받은 증권은 ｢자본시장과 금융투자업에 관한 법률｣(이하 “자본시장법”이라 한다)
                                제117조의10제7항 및 제309조제5항에 따라 한국예탁결제원의 명의로 일괄발행(등록)되고 동 증권은 청약자가 제출한 증권회사 계좌로 입고됨
                            </label>
                        </div>
                        <div class="mb10">
                            <input type="checkbox" name="a6" id="chk_6" class="data checkbox choice_y" value="N" />
                            <label for="chk_6">
                                청약이 완료된 후 청약자가 교부받은 증권은 자본시장법 제117조의10제7항에 따라 해당 증권을 예탁일부터 1년 동안 매도·양도를 제한하기 위해
                                배정된 증권이 청약자의 증권회사 계좌로 입고된 후 의무보유예탁(종목처분제한)으로 처리됨
                            </label>
                        </div>
                        <div class="mb10">
                            <input type="checkbox" name="a7" id="chk_7" class="data checkbox choice_y" value="N" />
                            <label for="chk_7">
                                청약자가 증권을 교부받은 날부터 1년이 경과되거나 자본시장법 제117조의10제7항 단서에 따라 예외적 매도·양도 사유가 발생하여
                                의무보유예탁(종목처분제한) 상태의 증권을 매도·양도하려는 경우에는 청약자가 예외적 매도 관련 서류(매매 계약서, 매수자의 전문투자자등 확인 서류 등)을
                                첨부하여 증권회사를 통하여 해당 의무보유예탁(종목처분제한) 해제를 신청하여야 함
                            </label>
                        </div>
                        <div class="mb10">
                            <input type="checkbox" name="a8" id="chk_8" class="data checkbox choice_y" value="N" />
                            <label for="chk_8">
                                (전문투자자 등 전매제한계약분) 전문투자자 등이 법시행령 제118조의15제2항에 따른 조치를 하는 경우 그 전문투자자 등에게 배정된 증권은 교부일로부터
                                1년 동안 그 증권을 인출하거나 다른 자에게 매도하지 못 함(자본시장법 제117조의10제7항 단서 적용 제외)
                            </label>
                        </div>
                        <div class="mb20">
                            <input type="checkbox" name="a3" id="chk_3" class="data checkbox choice_y" value="N" />
                            <label for="chk_3">개인정보 제 3자에 대한 정보제공에 동의합니다.</label>
                            <p class="info pl15">아래 내용에 대하여 동의를 거부하실 수 있으며, 거부 시 청약거래 서비스 이용이 제한됩니다.</p>
                        </div>
                        <div>
                            <p class="pl15 fw-b fs-14 mb10">개인정보 이용내역</p>
                            <table cellpadding="5" cellspacing="1">
                                <tbody>
                                <tr>
                                    <th>제공받는 자</th>
                                    <td>한국예탁결제원, 한국증권금융</td>
                                </tr>
                                <tr>
                                    <th>목적</th>
                                    <td>
                                        자본시장과 금융투자업에 관한 법률 등 관계법령에 따라 온라인 소액투자중개업자가 증권발행기업, 한국예탁결제원, 한국증권금융 등
                                        예치기관에 제공하는 투자자 정보의 제공, 조회 등
                                    </td>
                                </tr>
                                <tr>
                                    <th>항목</th>
                                    <td>성명, 실명확인번호, 이메일, 휴대폰번호</td>
                                </tr>
                                <tr>
                                    <th>보유기간</th>
                                    <td>거래정보등의 제공내용 기록관리내용은 금융실명거래 및 비밀보장에 관한 법률에 따라 5년 보존 후 파기</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="mb5">
                            <input type="checkbox" name="useName" id="chk_4" class="data checkbox choice_n" value="N" />
                            <label for="chk_4">투자내역 실명 공개 (선택사항)</label>
                            <p class="info pl15">동의하시면 웹 페이지에 공개되는 투자자 목록에 실명으로 기재됩니다. 비 동의 시 무기명으로 기재됩니다.</p>
                        </div>
                    </div>
                    <div class="form_box">
                        <div class="top">
                            <div class="notice_box">
                                <p>
                                    청약의 주문 접수 (청약완료)가 완료되기 위하여는 청약증거금의 이체가 완료되어야 합니다.
                                    청약의 주문 접수가 완료되면 신청의 대상 증권에 대한 청약의 의사가 있은 것으로 간주됩니다.
                                    다만, 발행인이 요청한 투자자의 자격제한 증권의 배정조건 (가령, 선착순 배정 등)에 따라 최종적으로 증권의 배정을 받을 수 없을 수 있습니다.
                                </p>
                                <p>
                                    위크라우드는 자본시장과 금융투자업에 관한 법률상 온라인소액투자중개업자로서 청약증거금을 직접 입금받거나 보관하지 않고 임의고 출금하지 않으며,
                                    모든 청약증거금은 예치기관(한국증권금융)에 예치됩니다.
                                </p>
                                <#--<p>-->
                                    <#--청약의 주문 접수 (청약완료)가 완료되기 위하여는 청약증거금의 이체가 완료되어야 합니다. 청약의 주문 접수가 완료되면 신청의 대상 증권에 대한 청약의 이사표시가 있은 것으로 간주됩니다. 다만, 발행인이 요청한 투자자의 자격제한 증권의 배정조건 (가령, 선착순 배정 등)에 따라 최종적으로 증권의 배정을 받을 수 없을 수 있습니다.-->
                                <#--</p>-->
                                <#--<p>-->
                                    <#--청약의 주문 접수 (청약완료)가 완료되기 위하여는 청약증거금의 이체가 완료되어야 합니다. 청약의 주문 접수가 완료되면 신청의 대상 증권에 대한 청약의 이사표시가 있은 것으로 간주됩니다. 다만, 발행인이 요청한 투자자의 자격제한 증권의 배정조건 (가령, 선착순 배정 등)에 따라 최종적으로 증권의 배정을 받을 수 없을 수 있습니다.-->
                                <#--</p>-->
                            </div>
                            <div class="notice_box line_top">
                                <#--<p>-->
                                    <#--위크라우드는 자본시장과 금융투자업에 관한 법률상 온라인소액투자중개업자로서 청약증거금을 직접 입금받거나 보관하지 않고 임의고 출금하지 않으며, 모든 청약증거금은 예치기관(한국증권금융 또는 기업은행)에 예치됩니다.-->
                                <#--</p>-->
                                <p>
                                    <strong>투자 위험 주지 및 고지</strong>
                                    위크라우드는 자본시장과 금융투자업에 관한 법률상 온라인소액투자중개업자로서 청약증거금을 직접 입금받거나 보관하지 않고 임의고 출금하지 않으며,
                                    모든 청약증거금은 예치기관(한국증권금융)에 예치됩니다.
                                </p>
                            </div>
                        </div>
                        <div class="bottom">
                            <input class="btn_type03" id="btn_submit" onClick="javascript:payRequestLink2(frmData);return false;" type="button" value="이체하기" />
                        </div>
                    </div>
                </div>
            </form>
            <div class="thum_wrap project">

                <#function fnSubscribeTypeName subscribeType>
                    <#if subscribeType == "1"><#return "공모"><#else><#return "사모"></#if>
                </#function>


                <ul class="card_list">
                    <li>
                        <a href="/project/${projectId}" target="_blank">
                            <div class="category">
                                <div>
                                    <i class="icon">${(project.category.name) !}</i>
                                    ${(fnSubscribeTypeName(project.subscribeType)) !}/${(project.location) !}
                                </div>
                                <#if project.taxDeduction?default('N') == 'Y'>
                                    <span class="ic_deduction">소득공제</span>
                                </#if>
                            </div>
                            <div class="thum">
                                <p class="image" style="background-image:url(${(project.mainImageUrl)?default('/images/sample.jpg') !});"></p>
                                <p class="blockUi"></p>
                                <div class="desc">
                                    <h4>
                                        <#assign endDate = project.sbscNdDt?datetime("yyyyMMdd")?long >
                                        <#assign nowDate = .now?string.yyyyMMdd?datetime("yyyyMMdd")?long >
                                        <#assign dDay = ((endDate - nowDate) / (1000 * 60 * 60 * 24))?int >
                                        <#if (dDay <= 0)>
                                            청약종료 <br/>
                                        <#else>
                                            D-${(dDay)! } <br/>
                                        </#if>
                                        목표금액 ${(project.targetAmt?default(0)) !}원
                                    </h4>
                                    <p>${(project.comment?default(""))!}</p>
                                </div>
                            </div>
                            <div class="info">
                                <div class="title">
                                    <h4>${(project.name) !}</h4>
                                </div>
                                <p class="firm">${(project.user.userPublisher.corpName) !}</p>
                                <p><span>${(dDay)! }</span>일 남음</p>
                                <p>현재 <span>${(project.sbscCount) !}</span>명</p>
                                <p class="price"><span>${(project.sbscAmt?default(0)) !}</span>원</p>
                                <#assign percent = (project.sbscAmt / project.targetAmt) * 100>
                                <#if (percent > 100)>
                                    <#assign percent = percent?string("0")>
                                <#else>
                                    <#assign percent = percent?string("0.#")>
                                </#if>
                                <p class="graph circleGraphic" data-form="${percent}"></p>
                            </div>
                        </a>
                    </li>
                    <li class="no_hover">
                        <div class="info">
                            <h5>청약 기본 사항</h5>
                            <ul>
                                <li>상호: ${(project.name) !}</li>
                                <li>모집수량: ${(project.targetStockQty) !}주</li>
                                <li>신주의 발행가액: ${(project.targetStockPrice) !}원</li>
                                <li>신주의 배정방법: ${(fnSubscribeTypeName(project.subscribeType)) !}</li>
                                <li>청약기간: ${(project.sbscStDt?datetime("yyyyMMdd")?string("yyyy년 MM월 dd일")) !}부터 ${(project.sbscNdDt?datetime("yyyyMMdd")?string("yyyy년 MM월 dd일")) !}</li>
                                <li>주금 납입일: 청약기간의 종료일로부터 8일 이내 (예정)</li>
                                <li>청약취급처: 위크라우드</li>
                                <li>청약증거금 예치기관: 한국증권금융</li>
                                <li>증권입고일: 납입일로부터 10일 이내</li>
                                <li>보호예수: 예탁결제원에서 1년간의 무보유 예탁조치</li>
                            </ul>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>


    <form id="resultForm" method="post" action="/sbsc/${(project.projectId) !}/result">
        <input type="hidden" name="success">
        <input type="hidden" name="message">
        <input type="hidden" name="resultSbscId">
    </form>


    </@layout.put>


    <@layout.put block="script">
    <script src="/js/BankPayEFT.js" type="text/javascript"></script>
    <script src="/js/KSFC_api.js" type="text/javascript"></script>
    <script>
        var projectId = '${project.projectId}';
    </script>
    <script type="text/javascript" src="/js/sbsc/transfer.js"></script>

    </@layout.put>

</@layout.extends>